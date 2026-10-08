EXP_Init()
{
    exp_enabled = maps\mp\uox\_uox_vars::varDef("exp", "enabled", "bool", false, false, "", "", "XP");
    
    if(!exp_enabled)
        return;

    //run exp before regular start game callback
    level.StartGametype_Callbacks = maps\mp\uox\_uox_arrays::arrayUnshift(level.StartGametype_Callbacks, ::EXP_StartGameType);
    //run exp routines before regular player damage callback
    level.PlayerDamage_Callbacks = maps\mp\uox\_uox_arrays::arrayUnshift(level.PlayerDamage_Callbacks, ::EXP_PlayerDamage);
    //run exp routines before regular player killed callback
    level.PlayerKilled_Callbacks = maps\mp\uox\_uox_arrays::arrayUnshift(level.PlayerKilled_Callbacks, ::EXP_PlayerKilled);
    //run exp routines after regular player connect callback
    level.PlayerConnect_Callbacks = maps\mp\uox\_uox_arrays::arrayPush(level.PlayerConnect_Callbacks, ::EXP_PlayerConnect);
    
    level.PlayerDisconnect_Callbacks = maps\mp\uox\_uox_arrays::arrayPush(level.PlayerDisconnect_Callbacks, ::EXP_PlayerDisconnect);
}

EXP_Vars()
{
    level.exp_multiplier = maps\mp\uox\_uox_vars::varDef("exp", "multiplier", "float", true, 1, 0, 10, "XP Multiplier");
    level.exp_killvalue = maps\mp\uox\_uox_vars::varDef("exp", "killvalue", "int", true, 10, 0, 100, "Kill Base XP Value", ::updateKillValue);
    level.exp_assistvalue = maps\mp\uox\_uox_vars::varDef("exp", "assistvalue", "int", true, 4, 0, 100, "Kill Base Assist Value", ::updateAssistValue);
    maps\mp\uox\_uox_vars::varDef("exp", "drawexpbar", "bool", true, true, "", "", "Draw XP Bar");
    maps\mp\uox\_uox_vars::varDef("exp", "levelsperrank", "int", false, 4, 1, 100, "Levels Per Rank");
    level.exp_drawrankicon = maps\mp\uox\_uox_vars::varDef("exp", "drawrankicon", "bool", true, true, "", "", "Draw Rank Icon", ::updateDrawRank);
    level.exp_loadtype = maps\mp\uox\_uox_vars::varDef("exp","loadtype", "int", false, 0, 0, 4);
}

EXP_Precache()
{
    game["plusText"] = &"+";
    precacheString(game["plusText"]);
    game["lvlText"] = &"lvl";
    precacheString(game["lvlText"]);
    game["exp_doubleKillText"] = &"Double Kill";
    game["exp_tripleKillText"] = &"Triple Kill";
    game["exp_multiKillText"] = &"Multi Kill";
    game["exp_fiveKillText"] = &"Bloodthirsty";
    game["exp_tenKillText"] = &"Killing Spree";
    game["exp_headshotText"] = &"Headshot";
    precacheString(game["exp_doubleKillText"]);
    precacheString(game["exp_tripleKillText"]);
    precacheString(game["exp_multiKillText"]);
    precacheString(game["exp_fiveKillText"]);
    precacheString(game["exp_tenKillText"]);
    precacheString(game["exp_headshotText"]);
    switch(level.objective)
    {
        case "ctf":
            game["exp_takeFlagText"] = &"Flag Taken";
            game["exp_returnFlagText"] = &"Flag Returned";
            game["exp_captureFlagText"] = &"Flag Captured";
            game["exp_defendFlagText"] = &"Flag Defended";
            game["exp_assistFlagText"] = &"Flag Carrier Assisted";
            precacheString(game["exp_takeFlagText"]);
            precacheString(game["exp_returnFlagText"]);
            precacheString(game["exp_captureFlagText"]);
            precacheString(game["exp_defendFlagText"]);
            precacheString(game["exp_assistFlagText"]);
            break;
        case "commandpost":
            game["exp_captureFlagText"] = &"Flag Captured";
            game["exp_defendFlagText"] = &"Flag Defended";
            precacheString(game["exp_captureFlagText"]);
            precacheString(game["exp_defendFlagText"]);
            break;
        case "bel":
            game["exp_survivedText"] = &"Survived";
            game["exp_killAlliedText"]= &"Allied Killed";
            precacheString(game["exp_survivedText"]);
            precacheString(game["exp_killAlliedText"]);
            break;
        case "retrieval":
            game["exp_pickupText"] = &"Objective Picked Up";
            game["exp_captureText"] = &"Objective Captured";
            precacheString(game["exp_pickupText"]);
            precacheString(game["exp_captureText"]);
            break;
        case "radio":
            game["exp_captureRadioText"] = &"Radio Captured";
            game["exp_destroyRadioText"] = &"Radio Destroyed";
            game["exp_holdRadioText"] = &"Radio Held";
            precacheString(game["exp_captureRadioText"]);
            precacheString(game["exp_destroyRadioText"]);
            precacheString(game["exp_holdRadioText"]);
            break;
    }
}

EXP_StartGameType()
{
    EXP_Vars();
    EXP_Precache();
}

EXP_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc)
{

    if(level.warmup)
        return;
        
    if ( (isdefined (eAttacker)) && (isPlayer(eAttacker)) && (isdefined (eAttacker.god)) && (eAttacker.god == true) )
		return; //ignore damage from god mode players

	if(self.sessionteam == "spectator" || (self.god == true) )
		return; //ignore damage to god mode players

	if([[level.getVars]]("scr_ceasefire"))
		return;
	
	if(level.roundended)
		return;
		
    if(!isDefined(eAttacker) || !isPlayer(eAttacker))
        return;	
		
    if(isPlayer(eAttacker) && (self == eAttacker))
    	    return;
		
	ffire = level.friendlyfire;
	
	if((ffire == 0 || ffire == 2) && level.uox_teamplay && eAttacker.pers["team"] == self.pers["team"])
	    return;
	    
    if(ffire == 3 && level.uox_teamplay && eAttacker.pers["team"] == self.pers["team"])
        iDamage = iDamage * 0.5; 
		
    //record player damage for potential assist
    if(!isDefined(self.assistDamage))
        self.assistDamage = maps\mp\uox\_uox_arrays::superArray();
    attackerNum = eAttacker getEntityNumber();
    time = getTime();
    damage = maps\mp\uox\_uox_arrays::getValue(self.assistDamage, attackerNum);
     
    //is there already recorded damage?
    if(isDefined(damage))
    { //add to damage
        if((time - damage["time"])/1000 < 10) //if last damage was less than 10s ago
            damage["damage"] += iDamage;
        else
            damage["damage"] = iDamage;  
        damage["time"] = time;
        
        self.assistDamage = maps\mp\uox\_uox_arrays::updateValue(self.assistDamage, attackerNum, damage);
    }
    else //no damage defined
    { //create new entry
        damage = [];
        damage["attacker"] = eAttacker;
        damage["victim"] = self;
        damage["damage"] = iDamage;
        damage["time"] = time;
        
        self.assistDamage = maps\mp\uox\_uox_arrays::arrayPush(self.assistDamage, damage, attackerNum);
    }
}

EXP_PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc)
{
    //pop the exp value on the kill
    if(level.warmup)
        return;
        
    if ( (isdefined (attacker)) && (isPlayer(attacker)) && (isdefined (attacker.god)) && (attacker.god == true) )
		return; //ignore damage from god mode players

	if(self.sessionteam == "spectator" || (self.god == true) )
		return; //ignore damage to god mode players

	if([[level.getVars]]("scr_ceasefire"))
		return;
	
	if(level.roundended)
		return;
		
    if(!isDefined(attacker) || !isPlayer(attacker))
        return;	
		
	//reset killstreak at this point
    self.pers["killstreak"] = undefined;
		
    if(isPlayer(attacker) && (attacker == self))
    	    return;
    	    
    if(!isDefined(self.assistDamage))
        return;
        
    time = getTime();
    attackerNum = attacker getEntityNumber();
    
    killxp = level.exp_killvalue;
    if(attacker.pers["team"] == self.pers["team"] && level.uox_teamplay)
        killxp = killxp * -1;

    botMultiplier = 1;
    if(isDefined(self.pers["isBot"]))
       botMultiplier = 0.5;

    killxp = killxp * level.exp_multiplier * botMultiplier;
    
    //remove the killer from the assist array
    self.assistDamage = maps\mp\uox\_uox_arrays::arrayPop(self.assistDamage, attackerNum);
    
    attacker EXP_updateEXP(killxp); //give kill xp
    //pop the xp text on the killing player 
    attacker thread EXP_HudPop(killxp);

    //pop the assist text on the assisting players
    thread maps\mp\uox\_uox_arrays::arrayReadEach(self.assistDamage, ::EXP_PopAssists);
    //delete the array
    self.assistDamage = undefined;

    if(sMeansOfDeath == "MOD_HEAD_SHOT")
    {
        attacker.notification = "headshot";
    }
    
    //record kill for killstreak tracking
    if(!isDefined(attacker.pers["killstreak"]))
        attacker.pers["killstreak"] = maps\mp\uox\_uox_arrays::superArray();
    time = getTime();
    
    //create new entry
    kill = [];
    kill["weapon"] = sWeapon;
    kill["victim"] = self.name;
    kill["time"] = time;
        
    attacker.pers["killstreak"] = maps\mp\uox\_uox_arrays::arrayPush(attacker.pers["killstreak"], kill);
    
    //check for multikill/killstreak
    attacker EXP_CheckKillstreak();
}

EXP_PlayerConnect()
{
    //load player level. watch for stat menu?
    self thread EXP_LoadPlayerLevel();
    self maps\mp\uox\_uox_loops::addToLoop(self, "medium", ::updateEXPHUD, "updateEXPHUD");
}

EXP_PlayerDisconnect()
{
    //save player level.
}

EXP_LoadPlayerLevel()
{
	self.pers["level"] = 1;
    self exp\_query::load("exp", "Experience");
    self.pers["level"] = getLevel(self.pers["exp"]);
}

updateKillValue(xp)
{
    level.exp_killvalue = xp;
}

updateAssistValue(xp)
{
    level.exp_assistvalue = xp;
}

updateDrawRank(drawrank)
{
    level.exp_drawrankicon = drawrank;

    if(level.exp_drawrankicon)
    {
        players = getentarray("player", "classname");
        for(i = 0; i < players.size; i++)
    	{
    		player = players[i];

            if ( isdefined(player.rank_hud_icon))
                player.rank_hud_icon destroy();
            if(isAlive(self) && self.pers["team"] != "spectator" && self.sessionstate == "playing")
                player thread EXP_RankHudInit();
        }
    }
    else
    {
        players = getentarray("player", "classname");
        for(i = 0; i < players.size; i++)
    	{
    		player = players[i];
            
            player thread EXP_RankHudDestroy2();
            if(isAlive(self) && self.pers["team"] != "spectator" && self.sessionstate == "playing")
                maps\mp\gametypes\_rank_gmi::RankHudInit();
        }
    }
}

EXP_PopAssists(damage)
{
    if(!isDefined(damage["attacker"]))
        return;
        
    if(!isPlayer(damage["attacker"])) //return if player is no longer valid
        return;
        
    assistxp = level.exp_assistvalue;
    if(damage["attacker"].pers["team"] == damage["victim"].pers["team"] && level.uox_teamplay)
        assistxp = assistxp * -1; 

    botMultiplier = 1;
    if(isDefined(damage["victim"].pers["isBot"]))
       botMultiplier = 0.5;

    assistxp = assistxp * level.exp_multiplier * botMultiplier;

    time = getTime();
    
    if((time - damage["time"])/1000 > 10) //return if damage was more than 10s ago
        return;
        
    if(damage["damage"] < 50) //return if damage wasn't more than 50
        return;
        
	damage["attacker"] EXP_updateEXP(assistxp); //give assist xp 
        
    damage["attacker"] thread EXP_HudPop(assistxp);   
}

EXP_HudPop(value)
{
    self notify("exp_pop");
    self endon("exp_pop");
    self endon("hud_clear");

    options = [];
    options["x"] = 320;
    options["y"] = 180;
    options["alignX"] = "left";
    options["alignY"] = "middle";
    options["alpha"] = 1;
    options["fontscale"] = 1.5;
    _options = [];
    _options["x"] = 320;
    _options["y"] = 180;
    _options["alignX"] = "right";
    _options["alignY"] = "middle";
    _options["alpha"] = 1;
    _options["fontscale"] = 1.5;

    element = self maps\mp\uox\_uox_hud::updateClientHUDElement("exp_pop", "number", value, options);
    
    
    if(!isDefined(element.exp_value))
        element.exp_value = value;
    else 
        element.exp_value += value;
        
    maps\mp\uox\_uox_debug::debugLog("debug", self.name + " create damage pop of value " + element.exp_value); 
    
    if(element.exp_value >= 0)    
        sign = game["plusText"];
    else
        sign = undefined;
    
    if(isDefined(sign))
        _element = self maps\mp\uox\_uox_hud::updateClientHUDElement("exp_pop+", "text", sign, _options);
        
    self maps\mp\uox\_uox_hud::updateClientHUDElement("exp_pop", "number", element.exp_value, options); 
        
    self thread maps\mp\uox\_uox_hud::animateClientHUDElement("exp_pop", "popText", options, 0.6);
    if(isDefined(sign))
        self thread maps\mp\uox\_uox_hud::animateClientHUDElement("exp_pop+", "popText", _options, 0.6);
 
    wait 1.5;
    element fadeOverTime(0.5);
    element.alpha = 0;
    if(isDefined(sign))
    {
        _element fadeOverTime(0.5);
        _element.alpha = 0;
    }
    
    wait 0.5;
    self maps\mp\uox\_uox_hud::deleteClientHUDElement("exp_pop");
    self maps\mp\uox\_uox_hud::deleteClientHUDElement("exp_pop+");
}

EXP_HudSlam(text)
{
    self notify("exp_slam");
    self endon("exp_slam");
    self endon("hud_clear");

    options = [];
    options["x"] = 320;
    options["y"] = 158;
    options["alignX"] = "center";
    options["alignY"] = "middle";
    options["alpha"] = 1;
    options["fontscale"] = 1.5;

    element = self maps\mp\uox\_uox_hud::updateClientHUDElement("exp_notification", "text", text, options);
        
    maps\mp\uox\_uox_debug::debugLog("debug", self.name + " create notification slam"); 
    
    self thread maps\mp\uox\_uox_hud::animateClientHUDElement("exp_notification", "slamText", options, 0.6);
    wait 1.5;
    element fadeOverTime(0.5);
    wait 0.5;
    self maps\mp\uox\_uox_hud::deleteClientHUDElement("exp_notification");
}

EXP_updateEXP(xp)
{
    self.pers["exp"] += (xp * level.exp_multiplier);

    lvl = getLevel(self.pers["exp"]);

    if(lvl != self.pers["level"])
    {
        maps\mp\uox\_uox_debug::debugLog("debug", self.name + " promoted from level " + self.pers["level"] + " to level " + lvl);

        self notify("level updated", lvl > self.pers["level"]);

        self.pers["level"] = lvl;
    }
}

updateEXPHUD()
{
    if(isAlive(self) && self.pers["team"] != "spectator" && self.sessionstate == "playing" && [[level.getVars]]("exp_drawexpbar"))
        self createEXPHUD();
    else 
        self deleteEXPHUD();

    //give exp for any pending nofications
    if(isDefined(self.notification))
    {
        switch(self.notification)
        {
            case "headshot":
                self EXP_updateEXP(level.exp_assistvalue);
                text = game["exp_headshotText"];
                break;
            case "double_kill":
                self EXP_updateEXP(level.exp_assistvalue);
                text = game["exp_doubleKillText"];
                break;
            case "triple_kill":
                self EXP_updateEXP(level.exp_assistvalue);
                text = game["exp_tripleKillText"];
                break;
            case "multi_kill":
                self EXP_updateEXP(level.exp_killvalue);
                text = game["exp_multiKillText"];
                break;
            case "bloodthirsty":
                self EXP_updateEXP(level.exp_killvalue);
                text = game["exp_fiveKillText"];
                break;
            case "killing_spree":
                self EXP_updateEXP(level.exp_killvalue);
                text = game["exp_tenKillText"];
                break; 
            case "bomb_plant":
                self EXP_updateEXP(level.exp_killvalue);
                self thread EXP_HudPop(level.exp_killvalue);
                text = game["bombPlantedText"];
                break;
            case "bomb_defuse":
                self EXP_updateEXP(level.exp_killvalue);
                self thread EXP_HudPop(level.exp_killvalue);
                text = game["bombDefusedText"];
                break;
            case "flag_take":
                self EXP_updateEXP(level.exp_assistvalue);
                self thread EXP_HudPop(level.exp_assistvalue);
                text = game["exp_takeFlagText"];
                break;
            case "flag_returned":
                self EXP_updateEXP(level.exp_assistvalue);
                self thread EXP_HudPop(level.exp_assistvalue);
                text = game["exp_returnFlagText"];
                break;
            case "flag_captured":
                self EXP_updateEXP(level.exp_killvalue);
                self thread EXP_HudPop(level.exp_killvalue);
                text = game["exp_captureFlagText"];
                break;
            case "flag_defense":
                self EXP_updateEXP(level.exp_assistvalue);
                self thread EXP_HudPop(level.exp_assistvalue);
                text = game["exp_defendFlagText"];
                break;
            case "flag_assist":
                self EXP_updateEXP(level.exp_assistvalue);
                self thread EXP_HudPop(level.exp_assistvalue);
                text = game["exp_assistFlagText"];
                break;
            case "bel_survived":
                self EXP_updateEXP(level.exp_assistvalue);
                self thread EXP_HudPop(level.exp_assistvalue);
                text = game["exp_survivedText"];
                break;
            case "bel_kill_allied":
                self EXP_updateEXP(level.exp_killvalue);
                self thread EXP_HudPop(level.exp_killvalue);
                text = game["exp_killAlliedText"];
                break;
            case "re_pickup":
                self EXP_updateEXP(level.exp_assistvalue);
                self thread EXP_HudPop(level.exp_assistvalue);
                text = game["exp_pickupText"];
                break;
            case "re_captured":
                self EXP_updateEXP(level.exp_killvalue);
                self thread EXP_HudPop(level.exp_killvalue);
                text = game["exp_captureText"];
                break;
            case "radio_captured":
                self EXP_updateEXP(level.exp_killvalue);
                self thread EXP_HudPop(level.exp_killvalue);
                text = game["exp_captureRadioText"];
                break;
            case "radio_destroyed":
                self EXP_updateEXP(level.exp_killvalue);
                self thread EXP_HudPop(level.exp_killvalue);
                text = game["exp_destroyRadioText"];
                break;
            case "radio_hold":
                self EXP_updateEXP(level.exp_assistvalue);
                self thread EXP_HudPop(level.exp_assistvalue);
                text = game["exp_holdRadioText"];
                break;
        }
        self thread EXP_HudSlam(text); //TODO implement significant notification menu
        self.notification = undefined;
    }
}

createEXPHUD()
{

    barsize = 100;
	updateBar = false;
    overflow = false;
    
	backgroundOptions = [];
	backgroundOptions["alignX"] = "left";
	backgroundOptions["alignY"] = "middle";
	backgroundOptions["x"] = 519;
	backgroundOptions["y"] = 474;
	backgroundOptions["height"] = 7;
	backgroundOptions["width"] = (barsize + 2);
    backgroundOptions["sort"] = 0;
	
	barOptions = [];
	barOptions["alignX"] = "right";
	barOptions["alignY"] = "middle";
	barOptions["x"] = 620;
	barOptions["y"] = 474;
    barOptions["color"] = ( 0.53, 0.87, 0.96 );
	barOptions["alpha"] = 1;
	barOptions["height"] = 5;
    barOptions["sort"] = 1;

    //if text exists, add it to the progress bar
    textOptions = [];
    textOptions["alignX"] = "center";
    textOptions["alignY"] = "middle";
    textOptions["x"] = 570;
    textOptions["y"] = 473;
    textOptions["fontscale"] = 0.45;
    //textOptions["color"] = (.5,.5,.5);
    textOptions["sort"] = 2; //draw ontop of bar

    lvlOptions = [];
    lvlOptions["alignX"] = "right";
    lvlOptions["alignY"] = "middle";
    lvlOptions["x"] = 518;
    lvlOptions["y"] = 473;
    lvlOptions["fontscale"] = 0.6;
    //textOptions["color"] = (.5,.5,.5);
    lvlOptions["sort"] = 2; //draw ontop of bar
    lvlOptions["label"] = game["lvlText"];

    if(!isDefined(self maps\mp\uox\_uox_hud::getClientHUDElement("exp_lvl")))
        self maps\mp\uox\_uox_hud::updateClientHUDElement("exp_lvl",
		"number", self.pers["level"], lvlOptions);

    if(!isDefined(self maps\mp\uox\_uox_hud::getClientHUDElement("exp_bardiv")))
	self maps\mp\uox\_uox_hud::updateClientHUDElement("exp_bardiv",
		"text", game["dividerText"], textOptions);

    textOptions["alignX"] = "right";
    textOptions["x"] = 569;

    num = self maps\mp\uox\_uox_hud::getClientHUDElement("exp_barnum");
    if(!isDefined(num))
    {
        num = self maps\mp\uox\_uox_hud::updateClientHUDElement("exp_barnum",
            "number", self.pers["exp"], textOptions);
        num.exp = self.pers["exp"];
    }
    else if(num.exp != self.pers["exp"])
    {
        num = self maps\mp\uox\_uox_hud::updateClientHUDElement("exp_barnum",
            "number", self.pers["exp"], textOptions);
        num.exp = self.pers["exp"];
        updateBar = true;
    }
    
    textOptions["alignX"] = "left";
    textOptions["x"] = 571;

    denom = self maps\mp\uox\_uox_hud::getClientHUDElement("exp_bardenom");
    if(!isDefined(denom))
    {
        xp = getLevelExperience( ( self.pers["level"] + 1 ) );
		denom = self maps\mp\uox\_uox_hud::updateClientHUDElement("exp_bardenom",
			"number", xp, textOptions);
		denom.lvl = self.pers["level"];
        denom.exp = xp;
	}
	else if(self.pers["level"] != denom.lvl)
	{
        xp = getLevelExperience( ( self.pers["level"] + 1 ) );
		denom = self maps\mp\uox\_uox_hud::updateClientHUDElement("exp_bardenom",
			"number", xp, textOptions);
        self maps\mp\uox\_uox_hud::updateClientHUDElement("exp_lvl",
            "number", self.pers["level"], lvlOptions);
		denom.lvl = self.pers["level"];
        denom.exp = xp;
        overflow = true;
	}
    width = 100 * ( self.pers["exp"] / ( denom.exp * 1.0 ) );
    if(width == 0)
        barOptions["width"] = 1;
    else if (overflow)
        barOptions["width"] = 100;
    else 
	    barOptions["width"] = width;

	//test if element already exists, don't spam hud updates
	if(!isDefined(self maps\mp\uox\_uox_hud::getClientHUDElement("exp_barbackground")))
		self maps\mp\uox\_uox_hud::updateClientHUDElement("exp_barbackground",
			"shader", "white", backgroundOptions);

	//test if element already exists, don't spam hud updates
	if(!isDefined(self maps\mp\uox\_uox_hud::getClientHUDElement("exp_bar")))
    {
        self maps\mp\uox\_uox_hud::updateClientHUDElement("exp_bar",
            "shader", "white", barOptions);
    }
    else if(updateBar)
    {
        if(overflow) //fill bar and then animate to new spot on exp bar
        {
            self maps\mp\uox\_uox_hud::animateClientHUDElement("exp_bar",
                "scaleShader", barOptions, (level.framerate/4) * (level.frametime/2));
            barOptions["width"] = 1;
            wait (level.framerate/4) * (level.frametime/2);
            self maps\mp\uox\_uox_hud::updateClientHUDElement("exp_bar",
            "shader", "white", barOptions);
            barOptions["width"] = width;
            self maps\mp\uox\_uox_hud::animateClientHUDElement("exp_bar",
                "scaleShader", barOptions, (level.framerate/4) * (level.frametime/2));
        }
        else
            self maps\mp\uox\_uox_hud::animateClientHUDElement("exp_bar",
                "scaleShader", barOptions, (level.framerate/4) * level.frametime);
    }
    
}

deleteEXPHUD()
{

    self maps\mp\uox\_uox_hud::deleteClientHUDElement("exp_barbackground");
	self maps\mp\uox\_uox_hud::deleteClientHUDElement("exp_bar");
    self maps\mp\uox\_uox_hud::deleteClientHUDElement("exp_bardiv");
    self maps\mp\uox\_uox_hud::deleteClientHUDElement("exp_barnum");
    self maps\mp\uox\_uox_hud::deleteClientHUDElement("exp_bardenom");

}

EXP_CheckKillstreak()
{
    //abort if no killstreak
    if(!isDefined(self.pers["killstreak"]))
        return;
    //get last kill time
    kill = maps\mp\uox\_uox_arrays::getPreviousValue(self.pers["killstreak"]);
    time = kill["time"];
    count = 0;
    killstreak = self.pers["killstreak"]["length"];
    killtime = time;
    //check for multi kill (multiple kills within 2 seconds of last kill)
    while(count < killstreak)
    {
        count++;
        kill = maps\mp\uox\_uox_arrays::getPreviousValue(self.pers["killstreak"],
            killstreak - count);
        if(!isDefined(kill))
            break;
        killtime = kill["time"];
        maps\mp\uox\_uox_debug::debugLog("debug", self.name + " kill #" + count + " was " +((time - killtime)/1000) + " seconds ago . killed player " + kill["victim"]);
        if((time - killtime)/1000 > 2 )
            break; 
    }
    if(count == 2)
        self.notification = "double_kill";
    else if(count == 3)
        self.notification = "triple_kill";
    if(killstreak == 5)
        self.notification = "bloodthirsty";
    if(count > 3)
        self.notification = "multi_kill"; 
    if(killstreak == 10)
        self.notification = "killing_spree";
    
}

// ----------------------------------------------------------------------------------
//	RankHudInit
//
// 		Sets up the rank hud icon
// ----------------------------------------------------------------------------------
EXP_RankHudInit()
{
	if(!level.exp_drawrankicon)
    {
        return;
    }
		
	self endon("death");
	self notify("rank RankHudInit");
	
	wait level.frametime;
	self endon("rank RankHudInit");
	
    self thread EXP_RankHudSetShader();
	self thread EXP_RankHudMonitor();
	self thread EXP_RankHudDestroy();
}		

// ----------------------------------------------------------------------------------
//	RankHudSetShader
//
// 		Sets up the rank hud icon to the appropriate shader for the rank
// ----------------------------------------------------------------------------------
EXP_RankHudSetShader(rank_change)
{
	self endon("death");
	self endon("rank RankHudInit");

    options = [];
    options["alignX"] = "center";
    options["alignY"] = "middle";
    options["x"] = 119;
    options["y"] = 405;
    options["alpha"] = 0.7;
	
	if ( isDefined(rank_change) && rank_change )
	{
        options["width"] = 78;
        options["height"] = 96;
		self maps\mp\uox\_uox_hud::updateClientHUDElement("rank_hud_icon", "shader", EXP_GetRankStatusIcon(self), options);
		options["width"] = 26;
        options["height"] = 32;
    	self maps\mp\uox\_uox_hud::animateClientHUDElement("rank_hud_icon", "scaleShader", options, 3);	
	}
	else
	{
		options["width"] = 26;
        options["height"] = 32;
    	self maps\mp\uox\_uox_hud::updateClientHUDElement("rank_hud_icon", "shader", EXP_GetRankStatusIcon(self), options);	
	}
}

// ----------------------------------------------------------------------------------
//	RankHudDestroy
//
// 		Sets up the rank hud icon to the appropriate shader for the rank
// ----------------------------------------------------------------------------------
EXP_RankHudDestroy()
{
	self thread EXP_RankHudDestroy2();
	self endon("rank RankHudInit");
	self waittill("death");
	
	self maps\mp\uox\_uox_hud::deleteClientHUDElement("rank_hud_icon");
}

// ----------------------------------------------------------------------------------
//	RankHudDestroy
//
// 		Sets up the rank hud icon to the appropriate shader for the rank
// ----------------------------------------------------------------------------------
EXP_RankHudDestroy2()
{
	self endon("death");
	self endon("rank RankHudInit");

	while ( level.exp_drawrankicon )
	 	wait level.frametime;
	
	self maps\mp\uox\_uox_hud::deleteClientHUDElement("rank_hud_icon");
}

// ----------------------------------------------------------------------------------
//	RankHudSetShader
//
// 		Sets up the rank hud icon to the appropriate shader for the rank
// ----------------------------------------------------------------------------------
EXP_RankHudMonitor()
{
	self endon("death");
	self endon("rank RankHudInit");
	
	while ( level.exp_drawrankicon )
	{
		self waittill("level updated", direction);
		if ( direction )
        {
            if(!(self.pers["level"] % [[level.getVars]]("exp_levelsperrank")) && isDefined(EXP_GetRankStatusIcon(self)))
            {
                maps\mp\gametypes\_rank_gmi::PlayPromotionSound(self);
                iprintln(self.name + " ^7has been promoted to " + EXP_GetRankName(self) + ".");		
            }
        }
        // or demoted?
        else
        {
            maps\mp\gametypes\_rank_gmi::PlayDemotionSound(self);
            iprintln(self.name + " ^7was demoted to " + EXP_GetRankName(self) + ".");			
        }
		self thread EXP_RankHudSetShader(true);
		wait level.frametime;
	}
	
	self maps\mp\uox\_uox_hud::deleteClientHUDElement("rank_hud_icon");
}

// ----------------------------------------------------------------------------------
//	GetRankStatusIcon
//
//		Returns the appropriate status rank icon
// ----------------------------------------------------------------------------------
EXP_GetRankStatusIcon(player)
{	
	if ( player.pers["team"] == "spectator" )
		return "";

    rank = (player.pers["level"] / [[level.getVars]]("exp_levelsperrank"));
		
	icon_name = "br_hudicons_allies_" + rank;
	
	return game[icon_name];
}

// ----------------------------------------------------------------------------------
//	GetRankName
//
//		Returns the appropriate rank name
// ----------------------------------------------------------------------------------
EXP_GetRankName(player)
{	

    rank = (player.pers["level"] / [[level.getVars]]("exp_levelsperrank"));
		
	switch(rank)
    {
        case 0:
            return "Private";
        case 1:
            return "Corporal";
        case 2:
            return "Seargant";
        case 3:
            return "Lieutenant";
        case 4:
            return "Commander";
    }
    return "DSR";
}

// Returns the total XP needed to be at least level lvl.
getLevelExperience(lvl)
{
	if(lvl <= 1)
		return 0;

	b = (lvl - 1) / 20;

	a = 30 + 10 * b;
	beta = -60 - 10 * b - 200 * b * (b + 1);

	// b(b+1)(2b+1) is always divisible by 6, so multiply first, then divide
	c = 30 + 100 * b * (b + 1) + 4000 * (b * (b + 1) * (2 * b + 1) / 6);

	return a * lvl * lvl + beta * lvl + c;
}

// Returns the current level for a given total XP.
getLevel(xp)
{
	if(xp <= 0)
		return 1;

	// find bounds where getLevelExperience(lo) <= xp < getLevelExperience(hi)
	lo = 1;
	hi = 2;
	while(getLevelExperience(hi) <= xp)
	{
		lo = hi;
		hi = hi * 2;
	}

	// binary search between them
	while(hi - lo > 1)
	{
		mid = (lo + hi) / 2;

		if(getLevelExperience(mid) <= xp)
			lo = mid;
		else
			hi = mid;
	}

	return lo;
}

