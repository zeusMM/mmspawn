if(!isServer) exitWith {};
private ["_loc", "_type", "_itemList", "_pos0", "_pos1", "_pos2", "_item", "_itemArray", "_magCount", "_magClass", "_magazines"];

_loc = _This select 0;
_loot = _this select 1;

_itemArray = (_loot select 0) call BIS_fnc_selectRandom;

_type = _itemArray select 0;
_item = _itemArray select 1;
_count = floor(random(_itemArray select 2));
if (_count == 0) then { _count = 1};

_pos0=	(_loc select 0);
_pos1=	(_loc select 1);
_pos2=	(_loc select 2);

_magCount = 0;
_magClass = "";

// Tricking any bad positioning and using physics to place the holder properly.
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
	_holder addweaponcargoglobal[_item, 1];
	_magCount = _count;
	
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
	
	case "item":
	{
		for "_i" from 1 to _count do
		{
		_holder additemcargoglobal [_item, 1];
		};	
	};
};














