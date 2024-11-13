return {
--[[ 	General = {
		name = 'Shop',
		blip = {
			id = 59, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'burger', price = 10 },
			{ name = 'water', price = 10 },
			{ name = 'cola', price = 10 },
		}, locations = {
			vec3(25.7, -1347.3, 29.49),
			vec3(-3038.71, 585.9, 7.9),
			vec3(-3241.47, 1001.14, 12.83),
			vec3(1728.66, 6414.16, 35.03),
			vec3(1697.99, 4924.4, 42.06),
			vec3(1961.48, 3739.96, 32.34),
			vec3(547.79, 2671.79, 42.15),
			vec3(2679.25, 3280.12, 55.24),
			vec3(2557.94, 382.05, 108.62),
			vec3(373.55, 325.56, 103.56),
		}, targets = {
			{ loc = vec3(25.06, -1347.32, 29.5), length = 0.7, width = 0.5, heading = 0.0, minZ = 29.5, maxZ = 29.9, distance = 1.5 },
			{ loc = vec3(-3039.18, 585.13, 7.91), length = 0.6, width = 0.5, heading = 15.0, minZ = 7.91, maxZ = 8.31, distance = 1.5 },
			{ loc = vec3(-3242.2, 1000.58, 12.83), length = 0.6, width = 0.6, heading = 175.0, minZ = 12.83, maxZ = 13.23, distance = 1.5 },
			{ loc = vec3(1728.39, 6414.95, 35.04), length = 0.6, width = 0.6, heading = 65.0, minZ = 35.04, maxZ = 35.44, distance = 1.5 },
			{ loc = vec3(1698.37, 4923.43, 42.06), length = 0.5, width = 0.5, heading = 235.0, minZ = 42.06, maxZ = 42.46, distance = 1.5 },
			{ loc = vec3(1960.54, 3740.28, 32.34), length = 0.6, width = 0.5, heading = 120.0, minZ = 32.34, maxZ = 32.74, distance = 1.5 },
			{ loc = vec3(548.5, 2671.25, 42.16), length = 0.6, width = 0.5, heading = 10.0, minZ = 42.16, maxZ = 42.56, distance = 1.5 },
			{ loc = vec3(2678.29, 3279.94, 55.24), length = 0.6, width = 0.5, heading = 330.0, minZ = 55.24, maxZ = 55.64, distance = 1.5 },
			{ loc = vec3(2557.19, 381.4, 108.62), length = 0.6, width = 0.5, heading = 0.0, minZ = 108.62, maxZ = 109.02, distance = 1.5 },
			{ loc = vec3(373.13, 326.29, 103.57), length = 0.6, width = 0.5, heading = 345.0, minZ = 103.57, maxZ = 103.97, distance = 1.5 },
		}
	},

	Liquor = {
		name = 'Liquor Store',
		blip = {
			id = 93, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'water', price = 10 },
			{ name = 'cola', price = 10 },
			{ name = 'burger', price = 15 },
		}, locations = {
			vec3(1135.808, -982.281, 46.415),
			vec3(-1222.915, -906.983, 12.326),
			vec3(-1487.553, -379.107, 40.163),
			vec3(-2968.243, 390.910, 15.043),
			vec3(1166.024, 2708.930, 38.157),
			vec3(1392.562, 3604.684, 34.980),
			vec3(-1393.409, -606.624, 30.319)
		}, targets = {
			{ loc = vec3(1134.9, -982.34, 46.41), length = 0.5, width = 0.5, heading = 96.0, minZ = 46.4, maxZ = 46.8, distance = 1.5 },
			{ loc = vec3(-1222.33, -907.82, 12.43), length = 0.6, width = 0.5, heading = 32.7, minZ = 12.3, maxZ = 12.7, distance = 1.5 },
			{ loc = vec3(-1486.67, -378.46, 40.26), length = 0.6, width = 0.5, heading = 133.77, minZ = 40.1, maxZ = 40.5, distance = 1.5 },
			{ loc = vec3(-2967.0, 390.9, 15.14), length = 0.7, width = 0.5, heading = 85.23, minZ = 15.0, maxZ = 15.4, distance = 1.5 },
			{ loc = vec3(1165.95, 2710.20, 38.26), length = 0.6, width = 0.5, heading = 178.84, minZ = 38.1, maxZ = 38.5, distance = 1.5 },
			{ loc = vec3(1393.0, 3605.95, 35.11), length = 0.6, width = 0.6, heading = 200.0, minZ = 35.0, maxZ = 35.4, distance = 1.5 }
		}
	},

	YouTool = {
		name = 'YouTool',
		blip = {
			id = 402, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'lockpick', price = 10 }
		}, locations = {
			vec3(2748.0, 3473.0, 55.67),
			vec3(342.99, -1298.26, 32.51)
		}, targets = {
			{ loc = vec3(2746.8, 3473.13, 55.67), length = 0.6, width = 3.0, heading = 65.0, minZ = 55.0, maxZ = 56.8, distance = 3.0 }
		}
	},

	Ammunation = {
		name = 'Ammunation',
		blip = {
			id = 110, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'ammo-9', price = 5, },
			{ name = 'WEAPON_KNIFE', price = 200 },
			{ name = 'WEAPON_BAT', price = 100 },
			{ name = 'WEAPON_PISTOL', price = 1000, metadata = { registered = true }, license = 'weapon' }
		}, locations = {
			vec3(-662.180, -934.961, 21.829),
			vec3(810.25, -2157.60, 29.62),
			vec3(1693.44, 3760.16, 34.71),
			vec3(-330.24, 6083.88, 31.45),
			vec3(252.63, -50.00, 69.94),
			vec3(22.56, -1109.89, 29.80),
			vec3(2567.69, 294.38, 108.73),
			vec3(-1117.58, 2698.61, 18.55),
			vec3(842.44, -1033.42, 28.19)
		}, targets = {
			{ loc = vec3(-660.92, -934.10, 21.94), length = 0.6, width = 0.5, heading = 180.0, minZ = 21.8, maxZ = 22.2, distance = 2.0 },
			{ loc = vec3(808.86, -2158.50, 29.73), length = 0.6, width = 0.5, heading = 360.0, minZ = 29.6, maxZ = 30.0, distance = 2.0 },
			{ loc = vec3(1693.57, 3761.60, 34.82), length = 0.6, width = 0.5, heading = 227.39, minZ = 34.7, maxZ = 35.1, distance = 2.0 },
			{ loc = vec3(-330.29, 6085.54, 31.57), length = 0.6, width = 0.5, heading = 225.0, minZ = 31.4, maxZ = 31.8, distance = 2.0 },
			{ loc = vec3(252.85, -51.62, 70.0), length = 0.6, width = 0.5, heading = 70.0, minZ = 69.9, maxZ = 70.3, distance = 2.0 },
			{ loc = vec3(23.68, -1106.46, 29.91), length = 0.6, width = 0.5, heading = 160.0, minZ = 29.8, maxZ = 30.2, distance = 2.0 },
			{ loc = vec3(2566.59, 293.13, 108.85), length = 0.6, width = 0.5, heading = 360.0, minZ = 108.7, maxZ = 109.1, distance = 2.0 },
			{ loc = vec3(-1117.61, 2700.26, 18.67), length = 0.6, width = 0.5, heading = 221.82, minZ = 18.5, maxZ = 18.9, distance = 2.0 },
			{ loc = vec3(841.05, -1034.76, 28.31), length = 0.6, width = 0.5, heading = 360.0, minZ = 28.2, maxZ = 28.6, distance = 2.0 }
		}
	}, ]]

	PopsDinerIngredients = {
		name = 'Pops Diner Ingredients',
		groups = {
			['diner'] = 0
		},
		inventory = {
			{ name = 'butter', price = 0 },
			{ name = 'crushedice', price = 0 },
			{ name = 'balsamicglaze', price = 0 },
			{ name = 'cranberrysauce', price = 0 },
			{ name = 'mozzarellacheese', price = 0 },
			{ name = 'cheeseslice', price = 0 },
			{ name = 'bread', price = 0 },
			{ name = 'eggs', price = 0 },
			{ name = 'chickenbreast', price = 0 },
			{ name = 'turkey', price = 0 },
			{ name = 'bacon', price = 0 },
			{ name = 'tuna', price = 0 },
			{ name = 'avocado', price = 0 },
			{ name = 'sweetcorn', price = 0 },
			{ name = 'blueraspberrysyrup', price = 0 },
			{ name = 'tropicalsyrup', price = 0 },
			{ name = 'strawberrysyrup', price = 0 },
			{ name = 'lemonlimesyrup', price = 0 },
			{ name = 'orangesyrup', price = 0 },
			{ name = 'grapesyrup', price = 0 },
			{ name = 'cherrysyrup', price = 0 },
		},
		locations = {
			vec3(1594.76, 6455.54, 25.0)
		}, 
		targets = {
			{ loc = vec3(1594.76, 6455.54, 25.0), length = 1.8, width = 0.8, heading = 335, minZ = 24.0, maxZ = 26.0, distance = 2 }
		}
	},

	PopsDinerSnacks = {
		name = 'Pops Diner Snack Shelf',
		inventory = {
			{ name = 'vanillacupcake', price = 10 },
			{ name = 'chocolatecupcake', price = 10 },
			{ name = 'chocolatebar', price = 10 },
			{ name = 'jamdoughnut', price = 10 },
			{ name = 'sugardoughnut', price = 10 },
			{ name = 'custarddoughnut', price = 10 },
			{ name = 'chocolatedoughnut', price = 10 },
		},
		locations = {
			vec3(1588.83, 6456.13, 25.7)
		}, 
		targets = {
			{ loc = vec3(1588.83, 6456.13, 25.7), length = 1.5, width = 0.8, heading = 335, minZ = 25.0, maxZ = 26.00, distance = 2 }
		}
	},

	
	PoliceArmoury = {
		name = 'Police Armoury',
		groups = shared.police,
		--[[ blip = {
			id = 110, colour = 84, scale = 0.8
		}, ]] 
		inventory = {
		--	{ name = 'weapon_stungun', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 0 },
		--	{ name = 'weapon_glock17', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 1 },
		--	{ name = 'weapon_ar15', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade =  2 },
		--	{ name = 'WEAPON_PQ15', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 3 },
		--	{ name = 'weapon_scarh', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 4 },
		--	{ name = 'WEAPON_HK416', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 6 },
		--	{ name = 'WEAPON_GRAU', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 8 },
		--	{ name = 'WEAPON_PDMK18', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 10},
		--	{ name = 'weapon_colbaton', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 0 },
			

			---- hero
			{ name = 'WEAPON_HK417', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 2 },
			{ name = 'WEAPON_PD870', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 2 },
			{ name = 'WEAPON_PDCM607', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 2 },
			{ name = 'WEAPON_SMG', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 2 },
			
			--- base
			{ name = 'WEAPON_PDBATON', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 1 },
			{ name = 'WEAPON_YTASER', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 1 },
			{ name = 'WEAPON_PDG22', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 1 },
			{ name = 'WEAPON_PDHK33', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 1 },
			{ name = 'WEAPON_PDHK45', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 1 },
			{ name = 'WEAPON_PDHKUSP', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 1 },
			

			
			
			{ name = 'harness', price = 20, grade = 1 },
			{ name = 'parachute', price = 20, grade = 0 },
			{ name = 'diving_gear', price = 20, grade = 0 },
			{ name = 'diving_fill', price = 20, grade = 0 },
			{ name = 'WEAPON_FIREEXTINGUISHER', price = 50, metadata = { registered = true, serial = 'POL' }, grade = 0 },


			{ name = 'pistol_ammo', price = 20, grade = 1 },
			{ name = 'smg_ammo', price = 20, grade = 1 },
			{ name = 'shotgun_ammo', price = 20, grade = 2 },
			{ name = 'rifle_ammo', price = 20, grade = 2 },
			{ name = 'handcuffs', price = 100, metadata = { registered = true, serial = 'POL' }, grade = 1 },
			{ name = 'weapon_flashlight', price = 50, metadata = { registered = true, serial = 'POL' }, grade = 0 },
			{ name = 'police_stormram', price = 50, metadata = { registered = true, serial = 'POL' }, grade = 0 },
			{ name = 'armor', price = 50,  grade = 0 },
			{ name = 'armorplate', price = 5,  grade = 0 },
			{ name = 'advancedrepairkit', price = 50, grade = 0 },
			{ name = 'radio', price = 500, grade = 0 },
			{ name = 'bandage', price = 30, grade = 0 },
			{ name = 'ifaks', price = 40, grade = 0 },
			{ name = 'megaphone', price = 100, grade = 0 },
			{ name = 'spikestrip', price = 10, metadata = { registered = true, serial = 'POL' }, grade = 0 },
			{ name = 'policegunrack', price = 100, metadata = { registered = true, serial = 'POL' }, grade = 0 },
			{ name = 'uvlight', price = 100, grade = 0 },
			{ name = 'keepcompanionpdk9', price = 2000, grade = 1 },
			{ name = "firstaidforpet", price = 100, grade = 4 },
			{ name = "petfood", price = 100, grade = 4 },
			{ name = "petwaterbottleportable", price = 100, grade = 4 },
			{ name = "water_bottle", price = 50, grade = 0 },
			{ name = "sandwich", price = 100, grade = 0 },
			{ name = "policecard", price = 1000, grade = 0 },
			{ name = "weapon_nightstick", price = 1000, grade = 0 },


			{ name = 'empty_evidence_bag', price = 2, grade = 0 },
			{ name = 'nikon', price = 1000, grade = 0 },
			{ name = 'gsrtestkit', price = 200, grade = 0 },
			{ name = 'dnatestkit', price = 200, grade = 0 },
			{ name = 'drugtestkit', price = 200, grade = 0 },
			{ name = 'breathalyzer', price = 200, grade = 0 },
			{ name = 'accesstool', price = 500, grade = 0 },
			{ name = 'fingerprintreader', price = 200, grade = 0 },
			{ name = 'sdcard', price = 100, grade = 0 },
			{ name = 'microfibercloth', price = 100, grade = 0 },
			{ name = 'blox', price = 100, grade = 0 },
			{ name = 'fingerprintkit', price = 1000, grade = 0 },
			{ name = 'mikrosil', price = 1000, grade = 0 },
			{ name = 'fingerprinttape', price = 1000, grade = 0 },
			{ name = 'jerrycan', price = 1000, grade = 0 },
			

		}, locations = {
			vector3(482.564, -995.179, 30.69)
		}, targets = {
			{ loc = vector3(482.564, -995.179, 30.69), length = 1, width = .5, heading = 2.69, minZ= 8.03, maxZ= 12.03, distance = 5 }
		}
	},

	--[[ EMSArmory = {
		name = 'EMS Armory',
		groups = {
			['ambulance'] = 0
		}, ]]
		--[[ blip = {
			id = 110, colour = 84, scale = 0.8
		}, ]] 
		--[[ inventory = {
			{ name = 'radio', price = 0, grade = 0  },
			{ name = 'bandage', price = 0, grade = 0  },
			{ name = 'painkillers', price = 0, grade = 0  },
			{ name = 'firstaid', price = 0, grade = 0  },
			{ name = 'weapon_flashlight', price = 0, grade = 0  },
			{ name = 'weapon_fireextinguisher', price = 0, grade = 0  },
			{ name = 'handcuffs', price = 0, grade = 0  },
			{ name = 'heavyarmor', price = 0, grade = 0  },
			{ name = 'ems_idcard', price = 0, grade = 0  },

		}, locations = {
			vector3(-454.16, -307.77, 34.91),
			vector3(-245.13, 6315.71, 32.82)
		}, targets = {
			{ loc = vector3(-454.16, -307.77, 34.91), length = 2.8, width = 1, heading = 20.0, minZ = 33.91, maxZ = 37.91, distance = 3 },
			{ loc = vector3(-245.13, 6315.71, 32.82), length = 2.8, width = 1, heading = 230.0, minZ = 29.82, maxZ = 33.82, distance = 3 }
		}
	}, ]]

	--[[ Medicine = {
		name = 'Medicine Cabinet',
		groups = {
			['ambulance'] = 0
		},
		blip = {
			id = 403, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'medikit', price = 26 },
			{ name = 'bandage', price = 5 }
		}, locations = {
			vec3(306.3687, -601.5139, 43.28406)
		}, targets = {

		}
	},

	BlackMarketArms = {
		name = 'Black Market (Arms)',
		inventory = {
			{ name = 'WEAPON_DAGGER', price = 5000, metadata = { registered = false	}, currency = 'black_money' },
			{ name = 'WEAPON_CERAMICPISTOL', price = 50000, metadata = { registered = false }, currency = 'black_money' },
			{ name = 'at_suppressor_light', price = 50000, currency = 'black_money' },
			{ name = 'ammo-rifle', price = 1000, currency = 'black_money' },
			{ name = 'ammo-rifle2', price = 1000, currency = 'black_money' }
		}, locations = {
			vec3(309.09, -913.75, 56.46)
		}, targets = {

		}
	},

	VendingMachineDrinks = {
		name = 'Vending Machine',
		inventory = {
			{ name = 'water', price = 10 },
			{ name = 'cola', price = 10 },
		},
		model = {
			`prop_vend_soda_02`, `prop_vend_fridge01`, `prop_vend_water_01`, `prop_vend_soda_01`
		}
	} ]]
}
