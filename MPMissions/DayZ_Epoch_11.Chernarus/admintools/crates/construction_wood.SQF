// Name of this crate
_crateName = "Construction_Wood";

// Crate type. Possibilities: MedBox0, FoodBox0, BAF_BasicWeapons, USSpecialWeaponsBox, USSpecialWeapons_EP1, USVehicleBox, RUSpecialWeaponsBox, RUVehicleBox, etc.
_classname = "USOrdnanceBox";

// Set the # of items
_numItems = 1;

// Location of player and crate
_dir = getdir player;
_pos = getposATL player;
_pos = [(_pos select 0)+1*sin(_dir),(_pos select 1)+1*cos(_dir), (_pos select 2)];
_spawnCrate = createVehicle [_classname, _pos, [], 0, "CAN_COLLIDE"];
_spawnCrate setDir _dir;
_spawnCrate setposATL _pos;

// Remove default items/weapons from current crate before adding custom gear
clearWeaponCargoGlobal _spawnCrate;
clearMagazineCargoGlobal _spawnCrate;
clearBackpackCargoGlobal _spawnCrate;

// Add weapon-slot items to crate
_spawnCrate addWeaponCargoGlobal ["ItemCrowbar", _numItems * 2];
_spawnCrate addWeaponCargoGlobal ["ItemEtool", _numItems * 2];
_spawnCrate addWeaponCargoGlobal ["ItemHatchet", _numItems * 2];
_spawnCrate addWeaponCargoGlobal ["ItemMatchbox", _numItems * 2];
_spawnCrate addWeaponCargoGlobal ["ItemSledge", _numItems * 2];
_spawnCrate addWeaponCargoGlobal ["ItemToolbox", _numItems * 2];

// Add magazine-slot items to crate
_spawnCrate addMagazineCargoGlobal ["ItemWoodFloor", _numItems * 20];
_spawnCrate addMagazineCargoGlobal ["ItemWoodFloorHalf", _numItems * 10];
_spawnCrate addMagazineCargoGlobal ["ItemWoodFloorQuarter", _numItems * 10];
_spawnCrate addMagazineCargoGlobal ["ItemWoodLadder", _numItems * 2];
_spawnCrate addMagazineCargoGlobal ["ItemWoodStairs", _numItems * 2];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWall", _numItems * 20];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallDoor", _numItems * 2];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallDoorLg", _numItems * 2];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallGarageDoor", _numItems * 2];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallGarageDoorLocked", _numItems * 2];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallLg", _numItems * 2];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallThird", _numItems * 5];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallWindow", _numItems * 2];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallWindowLg", _numItems * 2];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallWithDoor", _numItems * 2];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallwithDoorLg", _numItems * 2];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallWithDoorLgLocked", _numItems * 2];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallWithDoorLocked", _numItems * 2];
_spawnCrate addMagazineCargoGlobal ["PartPlankPack", _numItems * 10];
_spawnCrate addMagazineCargoGlobal ["PartPlywoodPack", _numItems * 10];
_spawnCrate addMagazineCargoGlobal ["workbench_kit", _numItems * 1];

// Add only 1 backpack. The rest will fall out onto the ground.
_spawnCrate addBackpackCargoGlobal ["DZ_Backpack_EP1", 1];

// Send text to spawner only
titleText [format[_crateName + " spawned!"],"PLAIN DOWN"]; titleFadeOut 4;

// Run delaymenu
delaymenu = 
[
	["",true],
	["Select delay", [-1], "", -5, [["expression", ""]], "1", "0"],
	["", [-1], "", -5, [["expression", ""]], "1", "0"],
	["30 seconds", [], "", -5, [["expression", "SelectDelay=30;DelaySelected=true;"]], "1", "1"],
	["1 min", [], "", -5, [["expression", "SelectDelay=60;DelaySelected=true;"]], "1", "1"],
	["3 min", [], "", -5, [["expression", "SelectDelay=180;DelaySelected=true;"]], "1", "1"],
	["5 min", [], "", -5, [["expression", "SelectDelay=300;DelaySelected=true;"]], "1", "1"],
	["10 min", [], "", -5, [["expression", "SelectDelay=600;DelaySelected=true;"]], "1", "1"],
	["30 min", [], "", -5, [["expression", "SelectDelay=1800;DelaySelected=true;"]], "1", "1"],
	["", [-1], "", -5, [["expression", ""]], "1", "0"],
	["No timer", [], "", -5, [["expression", "DelaySelected=false;"]], "1", "1"],
	["", [-1], "", -5, [["expression", ""]], "1", "0"]
];
showCommandingMenu "#USER:delaymenu";
WaitUntil{DelaySelected};
DelaySelected=false;
titleText [format[_crateName + " will disappear in %1 seconds.",SelectDelay],"PLAIN DOWN"]; titleFadeOut 4;
sleep SelectDelay;

// Delete crate after SelectDelay seconds
deletevehicle _spawnCrate;
titleText [format[_crateName + " disappeared."],"PLAIN DOWN"]; titleFadeOut 4;