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
}

EXP_Vars()
{
   
}

EXP_Precache()
{

}

EXP_StartGameType()
{
    EXP_Vars();
    EXP_Precache();
}

EXP_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc)
{
    //record player damage for potential assist
}

EXP_PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc)
{
    //pop the exp value on the kill
}

EXP_PlayerConnect()
{
    //load player level. watch for stat menu?
}
