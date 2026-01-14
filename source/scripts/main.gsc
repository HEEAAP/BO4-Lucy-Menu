init()
{
    level thread InitializeVarsPrecaches();
}

onPlayerSpawned()
{
    if(!isDefined(self.menuThreaded))
        self thread playerSetup();
}

InitializeVarsPrecaches()
{
    if(isDefined(level.InitializeVarsPrecaches))
        return;
    level.InitializeVarsPrecaches = true;

    level.menuName = "Lucy | Free GSC Menu";
    level.menuDeveloper = "Gillam";
    level.AutoVerify = 0;
    level.MenuStatus = StrTok("None, Verified, VIP, Co-Host, Admin, Host, Developer", ",");
    
}

playerSetup()
{
    if(isDefined(self.menuThreaded))
        return;
    
    self defineVariables();
    if(!self IsHost())
    {
        if(!isDefined(self.playerSetting["verification"]))
            self.playerSetting["verification"] = level.MenuStatus[level.AutoVerify];
    }
    else
        self.playerSetting["verification"] = level.MenuStatus[(level.MenuStatus.size - 2)];
    
    if(self hasMenu())
    {
        for(a=0;a<3;a++)
            self iPrintln(".");
        self iPrintln("^9Welcome To " + level.menuName);
        self iPrintLn("^1Developed By: " + level.menuDeveloper);
        self iPrintln("^0Status: " + self.playerSetting["verification"]);
        for(a=0;a<3;a++)
            self iPrintln(".");
    }
    
    self thread menuMonitor();
    self.menuThreaded = true;
}
 
defineVariables()
{
    if(isDefined(self.DefinedVariables))
        return;
    self.DefinedVariables = true;
    
    if(!isDefined(self.menu))
        self.menu = [];
    if(!isDefined(self.playerSetting))
        self.playerSetting = [];
    if(!isDefined(self.menu["curs"]))
        self.menu["curs"] = [];
    
    self.playerSetting["isInMenu"] = undefined;
    self.menu["currentMenu"] = "Main";
    self.menu["curs"][self.menu["currentMenu"]] = 0;
}