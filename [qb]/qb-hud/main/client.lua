local speedBuffer, velBuffer, pauseActive, isCarHud, stress, speedMultiplier, PlayerData, SpeedType, PlayerData = {0.0,0.0}, {}, false, false, 0, nil, nil, nil
Framework = nil
Framework = GetFramework()
Citizen.CreateThread(function()
   while Framework == nil do Citizen.Wait(750) end
   Citizen.Wait(2500)
end)
Callback = Config.Framework == "ESX" or Config.Framework == "NewESX" and Framework.TriggerServerCallback or Framework.Functions.TriggerCallback


--STRESS

local playerPed = nil
local function updatePlayerPed()
  playerPed = PlayerPedId()
end

local function relieveStress(action, configKey)
  updatePlayerPed()
  if Config.RemoveStress[configKey].enable and action(playerPed) then
    local val = math.random(Config.RemoveStress[configKey].min, Config.RemoveStress[configKey].max)
    TriggerServerEvent('hud:server:RelieveStress', val)
  end
end


local function addStress(condition, action, configKey)
  updatePlayerPed()
  if Config.AddStress[configKey].enable and condition() then
    action(Config.AddStress[configKey])
  end
end


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000) 
    relieveStress(IsPedSwimming, "on_swimming")
    relieveStress(IsPedRunning, "on_running")
    addStress(function()
      return IsPedInAnyVehicle(playerPed, false) and GetEntitySpeed(GetVehiclePedIsIn(playerPed, false)) * 3.6 > 110
    end, function(config)
      TriggerServerEvent('hud:server:GainStress', math.random(config.min, config.max))
    end, "on_fastdrive")
    if Config.AddStress["on_shoot"].enable then
      local weapon = GetSelectedPedWeapon(playerPed)
      if weapon ~= `WEAPON_UNARMED` and IsPedShooting(playerPed) then
        if math.random() < 0.15 and not IsWhitelistedWeaponStress(weapon) then
          TriggerServerEvent('hud:server:GainStress', math.random(Config.AddStress["on_shoot"].min, Config.AddStress["on_shoot"].max))
        end
      end
    end
  end
end)

   
   function IsWhitelistedWeaponStress(weapon)
      if weapon then
         for _, v in pairs(Config.WhitelistedWeaponStress) do
            if weapon == v then
               return true
            end
         end
      end
      return false
   end

   Citizen.CreateThread(function()
   while true do
      local ped = PlayerPedId()
      if tonumber(stress) >= 100 then
         local ShakeIntensity = GetShakeIntensity(stress)
         local FallRepeat = math.random(2, 4)
         local RagdollTimeout = (FallRepeat * 1750)
         ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', ShakeIntensity)
         SetFlash(0, 0, 500, 3000, 500)
   
         if not IsPedRagdoll(ped) and IsPedOnFoot(ped) and not IsPedSwimming(ped) then
            SetPedToRagdollWithFall(ped, RagdollTimeout, RagdollTimeout, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
         end
   
         Wait(500)
         for i=1, FallRepeat, 1 do
            Wait(750)
            DoScreenFadeOut(200)
            Wait(1000)
            DoScreenFadeIn(200)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', ShakeIntensity)
            SetFlash(0, 0, 200, 750, 200)
         end
      end
   
      if stress >= 50 then
         local ShakeIntensity = GetShakeIntensity(stress)
         ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', ShakeIntensity)
         SetFlash(0, 0, 500, 2500, 500)
      end
      Wait(GetEffectInterval(stress))
   end
   end)
   
   
   function GetShakeIntensity(stresslevel)
      local retval = 0.05
      local Intensity = {
         ["shake"] = {
            [1] = {
               min = 50,
               max = 60,
               intensity = 0.12,
            },
            [2] = {
               min = 60,
               max = 70,
               intensity = 0.17,
            },
            [3] = {
               min = 70,
               max = 80,
               intensity = 0.22,
            },
            [4] = {
               min = 80,
               max = 90,
               intensity = 0.28,
            },
            [5] = {
               min = 90,
               max = 100,
               intensity = 0.32,
            },
         }
      }
      for k, v in pairs(Intensity['shake']) do
         if stresslevel >= v.min and stresslevel <= v.max then
            retval = v.intensity
            break
         end
      end
      return retval
   end
   
   function GetEffectInterval(stresslevel)
      local EffectInterval = {
         [1] = {
            min = 50,
            max = 60,
            timeout = math.random(14000, 15000)
         },
         [2] = {
            min = 60,
            max = 70,
            timeout = math.random(12000, 13000)
         },
         [3] = {
            min = 70,
            max = 80,
            timeout = math.random(10000, 11000)
         },
         [4] = {
            min = 80,
            max = 90,
            timeout = math.random(8000, 9000)
         },
         [5] = {
            min = 90,
            max = 100,
            timeout = math.random(6000, 7000)
         }
      }
      local retval = 10000
      for k, v in pairs(EffectInterval) do
         if stresslevel >= v.min and stresslevel <= v.max then
            retval = v.timeout
            break
         end
      end
      return retval
   end
   
   RegisterNetEvent('hud:client:UpdateStress', function(newStress) -- Add this event with adding stress elsewhere
   stress = newStress
   SendNUIMessage({
      data = 'STRESS',
      stress = math.ceil(newStress),
   })
   end)
   
   RegisterNetEvent('esx_basicneeds:onEat')
   AddEventHandler('esx_basicneeds:onEat', function()
   if Config.RemoveStress["on_eat"].enable then
      local val = math.random(Config.RemoveStress["on_eat"].min, Config.RemoveStress["on_eat"].max)
      TriggerServerEvent('hud:server:RelieveStress', val)
   end
   end)
   
   RegisterNetEvent('consumables:client:Eat')
   AddEventHandler('consumables:client:Eat', function()
   if Config.RemoveStress["on_eat"].enable then
      local val = math.random(Config.RemoveStress["on_eat"].min, Config.RemoveStress["on_eat"].max)
      TriggerServerEvent('hud:server:RelieveStress', val)
   end
   end)
   
   
   RegisterNetEvent('consumables:client:Drink')
   AddEventHandler('consumables:client:Drink', function()
   if Config.RemoveStress["on_drink"].enable then
      local val = math.random(Config.RemoveStress["on_drink"].min, Config.RemoveStress["on_drink"].max)
      TriggerServerEvent('hud:server:RelieveStress', val)
   end
   end)
   RegisterNetEvent('consumables:client:DrinkAlcohol')
   AddEventHandler('consumables:client:DrinkAlcohol', function()
   if Config.RemoveStress["on_drink"].enable then
      local val = math.random(Config.RemoveStress["on_drink"].min, Config.RemoveStress["on_drink"].max)
      TriggerServerEvent('hud:server:RelieveStress', val)
   end
   end)
   
   RegisterNetEvent('devcore_needs:client:StartEat')
   AddEventHandler('devcore_needs:client:StartEat', function()
   if Config.RemoveStress["on_eat"].enable then
      local val = math.random(Config.RemoveStress["on_eat"].min, Config.RemoveStress["on_eat"].max)
      TriggerServerEvent('hud:server:RelieveStress', val)
   end
   end)
   RegisterNetEvent('devcore_needs:client:DrinkShot')
   AddEventHandler('devcore_needs:client:DrinkShot', function()
   if Config.RemoveStress["on_drink"].enable then
      local val = math.random(Config.RemoveStress["on_drink"].min, Config.RemoveStress["on_drink"].max)
      TriggerServerEvent('hud:server:RelieveStress', val)
   end
   end)
   
   RegisterNetEvent('devcore_needs:client:StartDrink')
   AddEventHandler('devcore_needs:client:StartDrink', function()
   if Config.RemoveStress["on_drink"].enable then
      local val = math.random(Config.RemoveStress["on_drink"].min, Config.RemoveStress["on_drink"].max)
      TriggerServerEvent('hud:server:RelieveStress', val)
   end
   end)
   
   RegisterNetEvent('esx_optionalneeds:onDrink')
   AddEventHandler('esx_optionalneeds:onDrink', function()
   if Config.RemoveStress["on_drink"].enable then
      local val = math.random(Config.RemoveStress["on_drink"].min, Config.RemoveStress["on_drink"].max)
      TriggerServerEvent('hud:server:RelieveStress', val)
   end
   end)
   
   
   RegisterNetEvent('esx_basicneeds:onDrink')
   AddEventHandler('esx_basicneeds:onDrink', function()
   if Config.RemoveStress["on_drink"].enable then
      local val = math.random(Config.RemoveStress["on_drink"].min, Config.RemoveStress["on_drink"].max)
      TriggerServerEvent('hud:server:RelieveStress', val)
   end
   end)
   
   AddEventHandler('esx:onPlayerDeath', function()
   TriggerServerEvent('hud:server:RelieveStress', 10000)
   end)
   
   RegisterNetEvent('hospital:client:RespawnAtHospital')
   AddEventHandler('hospital:client:RespawnAtHospital', function()
   TriggerServerEvent('hud:server:RelieveStress', 10000)
   end)
   
--STRESS



Citizen.CreateThread(function()
   while true do
      Citizen.Wait(150)
      local microphone = NetworkIsPlayerTalking(PlayerId()) 
      SendNUIMessage({
         data = "MICROPHONE",
         variable = microphone and true or false 
      })
   end
end)


local hunger, thirst = 0, 0 

local function handleStatus()
    SendNUIMessage({data = "STATUS", hunger = math.floor(hunger), thirst = math.floor(thirst)})
end

local function updateStatus(name, value)
    if name == "hunger" then
        hunger = math.floor(value / 10000)
    elseif name == "thirst" then
        thirst = math.floor(value / 10000)
    end
    handleStatus() 
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job) 
   SendNUIMessage({ data = "JOB",  label = job }) 
end)

RegisterNetEvent('esx:setAccountMoney', function(account)
   local accountType = (account.name == 'money' and 'CASH') or (account.name == 'bank' and 'BANK')
   if accountType then 
       SendNUIMessage({ data = 'ACCOUNT', type = accountType, amount = account.money })
   end
end)

local accountTypes = { 'CRYPTO', 'CASH', 'BANK' }

RegisterNetEvent("QBCore:Player:SetPlayerData")
AddEventHandler("QBCore:Player:SetPlayerData", function(data)
    for _, accountType in ipairs(accountTypes) do
        local amount = data.money[accountType:lower()]  
        if amount then
            SendNUIMessage({ data = 'QBSET_' .. accountType, amount = amount })
        end
    end
end)


RegisterNetEvent("QBCore:Client:OnJobUpdate")
AddEventHandler("QBCore:Client:OnJobUpdate", function(data)
   SendNUIMessage({ data = "JOB",  label = data }) 
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
   PlayerData = getPlayerData()
end)

AddEventHandler('onResourceStart', function(resourceName)
   if (GetCurrentResourceName() ~= resourceName) then return end
   PlayerData = getPlayerData()
end)


function getPlayerData()
   local framework = Config.Framework
   if framework == "ESX" or framework == "NewESX" then
       return Framework.GetPlayerData()
   else
       return Framework.Functions.GetPlayerData()
   end
end


Citizen.CreateThread(function()
   -- if Config.Framework == "ESX" or Config.Framework == "NewESX" then     
         while true do
         Citizen.Wait(1)
         HideHudComponentThisFrame(6) -- VEHICLE_NAME
         HideHudComponentThisFrame(7) -- AREA_NAME
         HideHudComponentThisFrame(8) -- VEHICLE_CLASS
         HideHudComponentThisFrame(9) -- STREET_NAME
         HideHudComponentThisFrame(3) -- CASH
         HideHudComponentThisFrame(4) -- MP_CASH
         DisplayAmmoThisFrame(false)
      end
   -- end
end)

if Config.Framework == "ESX" or Config.Framework == "NewESX" then

    RegisterNetEvent("esx_status:onTick")
    AddEventHandler("esx_status:onTick", function(data)
        for _, v in pairs(data) do
            updateStatus(v.name, v.val)
        end
    end)

    RegisterNetEvent('HudPlayerLoad')
    AddEventHandler('HudPlayerLoad', function(source)
        TriggerEvent('esx_status:getStatus', 'hunger', function(status) 
            updateStatus('hunger', status.val)
        end)

        Callback('EYES', function(data) 
         SendNUIMessage({data = "PLAYER", player = data})
       end) 
      
        TriggerEvent('esx_status:getStatus', 'thirst', function(status) 
            updateStatus('thirst', status.val)
        end)
    end)





elseif Config.Framework == 'QBCore' or Config.Framework == 'OLDQBCore' then

      local PlayerData = nil -- Define PlayerData variable

      RegisterNetEvent('HudPlayerLoad')
      AddEventHandler('HudPlayerLoad', function(source)
         Callback('EYES', function(data) 
            SendNUIMessage({data = "PLAYER", player = data})
         end) 
         Citizen.Wait(4000)
             PlayerData = getPlayerData() -- Assign value to PlayerData
             local hunger = math.ceil(PlayerData.metadata["hunger"])
             local thirst = math.ceil(PlayerData.metadata["thirst"])
             SendNUIMessage({data = "STATUS", hunger = hunger, thirst = thirst})
         end)

         RegisterNetEvent('hud:client:UpdateNeeds', function(newHunger, newThirst)
            SendNUIMessage({data = "STATUS", hunger = newHunger, thirst = newThirst})
         end)
         
end


Citizen.CreateThread(function()
   local LastStreetName1, LastStreetName2 = nil, nil
   while true do
      Citizen.Wait(2000)
     local Coords = GetEntityCoords(PlayerPedId())
     local Street1, Street2 = GetStreetNameAtCoord(Coords.x, Coords.y, Coords.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
     local StreetName1 = GetLabelText(GetNameOfZone(Coords.x, Coords.y, Coords.z))
     local StreetName2 = GetStreetNameFromHashKey(Street1)
     if StreetName1 ~= LastStreetName1 or StreetName2 ~= LastStreetName2 then
       if StreetName1 ~= nil and StreetName1 ~= "" and StreetName2 ~= nil and StreetName2 ~= "" then
         SendNUIMessage({
           data = 'STREET',
           StreetName1 = StreetName1,
           StreetName2 = StreetName2,
         })
         LastStreetName1, LastStreetName2 = StreetName1, StreetName2
       end
     end
     local wait = IsPedInAnyVehicle(PlayerPedId()) and 500 or 2000
     Citizen.Wait(wait)
   end
 end)
 
local lastAmmo = nil
local lastMaxAmmo = nil
local displayAmmo = false
local currentWeaponName = ""

local weapons = {
--Melee
{ label = "Dagger", name = "dagger", hash = "0x92A27487" },
{ label = "Bat", name = "bat", hash = "0x958A4A8F" },
{ label = "Bottle", name = "bottle", hash = "0xF9E6AA4B" },
{ label = "Crowbar", name = "crowbar", hash = "0x84BD7BFD" },
{ label = "Unarmed", name = "unarmed", hash = "0xA2719263" },
{ label = "Flashlight", name = "flashlight", hash = "0x8BB05FD7" },
{ label = "Golfclub", name = "golfclub", hash = "0x440E4788" },
{ label = "Hammer", name = "hammer", hash = "0x4E875F73" },
{ label = "Hatchet", name = "hatchet", hash = "0xF9DCBF2D" },
{ label = "Knuckle", name = "knuckle", hash = "0xD8DF3C3C" },
{ label = "Knife", name = "knife", hash = "0x99B507EA" },
{ label = "Machete", name = "machete", hash = "0xDD5DF8D9" },
{ label = "Switchblade", name = "switchblade", hash = "0xDFE37640" },
{ label = "Nightstick", name = "nightstick", hash = "0x678B81B1" },
{ label = "Wrench", name = "wrench", hash = "0x19044EE0" },
{ label = "Battleaxe", name = "battleaxe", hash = "0xCD274149" },
{ label = "Poolcue", name = "poolcue", hash = "0x94117305" },
{ label = "Stone Hatchet", name = "stone_hatchet", hash = "0x3813FC08" },

-- Pistols
{ label = "Pistol", name = "pistol", hash = "0x1B06D571" },
{ label = "Pistol MK2", name = "pistol_mk2", hash = "0xBFE256D4" },
{ label = "Combat Pistol", name = "combatpistol", hash = "0x5EF9FEC4" },
{ label = "AP Pistol", name = "appistol", hash = "0x22D8FE39" },
{ label = "Stun Gun", name = "stungun", hash = "0x3656C8C1" },
{ label = "Pistol .50", name = "pistol50", hash = "0x99AEEB3B" },
{ label = "SNS Pistol", name = "snspistol", hash = "0xBFD21232" },
{ label = "SNS Pistol MK2", name = "snspistol_mk2", hash = "0x88374054" },
{ label = "Heavy Pistol", name = "heavypistol", hash = "0xD205520E" },
{ label = "Vintage Pistol", name = "vintagepistol", hash = "0x83839C4" },
{ label = "Flare Gun", name = "flaregun", hash = "0x47757124" },
{ label = "Marksman Pistol", name = "marksmanpistol", hash = "0xDC4DB296" },
{ label = "Revolver", name = "revolver", hash = "0xC1B3C3D1" },
{ label = "Revolver MK2", name = "revolver_mk2", hash = "0xCB96392F" },
{ label = "Double Action", name = "doubleaction", hash = "0x97EA20B8" },
{ label = "Ray Pistol", name = "raypistol", hash = "0xAF3696A1" },
{ label = "Ceramic Pistol", name = "ceramicpistol", hash = "0x2B5EF5EC" },
{ label = "Navy Revolver", name = "navyrevolver", hash = "0x917F6C8C" },   
{ label = "Perico Pistol", name = "gadgetpistol", hash = "0x57A4368C" },   

--SMGs   
{ label = "Micro SMG", name = "microsmg", hash = "0x13532244" },   
{ label = "SMG", name = "smg", hash = "0x2BE6766B" },
{ label = "SMG Mk II", name = "smg_mk2", hash = "0x78A97CD0" },
{ label = "Assault SMG", name = "assaultsmg", hash = "0xEFE7E2DF" },
{ label = "Combat PDW", name = "combatpdw", hash = "0x0A3D4D34" },
{ label = "Machine Pistol", name = "machinepistol", hash = "0xDB1AA450" },
{ label = "Mini SMG", name = "minismg", hash = "0xBD248B55" },
{ label = "Unholy Hellbringer", name = "raycarbine", hash = "0x476BF155" },

--Shotguns
{ label = "Pump Shotgun", name = "pumpshotgun", hash = "0x1D073A89" },
{ label = "Pump Shotgun Mk II", name = "pumpshotgun_mk2", hash = "0x555AF99A" },
{ label = "Sawed-Off Shotgun", name = "sawnoffshotgun", hash = "0x7846A318" },
{ label = "Assault Shotgun", name = "assaultshotgun", hash = "0xE284C527" },
{ label = "Bullpup Shotgun", name = "bullpupshotgun", hash = "0x9D61E50F" },
{ label = "Musket", name = "musket", hash = "0xA89CB99E" },
{ label = "Heavy Shotgun", name = "heavyshotgun", hash = "0x3AABBBAA" },
{ label = "Double Barrel Shotgun", name = "dbshotgun", hash = "0xEF951FBB" },
{ label = "Sweeper Shotgun", name = "autoshotgun", hash = "0x12E82D3D" },
{ label = "Combat Shotgun", name = "combatshotgun", hash = "0x5A96BA4" },

--Rifles   
{ label = "Assault Rifle", name = "assaultrifle", hash = "0xBFEFFF6D" },
{ label = "Assault RiflE", name = "assaultrifle_mk2", hash = "0x394F415C" },
{ label = "Carbine Rifle", name = "carbinerifle", hash = "0x83BF0278" },
{ label = "Carbine Rifle", name = "carbinerifle_mk2", hash = "0xFAD1F1C9" },
{ label = "Advanced Rifle", name = "advancedrifle", hash = "0xAF113F99" },
{ label = "Special Carbine", name = "specialcarbine", hash = "0xC0A3098D" },   
{ label = "Special Carbine Mk II", name = "specialcarbine_mk2", hash = "0x969C3D67" },
{ label = "Bullpup Rifle", name = "bullpuprifle", hash = "0x7F229F94" },
{ label = "Bullpup Rifle Mk II", name = "bullpuprifle_mk2", hash = "0x84D6FAFD" },
{ label = "Compact Rifle", name = "compactrifle", hash = "0x624FE830" },
{ label = "Military Rifle", name = "militaryrifle", hash = "0x9D1F17E6" },
{ label = "Heavy Rifle", name = "heavyrifle", hash = "0xC78D71B4" },
{ label = "Tactical Rifle", name = "tacticalrifle", hash = "0xD1D5F52B" },

--LMGs   
{ label = "MG", name = "mg", hash = "0x9D07F764" },
{ label = "Combat MG", name = "combatmg", hash = "0x7FD62962" },
{ label = "Combat MG Mk II", name = "combatmg_mk2", hash = "0xDBBD7280" },
{ label = "Gusenberg Sweeper", name = "gusenberg", hash = "0x61012683" },

--Snipers
{ label = "Sniper Rifle", name = "sniperrifle", hash = "0x05FC3C11" },
{ label = "Heavy Sniper", name = "heavysniper", hash = "0x0C472FE2" },
{ label = "Heavy Sniper Mk II", name = "heavysniper_mk2", hash = "0xA914799" },
{ label = "Marksman Rifle", name = "marksmanrifle", hash = "0xC734385A" },
{ label = "Marksman Rifle Mk II", name = "marksmanrifle_mk2", hash = "0x6A6C02E0" },
{ label = "Precision Rifle", name = "precisionrifle", hash = "0x6E7DDDEC" },

--Heavy Weapons
{ label = "RPG", name = "rpg", hash = "0xB1CA77B1" },
{ label = "Grenade Launcher", name = "grenadelauncher", hash = "0xA284510B" },
{ label = "Grenade Launcher Smoke", name = "grenadelauncher_smoke", hash = "0x4DD2DC56" },
{ label = "Minigun", name = "minigun", hash = "0x42BF8A85" },
{ label = "Firework Launcher", name = "firework", hash = "0x7F7497E5" },
{ label = "Railgun", name = "railgun", hash = "0x6D544C99" },
{ label = "Homing Launcher", name = "hominglauncher", hash = "0x63AB0442" },
{ label = "Compact Grenade Launcher", name = "compactlauncher", hash = "0x0781FE4A" },
{ label = "Widowmaker", name = "rayminigun", hash = "0xB62D1F67" },
{ label = "Compact EMP Launcher", name = "emplauncher", hash = "0xDB26713A" },

--Throwables
{ label = "Grenade", name = "grenade", hash = "0x93E220BD" },
{ label = "BZ Gas", name = "bzgas", hash = "0xA0973D5E" },
{ label = "Molotov Cocktail", name = "molotov", hash = "0x24B17070" },
{ label = "Sticky Bomb", name = "stickybomb", hash = "0x2C3731D9" },
{ label = "Proximity Mines", name = "proxmine", hash = "0xAB564B93" },
{ label = "Snowballs", name = "snowball", hash = "0x787F0BB" },
{ label = "Pipe Bombs", name = "pipebomb", hash = "0xBA45E8B8" },
{ label = "Baseball", name = "ball", hash = "0x23C9F95C" },
{ label = "Tear Gas", name = "smokegrenade", hash = "0xFDBC8A50" },
{ label = "Flare", name = "flare", hash = "0x497FACC3" },

--Miscellaneous
{ label = "Jerry Can", name = "petrolcan", hash = "0x34A67B97" },
{ label = "Parachute", name = "parachute", hash = "0xFBAB5776" },
{ label = "Fire Extinguisher", name = "fireextinguisher", hash = "0x060EC506" },
{ label = "Hazardous Jerry Can", name = "hazardcan", hash = "0xBA536372" },
{ label = "Fertilizer Can", name = "fertilizercan", hash = "0x184140A1" },
}


local function getWeaponNameFromHash(hash)
   for _, weapon in ipairs(weapons) do
      if hash == GetHashKey('weapon_' .. weapon.name) then
         return weapon.name
      end
   end
   return ""
end


Citizen.CreateThread(function()
   local lastAmmo = nil
   local lastMaxAmmo = nil
   local displayAmmo = false
   while true do
       Citizen.Wait(200)
       local playerPed = PlayerPedId()
       local _, weaponHash = GetCurrentPedWeapon(playerPed)
       local currentWeaponName = getWeaponNameFromHash(weaponHash) 
       if IsPedArmed(playerPed, 7) then
           SendNUIMessage({
               data = 'WEAPON',
               weapon = currentWeaponName,
               stats = true
           })
           local _, ammoClip = GetAmmoInClip(playerPed, weaponHash)
           local ammoTotal = GetAmmoInPedWeapon(playerPed, weaponHash)
           local ammoRemaining = ammoTotal - ammoClip
           if not displayAmmo then
               displayAmmo = true
           end
           if IsControlPressed(0, 24) or lastAmmo ~= ammoClip or lastMaxAmmo ~= ammoTotal then
               SendNUIMessage({
                   data = 'AMMO',
                   ammo = ammoClip,
                   clip = ammoRemaining
               })
               lastAmmo = ammoClip
               lastMaxAmmo = ammoTotal
               Citizen.Wait(100)
           end
       else
           SendNUIMessage({
               data = 'WEAPON',
               weapon = currentWeaponName,
               stats = false
           })
           displayAmmo = false
       end
   end
end)

-- Seatbelt

local seatbeltOn = false
local speedBuffer = {nil, nil}
local velBuffer = {nil, nil}

function Fwv(entity)
  local hr = GetEntityHeading(entity) + 90.0
  if hr < 0.0 then hr = 360.0 + hr end
  hr = hr * 0.0174533
  return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end

RegisterKeyMapping('seatbelt', 'Toggle Seatbelt', 'keyboard', Config.SeatbeltControl)

RegisterCommand('seatbelt', function()
  local playerPed = PlayerPedId()
  if IsPedInAnyVehicle(playerPed, false) then
     local class = GetVehicleClass(GetVehiclePedIsUsing(playerPed))
   if class ~= 8 and class ~= 13 and class ~= 14 then
      if seatbeltOn then
         TriggerEvent('QBCore:Notify', 'Seatbelt removed', 'success')
      else
         TriggerEvent('QBCore:Notify', 'Seatbelt buckled', 'success')
      end
      seatbeltOn = not seatbeltOn
   end
  end
end, false)

Citizen.CreateThread(function()
  while true do
     local playerPed = PlayerPedId()
     local Veh = GetVehiclePedIsIn(playerPed, false)
     local isCarHud = true 

     if isCarHud then
        if seatbeltOn then DisableControlAction(0, 75) end
        speedBuffer[2] = speedBuffer[1]
        speedBuffer[1] = GetEntitySpeed(Veh)

        velBuffer[2] = velBuffer[1]
        velBuffer[1] = GetEntityVelocity(Veh)

        if speedBuffer[2] and GetEntitySpeedVector(Veh, true).y > 1.0  and speedBuffer[1] > 15 and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * 0.255) then
           if not seatbeltOn then
              local co = GetEntityCoords(playerPed)
              local fw = Fwv(playerPed)
              SetEntityCoords(playerPed, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
              SetEntityVelocity(playerPed, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
              Wait(500)
              SetPedToRagdoll(playerPed, 1000, 1000, 0, 0, 0, 0)
              seatbeltOn = false
           end
        end
     else
        Wait(3000)
     end
     Wait(0)
  end
end)

Citizen.CreateThread(function()
   while true do
      Citizen.Wait(650)
      if IsPauseMenuActive() and not pauseActive then
         pauseActive = true
         SendNUIMessage({
            data = 'EXIT',
            args = false
         })
      end
      if not IsPauseMenuActive() and pauseActive then
         pauseActive = false
         SendNUIMessage({
            data = 'EXIT',
            args = true
         })
      end
   end
   end)

-- Seatbelt 

local LastData = {
    Speed = 0,
    Rpm = 0,
    Fuel = 0,
    Engine = false,
    Light = false,
    Seatbelt = false,
 }

 Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        if IsPedInVehicle(ped, vehicle, true) and not pauseActive then
            SendNUIMessage({ data = 'MAP', type = Config.Map})
            local LightVal, LightLights, LightHighlights = GetVehicleLightsState(vehicle)
            local Light = LightLights == 1 or LightHighlights == 1
            local Speed, Rpm, Fuel, Engine, Seatbelt, Gear = GetEntitySpeed(vehicle), GetVehicleCurrentRpm(vehicle), getFuelLevel(vehicle), GetVehicleEngineHealth(vehicle), seatbeltOn, GetVehicleCurrentGear(vehicle)
            DisplayRadar(true)
            if LastData.Speed ~= Speed or LastData.Gear ~= Gear or LastData.Rpm ~= Rpm or LastData.Fuel ~= Fuel or LastData.Engine ~= Engine or LastData.Light ~= Light or LastData.Seatbelt ~= Seatbelt then
               if Engine < 500 then 
                  Engine = false 
               else
                  Engine = true 
               end
                SendNUIMessage({
                    data = 'CAR',
                    speed = math.floor(Speed * Config.Percentage),
                    rpm = math.ceil(Rpm * 510),
                    fuel = Fuel,
                    gear = Gear,
                    engine = Engine,
                    state = Light,
                    seatbelt = Seatbelt,
                })
                LastData.Speed, LastData.Rpm, LastData.Fuel, LastData.Engine, LastData.Light, LastData.Seatbelt, LastData.Gear = Speed, Rpm, Fuel, Engine, Light, Seatbelt, Gear
            end
        else
            SendNUIMessage({data = 'CIVIL'})
            DisplayRadar(false)
            SetRadarBigmapEnabled(false, false)
            SetRadarZoom(1000)
            Citizen.Wait(500)
        end
    end
 end)

 local lastFuelUpdate = 0
function getFuelLevel(vehicle)
    local updateTick = GetGameTimer()
    if (updateTick - lastFuelUpdate) > 2000 then
        lastFuelUpdate = updateTick
        LastFuel = math.floor(Config.GetVehFuel(vehicle))
    end
    return LastFuel
end


function calculateHealth(ped)
    local healthBase = GetEntityHealth(ped) - 100
    return GetEntityModel(ped) == `mp_f_freemode_01` and (healthBase + 25) or healthBase
 end
 
function sendPlayerStats(ped)
    SendNUIMessage({ data = 'HEALTH', health = calculateHealth(ped) })
    SendNUIMessage({ data = 'ARMOR',  armor = GetPedArmour(ped) })
 end
 
 Citizen.CreateThread(function()
    while true do
       Citizen.Wait(1000)
       local ped = PlayerPedId()
       sendPlayerStats(ped)
       Citizen.Wait(2500)
    end
 end)


 Citizen.CreateThread(function()
   local wait, LastOxygen
   while true do
       local Player = PlayerId()
       local PlayerPed = GetPlayerPed(Player) 
       local newoxygen = GetPlayerSprintStaminaRemaining(Player)

       if IsPedInAnyVehicle(PlayerPed) then 
           wait = 2100
       else
           if LastOxygen ~= newoxygen then
               wait = 125
               if IsEntityInWater(PlayerPed) then 
                   oxygen = GetPlayerUnderwaterTimeRemaining(Player) * 10
               else
                   oxygen = 100 - newoxygen 
               end
               LastOxygen = newoxygen
               SendNUIMessage({
                   data = 'OXYGEN',
                   oxygen = math.ceil(oxygen),
               })
           else
               wait = 1850
           end
       end
       Citizen.Wait(wait)
   end
end)


 Citizen.CreateThread(function()
    Citizen.Wait(100)
    if Config.Map == 'rounded' then 
        local defaultAspectRatio = 1920/1080 -- Sabit oran
        local resolutionX, resolutionY = GetActiveScreenResolution()
        local aspectRatio = resolutionX/resolutionY
        local minimapOffset = 0
        
        if aspectRatio > defaultAspectRatio then
            minimapOffset = ((defaultAspectRatio-aspectRatio)/3.6)-0.008
        end
       RequestStreamedTextureDict("circlemap", false)
       while not HasStreamedTextureDictLoaded("circlemap") do
           Wait(150)
       end
       SetMinimapClipType(1)
       AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")
       AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "circlemap", "radarmasksm")
       SetMinimapComponentPosition("minimap", "L", "B", 0.00999 + minimapOffset, -0.085 - minimapOffset - 0.01, 0.15, 0.170); 
       SetMinimapComponentPosition("minimap_mask", "L", "B", 0.2125 + minimapOffset, -0.045 - minimapOffset - 0.01, 0.065, 0.20); 
       SetMinimapComponentPosition('minimap_blur', 'L', 'B', 0.024 + minimapOffset, 0.009 - minimapOffset - 0.060, 0.185, 0.290); 
       SetBlipAlpha(GetNorthRadarBlip(), 0)
       SetMinimapClipType(1)
       SetRadarBigmapEnabled(true, false)
       Wait(0)
       SetRadarBigmapEnabled(false, false)
       
    else
       local defaultAspectRatio = 1920/1080 -- Don't change this.
       local resolutionX, resolutionY = GetActiveScreenResolution()
       local aspectRatio = resolutionX/resolutionY
       local minimapOffset = 0
       if aspectRatio > defaultAspectRatio then
           minimapOffset = ((defaultAspectRatio-aspectRatio)/3.6)-0.008
       end
       RequestStreamedTextureDict("squaremap", false)
       while not HasStreamedTextureDictLoaded("squaremap") do
           Wait(150)
       end
   
       SetMinimapClipType(0)
       AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")
       AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "squaremap", "radarmasksm")
       SetMinimapComponentPosition("minimap", "L", "B", 0.0 + minimapOffset, -0.099, 0.1638, 0.183) -- Burada -0.047'den -0.027'ye artırıldı
       SetMinimapComponentPosition("minimap_mask", "L", "B", 0.0 + minimapOffset, 0.02, 0.128, 0.20) -- Burada 0.0'dan 0.02'ye artırıldı
       SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0 + minimapOffset, -0.055, 0.245, 0.300) -- Burada 0.025'ten 0.045'e artırıldı

   
       SetBlipAlpha(GetNorthRadarBlip(), 0)
       SetRadarBigmapEnabled(true, false)
       SetMinimapClipType(0)
       Wait(0)
       SetRadarBigmapEnabled(false, false)
    end
 end)

