load(props, propNames, timeout, callback)
{
    propArr = maps\mp\uox\_uox_utils::stringSplit(props, ",");
	//set propName to property if not set
	if(!isDefined(propNames))
		propNames = props;
     propNamesArr = maps\mp\uox\_uox_utils::stringSplit(propNames, ",");
	//set timeout before giving up checking for result
	if(!isDefined(timeout))
		timeout = 10;

    //if a second prop exists then loads need to be batched
    if(isDefined(propArr[1]))
    {
        maps\mp\uox\_uox_debug::debugLog("info", self.name + " batched load branch: " + props);
        self thread loadBatched(propArr, props, propNamesArr, timeout, callback);
        return;
    }
    prop = propArr[0];
    propName = propNamesArr[0];
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
			self thread query(prop, timeout);
			break;
		case 4: //4 = load from manually specified server cvar
			self thread loadCvar(prop, 60);
			break;
	}
	
	self thread timeout(prop, propName);
    self thread waitForLoadOrTimeout(prop, callback);
}

loadBatched(props, _props, propNames, timeout, callback)
{

    if(level.exp_loadtype == 3) //run a batched query specifically for db lookups
        self thread batchedQuery(props, _props, timeout);
    
    for(i = 0; i < props.size; i++)
    {
        prop = props[i];
        propName = propNames[i];

        switch(level.exp_loadtype) //run regular setters individually for other types
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
    		case 4: //4 = load from manually specified server cvar
    			self thread loadCvar(prop, 60);
    			break;
    	}

        self thread timeout(prop, propName);
        self thread waitForLoadOrTimeout(prop, callback);
    }
}

waitForLoadOrTimeout(prop, callback)
{
    self.pers[prop + " loaded"] = false;

    self endon("load_timeout " + prop);
    self waittill("load_result " + prop);
    
	self.pers[prop + " loaded"] = true;

	if(isDefined(self.pers[prop]))
		self.pers[prop] += (int)self.pers["temp " + prop];
	else
		self.pers[prop] = (int)self.pers["temp " + prop];
    if(isDefined(callback))
       self thread [[ callback ]]();
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

query(prop, timeout)
{
	// one query in flight per player; queue behind any pending one
    while(isDefined(self.exp_queryBusy))
       	wait level.frametime;
   	self.exp_queryBusy = true;

    if(!isDefined(level.exp_queryID))
       	level.exp_queryID = 0;
    level.exp_queryID++;
        queryID = "" + level.exp_queryID;

	//craft a query ID to search for the result.
	playernum = self getEntityNumber();
	setCvar("query_result_" + playernum, "");   // clear BEFORE asking, so stale data can't match
	logPrint("GET;" + self getGuid() + ";" + playernum + ";" + queryID + ";" + prop + ";" + self.name + "\n");

	self thread waitForResult(prop, playernum, queryID, timeout);
}

batchedQuery(props, _props, timeout)
{
    // one query in flight per player; queue behind any pending one
    while(isDefined(self.exp_queryBusy))
       	wait level.frametime;
   	self.exp_queryBusy = true;

    if(!isDefined(level.exp_queryID))
       	level.exp_queryID = 0;
    level.exp_queryID++;
        queryID = "" + level.exp_queryID;

    //craft a query ID to search for the result.
	playernum = self getEntityNumber();
	setCvar("query_result_" + playernum, "");   // clear BEFORE asking, so stale data can't match
	logPrint("GET;" + self getGuid() + ";" + playernum + ";" + queryID + ";" + _props + ";" + self.name + "\n");

	self thread waitForBatchedResult(props, playernum, queryID, timeout);
}

waitForResult(prop, playernum, queryID, timeout)
{
	self endon("disconnect");
    cvarName = "query_result_" + playernum;
	i = 0;
	while( i < timeout * level.framerate )
	{
		query_result = getCvar(cvarName);
		//if the queryID matches
		if(maps\mp\uox\_uox_utils::findStr(queryID + ";", query_result, "start") > -1)
        {
            self.pers["temp " + prop] = (int)maps\mp\uox\_uox_utils::stringSplit(query_result)[1];
            self notify("load_result " + prop);
            self.exp_queryBusy = undefined;
            return;
        }
		//otherwise wait and try again
		wait level.frametime; //check every frame
		i++;
	}
	//hit timeout
	self notify("load_timeout " + prop);
    self.exp_queryBusy = undefined;
}

waitForBatchedResult(props, playernum, queryID, timeout)
{
	self endon("disconnect");
    cvarName = "query_result_" + playernum;
	i = 0;
	while( i < timeout * level.framerate )
	{
		query_result = getCvar(cvarName);
		//if the queryID matches
		if(maps\mp\uox\_uox_utils::findStr(queryID, query_result, "start") > -1)
        {
            batchedResult = maps\mp\uox\_uox_utils::stringSplit(query_result)[1];
            break;
        }
		//otherwise wait and try again
		wait level.frametime; //check every frame
		i++;
	}

    if(!isDefined(batchedResult))
    {
        //hit timeout
        for(i = 0; i < props.size; i++)
        {
            prop = props[i];
            self notify("load_timeout " + prop);
        }
    }
    else
    {
        //split result
        results = maps\mp\uox\_uox_utils::stringSplit(batchedResult, ",");
        for(i = 0; i < props.size; i++)
        {
            prop = props[i];
            if(!isDefined(results[i])) //somehow there were more properties than writebacks from db
            {
                prop = props[i];
                self notify("load_timeout " + prop);
            }
            else
            {
                self.pers["temp " + prop] = (int)results[i];
                self notify("load_result " + prop);
            }
        }
    }
    self.exp_queryBusy = undefined;
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

save(prop, value, force)
{
    if(!isDefined(force))
    {
        force = false;
    }
    //if the temp value hasn't been set then load failed so don't save (unless forced)
    if((!isDefined(self.pers[prop + " loaded"]) || (isDefined(self.pers[prop + " loaded"]) && !self.pers[prop + " loaded"])) && !force)
    {
        return;
    }

    switch(level.exp_loadtype)
	{
		case 0: //0 = instantly set property to zero
		case 1: //1 = randomly set a value
			return; //don't save random-zero load
		case 2: //2 = log value to save in _exp_values.gsc
			self thread exp\_exp_values::saveGSC(prop, self getGuid(), timeout);
			return;
		case 3: //3 = log for log parser backend (such as b3 etc)
			logPrint("SET;" + self getGuid() + ";" + self getEntityNumber() + ";" + prop + ";" + value + ";" + self.name + "\n");
			return;
		case 4: //4 = don't save from cvar either
			return;
	}
}

