// For Steam version users, you have to open PVZ before LiveSplit.
// If you run LiveSplit first this script won't work due to the stupid Steam logic.

// Timer should start at -8.80 seconds in NG+, at -5.00 in Endless categories, at -6.00 in other categories.

state("popcapgame1"){                       // main process of Steam version
	int gamestate : 0x331c50, 0x91c;
	int levelID : 0x331c50, 0x918;
	int level: 0x331c50, 0x94c, 0x50;
	int timesadventurecompleted: 0x331c50, 0x94c, 0x58;
	int sun: 0x331c50, 0x868, 0x5578;
	int endlessstreak: 0x331c50, 0x868, 0x178, 0x6c;
	int gametime: 0x331c50, 0x868, 0x5584;
}

state("PlantsVsZombies"){                    // main process of original version
	int gamestate : 0x2a9ec0, 0x7fc;
	int levelID: 0x2a9ec0, 0x7f8;              // 0 = Adventure, 16 = Zombotany, 51 = Vasebreaker, 1 = Survival: Day
	int level: 0x2a9ec0, 0x82c, 0x24;          // current level in Adventure mode, 1 = 1-1, 2 = 1-2, etc
	int timesadventurecompleted: 0x2a9ec0, 0x82c, 0x2c;
	int sun: 0x2a9ec0, 0x768, 0x5560;
	int endlessstreak: 0x2a9ec0, 0x768, 0x160, 0x6c;
	int gametime: 0x2a9ec0, 0x768, 0x556c;
}

init{
	vars.startlevels = new List<int>{1,2,3,4,5,6,7,8,9,10,16,18,51,60,70,13};
	// 1,2,...,10 = Normal / All Survivals;   16,18 = All minigames;   51 = All puzzles;   60 / 70 / 13 = Vasebreaker / I, Zombie / Survival Endless
}

start{
	if (current.timesadventurecompleted == 0){
		if (current.levelID == 0 && current.level == 1 && current.gamestate == 3 && current.sun == 50){
		// Any% or 100%
			return true;
		}
	}
	else if (current.gametime >=1 && current.gametime <= 20){
		if (vars.startlevels.IndexOf(current.levelID, 1) != -1){
			return true;
		}
		else if (current.levelID == 0 && current.level == 1){
		// NG+
			return true;
		}
	}
}

split{
	return current.level != old.level || (current.gamestate == 5 || current.gamestate == 7) && old.gamestate == 3 || current.endlessstreak != old.endlessstreak;
}
