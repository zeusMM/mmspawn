if(!isServer) exitWith {};

private ["_players", "_delete", "_playersAll", "_posPlayers", "_unit", "_tempTime", "_cleanupBuildings", "_loot", "_pos", "_buildings", "_spawn", "_nearBuildings", "_lootClass", "_lootType", "_buildingType", "_rnd", "_lootA", "_lootB"];

diag_log format ["MM DYNAMIC SPAWN: Starting up at %1", time];

while {mmSttsSpawnDynamic} do
{
	// Fill _players with all players depending on SP or MP! (Stupid BIS crap again - they always need to make stuff complicated!)
	_players = [];
	if (isDedicated) then
	{
		_playersAll = playableUnits;
	}
	else
	{
		_playersAll = switchableUnits;
	};
	
	{
	if (isPlayer _x) then {_players pushBack _x};
	} forEach _playersAll;
	
diag_log format ["MM DYNAMIC SPAWN: %1", _players];
	// Cleanup: after mmSttsSpawnRespawn seconds - remove the building in question from the blacklist for new loot to spawn!
	_cleanupBuildings = [];
	{
		_tempTime = _x select 1;
		if ((_tempTime + mmSttsSpawnRespawn) < time ) then 
		{
		_cleanupBuildings pushBack _x;
		};	
	} forEach mmArrBuildingsTimeout;
	if (count _cleanupBuildings > 0) then {mmArrBuildingsTimeout = mmArrBuildingsTimeout - _cleanupBuildings;};
	
	_posPlayers = [];
	_buildings = [];
	{

	_spawn = [];
	_unit = _x;
	_pos = position _unit;
	_posPlayers pushBack _pos;
	
	//if (((velocity _x) distance [0,0,0]) > 6) exitWith {}; // If player is moving too fast - don't spawn loot - it's pointless!

		
		_nearBuildings = nearestObjects [_pos, ["House", "Building"], mmSttsSpawnRadius];	
		{
			_nearBuildings = _nearBuildings - [_x select 0];
		} forEach mmArrBuildingsTimeout;		
		//_nearBuildings = _nearBuildings - mmArrBuildingsTimeout;
		{
			if( str (_x buildingPos 0) != "[0,0,0]") then 
			{
			_buildings pushBack _x;
			_temptime = time;
			mmArrBuildingsTimeout pushback [_x, _temptime];
			};
		} forEach _nearBuildings;		
	} forEach _players;
	
	{
		if ((floor(random(100))) < mmSttsSpawnChance) then 
		{
			_buildingPositions = [];
			_buildingPositions append (_x buildingPos -1);
			_buildingType = typeOf _x;
			
			{
				if (_buildingType == (_x select 0)) exitWith
				{
						_lootClass = (_x select 1);
				};
				_lootClass = -1;
			} forEach itemsBuildingsList;
			if (_lootClass != -1) then 
			{
				{				
					_pos = _x;
					for "_lootType" from 1 to ((count (lootList select _lootClass)) - 1) do
					{
						_rnd = floor(random(100));
						_lootTemp = (lootList select _lootClass) select _lootType;
						if ((_lootTemp select 0) > _rnd ) exitWith
						{
							_loot = (_lootTemp select 1);
							[_pos, _loot]execVM "mmspawn\spawner_dynamic_engine.sqf";
						};
					};
				} forEach _buildingPositions;
			};
		};
	} forEach _buildings;
	
	
	
	
	// Cleanup: delete all items that are out of range of any players - they didn't bother apparently.

	{
	_item = _x;
		{
			if ((_item distance _x) < 500 ) exitWith {_delete = false};		
			_delete = true;
		} foreach _posPlayers;
		if (_delete) then {deletevehicle _item;};
	} foreach mmArrItems;
	
	

	// Wait for mmSttsSpawnCycle
	diag_log format ["MM DYNAMIC SPAWN: Finished cycle at %1 for %2 locations.", time, count _buildings];
	sleep mmSttsSpawnCycle;
};



