if (!isServer) exitWith {Hint "This is only working on a server!"};

waitUntil {time > 1}; // Wait until the mission has started - then initialize everything and get going!

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
mmArrItems = [];

_init = []execVM "mmspawn\spawner_loottable.sqf";
waitUntil {scriptDone _init};   // Wait until the loot table has initialized before doing anything else!


[]execVM "mmspawn\spawner_dynamic.sqf";
