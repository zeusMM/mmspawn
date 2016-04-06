if(!isServer) exitWith {};

diag_log format ["MM LOOTTABLES: Initialization started at %1", time];

mmSttsSpawnDynamic = true;
mmSttsSpawnRadius = 300;
mmSttsSpawnChance = 50;

spawnList = [
[0, 13, 21, 24, 18, 22],	// civil
[1, 22, 36, 28, 26, 18],	// military
[2, 10, 21, 28, 26, 36],	// industrial
[3, 12, 36, 36, -1, -1]		// research
];

itemsWeaponsAR = ["arifle_Katiba_F", "arifle_MXC_F", "arifle_Mk20_F", "rhs_weap_m4", "rhs_weap_m16a4", "rhs_weap_ak74m", "hlc_rifle_FAL5061", "hlc_rifle_g3a3"];
itemsWeaponsMrks = ["srifle_dmr_01_F", "srifle_EBR_F", "rhs_weap_svd"];
itemsWeaponsSMG = ["SMG_01_F", "SMG_02_F", "hlc_smg_mp5a2", "hgun_PDW2000_F"];
itemsWeaponsPistol = ["hgun_Rook40_F", "hgun_Pistol_heavy_01_F", "hgun_ACPC2_F", "hgun_P07_F"];

itemsMedBandages = ["ACE_elasticBandage", "ACE_fieldDressing", "ACE_quickclot", "ACE_packingBandage"];
itemsMedDrugs = ["ACE_epinephrine", "ACE_morphine", "ACE_atropine"];
itemsMedTech = ["ACE_salineIV_500", "ACE_salineIV_250", "ACE_personalAidKit", "ACE_surgicalKit", "ACE_tourniquet"];

itemsUtilThrowable = ["rhs_mag_m67", "rhs_mag_rgo", "ACE_HandFlare_Red", "Chemlight_red", "Chemlight_green"];
itemsUtilNavigation = ["NVGoggles","acc_flashlight", "ItemMap", "ItemCompass", "ItemGPS", "ACE_Flashlight_XL50", "ACE_Flashlight_MX991"];
itemsUtilComs = ["tf_anprc152", "tf_fadak"];
itemsUtilSpotting = ["Binocular", "ACE_Rangecard", "Ace_Vector"];

itemsWeapons = (itemsweaponsar + itemsweaponsmrks + itemsweaponssmg + itemsweaponspistol);
itemsAmmo = [];

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
	_gun = _x;
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
			itemsAmmo = (itemsAmmo + [_magClass]);
		};
} foreach itemsWeapons;
diag_log format ["MM LOOTTABLES: Ammotable created for %1 weapons at %2!", count itemsWeapons, time];

diag_log format ["MM LOOTTABLES: Initialization finished at %1", time];

/*
This script handles the loot tables.
DO NOT ADD ENTRIES TO THE itemsAmmo TABLE! IT WILL POPULATE AUTOMATICALLY BASED ON THE WEAPONS YOU HAVE ADDED!
*/