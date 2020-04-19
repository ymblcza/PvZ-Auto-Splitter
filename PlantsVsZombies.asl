// For Steam version users, you have to open PVZ before LiveSplit.
// If you run LiveSplit first this script won't work due to the stupid Steam logic.

// Timer should start at -8.80 seconds in NG+, at -5.00 in Endless categories, at -6.00 in other categories.

state("popcapgame1"){            // main process of Steam version
	int gamestate : 0x331c50, 0x91c;
	int levelID : 0x331c50, 0x918;
	int level: 0x331c50, 0x94c, 0x50;
	int timesadventurecompleted: 0x331c50, 0x94c, 0x58;
	int sun: 0x331c50, 0x868, 0x5578;
	int endlessstreak: 0x331c50, 0x868, 0x178, 0x6c;
}

state("PlantsVsZombies"){         // main process of original version
	int gamestate : 0x2a9ec0, 0x7fc;
	int levelID: 0x2a9ec0, 0x7f8;                 // 0 = adventure, 18 = Slot Machine, 51 = Vasebreaker, 1 = Survial: Day
	int level: 0x2a9ec0, 0x82c, 0x24;           // current level in adventure mode, 1 = 1-1, 2 = 1-2, etc
	int timesadventurecompleted: 0x2a9ec0, 0x82c, 0x2c;
	int sun: 0x2a9ec0, 0x768, 0x5560;
	int endlessstreak: 0x2a9ec0, 0x768, 0x160, 0x6c;
}

start{
	if (current.timesadventurecompleted == 0){
		if (current.levelID == 0 && current.level == 1 && current.gamestate == 3 && current.sun == 50){
		// Any% or 100%
			//print("timescompleted "+current.timesadventurecompleted.ToString());
			//print("levelID "+current.levelID.ToString());
			//print("sun "+current.sun.ToString());
			//print("level "+current.level.ToString());
			//print("state "+current.gamestate.ToString());
			//print(modules.First().BaseAddress.ToString());
			//print(modules.First().ModuleMemorySize.ToString());
			return true;
		}
	}
	else{
		if (current.levelID == 18 or current.levelID == 16){
			if (current.gamestate == 2 && current.sun == 50){
			// All Mini-games, should start with Slot Machine or Zombotany
				return true;
			}
		}
		else if (current.levelID == 51){
			if (current.gamestate == 3){
			// All Puzzles, starts with Vasebreaker
				return true;
			}
		}
		else if (current.levelID >= 1 && current.levelID <= 10){
			if (current.gamestate == 2 && current.sun == 50){
			// All Survivals and Normal Survivals
				return true;
			}
		}
		else if (current.levelID == 0){
			if (current.level == 1 && current.gamestate == 2 && current.sun == 50){
			// NG+
				return true;
			}
		}
		else if (current.levelID == 60){
			if (current.endlessstreak == 0 && current.gamestate == 3 && current.sun == 0){
			// Vasebreaker Endless
				return true;
			}
		}
		else if (current.levelID == 70){
			if (current.endlessstreak == 0 && current.gamestate == 3 && current.sun == 150){
			// I, Zombie Endless
				return true;
			}
		}
		else if (current.levelID == 13){
			if (current.endlessstreak == 0 && current.gamestate == 2 && current.sun == 50){
			// Survival Endless
				return true;
			}
		}
	}
}

split{
	return current.level != old.level || (current.gamestate == 5 || current.gamestate == 7) && old.gamestate == 3 || current.endlessstreak != old.endlessstreak;
}
