// For Steam version users, you have to open PVZ before LiveSplit.
// If you run LiveSplit first this script won't work due to the stupid Steam logic.

// Timer shuold start at -6.00 seconds to return the correct time.
// Timer should start at -8.80 seconds in NG+, specifically.

state("popcapgame1"){            // Steam version's main process
	int gamestate : 0x331c50, 0x91c;
	int levelID : 0x331c50, 0x918;
	int level: 0x331c50, 0x94c, 0x50;
	int timesadventurecompleted: 0x331c50, 0x94c, 0x58;
	int sun: 0x331c50, 0x868, 0x5578;
}

state("PlantsVsZombies"){         // Original version's main process
	int gamestate : 0x2a9ec0, 0x7fc;
	int levelID: 0x2a9ec0, 0x7f8;                 // 0 = adventure, 18 = Slot Machine, 51 = Vasebreaker, 1 = Survial: Day
	int level: 0x2a9ec0, 0x82c, 0x24;           // current level in adventure mode, 1 = 1-1, 2 = 1-2, etc
	int timesadventurecompleted: 0x2a9ec0, 0x82c, 0x2c;
	int sun: 0x2a9ec0, 0x768, 0x5560;
}

init{
	vars.category = -1;
}

start{
	if (current.timesadventurecompleted == 0){
		if (current.levelID == 0 && current.level == 1 && current.gamestate == 3 && current.sun == 50){
		// Any%
			//print("timescompleted "+current.timesadventurecompleted.ToString());
			//print("levelID "+current.levelID.ToString());
			//print("sun "+current.sun.ToString());
			//print("level "+current.level.ToString());
			//print("state "+current.gamestate.ToString());
			//print(modules.First().BaseAddress.ToString());
			//print(modules.First().ModuleMemorySize.ToString());
			vars.category = 1;
			return true;
		}
	}
	else{
		if (current.levelID == 18){
			if (current.gamestate == 2 && current.sun == 50){
			// All Mini-games, should start with Slot Machine
				vars.category = 11;
				return true;
			}
		}
		else if (current.levelID == 51){
			if (current.gamestate == 3){
			// All Puzzles, must start with Vasebreaker
				vars.category = 12;
				return true;
			}
		}
		else if (current.levelID >= 1 && current.levelID <= 10){
			if (current.gamestate == 2){
			// All Survivals and Normal Survivals
				vars.category = 13;
				return true;
			}
		}
		else if (current.levelID == 0){
			if (current.level == 1 && current.gamestate == 2){
			// NG+
				vars.category = 2;
				return true;
			}
		}
	}
	
}

split{
	if (vars.category <= 9 && current.level != old.level)
		return true;
	else if (vars.category >= 10 && current.gamestate == 7 && old.gamestate == 3){
		return true;
	}
}
