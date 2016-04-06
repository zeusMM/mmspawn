DOCUMENTATION

For the loot script to work properly, you need to follow these easy steps:

1. Copy the mmspawn folder into your mission folder.
2. Open your mission in the editor and place a game logic. Name it       mmspawn_object         . This will be the center of operations for the population script - if you desire to run it.
3. In your description.ext, add the following. If you already use mission parameters - integrate the class into the parameters. Pay attention to which index that parameter has. (If it is the second param, index will be 1.)

class Params
{
	class LootMarkers
	{
		title = "Loot Markers";
		values[] = {1,2};
		texts[] = {"No", "Yes"};
		default = 2;
	};
};



4. If not existing already, add a text file named initServer.sqf to your mission folder (not the mmspawn folder! root folder!).
   In that initServer.sqf you need to run the init script by adding

	[true, 30000, 1]execVM "mmspawn\spawner_init.sqf"
	
   This line will enable general loot population across the whole map in all towns. If you want to use mmspawn only with custom loot sectors - use
   
    [false, 0, 1]execVM "mmspawn\spawner_init.sqf"
	
	ATTENTION: The third parameter is the index of your Loot Markers parameter that you added in step 3. It is very important this is accurate - otherwise you may have unwanted effects like nuclear devastation of your loved ones.
	
5. Open the mmspawn folder and within open the spawner_loottables.sqf.
   Edit the loot table to your liking. Be advised: do not add ammunition - it auto detects weapons and adds the appropriate ammunition to the loot table on mission start!