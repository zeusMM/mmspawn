if (!hasInterface && !isServer) exitWith {systemchat "HCs don't run the loot script!"};

diag_log format ["MM POPULATOR: Started loot population script at %1", time];

{
_city = locationposition _x;

_arrayCMD = [];

_countWeaponsAR = 2;
_countWeaponsMrks = 1;
_countWeaponsSMG = 3;
_countWeaponsP = 4;
_countMedL = 3;
_countMedM = 2;
_countMedH = 1;
_countUtilL = 3;
_countUtilM = 2;
_countUtilH = 2;
_countAmmo = 5;
_radius = 0;
_rate = 0;
_precision = 30;
_search = "houses";

switch (type _x) do
{
	case "NameCityCapital":
	{
		_rate = 3;
		_radius = 500;
	};
	
	case "NameCity":
	{
		_rate = 2;
		_radius = 400;
	};

	case "NameVillage":
	{
		_rate = 1;
		_radius = 300;
	};
};

	_nearBuildings = nearestObjects [_city, ["House", "Building"], _radius];
	_mult = (((count _nearBuildings) / 100) * _rate);
	
	_countWeaponsAR = 1 + floor random [0, ((_countWeaponsAR * _mult)/2),(_countWeaponsAR * _mult)];
	_countWeaponsMrks = 1 + floor random [0, ((_countWeaponsMrks * _mult)/2),(_countWeaponsMrks * _mult)];
	_countWeaponsSMG = 1 + floor random [0, ((_countWeaponsSMG * _mult)/2),(_countWeaponsSMG * _mult)];
	_countWeaponsP = 1 + floor random [0, ((_countWeaponsP * _mult)/2),(_countWeaponsP * _mult)];
	_countMedL = 1 + floor random [0,((_countMedL * _mult)/2),(_countMedL * _mult)];
	_countMedM = 1 + floor random [0,((_countMedM * _mult)/2),(_countMedM * _mult)];
	_countMedH = 1 + floor random [0,((_countMedH * _mult)/2),(_countMedH * _mult)];
	_countUtilL = 1 + floor random [0,((_countUtilL * _mult)/2),(_countUtilL * _mult)];
	_countUtilM = 1 + floor random [0,((_countUtilM * _mult)/2),(_countUtilM * _mult)];
	_countUtilH = 1 + floor random [0,((_countUtilH * _mult)/2),(_countUtilH * _mult)];
	_countAmmo = 1 + floor random [0,((_countAmmo * _mult)/2),(_countAmmo * _mult)];
		

	_arrayCmd = [["wpn", "ar", _countWeaponsAR],["wpn", "mrks", _countWeaponsMrks],["wpn", "smg", _countWeaponsSMG],["wpn", "p", _countWeaponsP],["med", "low", _countMedL],["med", "medium", _countMedM],["med", "high", _countMedH],["util", "high", _countutilH],["util", "medium", _countUtilM],["Util", "low", _countUtilL],["ammo", "", _countAmmo]];
	_handler = [_city, _radius, _arrayCmd] execVM "mmspawn\spawner_alloc.sqf";
	waitUntil { scriptDone _handler };

	diag_log format ["MM POPULATOR: Processed %1 (Type: %2) - /br Spawning %3 ARs, %4 Ms, %5 SMGs, %6 Ps, %7 MdL, %8 MdM, %9 MdH, %10 UtL, %11 UtM, %12 UtH", text _x, type _x, _countWeaponsAR, _countWeaponsMrks, _countWeaponsSMG, _countWeaponsP, _countMedL, _countMedM, _countMedH, _countUtilL, _countUtilM, _countUtilH];
} foreach nearestLocations[_this select 0, ["NameCityCapital", "NameCity", "NameVillage"], _this select 1];

"MM SPAWN initialized! Enjoy the game!" remoteExec ["hint", -2];
diag_log format ["MM POPULATOR: Finished loot script at %1", time];