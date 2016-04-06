if(!isServer) exitWith {};

// Get the input from whatever called the script!
_pos = _This select 0;
_radius = _This select 1;
_arrayCmd = _This select 2;

// Set the basics up and find all nearby buildings!
_buildings = [];
_position = [];
_nearBuildings = nearestObjects [_pos, ["House", "Building"], _radius];

{
    if( str (_x buildingPos 0) != "[0,0,0]") then {_buildings pushBack _x};
} forEach _nearBuildings;

_buildingPositions = [];
{  
    _buildingPositions append (_x buildingPos -1);
} forEach _buildings;

// _buildingPositions now contains every possible position WITHIN buildings in the given radius!

{
	_typeA = _x select 0;
	_typeB = _x select 1;
	_count = _x select 2;

	for "_i" from 0 to _count do
	{
		if (count _buildingPositions > 0) then
		{
			_position = _buildingPositions call BIS_fnc_selectRandom;
			_buildingPositions = _buildingPositions - [_position];
//			_position = [_position select 0] + [_position select 1] + [(_position select 2) + 0.00005];
		}
		else
		{
			_position = [];
			while {count _position == 0} do
			{
				_position = ((selectBestPlaces[_pos, _radius, "houses", 30, 1] select 0) select 0) + [0];
				_position = _position findEmptyPosition[0,2,"groundweaponholder"];
			};
		};
		_handler = [_position, _typeA, _typeB] execVM "mmspawn\spawner_engine.sqf";
		waitUntil { scriptDone _handler };
	};
} foreach _arrayCmd;


