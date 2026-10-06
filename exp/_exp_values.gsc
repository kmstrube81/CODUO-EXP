loadGSC(prop, player)
{
    updateGsc = false;
    if(!isDefined(game["loadGsc"]))
    {
        array = getValues();
        keys = game["loadGsc"]["keys"];
        guids = game["loadGsc"]["guids"];
    }
    else
    {
        array = game["loadGsc"]["array"];
        keys = game["loadGsc"]["keys"];
        guids = game["loadGsc"]["guids"];
    }
    if(!isDefined(array[prop]))
    {   //if the property doesn't exist yet
        keys[keys.size] = prop;
        array[prop] = [];
        updateGsc = true;
    }
    //search guids
    for(i = 0; i < guids.size; i++)
    {
        if(guids[i] != player)
            continue;
        guid = player;
    }
    if(!isDefined(guid))
    {
        guids[guids.size] = player;
        updateGsc = true;
    }
    if(!isDefined(array[prop][player]))
    {
        array[prop][player] = 0;
        updateGsc = true;
    }
    if(updateGsc)
    {
        game["loadGsc"]["array"] = array;
        game["loadGsc"]["keys"] = keys;
        game["loaGsc"]["guids"] = guids;
    }

    return array[prop][player];
}

saveGSC(prop, player, value)
{
    updateGsc = true;
    if(!isDefined(game["loadGsc"]))
    {
        array = getValues();
        keys = game["loadGsc"]["keys"];
        guids = game["loadGsc"]["guids"];
    }
    else
    {
        array = game["loadGsc"]["array"];
        keys = game["loadGsc"]["keys"];
        guids = game["loadGsc"]["guids"];
    }
    if(!isDefined(array[prop]))
    {   //if the property doesn't exist yet
        keys[keys.size] = prop;
        array[prop] = [];
        updateGsc = true;
    }
    //search guids
    for(i = 0; i < guids.size; i++)
    {
        if(guids[i] != player)
            continue;
        guid = player;
    }
    if(!isDefined(guid))
    {
        guids[guids.size] = player;
        updateGsc = true;
    }
    if(!isDefined(array[prop][player]))
    {
        array[prop][player] = value;
        updateGsc = true;
    }
    if(updateGsc)
    {
        game["loadGsc"]["array"] = array;
        game["loadGsc"]["keys"] = keys;
        game["loaGsc"]["guids"] = guids;
    }
}

getValues()
{
    array = [];
    keys = [];
    guids = [];
    /* ***************** PASTE VALUES FROM LOG BELOW THIS LINE *********************** */
    keys[0] = "exp";
    keys[1] = "exp_kills";
    keys[2] = "exp_death";
    guids[0] = 0;
    array["exp"] = [];
    array["exp_kills"] = [];
    array["exp_deaths"] = [];
    array["exp"][0] = 0;
    array["exp_kills"][0] = 0;
    array["exp_deaths"][0] = 0;
    /* ***************** PASTE VALUES FROM LOG ABOVE THIS LINE *********************** */

    if(!isDefined(game["loadGsc"]))
    {
        game["loadGsc"] = [];
        game["loadGsc"]["array"] = array;
        game["loadGsc"]["keys"] = keys;
        game["loadGsc"]["guids"] = guids;
    }

    return array;
}

logValues()
{
    log = "\n";

    log += "/* ***************** COPY VALUES BELOW THIS LINE AND PASTE INTO exp\_exp_values.gsc *********************** */";

    logPrint(log);

    if(!isDefined(game["loadGsc"]))
    {
         array = getValues();
         keys = game["loadGsc"]["keys"];
         guids = game["loadGsc"]["guids"];
    }
    else
    {
         array = game["loadGsc"]["array"];
         keys = game["loadGsc"]["keys"];
         guids = game["loadGsc"]["guids"];
    }

    for(i = 0; i < keys.size; i++)
    {
         key = keys[i];
         logPrint("\n    keys[" + i + "] = \"" + key + "\";");
    }
    for(i = 0; i < guids.size; i++)
    {
        guid = guids[i];
        logPrint("\n    guids[" + i + "] = \"" + guid + "\";");
    }

    for(i = 0; i < keys.size; i++)
    {
        key = keys[i];
        for(j = 0; j <= guids.size; j++)
        {
            guid = guids[j];
            if(isDefined(array[key][guid]))
            {
                logPrint("\n    array[\"" + key + "\"][" + guid + "] = " + array[key][guid] + ";");
            }
        }
    }

    log = "\n";
    log += "/* ***************** COPY VALUES ABOVE THIS LINE AND PASTE INTO exp\_exp_values.gsc *********************** */";
    log += "\n";

    logPrint(log);
}

