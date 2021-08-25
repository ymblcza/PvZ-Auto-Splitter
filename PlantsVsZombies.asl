// If you are using Steam version of PvZ, you must open PvZ before opening LiveSplit to make this script work.
// Timer should start at -8.80 sec in NG+, at -5.00 in Endless categories, at -6.00 in other categories.

state("popcapgame1", "1096_steam_en"){                               // Steam
	int UI: 0x331c50, 0x91c;                             // 3 = battling, 5 = unlocking new level, 7 = main menu
	int levelID : 0x331c50, 0x918;                               // 0 = Adventure, 16 = Zombotany, 51 = Vasebreaker, 1 = Survival: Day
	int advenLevel: 0x331c50, 0x94c, 0x50;
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
	int advenLevel: 0x2a9ec0, 0x82c, 0x24;
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
	int advenLevel: 0x329670, 0x94c, 0x4c;
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
	int advenLevel: 0x2a9ec0, 0x82c, 0x24;
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
	int advenLevel: 0x329670, 0x94c, 0x4c;
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
	vars.lvl_endless = new List<int>(){60,70,13};
	vars.lvl_not_start = new List<int>(){42,43};

	//print(modules.First().ModuleMemorySize.ToString());

	if (modules.First().ModuleMemorySize >= 4300000)
		version = "1096_steam_en"; //4317484
	else if (modules.First().ModuleMemorySize >= 4000000)
		version = "1073_en"; //4280320
	else
		version = "1051_en / 1065_en"; //3751936
}

startup{
	vars.name_puzzles = new List<string>{"Vasebreaker","To the Left","Third Vase","Chain Reaction","M is for Metal","Scary Potter","Hokey Pokey","Another Chain Reaction","Ace of Vase","Vasebreaker Endless","I, Zombie","I, Zombie Too","Can You Dig It?","Totally Nuts","Dead Zepplin","Me Smash","Zomboogie","Three Hit Wonder","All your brainz","I, Zombie Endless"};
	settings.Add("survival", false, "Split every round on Survivals");
	settings.Add("laststand", false, "Split every round on Last Stand");
	settings.Add("flag", false, "Split every flag");
	settings.Add("wave",false,"Split every wave. For practice only, run will be banned if checked");
	settings.Add("seed", false, "Split after seed selection. For practice only, run will be banned if checked");
	settings.Add("puzzles_start",true,"Start Autosplitter on Puzzles (must be checked)");
	for (int i = 51; i<=59; ++i)
		settings.Add("puzzles_start"+i.ToString(),false,vars.name_puzzles[i-51],"puzzles_start");
	for (int i = 61; i<=69; ++i)
		settings.Add("puzzles_start"+i.ToString(),false,vars.name_puzzles[i-51],"puzzles_start");
}

start{
	if (current.advenWinCount == 0){
		if (current.levelID == 0 && current.advenLevel == 1 && current.sun == 50 && old.sun == 150){
		// Any% or 100%
			return true;
		}
	}
	else if (current.rawGameClock >=1 && current.rawGameClock <= 10){
		if ( vars.lvl_endless.Contains(current.levelID) ){
			vars.is_endless = true;
			return true;
		}
		else if (current.levelID == 0 && current.advenLevel == 1){
		// NG+
			return true;
		}
		else if ( current.levelID<=48 && current.levelID>=1 && !vars.lvl_not_start.Contains(current.levelID)){
			return true;
		}
		for (int i =51; i<=59; ++i)
			if (settings["puzzles_start"+i.ToString()] && current.levelID==i || settings["puzzles_start"+(i+10).ToString()] && current.levelID==i+10)
				return true;
		// Puzzles
	}
}

split{
	// split every advenLevel in Adventure mode
	if (current.levelID == 0)
		return current.advenLevel != old.advenLevel;
	else {
		// split if returned to main menu
		if (old.UI == 3 && (current.UI == 5 || current.UI == 7) )
			return true;
		// split every flag
		if (settings["flag"] && (current.UI == 3 && current.currentWave % 10 == 0 && old.currentWave % 10 != 0) )
			return true;
		// split every wave
		if (settings["wave"] && (current.UI == 3 && current.currentWave != old.currentWave) )
			return true;
		// split after seed selection
		if (settings["seed"] && (current.UI == 3 && old.netGameClock == 0 && current.netGameClock > 0))
			return true;
		// split every round on Survival / Vasebreaker / I,Zombie Endless, Survivals, Last Stand)
		if (current.streak != old.streak && (vars.is_endless || current.levelID <= 10 && settings["survival"] || current.levelID == 31 && settings["laststand"]) )
			return true;
	}
}
