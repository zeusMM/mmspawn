if(!isServer) exitWith {};

diag_log format ["MM LOOTTABLES: Initialization started at %1", time];

mmSttsSpawnDynamic = true; // No alternative atm so leave on true!
mmSttsSpawnRadius = 300; // What radius around players should be populated with loot?
mmSttsSpawnChance = 50; // General chance for a buildingposition to get loot - use to adjust overall loot density!
mmSttsSpawnRespawn = 60; // After how many seconds should a building spawn new loot?
mmSttsSpawnCycle = 30; // How often should the script run? Needs performance testing!

/*
These are the item type lists. Add any items you wish to see spawning to the appropriate category!
For new items add an array into the appropriate category of the syntax:
["SPAWN CATEGORY", "CLASS NAME", COUNT]

SPAWN CATEGORY: this determines wether the spawn engine uses "AddWeaponCargo", "AddItemCargo", "AddMagazineCargo" or "AddBackpackCargo". It is very important this matches the item or there will be issues!
CLASS NAME: No explanation needed.
COUNT: The spawn engine will always spawn between 1 and COUNT of the item in question. If the item has SPAWN CATEOGORY "wpn", then it will spawn with 1 - COUNT magazines.
*/

// WEAPONS
_itemsWeapRifleLow = [["wpn", "arifle_Mk20_F", 3],["wpn", "hlc_rifle_FAL5061", 3],["wpn", "arifle_MXC_F", 3]];
_itemsWeapRifleHigh = [["wpn", "arifle_Katiba_F", 3],["wpn", "rhs_weap_m4", 3],["wpn", "rhs_weap_m16a4", 3],["wpn", "rhs_weap_ak74m", 3],["wpn", "hlc_rifle_g3a3", 3]];
_itemsWeapSPlow = [["wpn", "srifle_dmr_01_F", 2],["wpn", "srifle_EBR_F", 2]];
_itemsWeapSPhigh = [["wpn", "rhs_weap_svd", 2]];
_itemsWeapSMG = [["wpn", "SMG_01_F", 5],["wpn", "SMG_02_F", 5],["wpn", "hlc_smg_mp5a2", 5],["wpn", "hgun_PDW2000_F", 5]];
_itemsWeapP = [["wpn", "hgun_Rook40_F", 5],["wpn", "hgun_Pistol_heavy_01_F", 5],["wpn", "hgun_ACPC2_F", 5],["wpn", "hgun_P07_F", 5]];
_itemsWeapGren = [["rhs_mag_m67", 3],["rhs_mag_rgo", 3]];
_itemsWeapMines = [];
// CLOTHING AND OUTFIT
_itemsClothesCivilian = [["item", "U_C_WorkerCoveralls", 1],["item", "U_C_Poor_shorts_1", 1],["item", "U_C_Journalist", 1],["item", "U_Marshal", 1],["item", "U_C_Poloshirt_blue", 1]];
_itemsClothesParamilitary = [];
_itemsClothesMilitary = [["item", "U_B_CombatUniform_mcam_tshirt", 1],["item", "U_B_CombatUniform_mcam_worn", 1],["item", "U_O_SpecopsUniform_ocamo", 1],["item", "U_I_CombatUniform", 1],["item", "U_IG_leader", 1]];
// VESTS
_itemsVestCivilian = [["item", "V_Rangemaster_belt", 1],["item", "V_BandollierB_khk", 1]];
_itemsVestMilitary = [["item", "V_PlateCarrier1_rgr", 1]];
//MEDICAL SUPPLIES
_itemsMedBandages = [["item", "ACE_elasticBandage", 3],["item", "ACE_fieldDressing", 5],["item", "ACE_quickclot", 3],["item", "ACE_packingBandage", 3]];
_itemsMedDrugs = [["item", "ACE_epinephrine", 3],["item", "ACE_morphine", 3],["item", "ACE_atropine", 3]];
_itemsMedTech = [["item", "ACE_salineIV_500", 1],["item", "ACE_salineIV_250", 2],["item", "ACE_personalAidKit", 1],["item", "ACE_surgicalKit", 1],["item", "ACE_tourniquet", 1]];
//ADDITIONAL GEAR & UTILITY
_itemsUtilThrowable = [["item", "ACE_HandFlare_Red", 3],["item", "Chemlight_red", 5],["item", "Chemlight_green", 5]];
_itemsUtilNavigation = [["item", "acc_flashlight", 1],["item", "ItemMap", 1],["item", "ItemCompass", 1],["item", "ItemGPS", 1],["item", "ACE_Flashlight_XL50", 1],["item", "ACE_Flashlight_MX991", 1]];
_itemsUtilTech = [["item", "tf_anprc152", 1],["item", "tf_fadak", 1],["item", "NVGoggles", 1]];
_itemsUtilSpotting = [["item", "Binocular", 1],["item", "ACE_Rangecard", 1],["item", "Ace_Vector", 1]];

_itemsWeapons = (_itemsWeapRifleLow + _itemsWeapRifleHigh + _itemsWeapSPlow + _itemsWeapSPhigh + _itemsWeapSMG + _itemsWeapP);
_itemsAmmo = [];

/*
The following arrays are populated with all items from the given item categories - e.g loot0mil is high grade weaponry and will populate with SMGs, good and bad rifles as well as sniper rifles.
*/

// 0 - WEAPONS
loot0civ = _itemsWeapP + _itemsWeapSMG;
loot0med = _itemsWeapP + _itemsWeapSMG + _itemsWeapRifleLow;
loot0mil = _itemsWeapSMG + _itemsWeapRifleLow + _itemsWeapRifleHigh + _itemsWeapSPlow + _itemsWeapSPhigh;
loot0spec = _itemsWeapGren + _itemsWeapMines;

// 1 - MEDICAL SUPPLIES
loot1civ = _itemsMedBandages;
loot1med = _itemsMedBandages + _itemsMedDrugs;
loot1mil = _itemsMedBandages + _itemsMedDrugs + _itemsMedTech;

// 2 - UTILITY SUPPLIES
loot2civ = _itemsUtilThrowable + _itemsUtilNavigation;
loot2med = _itemsUtilThrowable + _itemsUtilSpotting + _itemsUtilNavigation;
loot2mil = _itemsUtilSpotting + _itemsUtilTech;

//4 - CLOTHING
loot3civ = _itemsClothesCivilian + _itemsVestCivilian;
loot3med = _itemsClothesParamilitary + _itemsClothesCivilian + _itemsVestCivilian;
loot3mil = _itemsClothesMilitary + _itemsClothesParamilitary + _itemsVestMilitary;

/*
The first number determines the category of building:
0-civilian
1-military
2-industrial
3-research/lab

Each following array starts with the drop chance for this category, followed by the loot list that it should spawn items from if the chance gets taken.
E.G: The [10, [loot0mil]] in the third entry of the second row tells you that a military type building has a 10% chance of spawning a item from loot0mil - which is high grade weaponry.
*/

lootList = [
[0, [20, [loot0civ]], [8, [loot0med]], [0, [ loot0mil]], [25, [loot1civ]], [10, [loot1med]], [0, [loot1mil]], [22, [loot2civ]], [8, [loot2med]], [0, [loot2mil]], [30, [loot3civ]], [15, [loot3med]], [0, [loot3mil]]],
[1, [8, [loot0civ]], [12, [loot0med]], [10, [ loot0mil]], [8, [loot1civ]], [10, [loot1med]], [5, [loot1mil]], [10, [loot2civ]], [15, [loot2med]], [8, [loot2mil]], [0, [loot3civ]], [12, [loot3med]], [18, [loot3mil]]],
[2, [30, [loot0civ]], [10, [loot0med]], [0, [ loot0mil]], [30, [loot1civ]], [10, [loot1med]], [0, [loot1mil]], [30, [loot2civ]], [10, [loot2med]], [0, [loot2mil]], [30, [loot3civ]], [10, [loot3med]], [0, [loot3mil]]],
[3, [30, [loot0civ]], [10, [loot0med]], [0, [ loot0mil]], [30, [loot1civ]], [10, [loot1med]], [0, [loot1mil]], [30, [loot2civ]], [10, [loot2med]], [0, [loot2mil]], [30, [loot3civ]], [10, [loot3med]], [0, [loot3mil]]]
];


/*
This list contains all buildings that loot should spawn in and designates their loot category.
You can add and other building to this - just make sure it has building positions!
*/
itemsBuildingsList = [
["Land_Airport_left_F", 0],
["Land_Airport_right_F", 0],
["Land_Airport_Tower_dam_F", 2],
["Land_Airport_Tower_F", 2],
["Land_cargo_house_slum_F", 0],
["Land_Cargo_House_V1_F", 1],
["Land_Cargo_House_V2_F", 1],
["Land_Cargo_House_V3_F", 1],
["Land_Cargo_HQ_V1_F", 1],
["Land_Cargo_HQ_V2_F", 1],
["Land_Cargo_HQ_V3_F", 1],
["Land_Cargo_Patrol_V1_F", 1],
["Land_Cargo_Patrol_V2_F", 1],
["Land_Cargo_Patrol_V3_F", 1],
["Land_Cargo_Tower_V1_F", 1],
["Land_Cargo_Tower_V3_F", 1],
["Land_CarService_F", 2],
["Land_Chapel_Small_V1_F", 0],
["Land_Chapel_Small_V2_F", 0],
["Land_Chapel_V1_F", 0],
["Land_Chapel_V2_F", 0],
["Land_Crane_F", 0],
["Land_dp_bigTank_F", 2], 
["Land_dp_mainFactory_F", 2],
["Land_d_Stone_Shed_V1_F", 0], 
["Land_d_Windmill01_F", 0],
["Land_FuelStation_Build_F", 0], 
["Land_FuelStation_Shed_F", 0], 
["Land_Hangar_F", 2],
["Land_Hospital_main_F", 0],
["Land_Hospital_side1_F", 0],
["Land_Hospital_side2_F", 0],
["Land_i_Addon_02_V1_F", 0],
["Land_i_Addon_03mid_V1_F", 0], 
["Land_i_Addon_03_V1_F", 0], 
["Land_i_Addon_04_V1_F", 0], 
["Land_i_Barracks_V1_F", 2],
["Land_i_Barracks_V2_F", 1],
["Land_i_Garage_V1_F", 0], 
["Land_i_Garage_V2_F", 0],
["Land_i_House_Big_01_V1_dam_F", 0], 
["Land_i_House_Big_01_V1_F", 0], 
["Land_i_House_Big_01_V2_F", 0],
["Land_i_House_Big_01_V3_F", 0],
["Land_i_House_Big_02_V1_dam_F", 0], 
["Land_i_House_Big_02_V1_F", 0], 
["Land_i_House_Big_02_V2_F", 0],
["Land_i_House_Big_02_V3_F", 0],
["Land_i_House_Small_01_V1_dam_F", 0], 
["Land_i_House_Small_01_V1_F", 0], 
["Land_i_House_Small_01_V2_dam_F", 0], 
["Land_i_House_Small_01_V2_F", 0], 
["Land_i_House_Small_01_V3_F", 0],
["Land_i_House_Small_02_V1_dam_F", 0], 
["Land_i_House_Small_02_V1_F", 0], 
["Land_i_House_Small_02_V2_F", 0],
["Land_i_House_Small_02_V3_F", 0],
["Land_i_House_Small_03_V1_dam_F", 0], 
["Land_i_House_Small_03_V1_F", 0], 
["Land_i_Shed_Ind_F", 2],
["Land_i_Shop_01_V1_dam_F", 0], 
["Land_i_Shop_01_V1_F", 0], 
["Land_i_Shop_01_V2_F", 0],
["Land_i_Shop_01_V3_F", 0],
["Land_i_Shop_02_V1_dam_F", 0], 
["Land_i_Shop_02_V1_F", 0], 
["Land_i_Shop_02_V2_F", 0],
["Land_i_Shop_02_V3_F", 0],
["Land_i_Stone_HouseBig_V1_dam_F", 0], 
["Land_i_Stone_HouseBig_V1_F", 0], 
["Land_i_Stone_HouseBig_V2_F", 0],
["Land_i_Stone_HouseBig_V3_F", 0],
["Land_i_Stone_HouseSmall_V1_dam_F", 0], 
["Land_i_Stone_HouseSmall_V1_F", 0], 
["Land_i_Stone_HouseSmall_V2_F", 0],
["Land_i_Stone_HouseSmall_V3_F", 0],
["Land_i_Stone_Shed_V1_dam_F", 0], 
["Land_i_Stone_Shed_V1_F", 0], 
["Land_i_Stone_Shed_V2_F", 0],
["Land_i_Stone_Shed_V3_F", 0],
["Land_i_Windmill01_F", 0],
["Land_LightHouse_F", 0], 
["Land_Lighthouse_small_F", 0], 
["Land_Metal_Shed_F", 2], 
["Land_MilOffices_V1_F", 1],
["Land_Offices_01_V1_F", 0],
["Land_Radar_F", 2],
["Land_Research_house_V1_F", 3],
["Land_Research_HQ_F", 3],
["Land_Slum_House01_F", 0],
["Land_Slum_House02_F", 0],
["Land_Slum_House03_F", 0],
["Land_spp_Tower_F", 2],
["Land_Unfinished_Building_01_F", 2], 
["Land_Unfinished_Building_02_F", 2],
["Land_u_Addon_01_V1_F", 0], 
["Land_u_Addon_02_V1_F", 0], 
["Land_u_Barracks_V2_F", 1],
["Land_u_House_Big_01_V1_F", 0],
["Land_u_House_Big_02_V1_F", 0],
["Land_u_House_Small_01_V1_dam_F", 0], 
["Land_u_House_Small_01_V1_F", 0], 
["Land_u_House_Small_02_V1_dam_F", 0], 
["Land_u_House_Small_02_V1_F", 0], 
["Land_u_Shed_Ind_F", 2],
["Land_u_Shop_01_V1_F", 0],
["Land_u_Shop_02_V1_F", 0],
["Land_WIP_F", 2]
];

_magazines = [];
_magClass = "";

{
	_gun = _x select 1;
	_magazines = getArray (configFile / "CfgWeapons" / _gun / "magazines");
	
		if (count _magazines > 0 && isClass (configFile / "CfgWeapons" / _gun)) then
		{
			_magClass = _magazines select 0;
		}
		else
		{
			_magClass = "";
		};
		
		if (isClass (configFile / "CfgMagazines" / _magClass)) then
		{
			_itemsAmmo pushback _magClass;
		};
} foreach _itemsWeapons;


diag_log format ["MM LOOTTABLES: Ammotable created for %1 weapons at %2!", count _itemsWeapons, time];

diag_log format ["MM LOOTTABLES: Initialization finished at %1", time];

/*
This script handles the loot tables.
DO NOT ADD ENTRIES TO THE itemsAmmo TABLE! IT WILL POPULATE AUTOMATICALLY BASED ON THE WEAPONS YOU HAVE ADDED!
*/