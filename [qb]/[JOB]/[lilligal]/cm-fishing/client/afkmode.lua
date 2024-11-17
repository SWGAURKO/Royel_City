startfish = false
startedCount = 0

function againfish()
   startedCount = 0
   local found = false
   SendNUIMessage({
      type = 'CLOSE_MENU'
   })
   currentSpot = NearSpot()
   Config.Notification(Config.Notifications["inventory"]["message"], Config.Notifications["inventory"]["type"])

   local item  = Callback("codem-fishing:GetItems")
   for k , v in pairs(item) do
      for j , l in pairs(Config.Fish) do
         if v.name == l.itemname and l.use == true  then
            startfish = true
            TriggerEvent('codem-fishing:useAfkRod',v.name)
            return
         end
      end
   end

   if not found then
      Config.Notification(Config.Notifications["fishingrod"]["message"], Config.Notifications["fishingrod"]["type"])
   end
end

local started = false
spamCount = 0

RegisterNUICallback('StartAFKFishing', function(data, cb)
   if not started  then
      spamCount = spamCount + 1
      if spamCount <= Config.SpamCount or not Config.SpamCheck then
         started = true
         local found = false
         SendNUIMessage({
            type = 'CLOSE_MENU'
         })
         currentSpot = NearSpot()
         Config.Notification(Config.Notifications["inventory"]["message"], Config.Notifications["inventory"]["type"])
         local item  = Callback("codem-fishing:GetItems")
         for k , v in pairs(item) do
            for j , l in pairs(Config.Fish) do
               if v.name == l.itemname and l.use == true  then
                  startfish = true
                  TriggerEvent('codem-fishing:useAfkRod',v.name)
                  return
               end
            end
         end

         if not found then
            Config.Notification(Config.Notifications["fishingrod"]["message"], Config.Notifications["fishingrod"]["type"])
         end
      else
         Config.Notification(Config.Notifications["spam"]["message"], Config.Notifications["spam"]["type"])
      end

      
   else
      Config.Notification(Config.Notifications["alreadystarted"]["message"], Config.Notifications["alreadystarted"]["type"])
   end
   cb("ok")
end)

Citizen.CreateThread(function()
    if Config.SpamCheck then
        while true do
            if spamCount >= 1 then
               spamCount = 0
            end
            Citizen.Wait(5000)
        end
    end
end)

RegisterNetEvent('codem-fishing:useAfkRod')
AddEventHandler('codem-fishing:useAfkRod', function(rodType)
   if startfish then
      if fishingRodHandler ~= 0 then
         TriggerEvent('codem-fishing:UseAFKBait')
      else
         fishingRodHandler = GenerateFishingRod(PlayerPedId())
         TriggerEvent('codem-fishing:UseAFKBait')
      end
   end
end)

RegisterNetEvent('codem-fishing:UseAFKBait')
AddEventHandler('codem-fishing:UseAFKBait', function()
   if currentSpot and startfish then
      local baits = false
      local usebaits
      local found = false
      local item  = Callback("codem-fishing:GetItems")
      for _, f in pairs(item) do
         for _, z in pairs(Config.Fish) do
            if f.name == z.itemname and z.baitsuse == true then
               baits = true
               usebaits = f.name
            end
         end
      end
      if baits then
         local baitData = GetBaitData(usebaits)
         for _, v in pairs(currentSpot.fishQualityScaleTable) do
            for _, d in pairs(baitData.fishQualityScale) do
               if v == d and not found then
                  currentBait = usebaits
                  Config.Notification(Config.Notifications["usedbait"]["message"], Config.Notifications["usedbait"]["type"])
                  found = true
                  TriggerServerEvent('codem-fishing:RemoveItem', usebaits, 1)
                  TriggerEvent('codem-fishing:AFKStartFishing')
               end
            end
         end
         if not found then
            Config.Notification(Config.Notifications["thisspot"]["message"], Config.Notifications["thisspot"]["type"])
         end
      else
         StopAFKFishing()
         Config.Notification(Config.Notifications["bait"]["message"], Config.Notifications["bait"]["type"])
      end
   end
end)

function StopAFKFishing()
   RemoveLoadingPrompt()
   ClearPedTasks(PlayerPedId())
   DeleteEntity(fishingRodHandler)
   SendNUIMessage({
      type = 'FISHING_STOPPED'
   })
   started = false
   fishingReady = false
   currentRod = false
   startfish = false
   currentSpot = false
   interupted = false
   currentBait = false
   fishingRodHandler = 0
   startedCount = 0
end

interupted = false
RegisterNetEvent('codem-fishing:AFKStartFishing')
AddEventHandler('codem-fishing:AFKStartFishing', function()
   if startedCount == 0 then
      SendNUIMessage({
         type = 'FISHING_STARTED',
         text =  Config.Notifications["checkspot"]["message"],
         time = 3000,
         updateProgressbar = true,
      })

      local waterValidated, castLocation = CanStartFishing()
      if waterValidated then
         if startfish  then
            if currentSpot then
               StartAFKFishing(castLocation, fishingRodHandler,currentSpot.afkCatchInMinute * 60000)
               -- StartAFKFishing(castLocation, fishingRodHandler,5000)
            end
         end
      else
         Config.Notification(Config.Notifications["notwater"]["message"], Config.Notifications["notwater"]["type"])
      end
   end
end)

function StartAFKFishing(castLocation, fishingRod,afkmin)
   if startfish and not interupted and startedCount == 0 then
      startedCount = startedCount + 1
      PlayAnimation(PlayerPedId(), "mini@tennis", "forehand_ts_md_far", {
         ["flag"] = 48
      })
      while IsEntityPlayingAnim(PlayerPedId(), "mini@tennis", "forehand_ts_md_far", 3) do
         Citizen.Wait(0)
      end
      PlayAnimation(PlayerPedId(), "amb@world_human_stand_fishing@idle_a", "idle_c", {
         ["flag"] = 11
      })
      while not IsEntityPlayingAnim(PlayerPedId(), "amb@world_human_stand_fishing@idle_a", "idle_c", 3) do
         Citizen.Wait(0)
      end
      
      SendNUIMessage({
         type = 'FISHING_STARTED',
         text = Config.Notifications["waitingfish"]["message"],
         time = afkmin,
         updateProgressbar = true,
      })
      
      local startedBaiting = GetGameTimer()

      while GetGameTimer() - startedBaiting < afkmin do
         Citizen.Wait(0)
         DrawScriptMarker({
            ["type"] = 1,
            ["size"] = vector3(2.0, 2.0, 2.0),
            ["color"] = vector3(0, 255, 150),
            ["pos"] = castLocation - vector3(0.0, 0.0, 0.985),
         })

         if not startfish then
            StopAFKFishing()
            StopFishing()
            break
         end
         
         if not IsEntityPlayingAnim(PlayerPedId(), "amb@world_human_stand_fishing@idle_a", "idle_c", 3) then
            interupted = true
            break
         end
      end

      if interupted and startfish then
         ClearPedTasks(PlayerPedId())
         StartFishing(castLocation, fishingRod,afkmin)
         return
      end

      if startfish and not interupted then
         local ped = PlayerPedId()
         local pedPos = GetEntityCoords(ped)
         local forwardVector = GetEntityForwardVector(ped)
         local forwardPos = vector3(pedPos["x"] + forwardVector["x"] * 7, pedPos["y"] + forwardVector["y"] * 7, pedPos["z"]+1.25)
         local fishHash = `a_c_fish`
         WaitForModel(fishHash)
         local fishHandle = CreatePed(1, fishHash, forwardPos, 0.0, false)
         local forwardVector = GetEntityForwardVector(ped)
         SetEntityVelocity(fishHandle, forwardVector*-25)
         SetEntityHealth(fishHandle, 0)
         local amount
         if usedBait then
            amount = math.random(1, 5)
         else
            amount = math.random(1, 2)
         end
         local currentBaitData = GetBaitData(currentBait)
         if currentBaitData then
            local spotData = NearSpot()
            local quality = {}
            for _,v in pairs(spotData.fishQualityScaleTable) do
               local baitData = GetBaitDataByQuality(v)
               for j,k in pairs(baitData) do
                  local baitDataLevel = GetBaitDataByLevel(k.baitLevel)
                  if currentBaitData.baitLevel >= k.baitLevel then
                     table.insert(quality, v)
                  end
               end
            end
            local possibleFishData = GetFishByQuality(quality)
            local fish = possibleFishData[math.random(1, #possibleFishData)]
            TriggerServerEvent('codem-fishing:AddItem', fish.itemname, math.random(1, 2))
            TriggerServerEvent('codem-fishing:AddXP', fish.xp)
            Config.Notification(Config.Notifications["youcaught"]["message"], Config.Notifications["bait"]["type"])
            Citizen.Wait(2000)
            DeleteEntity(fishHandle)
            againfish()
         end
      end
   end
end

function NearStore()
   local Player = PlayerPedId()
   local coords = GetEntityCoords(Player)
   local dist = #(coords - Config.FishingRestaurant.ped.position )
   if dist < 3.0 then
      return true
   end
end

Citizen.CreateThread(function ()
   while true do
      if IsControlJustPressed(0, Config.MenuOpenKey) then

         while not response do
            Citizen.Wait(0)
         end

         local nearStore = NearStore()

         if nearStore then
            OpenMenu(true)
         end

      end
      Citizen.Wait(0)
   end
end)

Citizen.CreateThread(function ()
   while Config.Draw.enabled do
      local Player = PlayerPedId()
      local coords = GetEntityCoords(Player)
      local dist = #(coords - Config.FishingRestaurant.ped.position)
      local sleep = 2000
      if dist < 5 then
         sleep = 0
         DrawText3D(Config.FishingRestaurant.ped.position.x,Config.FishingRestaurant.ped.position.y,Config.FishingRestaurant.ped.position.z +1.98,Config.Draw.textmarket)
      end
      Citizen.Wait(sleep)
   end
end)

RegisterNetEvent('cm-fishing:openMarket')
AddEventHandler('cm-fishing:openMarket', function()
   OpenMenu(true)
end)