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
	while( i < timeout * level.framerate )
	{
		query_result = getCvar("query_result");
		//if the queryID matches
		if(maps\mp\uox\_uox::findStr(queryID, query_result, "start") > -1)
        {
            self.pers[prop] = maps\mp\uox\_uox::stringSplit(query_result)[1];
            return;
        }
		//otherwise wait and try again
		wait level.frametime; //check every frame
		i++;
	}
}


