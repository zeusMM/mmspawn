if(!isServer) exitWith {};

private ["_players", "_unit", "_pos", "_buildings", "_spawn", "_nearBuildings", "_type", "_buildingType", "_rnd", "_lootA", "_lootB"];

diag_log format ["MM DYNAMIC SPAWN: Starting up at %1", time];

while {mmSttsSpawnDynamic} do
{
	if (isDedicated) then
	{
		_players = playableUnits;
	}
	else
	{
		_players = switchableUnits;
	};

	{
		_unit = _x;
		_pos = position _unit;
		
		_buildings = [];
		_spawn = [];
		
		_nearBuildings = nearestObjects [_pos, ["House", "Building"], mmSttsSpawnRadius];
		_nearBuildings = _nearBuildings - mmArrBuildingsTimeout;
		{
			if( str (_x buildingPos 0) != "[0,0,0]") then {_buildings pushBack _x};
		} forEach _nearBuildings;
		
		{
			_buildingPositions = [];
			_buildingPositions append (_x buildingPos -1);
			mmArrBuildingsTimeout = mmArrBuildingsTimeout + [_x];
			_buildingType = typeOf _x;
			
			{
				if (_buildingType == (_x select 0)) exitWith {
						_type = (_x select 1);
				};
				_type = -1;
			} forEach itemsBuildingsList;
			
			if (_type != -1) then {
				diag_log format ["MM DYNAMIC SPAWN: Found type %1", _type];
				{
					for "_loottype" from 1 to 4 do {
						if ((floor (random 100)) < mmSttsSpawnChance) then
						{
							_rnd = floor (random(100));
							if (((spawnList select _type) select _loottype) > _rnd) then {
								_lootA = "";
								_lootB = "";
								if (_loottype == 1) exitWith
								{
									_lootA = "wpn";
									_lootB = "ar";								
								};
								if (_loottype == 2) exitWith
								{
									_lootA = "util";
									_lootB = "low";								
								};
								if (_loottype == 3) exitWith
								{
									_lootA = "med";
									_lootB = "low";								
								};
								if (_loottype == 4) exitWith
								{
									_lootA = "ammo";
									_lootB = "";
								};	
							_handler = [_x, _lootA, _lootB] execVM "mmspawn\spawner_engine.sqf";
							};
						};
					};
				} forEach _buildingPositions;
			};
		} forEach _buildings;
	} forEach _players;

	diag_log format ["MM DYNAMIC SPAWN: Finished cycle at %1 for %2 locations.", time, count _buildings];
	sleep 30;
};