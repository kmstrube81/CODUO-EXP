load(prop, propName, timeout)
{
	//set propName to property if not set
	if(!isDefined(propName))
		propName = prop;
	//set timeout before giving up checking for result
	if(!isDefined(timeout))
		timeout = 10;

	switch(level.exp_loadtype)
	{
		case 0: //0 = instantly set property to zero
			self thread loadZero(prop);
			break;
		case 1: //1 = randomly set a value
			self thread loadRandom(prop, timeout);
			break;
		case 2: //2 = load from values specified in _exp_values.gsc
			self thread loadGSC(prop, self getGuid(), timeout);
			break;
		case 3: //3 = load from log parser backend (such as b3 etc)
			self thread query(prop, "GET " + prop + " WHERE guid=" + self getGuid(), timeout);
			break;
		case 4: //4 = load from manually specified server cvar
			self thread loadCvar(prop, 60);
			break;
	}
	
	self thread timeout();
    
    self endon("load_timeout " + prop);
    self waittill("load_result " + prop);
    
	self.pers[prop + " loaded"] = true;

	if(isDefined(self.pers[prop]))
		self.pers[prop] += self.pers["temp " + prop];
	else
		self.pers[prop] = self.pers["temp " + prop];
}

timeout(prop, propName)
{
    self endon("load_result " + prop);
    self waittill("load_timeout " + prop);

	self.pers[prop + " loaded"] = false;
    
    self iprintln("Failed to connect to backend. " + propName + " will not save between rounds");
}

loadZero(prop)
{
	self.pers["temp " + prop] = 0;

	wait level.frametime; // wait a frame before sending notify

	self notify("load_result " + prop);
}

loadRandom(prop, timeout)
{
	debug = getCvar("g_debug");

	if(debug)
		wait timeout * 2; //coinflip to load value during debug

	self.pers["temp " + prop] = randomInt(9999);

	wait level.frametime; // wait a frame before sending notify

	self notify("load_result " + prop);
}

loadGSC(prop, player, timeout)
{
	debug = getCvar("g_debug");

	if(debug)
		wait timeout * 2; //coinflip to load value during debug

	self.pers["temp " + prop] = exp\_exp_values::loadGSC(prop, player);

	wait level.frametime; // wait a frame before sending notify

	self notify("load_result " + prop);
}

query(prop, query_text, timeout)
{
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
            self.pers["temp " + prop] = maps\mp\uox\_uox::stringSplit(query_result)[1];
            self notify("load_result " + prop);
            return;
        }
		//otherwise wait and try again
		wait level.frametime; //check every frame
		i++;
	}
	//hit timeout
	self notify("load_timeout " + prop);
}

loadCvar(prop, timeout)
{
    result = getCvar("query_result");
    player_ent = getCvar("query_player");
    i = 0;
    while(i < timeout * level.frametime)
    {
        if(result == "" || player_ent == "")
        {
            wait level.frametime;
            continue;
        }
        if(player_ent == self getEntityNumber())
            break;
        wait level.frametime;
        i++;
    }

    if( i >= timeout * level.frametime)
    {
        //hit timeout
        self notify("load_timeout " + prop);
        return;
    }
    self.pers["temp " + prop] = query_result;
    self notify("load_result " + prop);
    return;
}

