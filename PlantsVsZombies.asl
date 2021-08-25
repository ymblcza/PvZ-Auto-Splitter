// If you are using Steam version of PvZ, you must open PvZ before opening LiveSplit to make this script work.
// Timer should start at -8.80 sec in NG+, at -5.00 in Endless categories, at -6.00 in other categories.

state("popcapgame1", "1096_steam_en"){                               // main process of Steam version of PvZ
	int gamestate : 0x331c50, 0x91c;                             // 3 = battling, 5 = unlocking new level, 7 = main menu
	int levelID : 0x331c50, 0x918;                               // 0 = Adventure, 16 = Zombotany, 51 = Vasebreaker, 1 = Survival: Day
	int level: 0x331c50, 0x94c, 0x50;                            // current level in Adventure mode, 1 = 1-1, 2 = 1-2, etc
	int adventurecompleted: 0x331c50, 0x94c, 0x58;
	int sun: 0x331c50, 0x868, 0x5578;
	int streak: 0x331c50, 0x868, 0x178, 0x6c;
	int gametime: 0x331c50, 0x868, 0x5584;
	int currentwave: 0x331c50, 0x868, 0x5594;
}

state("popcapgame1", "1051_en / 1065_en"){                           // main process of original version and fixed original version of PvZ
	int gamestate : 0x2a9ec0, 0x7fc;
	int levelID: 0x2a9ec0, 0x7f8;
	int level: 0x2a9ec0, 0x82c, 0x24;
	int adventurecompleted: 0x2a9ec0, 0x82c, 0x2c;
	int sun: 0x2a9ec0, 0x768, 0x5560;
	int streak: 0x2a9ec0, 0x768, 0x160, 0x6c;
	int gametime: 0x2a9ec0, 0x768, 0x556c;
	int currentwave: 0x2a9ec0, 0x768, 0x557c;
}

state("popcapgame1", "1073_en"){                                       // main process of GoTY-en version of PvZ
	int gamestate : 0x329670, 0x91c;
	int levelID: 0x329670, 0x918;
	int level: 0x329670, 0x94c, 0x4c;
	int adventurecompleted: 0x329670, 0x94c, 0x54;
	int sun: 0x329670, 0x868, 0x5578;
	int streak: 0x329670, 0x868, 0x178, 0x6c;
	int gametime: 0x329670, 0x868, 0x5584;
	int currentwave: 0x329670, 0x868, 0x5594;
}

state("PlantsVsZombies", "1051_en / 1065_en"){                       // another main process of original version and fixed original version of PvZ
	int gamestate : 0x2a9ec0, 0x7fc;
	int levelID: 0x2a9ec0, 0x7f8;
	int level: 0x2a9ec0, 0x82c, 0x24;
	int adventurecompleted: 0x2a9ec0, 0x82c, 0x2c;
	int sun: 0x2a9ec0, 0x768, 0x5560;
	int streak: 0x2a9ec0, 0x768, 0x160, 0x6c;
	int gametime: 0x2a9ec0, 0x768, 0x556c;
	int currentwave: 0x2a9ec0, 0x768, 0x557c;
}

state("PlantsVsZombies", "1073_en"){                                 // another main process of GoTY-en version of PvZ
	int gamestate : 0x329670, 0x91c;
	int levelID: 0x329670, 0x918;
	int level: 0x329670, 0x94c, 0x4c;
	int adventurecompleted: 0x329670, 0x94c, 0x54;
	int sun: 0x329670, 0x868, 0x5578;
	int streak: 0x329670, 0x868, 0x178, 0x6c;
	int gametime: 0x329670, 0x868, 0x5584;
	int currentwave: 0x329670, 0x868, 0x5594;
}

init{
	vars.isendless = false;
	vars.endlesslv = new List<int>(){60,70,13};
	vars.badlv = new List<int>(){42,43};

	//print(modules.First().ModuleMemorySize.ToString());

	if (modules.First().ModuleMemorySize >= 4300000)
		version = "1096_steam_en"; //4317484
	else if (modules.First().ModuleMemorySize >= 4000000)
		version = "1073_en"; //4280320
	else
		version = "1051_en / 1065_en"; //3751936
}

startup{
	vars.puzzlename = new List<string>{"Vasebreaker","To the Left","Third Vase","Chain Reaction","M is for Metal","Scary Potter","Hokey Pokey","Another Chain Reaction","Ace of Vase","Vasebreaker Endless","I, Zombie","I, Zombie Too","Can You Dig It?","Totally Nuts","Dead Zepplin","Me Smash","Zomboogie","Three Hit Wonder","All your brainz","I, Zombie Endless"};
	settings.Add("sv", false, "Split every round on Survivals");
	settings.Add("ls", false, "Split every round on Last Stand");
	settings.Add("fl", false, "Split every flag");
	settings.Add("wave",false,"Split every wave. For practice only, run will be banned if checked");
	settings.Add("ps",true,"Start Autosplitter on Puzzles (must be checked)");
	for (int i = 51; i<=59; ++i)
		settings.Add("ps"+i.ToString(),false,vars.puzzlename[i-51],"ps");
	for (int i = 61; i<=69; ++i)
		settings.Add("ps"+i.ToString(),false,vars.puzzlename[i-51],"ps");
}

start{
	if (current.adventurecompleted == 0){
		if (current.levelID == 0 && current.level == 1 && current.sun == 50 && old.sun == 150){
		// Any% or 100%
			return true;
		}
	}
	else if (current.gametime >=1 && current.gametime <= 10){
		if ( vars.endlesslv.Contains(current.levelID) ){
			vars.isendless = true;
			return true;
		}
		else if (current.levelID == 0 && current.level == 1){
		// NG+
			return true;
		}
		else if ( current.levelID<=48 && current.levelID>=1 && !vars.badlv.Contains(current.levelID)){
			return true;
		}
		for (int i =51; i<=59; ++i)
			if (settings["ps"+i.ToString()] && current.levelID==i || settings["ps"+(i+10).ToString()] && current.levelID==i+10)
				return true;
		// Puzzles
	}
}

split{
	// split every level in Adventure mode
	if (current.levelID == 0)
		return current.level != old.level;
	else {
		// split if returning to main menu
		if (old.gamestate == 3 && (current.gamestate == 5 || current.gamestate == 7) )
			return true;

		// split every flag (aka, every 10 waves)
		if (settings["fl"] && (current.gamestate == 3 && current.currentwave % 10 == 0 && old.currentwave % 10 != 0) )
			return true;
		if (settings["wave"] && (current.gamestate == 3 && current.currentwave != old.currentwave) )
			return true;
		// split every round in Survival / Vasebreaker / I,Zombie Endless, Survivals, Last Stand)
		if (current.streak != old.streak && (vars.isendless || current.levelID <= 10 && settings["sv"] || current.levelID == 31 && settings["ls"]) )
			return true;
	}
}
