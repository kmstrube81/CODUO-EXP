EXP_restrict(weapon)
{
    if([[level.getVars]]("exp_levelunlock_all"))
    {
        return weapon;
    }
    wepon = maps\mp\uox\_uox_arrays::getValue(level.weaponUnlocks, weapon);
    if(!isDefined(wepon))
    {
        maps\mp\uox\_uox_debug::debugLog("info", self.name + " EXP restrict " + weapon + " not found");
        return "restricted";
    }
    maps\mp\uox\_uox_debug::debugLog("info", self.name + " lvl " + self.pers["level"] + " EXP restrict " + weapon + " unlock level is " + wepon);
    if(self.pers["level"] >= wepon)
    {
        return weapon;
    }
    else
    {
        return "restricted";
    }
}

setupLevelUnlocks()
{
    weaponUnlocks = maps\mp\uox\_uox_arrays::superArray();
    weaponUnlocks = maps\mp\uox\_uox_arrays::arrayPush(weaponUnlocks, 0, "m1garand_mp");
    weaponUnlocks = maps\mp\uox\_uox_arrays::arrayPush(weaponUnlocks, 0, "m1carbine_mp");
    weaponUnlocks = maps\mp\uox\_uox_arrays::arrayPush(weaponUnlocks, 4, "thompson_mp");
    weaponUnlocks = maps\mp\uox\_uox_arrays::arrayPush(weaponUnlocks, 8, "bar_mp");
    weaponUnlocks = maps\mp\uox\_uox_arrays::arrayPush(weaponUnlocks, 12, "springfield_mp");
    weaponUnlocks = maps\mp\uox\_uox_arrays::arrayPush(weaponUnlocks, 16, "mg30cal_mp");
    weaponUnlocks = maps\mp\uox\_uox_arrays::arrayPush(weaponUnlocks, 0, "enfield_mp");
    weaponUnlocks = maps\mp\uox\_uox_arrays::arrayPush(weaponUnlocks, 4, "sten_mp");
    weaponUnlocks = maps\mp\uox\_uox_arrays::arrayPush(weaponUnlocks, 8, "bren_mp");
    weaponUnlocks = maps\mp\uox\_uox_arrays::arrayPush(weaponUnlocks, 0, "mosin_nagant_mp");
    weaponUnlocks = maps\mp\uox\_uox_arrays::arrayPush(weaponUnlocks, 0, "svt40_mp");
    weaponUnlocks = maps\mp\uox\_uox_arrays::arrayPush(weaponUnlocks, 4, "ppsh_mp");
    weaponUnlocks = maps\mp\uox\_uox_arrays::arrayPush(weaponUnlocks, 12, "mosin_nagant_sniper_mp");
    weaponUnlocks = maps\mp\uox\_uox_arrays::arrayPush(weaponUnlocks, 16, "dp28_mp");
    weaponUnlocks = maps\mp\uox\_uox_arrays::arrayPush(weaponUnlocks, 0, "kar98k_mp");
    weaponUnlocks = maps\mp\uox\_uox_arrays::arrayPush(weaponUnlocks, 0, "gewehr43_mp");
    weaponUnlocks = maps\mp\uox\_uox_arrays::arrayPush(weaponUnlocks, 4, "mp40_mp");
    weaponUnlocks = maps\mp\uox\_uox_arrays::arrayPush(weaponUnlocks, 8, "mp44_mp");
    weaponUnlocks = maps\mp\uox\_uox_arrays::arrayPush(weaponUnlocks, 12, "kar98k_sniper_mp");
    weaponUnlocks = maps\mp\uox\_uox_arrays::arrayPush(weaponUnlocks, 16, "mg34_mp");

    return weaponUnlocks;
}

EXP_checkLevelUnlocks()
{
    self maps\mp\uox\_uox_arrays::arrayReadEach(level.weaponUnlocks, ::EXP_checkWeaponLevel);
}

EXP_checkWeaponLevel(lvl, weapon)
{
    switch(weapon)
    {
        case "m1carbine_mp":
            if(self.pers["level"] < lvl)
            {
                //turn off weapon
                setcvar("ui_allow_m1carbine", "0");
            }
            else
            {
                //turn on weapon
                setcvar("ui_allow_m1carbine", "1");
            }
            break;
            
        case "m1garand_mp":
            if(self.pers["level"] < lvl)
            {
                //turn off weapon
                setcvar("ui_allow_m1garand", "0");
            }
            else
            {
                //turn on weapon
                setcvar("ui_allow_m1garand", "1");
            }
            break;
            
        case "thompson_mp":
            if(self.pers["level"] < lvl)
            {
                //turn off weapon
                setcvar("ui_allow_thompson", "0");
            }
            else
            {
                //turn on weapon
                setcvar("ui_allow_thompson", "1");
            }
            break;
            
        case "bar_mp":
            if(self.pers["level"] < lvl)
            {
                //turn off weapon
                setcvar("ui_allow_bar", "0");
            }
            else
            {
                //turn on weapon
                setcvar("ui_allow_bar", "1");
            }
            break;
            
        case "springfield_mp":
            if(self.pers["level"] < lvl)
            {
                //turn off weapon
                setcvar("ui_allow_springfield", "0");
            }
            else
            {
                //turn on weapon
                setcvar("ui_allow_springfield", "1");
            }
            break;

        case "mg30cal_mp":
            if(self.pers["level"] < lvl)
            {
                //turn off weapon
                setcvar("ui_allow_mg30cal", "0");
            }
            else
            {
                //turn on weapon
                setcvar("ui_allow_mg30cal", "1");
            }
            break;

        case "enfield_mp":
            if(self.pers["level"] < lvl)
            {
                //turn off weapon
                setcvar("ui_allow_enfield", "0");
            }
            else
            {
                //turn on weapon
                setcvar("ui_allow_enfield", "1");
            }
            break;

        case "sten_mp":
            if(self.pers["level"] < lvl)
            {
                //turn off weapon
                setcvar("ui_allow_sten", "0");
            }
            else
            {
                //turn on weapon
                setcvar("ui_allow_sten", "1");
            }
            break;

        case "bren_mp":
            if(self.pers["level"] < lvl)
            {
                //turn off weapon
                setcvar("ui_allow_bren", "0");
            }
            else
            {
                //turn on weapon
                setcvar("ui_allow_bren", "1");
            }
            break;

        case "mosin_nagant_mp":
            if(self.pers["level"] < lvl)
            {
                //turn off weapon
                setcvar("ui_allow_nagant", "0");
            }
            else
            {
                //turn on weapon
                setcvar("ui_allow_nagant", "1");
            }
            break;

        case "svt40_mp":
            if(self.pers["level"] < lvl)
            {
                //turn off weapon
                setcvar("ui_allow_svt40", "0");
            }
            else
            {
                //turn on weapon
                setcvar("ui_allow_svt40", "1");
            }
            break;

        case "ppsh_mp":
            if(self.pers["level"] < lvl)
            {
                //turn off weapon
                setcvar("ui_allow_ppsh", "0");
            }
            else
            {
                //turn on weapon
                setcvar("ui_allow_ppsh", "1");
            }
            break;

        case "mosin_nagant_sniper_mp":
            if(self.pers["level"] < lvl)
            {
                //turn off weapon
                setcvar("ui_allow_nagantsniper", "0");
            }
            else
            {
                //turn on weapon
                setcvar("ui_allow_nagantsniper", "1");
            }
            break;

        case "dp28_mp":
            if(self.pers["level"] < lvl)
            {
                //turn off weapon
                setcvar("ui_allow_dp28", "0");
            }
            else
            {
                //turn on weapon
                setcvar("ui_allow_dp28", "1");
            }
            break;

        case "kar98k_mp":
            if(self.pers["level"] < lvl)
            {
                //turn off weapon
                setcvar("ui_allow_kar98k", "0");
            }
            else
            {
                //turn on weapon
                setcvar("ui_allow_kar98k", "1");
            }
            break;

        case "gewehr43_mp":
            if(self.pers["level"] < lvl)
            {
                //turn off weapon
                setcvar("ui_allow_gewehr43", "0");
            }
            else
            {
                //turn on weapon
                setcvar("ui_allow_gewehr43", "1");
            }
            break;

        case "mp40_mp":
            if(self.pers["level"] < lvl)
            {
                //turn off weapon
                setcvar("ui_allow_mp40", "0");
            }
            else
            {
                //turn on weapon
                setcvar("ui_allow_mp40", "1");
            }
            break;

        case "mp44_mp":
            if(self.pers["level"] < lvl)
            {
                //turn off weapon
                setcvar("ui_allow_mp44", "0");
            }
            else
            {
                //turn on weapon
                setcvar("ui_allow_mp44", "1");
            }
            break;

        case "kar98k_sniper_mp":
            if(self.pers["level"] < lvl)
            {
                //turn off weapon
                setcvar("ui_allow_kar98ksniper", "0");
            }
            else
            {
                //turn on weapon
                setcvar("ui_allow_kar98ksniper", "1");
            }
            break;

        case "mg34_mp":
            if(self.pers["level"] < lvl)
            {
                //turn off weapon
                setcvar("ui_allow_mg34", "0");
            }
            else
            {
                //turn on weapon
                setcvar("ui_allow_mg34", "1");
            }
            break;
    }
}

