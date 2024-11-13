zr_config = {}
zr_config.zr_translation = {}
zr_trans = zr_config.zr_translation

-- We support the following frameworks: 'QB' / 'ESX'
zr_config.framework = 'QB'
zr_config.QB = 'qb-core'
zr_config.ESX = 'es_extended'

zr_config.OnlyLastLocation = true
zr_config.SpawnAnimation = true
zr_config.SpawnAnimationDuration = 1000 -- 1000s before the animation starts, if your player loads slower and you fall under map increase this 'Wait' value.

zr_trans.last = "Last Location."
zr_trans.lastinfo = "You will spawn in your last location"

zr_trans.spawn = "Spawn here."
zr_trans.spawnlast = "Spawn at last location"


zr_config.zr_locations = {
    { 
        name = "cityhall", 
        label = "City Hall", 
        adress = "Glen Park Boulevard, Los Santos.",
        coords = vector3(-532.52, -237.43, 49.22), 
        rot = vector3(-23.58, -0.0, 17.22), 
        spawn = vector4(-536.2222, -226.3347, 37.666244, 212.51023) 
    },
    { 
        name = "pinkcage", 
        label = "Pink Cage Motel", 
        adress = "Glen Park Boulevard, Los Santos.",
        coords = vector3(320.82, -254.77, 72.66), 
        rot = vector3(-29.28, -0.0, 1.53), 
        spawn = vector4(313.76745, -230.6358, 53.990818, 153.79005) 
    },
    { 
        name = "fishing", 
        label = "Fishing Spot", 
        adress = "Glen Park Boulevard, Los Santos.",
        coords = vector3(-1879.11, -1254.358, 15.033), 
        rot = vector3(-14.85577, -0.0, -67.75), 
        spawn = vector4(-1850.43, -1232.158, 13.01728, 141.12789) 
    },
    { 
        name = "vehicleshop", 
        label = "PDM", 
        adress = "Glen Park Boulevard, Los Santos.",
        coords = vector3(-74.46, -1118.379, 32.82), 
        rot = vector3(-15.45, 4.26, -64.80), 
        spawn = vector4(-42.1563, -1108.702, 26.438091, 162.17939) 
    },
    {
        name = "prison",
        label = "Prison", 
        adress = "Glen Park Boulevard, Los Santos.",
        job = "police", 
        coords = vector3(1875.56, 2561.128, 55.37), 
        rot = vector3(-18.36, 1.70, 47.65), 
        spawn = vector4(1847.7116, 2585.9758, 45.67237, 100.0) 
    },
    {
        name = "hospital", 
        label = "Hospital", 
        adress = "Glen Park Boulevard, Los Santos.",
        job = "ambulance", 
        coords = vector3(270.32, -564.83, 53.52), 
        rot = vector3(-29.46, -0.0, -123.25), 
        spawn = vector4(299.64801, -575.1514, 43.260845, 76.685317) 
    },
}