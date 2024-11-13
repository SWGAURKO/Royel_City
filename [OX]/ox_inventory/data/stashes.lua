return {
	{
		coords = vec3(452.3, -991.4, 30.7),
		target = {
			loc = vec3(451.25, -994.28, 30.69),
			length = 1.2,
			width = 5.6,
			heading = 0,
			minZ = 29.49,
			maxZ = 32.09,
			label = 'Open personal locker'
		},
		name = 'policelocker',
		label = 'Personal locker',
		owner = true,
		slots = 70,
		weight = 70000,
		groups = shared.police
	},

	  {
		coords = vec3(301.3, -600.23, 43.28),
		target = {
			loc = vec3(298.59, -598.03, 43.28),
			length = 0.6,
			width = 1.8,
			heading = 340,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Open personal locker'
		},
		name = 'emslocker',
		label = 'Personal Locker',
		owner = true,
		slots = 70,
		weight = 70000,
		groups = {['ambulance'] = 0}
	}, 



	{ -- pops diner collection tray
		coords = vec3(1590.3, 6455.25, 26.19),
		target = {
			loc = vec3(1590.3, 6455.25, 26.19),
			length = 0.8,
			width = 0.5,
			heading = 155.24,
			minZ = 26.10,
			maxZ = 26.25,
			label = 'Open Pops Diner Collection Tray'
		},
		name = 'popsdinercollectiontray2',
		label = 'Pops Diner Collection Tray',
		owner = false,
		slots = 10,
		weight = 100000000,
	},

	{ -- pops diner storage fridge
		coords = vec3(1596.07, 6454.55, 25.25),
		target = {
			loc = vec3(1596.07, 6454.55, 25.25),
			length = 0.75,
			width = 1.0,
			heading = 335,
			minZ = 25.0,
			maxZ = 27.25,
			label = 'Open Pops Diner Storage Fridge'
		},
		name = 'popsdinerstoragefridge',
		label = 'Pops Diner Storage Fridge',
		owner = true,
		slots = 64,
		weight = 10000000000000,
		groups = {['diner'] = 0}
	},
	
}
