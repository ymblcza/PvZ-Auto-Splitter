// If you are using Steam version of PvZ, you must open PvZ before LiveSplit to make this script work.
// If you open LiveSplit first this script won't work due to the stupid logic of Steam version of PvZ.

// Timer should start at -8.80 seconds in NG+, at -5.00 in Endless categories, at -6.00 in other categories.

state("popcapgame1", "1096_steam_en"){                               // main process of Steam version of PvZ
	int gamestate : 0x331c50, 0x91c;                             // 3 = battling, 5 = unlocking new level, 7 = main menu
	int levelID : 0x331c50, 0x918;                               // 0 = Adventure, 16 = Zombotany, 51 = Vasebreaker, 1 = Survival: Day
	int level: 0x331c50, 0x94c, 0x50;                            // current level in Adventure mode, 1 = 1-1, 2 = 1-2, etc
	int timesadventurecompleted: 0x331c50, 0x94c, 0x58;
	int sun: 0x331c50, 0x868, 0x5578;
	int endlessstreak: 0x331c50, 0x868, 0x178, 0x6c;
	int gametime: 0x331c50, 0x868, 0x5584;
	int currentwave: 0x331c50, 0x868, 0x5594;
}

state("popcapgame1", "1051_en / 1065_en"){                           // main process of original version and fixed original version of PvZ
	int gamestate : 0x2a9ec0, 0x7fc;                             // 3 = battling, 5 = unlocking new level, 7 = main menu
	int levelID: 0x2a9ec0, 0x7f8;                                // 0 = Adventure, 16 = Zombotany, 51 = Vasebreaker, 1 = Survival: Day
	int level: 0x2a9ec0, 0x82c, 0x24;                            // current level in Adventure mode, 1 = 1-1, 2 = 1-2, etc
	int timesadventurecompleted: 0x2a9ec0, 0x82c, 0x2c;
	int sun: 0x2a9ec0, 0x768, 0x5560;
	int endlessstreak: 0x2a9ec0, 0x768, 0x160, 0x6c;
	int gametime: 0x2a9ec0, 0x768, 0x556c;
	int currentwave: 0x2a9ec0, 0x768, 0x557c;
}

state("popcapgame1", "1073_en"){                                 // main process of GoTY-en version of PvZ
	int gamestate : 0x329670, 0x91c;                             // 3 = battling, 5 = unlocking new level, 7 = main menu
	int levelID: 0x329670, 0x918;                                // 0 = Adventure, 16 = Zombotany, 51 = Vasebreaker, 1 = Survival: Day
	int level: 0x329670, 0x94c, 0x4c;                            // current level in Adventure mode, 1 = 1-1, 2 = 1-2, etc
	int timesadventurecompleted: 0x329670, 0x94c, 0x54;
	int sun: 0x329670, 0x868, 0x5578;
	int endlessstreak: 0x329670, 0x868, 0x178, 0x6c;
	int gametime: 0x329670, 0x868, 0x5584;
	int currentwave: 0x329670, 0x868, 0x5594;
}

state("PlantsVsZombies", "1051_en / 1065_en"){                       // another main process of original version and fixed original version of PvZ
	int gamestate : 0x2a9ec0, 0x7fc;                             // 3 = battling, 5 = unlocking new level, 7 = main menu
	int levelID: 0x2a9ec0, 0x7f8;                                // 0 = Adventure, 16 = Zombotany, 51 = Vasebreaker, 1 = Survival: Day
	int level: 0x2a9ec0, 0x82c, 0x24;                            // current level in Adventure mode, 1 = 1-1, 2 = 1-2, etc
	int timesadventurecompleted: 0x2a9ec0, 0x82c, 0x2c;
	int sun: 0x2a9ec0, 0x768, 0x5560;
	int endlessstreak: 0x2a9ec0, 0x768, 0x160, 0x6c;
	int gametime: 0x2a9ec0, 0x768, 0x556c;
	int currentwave: 0x2a9ec0, 0x768, 0x557c;
}

state("PlantsVsZombies", "1073_en"){                                 // another main process of GoTY-en version of PvZ
	int gamestate : 0x329670, 0x91c;                             // 3 = battling, 5 = unlocking new level, 7 = main menu
	int levelID: 0x329670, 0x918;                                // 0 = Adventure, 16 = Zombotany, 51 = Vasebreaker, 1 = Survival: Day
	int level: 0x329670, 0x94c, 0x4c;                            // current level in Adventure mode, 1 = 1-1, 2 = 1-2, etc
	int timesadventurecompleted: 0x329670, 0x94c, 0x54;
	int sun: 0x329670, 0x868, 0x5578;
	int endlessstreak: 0x329670, 0x868, 0x178, 0x6c;
	int gametime: 0x329670, 0x868, 0x5584;
	int currentwave: 0x329670, 0x868, 0x5594;
}

init{
	vars.isendless = false;                                      // if the current running category is endless
	vars.split_gamestate = false;                                // if split when gamestate changes
	vars.split_currentwave = false;                              // if split when currentwave is a times of 10
	vars.split_endlessstreak = false;                            // if split when streak number changes
	
	vars.puzzlesstartinglevels = new List<int>(){51,55,59,61,69};
	vars.endlesslevels = new List<int>(){60,70,13};
	
	if (modules.First().ModuleMemorySize >= 4000000)
		version = "1073_en";
	else if (modules.First().ModuleMemorySize >= 3000000)
		version = "1051_en / 1065_en";
	else
		version = "1096_steam_en";
}

startup{
	settings.Add("splitinsurvival", false, "Split every 2 flags in non-endless Survival levels");
	settings.Add("splitinlaststand", false, "Split every flag in Last Stand");
	settings.Add("splitinil", false, "Split every flag (aka, 10 waves)");
}

start{
	if (current.timesadventurecompleted == 0){
		if (current.levelID == 0 && current.level == 1 && current.sun == 50 && old.sun == 150){
		// Any% or 100%
			return true;
		}
	}
	else if (current.gametime >=1 && current.gametime <= 20){
		if ( vars.endlesslevels.Contains(current.levelID) ){
			vars.isendless = true;
			return true;
		}
		else if (current.levelID == 0 && current.level == 1){
		// NG+
			return true;
		}
		else if ( current.levelID<=48 && current.levelID != 42 && current.levelID != 43 || vars.puzzlesstartinglevels.Contains(current.levelID) ){
			return true;
		}
	}
}

split{
	// split every level in Adventure mode
	if (current.levelID == 0)
		return current.level != old.level;

	else {
		// split if returns to main menu
		vars.split_gamestate = (old.gamestate == 3 && (current.gamestate == 5 || current.gamestate == 7));

		// split every flag (aka, 10 waves)
		vars.split_currentwave = settings["splitinil"] && (current.gamestate == 3 && current.currentwave % 10 == 0 && old.currentwave % 10 != 0);

		// split every round during long levels (Endlesses, Survivals, Last Stand)
		vars.split_endlessstreak = current.endlessstreak != old.endlessstreak && (vars.isendless || current.levelID <= 10 && settings["splitinsurvival"] 
					|| current.levelID == 31 && settings["splitinlaststand"]);

		return vars.split_gamestate || vars.split_currentwave || vars.split_endlessstreak;
	}
}
