// If you are using Steam version of PvZ, you must open PvZ before opening LiveSplit to make this script work.
// Timer should start at -8.80 sec in NG+, at -5.00 in Endless categories, at -6.00 in other categories.

state("popcapgame1", "1096_steam_en"){                               // Steam
	int UI: 0x331c50, 0x91c;                             // 3 = battling, 5 = unlocking new level, 7 = main menu
	int levelID : 0x331c50, 0x918;                               // 0 = Adventure, 16 = Zombotany, 51 = Vasebreaker, 1 = Survival: Day
	int advenlevel: 0x331c50, 0x94c, 0x50;
	int advenWinCount: 0x331c50, 0x94c, 0x58;
	int sun: 0x331c50, 0x868, 0x5578;
	int streak: 0x331c50, 0x868, 0x178, 0x6c;
	int rawGameClock: 0x331c50, 0x868, 0x5584;
	int netGameClock: 0x331c50, 0x868, 0x5580;
	int currentWave: 0x331c50, 0x868, 0x5594;
	int csBeforeNextWave: 0x331c50, 0x868, 0x55b4;
}

state("popcapgame1", "1051_en / 1065_en"){                           // OG and OG fixed
	int UI: 0x2a9ec0, 0x7fc;
	int levelID: 0x2a9ec0, 0x7f8;
	int advenlevel: 0x2a9ec0, 0x82c, 0x24;
	int advenWinCount: 0x2a9ec0, 0x82c, 0x2c;
	int sun: 0x2a9ec0, 0x768, 0x5560;
	int streak: 0x2a9ec0, 0x768, 0x160, 0x6c;
	int rawGameClock: 0x2a9ec0, 0x768, 0x556c;
	int netGameClock: 0x2a9ec0, 0x768, 0x5568;
	int currentWave: 0x2a9ec0, 0x768, 0x557c;
	int csBeforeNextWave: 0x2a9ec0, 0x768, 0x559c;
}

state("popcapgame1", "1073_en"){                                       // GoTY-en
	int UI: 0x329670, 0x91c;
	int levelID: 0x329670, 0x918;
	int advenlevel: 0x329670, 0x94c, 0x4c;
	int advenWinCount: 0x329670, 0x94c, 0x54;
	int sun: 0x329670, 0x868, 0x5578;
	int streak: 0x329670, 0x868, 0x178, 0x6c;
	int rawGameClock: 0x329670, 0x868, 0x5584;
	int netGameClock: 0x329670, 0x868, 0x5580;
	int currentWave: 0x329670, 0x868, 0x5594;
	int csBeforeNextWave: 0x329670, 0x868, 0x55b4;
}

state("PlantsVsZombies", "1051_en / 1065_en"){                       // OG and OG fixed
	int UI: 0x2a9ec0, 0x7fc;
	int levelID: 0x2a9ec0, 0x7f8;
	int advenlevel: 0x2a9ec0, 0x82c, 0x24;
	int advenWinCount: 0x2a9ec0, 0x82c, 0x2c;
	int sun: 0x2a9ec0, 0x768, 0x5560;
	int streak: 0x2a9ec0, 0x768, 0x160, 0x6c;
	int rawGameClock: 0x2a9ec0, 0x768, 0x556c;
	int netGameClock: 0x2a9ec0, 0x768, 0x5568;
	int currentWave: 0x2a9ec0, 0x768, 0x557c;
	int csBeforeNextWave: 0x2a9ec0, 0x768, 0x559c;
}

state("PlantsVsZombies", "1073_en"){                                 // GoTY-en
	int UI: 0x329670, 0x91c;
	int levelID: 0x329670, 0x918;
	int advenlevel: 0x329670, 0x94c, 0x4c;
	int advenWinCount: 0x329670, 0x94c, 0x54;
	int sun: 0x329670, 0x868, 0x5578;
	int streak: 0x329670, 0x868, 0x178, 0x6c;
	int rawGameClock: 0x329670, 0x868, 0x5584;
	int netGameClock: 0x329670, 0x868, 0x5580;
	int currentWave: 0x329670, 0x868, 0x5594;
	int csBeforeNextWave: 0x329670, 0x868, 0x55b4;
}

init{
	vars.is_endless = false;
	vars.level_not_start = new List<int>(){42,43};
	vars.level_has_seed_selection = new List<int>(){0,1,2,3,4,5,6,7,8,9,10,13,16,22,28,29,31,32,34,36,37,38,39,40,41,44,45};
	
	//print(modules.First().ModuleMemorySize.ToString());

	if (modules.First().ModuleMemorySize >= 4300000)
		version = "1096_steam_en"; //4317484
	else if (modules.First().ModuleMemorySize >= 4000000)
		version = "1073_en"; //4280320
	else
		version = "1051_en / 1065_en"; //3751936
}

startup{
	vars.name_puzzle = new List<string>{"Vasebreaker","To the Left","Third Vase","Chain Reaction","M is for Metal","Scary Potter","Hokey Pokey","Another Chain Reaction","Ace of Vase","Vasebreaker Endless","I, Zombie","I, Zombie Too","Can You Dig It?","Totally Nuts","Dead Zepplin","Me Smash","Zomboogie","Three Hit Wonder","All your brainz","I, Zombie Endless"};
	settings.Add("puzzle_start",true,"Start Autosplitter on Puzzles (must be checked)");
	settings.Add("seed", false,"Split after seed selection");
	settings.Add("wave",false,"Split every wave. For practice only, run will be banned if checked");
	settings.Add("flag", false, "Split every flag");
	settings.Add("laststand_streak", false, "Split every round on Last Stand");
	settings.Add("puzzle_streak",true,"Split every round on I,Zombie / Vasebreaker Endless");
	settings.Add("survival_streak", false, "Split every round on Survivals");
	for (int i = 51; i<=59; ++i)
		settings.Add("puzzle_start"+i.ToString(),false,vars.name_puzzle[i-51],"puzzle_start");
	for (int i = 61; i<=69; ++i)
		settings.Add("puzzle_start"+i.ToString(),false,vars.name_puzzle[i-51],"puzzle_start");
}

start{
	if (current.advenWinCount == 0){
		if (current.levelID == 0 && current.advenlevel == 1 && current.sun == 50 && old.sun == 150){
		// Any% or 100%
			return true;
		}
	}
	else if (current.rawGameClock >=1 && current.rawGameClock <= 10){
		if ( current.levelID == 13 || current.levelID == 60 || current.levelID == 70){
			return true;
		}
		else if (current.levelID == 0 && current.advenlevel == 1){
		// NG+
			return true;
		}
		else if ( current.levelID<=48 && current.levelID>=1 && !vars.level_not_start.Contains(current.levelID)){
		// Mini-Game
			return true;
		}
		for (int i =51; i<=59; ++i)
			if (settings["puzzle_start"+i.ToString()] && current.levelID==i || settings["puzzle_start"+(i+10).ToString()] && current.levelID==i+10)
				return true;
		// Puzzle
	}
}

split{
	// split every advenlevel in Adventure mode
	if (current.levelID == 0)
		return current.advenlevel != old.advenlevel;
	else {
		// split when returing to main menu
		if (old.UI == 3 && (current.UI == 5 || current.UI == 7) )
			return true;

		// split every flag
		if (settings["flag"] && (current.UI == 3 && current.currentWave % 10 == 0 && old.currentWave % 10 != 0) )
			return true;

		// split every wave
		if (settings["wave"] && (current.UI == 3 && current.currentWave != old.currentWave) )
			return true;

		// split after seed selection
		if (settings["seed"] && (current.UI == 3 && old.netGameClock == 0 && current.netGameClock > 0) && vars.level_has_seed_selection.Contains(current.levelID) )
			return true;

		// split every round on Vasebreaker / I,Zombie Endless, Survivals, Last Stand)
		if (current.streak != old.streak && (current.levelID >= 51 && settings["puzzle_streak"] || current.levelID <= 15 && settings["survival_streak"] || current.levelID == 31 && settings["laststand_streak"]) )
			return true;
	}
}
