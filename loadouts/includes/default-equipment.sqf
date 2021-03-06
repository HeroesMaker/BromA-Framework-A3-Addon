_factionSide = if (isNil "_factionSide") then {
	switch (_faction) do {
		case "side_a";
		case side_a_faction: { side_a_side };
		case "side_b";
		case side_b_faction: { side_b_side };
		case "side_c";
		case side_c_faction: { side_c_side };
		default {
			switch (true) do {
				case (_faction in ["blufor","west"]): { WEST };
				case (_faction in ["opfor","redfor","east"]): { EAST };
				case (_faction in ["independent","resistance","indfor","guerilla"]): { RESISTANCE };
				default { if (isNil "_defaultSide") then { WEST } else { _defaultSide } };
			};
		};
	};
} else { _factionSide };

switch (_factionSide) do {
	case WEST: {
		if (isNil "_commonAR") then { _commonAR = ["rhs_weap_m249_pip_S", "rhsusf_100Rnd_556x45_soft_pouch"]; };
		if (isNil "_countAR") then { _countAR = 5; };

		if (isNil "_weaponsAT") then { _weaponsAT = _JAVELIN; };
		if (isNil "_weaponsAA") then { _weaponsAA = _STINGER; };
	};

	case EAST: {
		if (isNil "_commonAR") then { _commonAR = ["hlc_rifle_rpk74n", "hlc_45Rnd_545x39_t_rpk"]; };
		if (isNil "_countAR") then { _countAR = 7; };

		if (isNil "_weaponsAT") then { _weaponsAT = _TitanAT; };
		if (isNil "_weaponsAA") then { _weaponsAA = _IGLA; };
	};

	case RESISTANCE: {
		if (isNil "_commonAR") then { _commonAR = ["hlc_rifle_rpk74n", "hlc_45Rnd_545x39_t_rpk"]; };
		if (isNil "_countAR") then { _countAR = 7; };

		if (isNil "_weaponsAT") then { _weaponsAT = _JAVELIN; };
		if (isNil "_weaponsAA") then { _weaponsAA = _STINGER; };
	};

	default {
		if (isNil "_commonAR") then { _commonAR = ["hlc_rifle_rpk74n", "hlc_45Rnd_545x39_t_rpk"]; };
		if (isNil "_countAR") then { _countAR = 7; };

		if (isNil "_weaponsAT") then { _weaponsAT = _JAVELIN; };
		if (isNil "_weaponsAA") then { _weaponsAA = _STINGER; };
	};
};

if (isNil "_countArCARGO") then { _countArCARGO = _countAR * 4; };
if (isNil "_countWeaponsAA") then { _countWeaponsAA = 2; };
if (isNil "_countWeaponsAT") then { _countWeaponsAT = 2; };

if (isNil "_countWeaponsATCARGO") then { _countWeaponsATCARGO = _countWeaponsAT * 5; };
if (isNil "_countWeaponsAACARGO") then { _countWeaponsAACARGO = _countWeaponsAA * 5; };
