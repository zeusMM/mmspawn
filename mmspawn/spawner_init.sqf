if (!isServer) exitWith {Hint "This is only working on a server!"};

waitUntil {time > 1};

diag_log format ["-------------------------------------------------------------------------------"];
diag_log format ["  ##     ## ##     ##         ######  ########     ###    ##      ## ##    ## "];
diag_log format ["  ###   ### ###   ###        ##    ## ##     ##   ## ##   ##  ##  ## ###   ## "];
diag_log format ["  #### #### #### ####        ##       ##     ##  ##   ##  ##  ##  ## ####  ## "];
diag_log format ["  ## ### ## ## ### ##         ######  ########  ##     ## ##  ##  ## ## ## ## "];
diag_log format ["  ##     ## ##     ##              ## ##        ######### ##  ##  ## ##  #### "];
diag_log format ["  ##     ## ##     ## ###    ##    ## ##        ##     ## ##  ##  ## ##   ### "];
diag_log format ["  ##     ## ##     ## ###     ######  ##        ##     ##  ###  ###  ##    ## "];
diag_log format ["-------------------------------------------------------------------------------"];
diag_log format ["MM. SPAWN init!"];
diag_log format ["-------------------------------------------------------------------------------"];

mmArrBuildingsTimeout = [];

if (paramsArray select (_this select 2) == 2) then {
	mmSettingsMarkers = true;
}
else
{
	mmSettingsMarkers = false;
};

_init = []execVM "mmspawn\spawner_loottable.sqf";
waitUntil {scriptDone _init};   // Wait until the loot table has initialized before doing anything else!


/*
if (_this select 0) then {
	[mmspawn_object, _this select 1]execVM "mmspawn\spawner_populate.sqf";
};
*/

[]execVM "mmspawn\spawner_dynamic.sqf";


/*
This script needs to be called in the initServer.sqf! It will fire once the mission has started - so expect a small delay.

SYNTAX:    [BOOL: populate area automatically?, RADIUS: what radius around mmspawn_object should it populate?, INT: Which index has the LOOT MARKERS parameter in the description.ext?]execVM "mmspawn\spawner_init.sqf"
EXAMPLE:

waitUntil {time > 1};
[true, 30000, 1]execVM "mmspawn\spawner_init.sqf"

This will populate the entire map with loot. The LOOT MARKER parameter is the second in the description.ext.
*/