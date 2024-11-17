Config = {}

Config.Framework = 'qb' -- esx, qb, oldqb, oldesx, autodetect
Config.SQL = 'oxmysql'  --- mysql-async - oxmysql - ghmattimysql


Config.Command = "carplay"
Config.UsableItem = false        -- false or "" -- leave blank or set to false to disable item name | item control for open menu
Config.CursorControl = 137       -- CAPS
Config.FuelSystem = 'LegacyFuel' -- LegacyFuel / ox-fuel / nd-fuel / frfuel / cdn-fuel / hyon_gas_station
Config.SpotifyImage = true
Config.SpotifyClientID = "b048188eabdb4e7dbbc94da1b5293c3a"
Config.SpotifyClientSecret = "917d059e50fa41c79f1e73297df2cc9e"
Config.SongMinimumDistance = 10.0
Config.EnableRegisterKeyMapping = true
Config.EnableRegisterKeyMappingKey = 'F10'
Config.vehicleData = 'player_vehicles' -- player_vehicles or owned_vehicles
Config.AutoPilot = {
    ["SPEED"] = 50.0,
    ["DRIVING_MODE"] = 191 --https://vespura.com/fivem/drivingstyle/
}
Config.MPH = false
Config.Debug = false
Config.MovingMouse = true
Config.Fuel = function(vehicle)
    if DoesEntityExist(vehicle) then
        if GetResourceState('LegacyFuel') == 'started' then
            return exports["LegacyFuel"]:GetFuel(vehicle)
        end
        return GetVehicleFuelLevel(vehicle)
    end
    return 0
end

Config.Nitro = function(vehicle)
    return 0
end

Config.Belt = function()
    return true
end

Config.Neon = function(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    local bool = TriggerCallback('mCarplay:getNeon', plate)
    return bool
end


--https://pastebin.com/dzP53BCK vehicle class
Config.AutoPilotWhitelist = { 6, 5 }
Config.AutoPilotWhitelistBool = false
Config.CarcontrolWhitelist = { 6, 5 }
Config.CarcontrolWhitelistBool = false

Config.NotificationData = {
    ["NoAcces"] = {
        type = 'error',
        msg = 'Driver must give access'
    },
    ["NoWhitelist"] = {
        type = 'error',
        msg = 'This vehicle is not whitelisted'
    },
    ["SelectLocation"] = {
        type = 'error',
        msg = 'Choose a location'
    }

}

Config.QuickLocations = {
    bank = {
        vector3(150.266, -1040.203, 29.374),
        vector3(-1212.980, -330.841, 37.787),
        vector3(-2962.582, 482.627, 15.703),
        vector3(-112.202, 6469.295, 31.626),
        vector3(314.187, -278.621, 54.170),
        vector3(-351.534, -49.529, 49.042),
        vector3(241.727, 220.706, 106.286),
        vector3(1175.064, 2706.643, 38.094),
    },
    gas_stations = {
        vector3(49.4187, 2778.793, 58.043),
        vector3(263.894, 2606.463, 44.983),
        vector3(1039.958, 2671.134, 39.550),
        vector3(1207.260, 2660.175, 37.899),
        vector3(2539.685, 2594.192, 37.944),
        vector3(2679.858, 3263.946, 55.240),
        vector3(2005.055, 3773.887, 32.403),
        vector3(1687.156, 4929.392, 42.078),
        vector3(1701.314, 6416.028, 32.763),
        vector3(179.857, 6602.839, 31.868),
        vector3(-94.4619, 6419.594, 31.489),
        vector3(-2554.996, 2334.40, 33.078),
        vector3(-1800.375, 803.661, 138.651),
        vector3(-1437.622, -276.747, 46.207),
        vector3(-2096.243, -320.286, 13.168),
        vector3(-724.619, -935.1631, 19.213),
        vector3(-526.019, -1211.003, 18.184),
        vector3(-70.2148, -1761.792, 29.534),
        vector3(265.648, -1261.309, 29.292),
        vector3(819.653, -1028.846, 26.403),
        vector3(1208.951, -1402.567, 35.224),
        vector3(1181.381, -330.847, 69.316),
        vector3(620.843, 269.100, 103.089),
        vector3(2581.321, 362.039, 108.468),
        vector3(176.631, -1562.025, 29.263),
        vector3(176.631, -1562.025, 29.263),
        vector3(-319.292, -1471.715, 30.549),
        vector3(1784.324, 3330.55, 41.253)
    },
    shops = {
        vector3(373.875, 325.896, 102.566),
        vector3(2557.458, 382.282, 107.622),
        vector3(-3038.939, 585.954, 6.908),
        vector3(-1487.553, -379.107, 39.163),
        vector3(1392.562, 3604.684, 33.980),
        vector3(-2968.243, 390.910, 14.043),
        vector3(2678.916, 3280.671, 54.24),
        vector3(-48.519, -1757.514, 28.421),
        vector3(1163.373, -323.801, 68.205),
        vector3(-707.501, -914.260, 18.215),
        vector3(-1820.523, 792.518, 137.118),
        vector3(1698.388, 4924.404, 41.063),
        vector3(1961.464, 3740.672, 31.343),
        vector3(1135.808, -982.281, 45.415),
        vector3(25.88, -1347.1, 28.5),
        vector3(547.431, 2671.710, 41.156),
        vector3(-3241.927, 1001.462, 11.830),
        vector3(1166.024, 2708.930, 37.157),
        vector3(1729.216, 6414.131, 34.037),
    },
    clothing_shops = {
        vector3(72.3, -1399.1, 28.4),
        vector3(-703.8, -152.3, 36.4),
        vector3(-167.9, -299.0, 38.7),
        vector3(428.7, -800.1, 28.5),
        vector3(-829.4, -1073.7, 10.3),
        vector3(-1447.8, -242.5, 48.8),
        vector3(11.6, 6514.2, 30.9),
        vector3(123.6, -219.4, 53.6),
        vector3(1696.3, 4829.3, 41.1),
        vector3(618.1, 2759.6, 41.1),
        vector3(1190.6, 2713.4, 37.2),
        vector3(-1193.4, -772.3, 16.3),
        vector3(-3172.5, 1048.1, 19.9),
        vector3(-1108.4, 2708.9, 18.1)
    },
    barber_shops = {
        vector3(-814.3, -183.8, 36.6),
        vector3(136.8, -1708.4, 28.3),
        vector3(-1282.6, -1116.8, 6.0),
        vector3(1931.5, 3729.7, 31.8),
        vector3(1212.8, -472.9, 65.2),
        vector3(-32.9, -152.3, 56.1),
        vector3(-278.1, 6228.5, 30.7)
    },
    tattoo_shops = {
        vector3(1322.6, -1651.9, 51.2),
        vector3(-1153.6, -1425.6, 4.9),
        vector3(322.1, 180.4, 103.5),
        vector3(-3170.0, 1075.0, 20.8),
        vector3(1864.6, 3747.7, 33.0),
        vector3(-293.7, 6200.0, 31.4)
    },
}

Config.zoneNames = {
    AIRP = "Los Santos International Airport",
    ALAMO = "Alamo Sea",
    ALTA = "Alta",
    ARMYB = "Fort Zancudo",
    BANHAMC = "Banham Canyon",
    BANNING = "Banning",
    BAYTRE = "Baytree Canyon",
    BEACH = "Vespucci Beach",
    BHAMCA = "Banham Canyon",
    BRADP = "Braddock Pass",
    BRADT = "Braddock Tunnel",
    BURTON = "Burton",
    CALAFB = "Calafia Bridge",
    CANNY = "Raton Canyon",
    CCREAK = "Cassidy Creek",
    CHAMH = "Chamberlain Hills",
    CHIL = "Vinewood Hills",
    CHU = "Chumash",
    CMSW = "Chiliad Mountain State Wilderness",
    CYPRE = "Cypress Flats",
    DAVIS = "Davis",
    DELBE = "Del Perro Beach",
    DELPE = "Del Perro",
    DELSOL = "La Puerta",
    DESRT = "Grand Senora Desert",
    DOWNT = "Downtown",
    DTVINE = "Downtown Vinewood",
    EAST_V = "East Vinewood",
    EBURO = "El Burro Heights",
    ELGORL = "El Gordo Lighthouse",
    ELYSIAN = "Elysian Island",
    GALFISH = "Galilee",
    GALLI = "Galileo Park",
    golf = "GWC and Golfing Society",
    GRAPES = "Grapeseed",
    GREATC = "Great Chaparral",
    HARMO = "Harmony",
    HAWICK = "Hawick",
    HORS = "Vinewood Racetrack",
    HUMLAB = "Humane Labs and Research",
    JAIL = "Bolingbroke Penitentiary",
    KOREAT = "Little Seoul",
    LACT = "Land Act Reservoir",
    LAGO = "Lago Zancudo",
    LDAM = "Land Act Dam",
    LEGSQU = "Legion Square",
    LMESA = "La Mesa",
    LOSPUER = "La Puerta",
    MIRR = "Mirror Park",
    MORN = "Morningwood",
    MOVIE = "Richards Majestic",
    MTCHIL = "Chiliad Mountain",
    MTGORDO = "Mount Gordo",
    MTJOSE = "Mount Josiah",
    MURRI = "Murrieta Heights",
    NCHU = "North Chumash",
    NOOSE = "N.O.O.S.E",
    OCEANA = "Pacific Ocean",
    PALCOV = "Paleto Cove",
    PALETO = "Paleto Bay",
    PALFOR = "Paleto Forest",
    PALHIGH = "Palomino Highlands",
    PALMPOW = "Palmer-Taylor Power Station",
    PBLUFF = "Pacific Bluffs",
    PBOX = "Pillbox Hill",
    PROCOB = "Procopio Beach",
    RANCHO = "Rancho",
    RGLEN = "Richman Glen",
    RICHM = "Richman",
    ROCKF = "Rockford Hills",
    RTRAK = "Redwood Lights Track",
    SanAnd = "San Andreas",
    SANCHIA = "San Chianski Mountain Range",
    SANDY = "Sandy Shores",
    SKID = "Mission Row",
    SLAB = "Stab City",
    STAD = "Maze Bank Arena",
    STRAW = "Strawberry",
    TATAMO = "Tataviam Mountains",
    TERMINA = "Terminal",
    TEXTI = "Textile City",
    TONGVAH = "Tongva Hills",
    TONGVAV = "Tongva Valley",
    VCANA = "Vespucci Canals",
    VESP = "Vespucci",
    VINE = "Vinewood",
    WINDF = "Ron Alternates Wind Farm",
    WVINE = "West Vinewood",
    ZANCUDO = "Zancudo River",
    ZP_ORT = "South Los Santos Port",
    ZQ_UAR = "Davis Quartz",

}
Config.Notification = function(message, type, isServer, src) -- You can change here events for notifications
    if isServer then
        if Config.Framework == "esx" then
            TriggerClientEvent("esx:showNotification", src, message)
        else
            TriggerClientEvent('QBCore:Notify', src, message, type, 1500)
        end
    else
        if Config.Framework == "esx" then
            TriggerEvent("esx:showNotification", message)
        else
            TriggerEvent('QBCore:Notify', message, type, 1500)
        end
    end
end
