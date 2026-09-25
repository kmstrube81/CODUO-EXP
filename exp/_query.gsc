query(prop, query_text, timeout)
{
	//set timeout before giving up checking for result
	if(!isDefined(timeout))
		timeout = 10;
	
	//init the property
	self.pers[prop] = "";
	
	//craft a query ID to search for the result.
	queryID = self getGuid() + randomInt(100000);
	logPrint( "query;" + queryID + ";" + query_text + "\n" );
	
	self thread waitForResult(prop, queryID, timeout);
	
}

waitForResult(prop, queryID, timeout)
{
	i = 0;
	while( i < timeout * 20 )
	{
		query_result = getCvar("query_result");
		//if the queryID matches
		if(findStr(queryID, query_result, "start") > -1)
			self.pers[prop] = splitArray(query_result)[1];
		return;
		//otherwise wait and try again
		wait 0.05; //check every frame
		i++;
	}
}


// CODE BELOW ORIGINALLY FROM CoDAM
splitArray( str, sep, quote, skipEmpty )
{
	if ( !isdefined( str ) || ( str == "" ) )
		return ( [] );

	if ( !isdefined( sep ) || ( sep == "" ) )
		sep = ";";	// Default separator

	if ( !isdefined( quote ) )
		quote = "";

	skipEmpty = isdefined( skipEmpty );

	a = _splitRecur( 0, str, sep, quote, skipEmpty );

	return ( a );
}

_splitRecur( iter, str, sep, quote, skipEmpty )
{
	s = sep[ iter ];

	_a = [];
	_s = "";
	doQuote = false;
	for ( i = 0; i < str.size; i++ )
	{
		ch = str[ i ];
		if ( ch == quote )
		{
			doQuote = !doQuote;

			if ( iter + 1 < sep.size )
				_s += ch;
		}
		else
		if ( ( ch == s ) && !doQuote )
		{
			if ( ( _s != "" ) || !skipEmpty )
			{
				_l = _a.size;

				if ( iter + 1 < sep.size )
				{
					_x = _splitRecur( iter + 1, _s,	sep, quote, skipEmpty );

					if ( ( _x.size > 0 ) || !skipEmpty )
					{
						_a[ _l ][ "str" ] = _s;
						_a[ _l ][ "fields" ] = _x;
					}
				}
				else
					_a[ _l ] = _s;
			}

			_s = "";
		}
		else
			_s += ch;
	}

	if ( _s != "" )
	{
		_l = _a.size;

		if ( iter + 1 < sep.size )
		{
			_x = _splitRecur( iter + 1, _s, sep, quote, skipEmpty );
			if ( _x.size > 0 )
			{
				_a[ _l ][ "str" ] = _s;
				_a[ _l ][ "fields" ] = _x;
			}
		}
		else
			_a[ _l ] = _s;
	}

	return ( _a );
}

findStr( find, str, pos )
{
	if ( !isdefined( find ) || ( find == "" ) || 
		 !isdefined( str ) || 
		 !isdefined( pos ) || 
		 ( find.size > str.size ) )
		return ( -1 );

	fsize = find.size;
	ssize = str.size;

	switch ( pos )
	{
	  case "start": place = 0 ; break;
	  case "end":	place = ssize - fsize; break;
	  default:	place = 0 ; break;
	}

	for ( i = place; i < ssize; i++ )
	{
		if ( i + fsize > ssize )
			break;			// Too late to compare

		// Compare now ...
		for ( j = 0; j < fsize; j++ )
			if ( str[ i + j ] != find[ j ] )
				break;		// No match

		if ( j >= fsize )
			return ( i );		// Found it!

		if ( pos == "start" )
			break;			// Didn't find at start
	}

	return ( -1 );
}