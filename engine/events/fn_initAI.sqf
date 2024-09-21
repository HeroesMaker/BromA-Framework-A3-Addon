/*
================================================================================

NAME:
    BRM_FMK_fnc_initAI

AUTHOR(s):
    Nife

DESCRIPTION:
    Initializes an AI unit with their loadout and environment variables.

PARAMETERS:
    0 - Target unit. (OBJECT)
    1 - Faction the unit belongs to. (STRING)

USAGE:
    [aiUnit, "SLA"] call BRM_FMK_fnc_initAI;
    [this, "RACS"] call BRM_FMK_fnc_initAI;

RETURNS:
    Nothing.

================================================================================
*/

params ["_unit", "_faction"];

if !(local _unit && _unit isKindOf "CAManBase") exitWith {};

// Check if the unit already hasn't been initialized. ==========================

if (_unit getVariable ["unit_initialized", false]) exitWith {};

if (!BRM_FMK_initialized) exitWith {
	[{ BRM_FMK_initialized }, { _this call BRM_FMK_fnc_initAI; }, _this] call CBA_fnc_waitUntilAndExecute;
};

// Determines the unit's faction. ==========================================

_unit setVariable ["unit_side", side _unit, true]; // Backward compatibility

private _unitInit = _unit getVariable "unitInit";
if (!isNil "_unitInit") then {
	_faction = _unitInit select 1;
};

_faction = switch (_faction) do {
	case "side_a": { side_a_faction };
	case "side_b": { side_b_faction };
	case "side_c": { side_c_faction };
	default        { _faction };
};

private _aliasAUTO = ["*", "AUTO", "ANY"];
private _aliasNONE = ["-", "NONE", "VANILLA"];

if (toUpper _faction in _aliasAUTO) then {
	_faction = [side _unit, "FACTION"] call BRM_FMK_fnc_getSideInfo;
};

if !(_faction isEqualType "") then { _faction = str _faction };

// Assigns the Unit's loadout depending on mission settings. ===============

if (!(_faction in _aliasNONE) && !units_AI_useVanillaGear) then {
	if (!isNil "_unitInit") then {
		private _role = _unitInit select 2;
		if (toUpper _role in _aliasAUTO) then {
			_role = getText (configOf _unit >> "displayName");
		};
		[_unit, _faction, _role] call BRM_fnc_assignLoadout;
	} else {
		if (_faction != "civilian") then {
			[_unit, _faction] call BRM_fnc_assignLoadout;
		};
	}
};

// Adds the relevant Event Handlers. =======================================

_unit addEventHandler ["Hit", { (_this select 0) setVariable ["last_damage", _this select 1] }];
_unit addEventHandler ["Killed", BRM_fnc_onAIKilled];

// Finishes loading. =======================================================

_unit setVariable ["unit_initialized", true, true];
