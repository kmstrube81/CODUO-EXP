getCallsigns()
{
	array = [];
	array[0] = &"PC_CALLSIGN0";
	array[1] = &"PC_CALLSIGN1";
	array[2] = &"PC_CALLSIGN2";
	array[3] = &"PC_CALLSIGN3";
	array[4] = &"PC_CALLSIGN4";
	array[5] = &"PC_CALLSIGN5";
	array[6] = &"PC_CALLSIGN6";
	array[7] = &"PC_CALLSIGN7";
	array[8] = &"PC_CALLSIGN8";
	array[9] = &"PC_CALLSIGN9";
	array[10] = &"PC_CALLSIGN10";
	array[11] = &"PC_CALLSIGN11";
	array[12] = &"PC_CALLSIGN12";
	array[13] = &"PC_CALLSIGN13";
	array[14] = &"PC_CALLSIGN14";
	array[15] = &"PC_CALLSIGN15";
	array[16] = &"PC_CALLSIGN16";
	array[17] = &"PC_CALLSIGN17";
	array[18] = &"PC_CALLSIGN18";
	array[19] = &"PC_CALLSIGN19";
	array[20] = &"PC_CALLSIGN20";
	array[21] = &"PC_CALLSIGN21";
	array[22] = &"PC_CALLSIGN22";
	array[23] = &"PC_CALLSIGN23";
	array[24] = &"PC_CALLSIGN24";
	array[25] = &"PC_CALLSIGN25";
	array[26] = &"PC_CALLSIGN26";
	array[27] = &"PC_CALLSIGN27";
	array[28] = &"PC_CALLSIGN28";
	array[29] = &"PC_CALLSIGN29";
	array[30] = &"PC_CALLSIGN30";
	array[31] = &"PC_CALLSIGN31";
	array[32] = &"PC_CALLSIGN32";
	array[33] = &"PC_CALLSIGN33";
	array[34] = &"PC_CALLSIGN34";
	array[35] = &"PC_CALLSIGN35";
	array[36] = &"PC_CALLSIGN36";
	array[37] = &"PC_CALLSIGN37";
	array[38] = &"PC_CALLSIGN38";
	array[39] = &"PC_CALLSIGN39";
	array[40] = &"PC_CALLSIGN40";
	array[41] = &"PC_CALLSIGN41";
	array[42] = &"PC_CALLSIGN42";
	array[43] = &"PC_CALLSIGN43";
	array[44] = &"PC_CALLSIGN44";
	
	for(i = 0; i < array.size; i++)
	{
		precacheString(array[i]);
	}
	
	return array;
}

getMenuCallsigns()
{
	array = [];
	array[0] = "@PC_CALLSIGN0";
	array[1] = "@PC_CALLSIGN1";
	array[2] = "@PC_CALLSIGN2";
	array[3] = "@PC_CALLSIGN3";
	array[4] = "@PC_CALLSIGN4";
	array[5] = "@PC_CALLSIGN5";
	array[6] = "@PC_CALLSIGN6";
	array[7] = "@PC_CALLSIGN7";
	array[8] = "@PC_CALLSIGN8";
	array[9] = "@PC_CALLSIGN9";
	array[10] = "@PC_CALLSIGN10";
	array[11] = "@PC_CALLSIGN11";
	array[12] = "@PC_CALLSIGN12";
	array[13] = "@PC_CALLSIGN13";
	array[14] = "@PC_CALLSIGN14";
	array[15] = "@PC_CALLSIGN15";
	array[16] = "@PC_CALLSIGN16";
	array[17] = "@PC_CALLSIGN17";
	array[18] = "@PC_CALLSIGN18";
	array[19] = "@PC_CALLSIGN19";
	array[19] = "@PC_CALLSIGN19";
	array[20] = "@PC_CALLSIGN20";
	array[21] = "@PC_CALLSIGN21";
	array[22] = "@PC_CALLSIGN22";
	array[23] = "@PC_CALLSIGN23";
	array[24] = "@PC_CALLSIGN24";
	array[25] = "@PC_CALLSIGN25";
	array[26] = "@PC_CALLSIGN26";
	array[27] = "@PC_CALLSIGN27";
	array[28] = "@PC_CALLSIGN28";
	array[29] = "@PC_CALLSIGN29";
	array[30] = "@PC_CALLSIGN30";
	array[31] = "@PC_CALLSIGN31";
	array[32] = "@PC_CALLSIGN32";
	array[33] = "@PC_CALLSIGN33";
	array[34] = "@PC_CALLSIGN34";
	array[35] = "@PC_CALLSIGN35";
	array[36] = "@PC_CALLSIGN36";
	array[37] = "@PC_CALLSIGN37";
	array[38] = "@PC_CALLSIGN38";
	array[39] = "@PC_CALLSIGN39";
	array[40] = "@PC_CALLSIGN40";
	array[41] = "@PC_CALLSIGN41";
	array[42] = "@PC_CALLSIGN42";
	array[43] = "@PC_CALLSIGN43";
	array[44] = "@PC_CALLSIGN44";
	
	return array;
}

getBackgrounds()
{

	array = [];
	
	array[array.size] = "gfx/backgrounds/hud@aa-uo_mp.dds";
	array[array.size] = "gfx/backgrounds/hud@aa-vcod-american.dds";
	array[array.size] = "gfx/backgrounds/hud@aa-vcod-british.dds";
	array[array.size] = "gfx/backgrounds/hud@aa-vcod-russian.dds";
	array[array.size] = "gfx/backgrounds/hud@aaz-usa-flag.dds";
	array[array.size] = "gfx/backgrounds/hud@picklejuice.dds";
	array[array.size] = "gfx/backgrounds/hud@punches.dds";
	array[array.size] = "gfx/backgrounds/hud@spider.dds";
	array[array.size] = "gfx/backgrounds/hud@butterfly.dds";
	array[array.size] = "gfx/backgrounds/hud@bullet.dds";
	array[array.size] = "gfx/backgrounds/hud@fourthofjuly.dds";
	array[array.size] = "gfx/backgrounds/hud@shark.dds";
	array[array.size] = "gfx/backgrounds/hud@blackcat.dds";
	array[array.size] = "gfx/backgrounds/hud@bloodsplat.dds";
	array[array.size] = "gfx/backgrounds/hud@benjamins.dds";
	array[array.size] = "gfx/backgrounds/hud@dice.dds";
	array[array.size] = "gfx/backgrounds/hud@way2fast.dds";
	array[array.size] = "gfx/backgrounds/hud@makeitrain.dds";
	array[array.size] = "gfx/backgrounds/hud@weed.dds";
	array[array.size] = "gfx/backgrounds/hud@tiger.dds";
	array[array.size] = "gfx/backgrounds/hud@potogold.dds";
	array[array.size] = "gfx/backgrounds/hud@spy.dds";
	array[array.size] = "gfx/backgrounds/hud@paddle.dds";
	array[array.size] = "gfx/backgrounds/hud@smokeem.dds";
	array[array.size] = "gfx/backgrounds/hud@aaz-canada-flag.dds";
	array[array.size] = "gfx/backgrounds/hud@aaz-elsalvador-flag.dds";
	array[array.size] = "gfx/backgrounds/hud@aaz-german-flag.dds";
	array[array.size] = "gfx/backgrounds/hud@aaz-mexico-flag.dds";
	array[array.size] = "gfx/backgrounds/hud@aaz-poland-flag.dds";
	array[array.size] = "gfx/backgrounds/hud@aaz-uk-flag.dds";
	
	// bubble sort using manual string comparison
	for(i = 0; i < array.size; i++)
	{
		for(j = i + 1; j < array.size; j++)
		{
			if(compareStrings(array[j], array[i]) < 0)
			{
				temp = array[i];
				array[i] = array[j];
				array[j] = temp;
			}
		}
	}
	
	for(i = 0; i < array.size; i++)
	{
		precacheShader(array[i]);
	}
	
	return array;
}

getEmblems()
{
	array = [];
	array[array.size] = "gfx/emblems/hud@bar_mp.dds";
	array[array.size] = "gfx/emblems/hud@bazooka_mp.dds";
	array[array.size] = "gfx/emblems/hud@binoculars_mp.dds";
	array[array.size] = "gfx/emblems/hud@bren_mp.dds";
	array[array.size] = "gfx/emblems/hud@brutalamish.dds";
	array[array.size] = "gfx/emblems/hud@camper.dds";
	array[array.size] = "gfx/emblems/hud@colt_mp.dds";
	array[array.size] = "gfx/emblems/hud@emoji57.dds";
	array[array.size] = "gfx/emblems/hud@empire.dds";
	array[array.size] = "gfx/emblems/hud@enfield_mp.dds";
	array[array.size] = "gfx/emblems/hud@fg42_mp.dds";
	array[array.size] = "gfx/emblems/hud@flamethrower_mp.dds";
	array[array.size] = "gfx/emblems/hud@fraggrenade_mp.dds";
	array[array.size] = "gfx/emblems/hud@gay69.dds";
	array[array.size] = "gfx/emblems/hud@gewehr_mp.dds";
	array[array.size] = "gfx/emblems/hud@greenthumb.dds";
	array[array.size] = "gfx/emblems/hud@jumpman.dds";
	array[array.size] = "gfx/emblems/hud@kar98k_mp.dds";
	array[array.size] = "gfx/emblems/hud@kar98k_sniper_mp.dds";
	array[array.size] = "gfx/emblems/hud@luger_mp.dds";
	array[array.size] = "gfx/emblems/hud@m1carbine_mp.dds";
	array[array.size] = "gfx/emblems/hud@m1garand_mp.dds";
	array[array.size] = "gfx/emblems/hud@mg34_mp.dds";
	array[array.size] = "gfx/emblems/hud@mg42_mp.dds";
	array[array.size] = "gfx/emblems/hud@mk1britishfrag_mp.dds";
	array[array.size] = "gfx/emblems/hud@mod_melee.dds";
	array[array.size] = "gfx/emblems/hud@mosin_nagant_mp.dds";
	array[array.size] = "gfx/emblems/hud@mosin_nagant_sniper_mp.dds";
	array[array.size] = "gfx/emblems/hud@mp40_mp.dds";
	array[array.size] = "gfx/emblems/hud@mp44_mp.dds";
	array[array.size] = "gfx/emblems/hud@ninja.dds";
	array[array.size] = "gfx/emblems/hud@none.dds";
	array[array.size] = "gfx/emblems/hud@panzerfaust_mp.dds";
	array[array.size] = "gfx/emblems/hud@panzerschreck_mp.dds";
	array[array.size] = "gfx/emblems/hud@ppsh_mp.dds";
	array[array.size] = "gfx/emblems/hud@ra.dds";
	array[array.size] = "gfx/emblems/hud@ratcumfarmer.dds";
	array[array.size] = "gfx/emblems/hud@rgd-33russianfrag_mp.dds";
	array[array.size] = "gfx/emblems/hud@satchelcharge_mp.dds";
	array[array.size] = "gfx/emblems/hud@silenced_sten_mp.dds";
	array[array.size] = "gfx/emblems/hud@springfield_mp.dds";
	array[array.size] = "gfx/emblems/hud@steilhandgrenate_mp.dds";
	array[array.size] = "gfx/emblems/hud@sten_mp.dds";
	array[array.size] = "gfx/emblems/hud@svt40_mp.dds";
	array[array.size] = "gfx/emblems/hud@targetmaster.dds";
	array[array.size] = "gfx/emblems/hud@thompson_mp.dds";
	array[array.size] = "gfx/emblems/hud@touchgrass.dds";
	array[array.size] = "gfx/emblems/hud@tt33_mp.dds";
	array[array.size] = "gfx/emblems/hud@webley_mp.dds";
	array[array.size] = "gfx/emblems/hud@sipsOJ.dds";
	
	// bubble sort using manual string comparison
	for(i = 0; i < array.size; i++)
	{
		for(j = i + 1; j < array.size; j++)
		{
			if(compareStrings(array[j], array[i]) < 0)
			{
				temp = array[i];
				array[i] = array[j];
				array[j] = temp;
			}
		}
	}
	
	for(i = 0; i < array.size; i++)
	{
		precacheShader(array[i]);
	}
	
	return array;
}

precachePlayerCardElems()
{
	game["menu_playercard"] = "menu_playercard";
	precacheMenu(game["menu_playercard"]);
	game["emblems"] = getEmblems();
	game["playercards"] = getBackgrounds();
	game["callsigns"] = getCallsigns();
	game["menu_callsigns"] = getMenuCallsigns();
	precacheString(&"K: ");
	precacheString(&"D: ");
	precacheString(&"S: ");
}

drawPlayerCard(player, pos)
{
	if(level.exp_drawplayercards != 1)
		return;

	self notify("flash_playercard");
	
	if(!isDefined(player) || !isPlayer(player))
		return;
    
	playercard_size = level.exp_playercard_size;	
	
	emblemIndex = player.pers["emblem"];
	
    if(emblemIndex >= game["emblems"].size)
        emblemIndex = 0;

	emblem = game["emblems"][emblemIndex];
		
	backgroundIndex = player.pers["background"];
	if(backgroundIndex >= game["playercards"].size)
        backgroundIndex = 0;

	playercard = game["playercards"][backgroundIndex];
		
	callsignIndex = player.pers["callsign"];
	if(callsignIndex >= game["callsigns"].size)
        callsignIndex = 0;

	callsign = game["callsigns"][callsignIndex];
		
	kills = player.pers["totalkills"];
    
	deaths = player.pers["totaldeaths"];

	skills = player.pers["skill"];

    if(!isDefined(kills))
        kills = self.pers["kills"];
    if(!isDefined(deaths))
        deaths = self.pers["deaths"];
    if(!isDefined(skill))
        skill = 0;
	
	options = [];
    options["sort"] = 1;
    options["color"] = (1,1,1);
    options["alpha"] = 0.8;
    options["archived"] = false;

    emblemOptions = [];
    emblemOptions["sort"] = 2;
    emblemOptions["alpha"] = 0.8;
    emblemOptions["archived"] = false;

    callsignOptions = [];
    callsignOptions["alignX"] = "center";
    callsignOptions["sort"] = 3;
    callsignOptions["font"] = "default";
    callsignOptions["alpha"] = 0.8;
    callsignOptions["archived"] = false;

    guiOptions = [];
    guiOptions["sort"] = 3;
    guiOptions["font"] = "default";
    guiOptions["alpha"] = 0.8;
    guiOptions["archived"] = false;
	
	switch(pos)
    {
        case 0:
        case 1:
            playercardY = 320;
            break;
        case 2:
            self iprintlnbold("Killed By " + player.name);
            playercardY = 150;
            break;
        default:
            playercardY = 376;
    }
	
	switch(playercard_size)
	{
		case 1:
			options["width"] = 128;
			options["height"] = 32;
			options["x"] = 256;
			options["y"] = playercardY;
            options["width"] = 128;
            options["height"] = 32;
            self maps\mp\uox\_uox_hud::updateClientHUDElement("playercard", "shader", playercard, options);

			emblemOptions["width"] = 32;
			emblemOptions["height"] = 32;
			emblemOptions["x"] = 352;
			emblemOptions["y"] = playercardY;
            self maps\mp\uox\_uox_hud::updateClientHUDElement("emblem", "shader", emblem, emblemOptions);
			
			callsignOptions["x"] = 304;
			callsignOptions["y"] = playercardY + 1;
			callsignOptions["fontscale"] = 0.8;
            self maps\mp\uox\_uox_hud::updateClientHUDElement("callsign", "text", callsign, callsignOptions);

            guiOptions["label"] = &"K: ";
			guiOptions["x"] = 260;
			guiOptions["y"] = playercardY + 11;
			guiOptions["fontscale"] = 0.8;
            self maps\mp\uox\_uox_hud::updateClientHUDElement("totalkills", "number", kills, guiOptions);

            guiOptions["label"] = &"D: ";
			guiOptions["x"] = 308;
            self maps\mp\uox\_uox_hud::updateClientHUDElement("totaldeaths", "number", deaths, guiOptions);

            guiOptions["label"] = &"S: ";
			guiOptions["x"] = 260;
			guiOptions["y"] = playercardY + 21;
            self maps\mp\uox\_uox_hud::updateClientHUDElement("skill", "number", skill, guiOptions);
			break;
		case 2:
			options["width"] = 192;
			options["height"] = 48;
			options["x"] = 224;
			options["y"] = playercardY;
            options["width"] = 192;
            options["height"] = 48;
			self maps\mp\uox\_uox_hud::updateClientHUDElement("playercard", "shader", playercard, options);

			emblemOptions["width"] = 48;
			emblemOptions["height"] = 48;
			emblemOptions["x"] = 368;
			emblemOptions["y"] = playercardY;
			self maps\mp\uox\_uox_hud::updateClientHUDElement("emblem", "shader", emblem, emblemOptions);

			callsignOptions["x"] = 296;
			callsignOptions["y"] = playercardY + 2;
            self maps\mp\uox\_uox_hud::updateClientHUDElement("callsign", "text", callsign, callsignOptions);

            guiOptions["label"] = &"K: ";
			guiOptions["x"] = 228;
			guiOptions["y"] = playercardY + 17;
            self maps\mp\uox\_uox_hud::updateClientHUDElement("totalkills", "number", kills, guiOptions);

            guiOptions["label"] = &"D: ";
			guiOptions["x"] = 300;
			guiOptions["y"] = playercardY + 17;
            self maps\mp\uox\_uox_hud::updateClientHUDElement("totaldeaths", "number", deaths, guiOptions);

            guiOptions["label"] = &"S: ";
			guiOptions["x"] = 228;
			guiOptions["y"] = playercardY + 32;
            self maps\mp\uox\_uox_hud::updateClientHUDElement("skill", "number", skill, guiOptions);
			break;
		default:
			options["width"] = 256;
			options["height"] = 64;
			options["x"] = 192;
			options["y"] = playercardY;
            options["width"] = 256;
            options["height"] = 64;
			self maps\mp\uox\_uox_hud::updateClientHUDElement("playercard", "shader", playercard, options);

			emblemOptions["width"] = 64;
			emblemOptions["height"] = 64;
			emblemOptions["x"] = 384;
			emblemOptions["y"] = playercardY;
			self maps\mp\uox\_uox_hud::updateClientHUDElement("emblem", "shader", emblem, emblemOptions);

			callsignOptions["x"] = 288;
			callsignOptions["y"] = playercardY + 2;
            self maps\mp\uox\_uox_hud::updateClientHUDElement("callsign", "text", callsign, callsignOptions);
			
			guiOptions["label"] = &"K: ";
			guiOptions["x"] = 288;
			guiOptions["y"] = playercardY + 22;
            self maps\mp\uox\_uox_hud::updateClientHUDElement("totalkills", "number", kills, guiOptions);

			guiOptions["label"] = &"D: ";
			guiOptions["x"] = 384;
			guiOptions["y"] = playercardY + 22;
            self maps\mp\uox\_uox_hud::updateClientHUDElement("totaldeaths", "number", deaths, guiOptions);

			guiOptions["label"] = &"S: ";
			guiOptions["x"] = 288;
			guiOptions["y"] = playercardY + 42;
            self maps\mp\uox\_uox_hud::updateClientHUDElement("skill", "number", skill, guiOptions);
	}
	
	if(pos > 0)
		self thread waitPlayerCard();
	self thread spawnedPlayerCardCleanup();
	self thread destroyPlayerCard(pos);
		
}

spawnedPlayerCardCleanup()
{
    self endon("disconnect");
	self endon("flash_playercard");
	self endon("destroy_playercard");
	self waittill("spawned");
	
	self notify("destroy_playercard");
}

waitPlayerCard()
{
    self endon("disconnect");
	self endon("flash_playercard");
	self endon("destroy_playercard");
	wait 7;
	
	self notify("destroy_playercard");
}

destroyPlayerCard(pos)
{
	self endon("disconnect");
	self endon("flash_playercard");
	self waittill("destroy_playercard");
	
	if(pos == 2)
	{
		self iprintlnbold(" ");
		self iprintlnbold(" ");
		self iprintlnbold(" ");
		self iprintlnbold(" ");
		self iprintlnbold(" ");
	}
	
    self maps\mp\uox\_uox_hud::deleteClientHUDElement("playercard");
	self maps\mp\uox\_uox_hud::deleteClientHUDElement("emblem");
	self maps\mp\uox\_uox_hud::deleteClientHUDElement("callsign");
	self maps\mp\uox\_uox_hud::deleteClientHUDElement("totalkills");
	self maps\mp\uox\_uox_hud::deleteClientHUDElement("totaldeaths");
	self maps\mp\uox\_uox_hud::deleteClientHUDElement("skill");

}

spectatePlayerCard(spectatedClient)
{
	
	self.oldspec = undefined;
	self.oldorigin = self.origin;//(0,0,0);
    if(!isDefined(spectatedClient)) 
        self.spectatedclient = self getSpectatorClient("next");
    else
        self.spectatedclient = spectatedclient;
	self drawPlayerCard(self.spectatedclient, 0);

    self maps\mp\uox\_uox_inputs::addHoldMelee("spectate prev", false, 0, 0, undefined, ::spectatePrev);
    self maps\mp\uox\_uox_inputs::addHoldFire("spectate next", false, 0, 0, undefined, ::spectateNext);
    self maps\mp\uox\_uox_loops::addToLoop(self, "fast", ::testSpectateClient, "testSpectateClient");
    
	self.exp_spec = true;

    maps\mp\uox\_uox_debug::debugLog("info", self.name + " start playercard spectate.");
	
}

testSpectateClient()
{
    if(self.origin != self.oldorigin) //free spectating
    {
        self.spectatedclient = undefined;
        self notify("destroy_playercard");
    }
		
	self.oldorigin = self.origin; //set new spectate origin setting

    if(isDefined(self.spectatedclient) && isPlayerDead(self.spectatedclient)) //spectate next player if spectated player dies
        self spectateNext();
     if(self.pers["team"] != "spectator" && self.sessionstate == "playing")
     {    //stop spectating
     	self.exp_spec = undefined;
		self notify("destroy_playercard");
        self maps\mp\uox\_uox_inputs::removeHoldMelee("spectate prev");
        self maps\mp\uox\_uox_inputs::removeHoldFire("spectate next");
        self maps\mp\uox\_uox_loops::removeFromLoop(self, "fast", "testSpectateClient");
        maps\mp\uox\_uox_debug::debugLog("info", self.name + " stop playercard spectate because player is playing"); 
        return;
	}
	
    if(isDefined(self.spectatedclient)) //draw the new player card
    {
        if(isDefined(self.oldspec) && self.oldspec != self.spectatedclient)
        {
            self drawPlayerCard(self.spectatedclient, 0);
        }
    }
    self.oldspec = self.spectatedclient;
}

spectateNext()
{
    self.spectatedclient = self getSpectatorClient("next");
    self iprintlnbold(" ");
    self iprintlnbold(" ");
    self iprintlnbold(" ");
    self iprintlnbold(" ");
    name = getPlayerName(self.spectatedclient);
    if(isDefined(name))
        self iprintlnbold("Spectating: " + name); 
}

spectatePrev()
{
    self.spectatedclient = self getSpectatorClient("prev");
    self iprintlnbold(" ");
    self iprintlnbold(" ");
    self iprintlnbold(" ");
    self iprintlnbold(" ");
    name = getPlayerName(self.spectatedclient);
    if(isDefined(name))
        self iprintlnbold("Spectating: " + name);
}

getPlayerName(player)
{
	if(!isDefined(player))
		return undefined;
	
	return player.name;

}

isPlayerDead(spectatedPlayer)
{

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		if(player == self)
			continue;
		if(!isDefined(spectatedPlayer))
		{
			if(self.pers["team"] == "spectator" && player.sessionstate == "playing")
				return true;
			if( player.sessionstate == "playing" && self.pers["team"] != "spectator" && player.pers["team"] == self.pers["team"] )
				return true;
			if( (isDefined(level.allowenemyspectate) && !level.allowenemyspectate) && self.pers["team"] != "spectator" && player.pers["team"] != self.pers["team"] )
				return true;
		}
		if(spectatedPlayer == player)
		{
			if ((player.sessionstate == "dead" || player.sessionstate == "spectator") || (isDefined(player.pers["team"]) && player.pers["team"] == "spectator") || ((isDefined(level.allowenemyspectate) && !level.allowenemyspectate) && player.pers["team"] != self.pers["team"] && self.pers["team"] != "spectator" ))
				return true;
		}
	}
	return false;
}

getSpectatorClient(dir)
{
	if(!isDefined(self.spectatedclient))
		id = -1;
	else id = self.spectatedclient getEntityNumber();
	
	clients = [];
	
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		if(isDefined(player.pers["team"]) && player.pers["team"] == "spectator")
			continue;
			
		if(player.sessionstate != "playing")
			continue;
		
		if ( (isDefined(level.allowenemyspectate) && !level.allowenemyspectate) && player.pers["team"] != self.pers["team"] && self.pers["team"] != "spectator" )
			continue;
		
		clients[clients.size] = player;
			
	}
	for(i = 0; i < clients.size; i++)
	{
		if(!isDefined(min) || min > clients[i] getEntityNumber())
		{
			min = clients[i] getEntityNumber();
			min_index = i;
		}
		if(!isDefined(max) || max < clients[i] getEntityNumber())
		{
			max = clients[i] getEntityNumber();
			max_index = i;
		}
			
		if(clients[i] getEntityNumber() > id)
		{
			if(!isDefined(next) || clients[i] getEntityNumber() < next)
			{
				next = clients[i] getEntityNumber();
				next_index = i;
			}
		}
		else if(clients[i] getEntityNumber() < id)
		{
			if(!isDefined(prev) || clients[i] getEntityNumber() > prev)
			{
				prev = clients[i] getEntityNumber();
				prev_index = i;
			}
		}
	}
	
	
	switch(dir)
	{
		case "next":
			if(id == -1 || !isDefined(next))
				if(isDefined(min))
					return clients[min_index]; //lowest client num
				else
					return undefined;
			else
				return clients[next_index];
		case "prev":
			if(id == -1 || !isDefined(prev))
				if(isDefined(max))
					return clients[max_index]; //highest client num
				else
					return undefined;
			else
				return clients[prev_index];
	}
	
	return undefined;
}

handleMenuResponse(response, optional)
{

	emblemIndex = self.pers["emblem"];
		
	emblem = game["emblems"][emblemIndex];
		
	backgroundIndex = self.pers["background"];
		
	playercard = game["playercards"][backgroundIndex];
		
	callsignIndex = self.pers["callsign"];
		
	callsign = game["menu_callsigns"][callsignIndex];
		
	kills = self.pers["totalkills"];
		
	deaths = self.pers["totaldeaths"];

	skill = self.pers["skill"];

	if(!isDefined(kills))
        kills = self.pers["kills"];
    if(!isDefined(deaths))
        deaths = self.pers["deaths"];
    if(!isDefined(skill))
        skill = 0;

	self setClientCvar("ui_playercard_cs", callsign);
	self setClientCvar("ui_playercard_em", emblem);
	self setClientCvar("ui_playercard_bg", playercard);
	self setClientCvar("ui_playercard_ks", "K: " + kills);
	self setClientCvar("ui_playercard_ds", "D: " + deaths);
	self setClientCvar("ui_playercard_sk", "S: " + skill);
	
	switch(response)
	{		
		case "prevCS":
			self.pers["callsign"]--;
			if(self.pers["callsign"] < 0)
				self.pers["callsign"] = game["menu_callsigns"].size - 1;
			self setClientCvar("ui_playercard_cs", game["menu_callsigns"][self.pers["callsign"]]);
			break;
		case "nextCS":
			self.pers["callsign"]++;
			if(self.pers["callsign"] >= game["callsigns"].size)
				self.pers["callsign"] = 0;
			self setClientCvar("ui_playercard_cs", game["menu_callsigns"][self.pers["callsign"]]);
			break;
		case "prevEM":
			self.pers["emblem"]--;
			if(self.pers["emblem"] < 0)
				self.pers["emblem"] = game["emblems"].size - 1;
			self setClientCvar("ui_playercard_em", game["emblems"][self.pers["emblem"]]);
			break;
		case "nextEM":
			self.pers["emblem"]++;
			if(self.pers["emblem"] >= game["emblems"].size)
				self.pers["emblem"] = 0;
			self setClientCvar("ui_playercard_em", game["emblems"][self.pers["emblem"]]);
			break;
		case "prevBG":
			self.pers["background"]--;
			if(self.pers["background"] < 0)
				self.pers["background"] = game["playercards"].size - 1;
			self setClientCvar("ui_playercard_bg", game["playercards"][self.pers["background"]]);
			break;
		case "nextBG":
			self.pers["background"]++;
			if(self.pers["background"] >= game["playercards"].size)
				self.pers["background"] = 0;
			self setClientCvar("ui_playercard_bg", game["playercards"][self.pers["background"]]);
			break;
		case "save":
			exp\_query::save("background", self.pers["background"], true);
            exp\_query::save("emblem", self.pers["emblem"], true);
            exp\_query::save("callsign", self.pers["callsign"], true);
			break;
		case "cancel":
			self.pers["callsign"] = callsignIndex;
			self.pers["emblem"] = emblemIndex;
			self.pers["background"] = backgroundIndex;
	
			self setClientCvar("ui_playercard_cs", game["menu_callsigns"][callsignIndex]);
			self setClientCvar("ui_playercard_em", game["emblems"][emblemIndex]);
			self setClientCvar("ui_playercard_bg", game["playercards"][backgroundIndex]);
			break;
	}
	
}

compareStrings(a, b)
{
	alen = a.size;
	blen = b.size;
	if(alen < blen)
		minlen = alen;
	else
		minlen = blen;

	for(i = 0; i < minlen; i++)
	{
		achar = a[i];
		bchar = b[i];
		aval = getCharValue(achar);
		bval = getCharValue(bchar);

		if(aval < bval)
			return -1;
		else if(aval > bval)
			return 1;
	}

	// if one is prefix of the other
	if(alen < blen)
		return -1;
	else if(alen > blen)
		return 1;
	return 0;
}

getCharValue(ch)
{
	switch(ch)
	{
	// control characters are ignored
	case " ": return 32;
	case "!": return 33;
	case "\"": return 34;
	case "#": return 35;
	case "$": return 36;
	case "%": return 37;
	case "&": return 38;
	case "'": return 39;
	case "(": return 40;
	case ")": return 41;
	case "*": return 42;
	case "+": return 43;
	case ",": return 44;
	case "-": return 45;
	case ".": return 46;
	case "/": return 47;

	// digits
	case "0": return 48;
	case "1": return 49;
	case "2": return 50;
	case "3": return 51;
	case "4": return 52;
	case "5": return 53;
	case "6": return 54;
	case "7": return 55;
	case "8": return 56;
	case "9": return 57;

	case ":": return 58;
	case ";": return 59;
	case "<": return 60;
	case "=": return 61;
	case ">": return 62;
	case "?": return 63;
	case "@": return 64;

	// uppercase
	case "A": return 65;
	case "B": return 66;
	case "C": return 67;
	case "D": return 68;
	case "E": return 69;
	case "F": return 70;
	case "G": return 71;
	case "H": return 72;
	case "I": return 73;
	case "J": return 74;
	case "K": return 75;
	case "L": return 76;
	case "M": return 77;
	case "N": return 78;
	case "O": return 79;
	case "P": return 80;
	case "Q": return 81;
	case "R": return 82;
	case "S": return 83;
	case "T": return 84;
	case "U": return 85;
	case "V": return 86;
	case "W": return 87;
	case "X": return 88;
	case "Y": return 89;
	case "Z": return 90;

	case "[": return 91;
	case "\\": return 92;
	case "]": return 93;
	case "^": return 94;
	case "_": return 95;
	case "`": return 96;

	// lowercase
	case "a": return 97;
	case "b": return 98;
	case "c": return 99;
	case "d": return 100;
	case "e": return 101;
	case "f": return 102;
	case "g": return 103;
	case "h": return 104;
	case "i": return 105;
	case "j": return 106;
	case "k": return 107;
	case "l": return 108;
	case "m": return 109;
	case "n": return 110;
	case "o": return 111;
	case "p": return 112;
	case "q": return 113;
	case "r": return 114;
	case "s": return 115;
	case "t": return 116;
	case "u": return 117;
	case "v": return 118;
	case "w": return 119;
	case "x": return 120;
	case "y": return 121;
	case "z": return 122;

	case "{": return 123;
	case "|": return 124;
	case "}": return 125;
	case "~": return 126;

	default: return 0; // unknown / non-printable
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