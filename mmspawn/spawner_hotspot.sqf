if(!isServer) exitWith {};
_trigger = _This select 0;
_radius = TriggerArea _trigger select 0;
_arrayCmd = _this select 1;

[_trigger, _radius, _arrayCmd]execVM "mmspawn\spawner_alloc.sqf"

// Call by using [_thisTrigger, [["wpn", "ar", 3], ["wpn", "pistol"], 5]]execVM "mmspawn\spawner_hotspot.sqf"
// Example will spawn 3 ARs and 5 Pistols at random locations within trigger radius!