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
}

EXP_Precache()
{
    game["plusText"] = &"+";
    precacheString(game["plusText"]);
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
		
    if(isPlayer(attacker) && (attacker == self))
    	    return;
    	    
    if(!isDefined(self.assistDamage))
        return;
        
    time = getTime();
    attackerNum = attacker getEntityNumber();
    
    killxp = level.exp_killvalue;
    if(attacker.pers["team"] == self.pers["team"] && !level.uox_teamplay)
        killxp = killxp * -1;

    botMultiplier = 1;
    if(isDefined(self.pers["isBot"]))
       botMultiplier = 0.5;

    killxp = killxp * level.exp_multiplier * botMultiplier;
    
    //remove the killer from the assist array
    self.assistDamage = maps\mp\uox\_uox_arrays::arrayPop(self.assistDamage, attackerNum);
    
    //pop the xp text on the killing player 
    attacker thread EXP_HudPop(killxp);

    //pop the assist text on the assisting players
    thread maps\mp\uox\_uox_arrays::arrayReadEach(self.assistDamage, ::EXP_PopAssists);
    //delete the array
    self.assistDamage = undefined;
}

EXP_PlayerConnect()
{
    //load player level. watch for stat menu?
}

EXP_PlayerDisconnect()
{
    //save player level.
}

updateKillValue(xp)
{
    level.exp_killvalue = xp;
}

updateAssistValue(xp)
{
    level.exp_assistvalue = xp;
}

EXP_PopAssists(damage)
{
    if(!isDefined(damage["attacker"]))
        return;
        
    if(!isPlayer(damage["attacker"])) //return if player is no longer valid
        return;
        
    assistxp = level.exp_assistvalue;
    if(damage["attacker"].pers["team"] == damage["victim"].pers["team"])
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
        
    damage["attacker"] thread EXP_HudPop(assistxp);   
}

EXP_HudPop(value)
{
    self notify("exp_pop");
    
    options = [];
    options["x"] = 320;
    options["y"] = 320;
    options["alignX"] = "left";
    options["alignY"] = "middle";
    options["alpha"] = 0;
    //options["font"] = "bigfixed";
    _options = [];
    _options["x"] = 320;
    _options["y"] = 320;
    _options["alignX"] = "right";
    _options["alignY"] = "middle";
    _options["alpha"] = 0;
    //_options["font"] = "bigfixed";

    element = self maps\mp\uox\_uox_hud::updateClientHUDElement("exp_pop", "number", value, options);
    
    
    if(!isDefined(element.exp_value))
        element.exp_value = value;
    else 
        element.exp_value += value;
        
    maps\mp\uox\_uox_debug::debugLog("debug", self.name + " create damage pop of value " + element.exp_value); 
    
    if(value >= 0)    
        sign = game["plusText"];
    else
        sign = undefined;
    
    if(isDefined(sign))
        _element = self maps\mp\uox\_uox_hud::updateClientHUDElement("exp_pop+", "text", sign, _options);
        
    self maps\mp\uox\_uox_hud::updateClientHUDElement("exp_pop", "number", element.exp_value, options); 
        
    self thread maps\mp\uox\_uox_hud::popText(element, 1.5);
    if(isDefined(sign))
        self thread maps\mp\uox\_uox_hud::popText(_element, 1.5);
    
    wait level.frametime;
    self endon("exp_pop");
    self endon("hud_clear");
    
    wait 1.5 - level.frametime;
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
