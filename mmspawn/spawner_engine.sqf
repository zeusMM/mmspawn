if(!isServer) exitWith {};
private ["_loc", "_type", "_typeB", "_holder", "_cutter", "_item", "_magCount", "_magClass", "_item1count", "_item2count", "_item3count"];

_loc = _This select 0;
_type = _this select 1;
_typeB = _this select 2;

_pos0=	(_loc select 0);
_pos1=	(_loc select 1);
_pos2=	(_loc select 2);

_item = "";
_magCount = 0;
_magClass = "";
_item1count = 0;
_item2count = 0;
_item3count = 0;
_item4count = 0;



_physx = createVehicle ["Land_Battery_F",[_pos0,_pos1,_pos2+0.1], [], 0, "can_Collide"];
sleep 0.5;
_holder = createVehicle ["groundweaponholder",[_pos0,_pos1,(getposATL _physx select 2)], [], 0, "can_Collide"];
deletevehicle _physx;

//_holder = createvehicle [ "groundweaponholder", _loc,[], 0, "can_Collide"];
//_cutter = createvehicle [ "ClutterCutter_small_2_Ep1", _loc,[], 0, "can_Collide"];

switch (_type) do
{
	case "wpn":
	{
	if (mmSettingsMarkers) then {
	_helper = createvehicle [ "Sign_Arrow_F", _loc,[], 0, "can_Collide"];
	};

		switch (_typeB) do
		{
			case "ar":
			{
				_item = itemsWeaponsAR call BIS_fnc_selectRandom;
				_magCount = 1 + floor random 3;
			};
		
			case "mrks":
			{
				_item = itemsWeaponsMrks call BIS_fnc_selectRandom;
				_magCount = 1 + floor random 2;
			};
				
			case "smg":
			{
				_item = itemsWeaponsSMG call BIS_fnc_selectRandom;
				_magCount = 1 + floor random 4;
			};
			
			case "pistol":
			{
				_item = itemsWeaponsPistol call BIS_fnc_selectRandom;
				_magCount = 1 + floor random 5;
			};
		};
		
		_holder addweaponcargoglobal[_item, 1];
		
		if (_magCount > 0) then
		{
			_magazines = getArray (configFile / "CfgWeapons" / _item / "magazines");
			if (count _magazines > 0 && isClass (configFile / "CfgWeapons" / _item)) then
			{
				_magClass = 1 + floor random count _magazines;
				_magClass = _magazines select (_magClass min (count _magazines - 1));
			}
			else
			{
				_magClass = "";
			};
			if (isClass (configFile / "CfgMagazines" / _magClass)) then
			{
				_holder addmagazinecargoglobal [_magClass, _magCount];
			};
		};
	};
	
	case "med":
	{
	if (mmSettingsMarkers) then {
		_helper = createvehicle [ "Sign_Arrow_Blue_F", _loc,[], 0, "can_Collide"];
	};

		switch "_typeB" do
		{
			case "low":
			{
			_item1count = 1 + floor random 1;
			_item2count = 1 + floor random 2;
			_item3count = 0;
			};
			
			case "medium":
			{
			_item1count = 1 + floor random 2;
			_item2count = 1 + floor random 3;
			_item3count = 1 + floor random 1;
			};
			
			case "high":
			{
			_item1count = 1 + floor random 5;
			_item2count = 1 + floor random 4;
			_item3count = 1 + floor random 3;
			};
		};
		
		for "_i" from 0 to _item1count do
		{
			_item = itemsMedBandages call BIS_fnc_selectRandom;
			_holder additemcargoglobal [_item, 3];
			;
		};
		
		for "_i" from 0 to _item2count do
		{
			_item = itemsMedDrugs call BIS_fnc_selectRandom;
			_holder additemcargoglobal [_item, 1];
			;
		};
		if (_item3count > 0) then {
			for "_i" from 0 to _item3count do
			{
				_item = itemsMedTech call BIS_fnc_selectRandom;
				_holder additemcargoglobal [_item, 1];
				;
			};
		};
	};
	
	case "ammo":
	{
	if (mmSettingsMarkers) then {
		_helper = createvehicle [ "Sign_Arrow_Yellow_F", _loc,[], 0, "can_Collide"];
	};	
		_item1count = 1 + floor random 6;
		if (_item1count > 0) then {
			_item = itemsAmmo call BIS_fnc_selectRandom;
			_holder addmagazinecargoglobal [_item, _item1count];		
		};
	};
	
	case "util":
	{
	if (mmSettingsMarkers) then {
		_helper = createvehicle [ "Sign_Arrow_Green_F", _loc,[], 0, "can_Collide"];
	};

		switch "_typeB" do
		{
			case "low":
			{
			_item1count = 1 + floor random 1;
			_item2count = 1 + floor random 2;
			_item3count = 0;
			};
			
			case "medium":
			{
			_item1count = 1 + floor random 2;
			_item2count = 1 + floor random 3;
			_item3count = 0;
			};
			
			case "high":
			{
			_item1count = 1 + floor random 5;
			_item2count = 1 + floor random 4;
			_item3count = 1 + floor random 1;
			};
		};
		
		for "_i" from 0 to _item1count do
		{
			_item = itemsUtilNavigation call BIS_fnc_selectRandom;
			_holder additemcargoglobal [_item, 1];
			;
		};
		
		for "_i" from 0 to _item2count do
		{
			_item = itemsUtilSpotting call BIS_fnc_selectRandom;
			_holder additemcargoglobal [_item, 1];
			;
		};
		if (_item3count > 0) then {
			for "_i" from 0 to _item3count do
			{
				_item = itemsUtilComs call BIS_fnc_selectRandom;
				_holder additemcargoglobal [_item, 1];
				;
			};
		};
	};
};












