---@diagnostic disable: duplicate-set-field
if GetResourceState('qbx_core') == 'missing' then return end

if not lib.checkDependency('qbx_core', '1.18.0') then return print('[^6MANKIND^7] [^1ERROR^7] [^5Utils^7] ^1qbx_core version 1.18.0 or higher is required.^7') end
if GetResourceState('ox_inventory') == 'started' then
    if not lib.checkDependency('ox_inventory', '2.42.0') then return print('[^6MANKIND^7] [^1ERROR^7] [^5Utils^7] ^1ox_inventory version 2.42.0 or higher is required.^7') end
end

QBX = exports['qb-core']:GetCoreObject()

-- Framework label used by all scripts
framework.name = 'QBOX'

-- Framework core that can be accessed by all scripts if needed
framework.core = QBX

--Show client console prints from mk scripts. Disable will only show nothing
framework.consoleLogging = true

-- Default garage used by [mk_usedvehicles] and [mk_garage] to store a vehicle if one wasn't found
framework.defaultGarage = GetResourceState('mk_garage') ~= 'missing' and 'legion' or 'pillboxgarage'

-- Used by all scripts
---@param data { message: string, type: string|'primary'|'success'|'error', duration: number } Notify data
function notify(data)
    if data.type == 'primary' then data.type = 'inform' end

    exports.qbx_core:Notify(data.message, data.type, data.duration)
end

-- Used by [mk_vehiclekeys]
---@param data { message: string, coords: vector3, vehicle: number, plate: string, vehicleName: string, modelHash: number, modelString: string, blipText: string } Dispatch notify data
framework.policeDispatchNotify = function(self, data)
    TriggerServerEvent('police:server:policeAlert', data.message)
end

-- Used by [mk_vehiclekeys]
---@return boolean true player is restricted from performing tasks. ex: dead or cuffed. false if not
framework.isRestricted = function(self)
    --utils.logger:debug(GetInvokingResource(), 'in last stand: '..tostring(playerState.mk_playerData?.metadata?.inlaststand)..' | is dead: '..tostring(playerState.mk_playerData?.metadata?.isdead)..' | is handcuffed: '..tostring(playerState.mk_playerData?.metadata?.ishandcuffed), {console = true})

    if playerState.mk_playerData?.metadata?.inlaststand or playerState.mk_playerData?.metadata?.isdead or playerState.mk_playerData?.metadata?.ishandcuffed then
        return true
    else
        return false
    end
end

-- Used by [mk_usedvehicles] [mk_vehiclekeys]
---@param modelNumber number Vehicle model number
---@param modelString string Vehicle model name
---@return string Vehicle name text
framework.getVehicleName = function(self, modelNumber, modelString)
    return GetLabelText(GetDisplayNameFromVehicleModel(modelNumber))
end

-- Used by [mk_usedvehicles]
---@param modelNumber number Vehicle model number
---@param modelString string Vehicle model name
---@return number Vehicle sell price
framework.getVehiclePrice = function(self, modelNumber, modelString)
    if QBX.Shared.Vehicles[modelString]?.price then
        return tonumber(QBX.Shared.Vehicles[modelString]?.price)
    else
        return 0
    end
end

-- Player Loaded event - Sets client side player data and logged in state. Sets player identifier to the client and server.
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBX.Functions.GetPlayerData(function(pData)
        playerState.mk_playerData = pData
        playerState:set('mk_identifier', pData.citizenid, true)
        Wait(100)
        playerState.mk_isLoggedIn = true
    end)
end)

-- Player Unloaded event - Clears client / server player data, logged in state and identifier
RegisterNetEvent('qbx_core:client:playerLoggedOut', function()
    playerState.mk_isLoggedIn = false
    Wait(100)
    playerState.mk_playerData = nil
    playerState:set('mk_identifier', nil, true)
end)

--- Updates client side player data
RegisterNetEvent('QBCore:Player:SetPlayerData', function(pData)
    playerState.mk_playerData = pData
end)

--- Updates mk_jobUpdate statebag. Used by [mk_garage] to recheck garage authorization when the player job is updated
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    local pData = playerState.mk_playerData
    if pData and job then
        pData.job = job
        playerState.mk_jobUpdate = pData
    end
end)

--- Updates mk_gangUpdate statebag. Used by [mk_garage] to recheck garage authorization when the player gang is updated
RegisterNetEvent('QBCore:Client:OnGangUpdate', function(gang)
    local pData = playerState.mk_playerData
    if pData and gang then
        pData.gang = gang
        playerState.mk_gangUpdate = pData
    end
end)

-- Used by [mk_garage] [mk_usedvehicles] [mk_vehiclekeys] [mk_vehicleshop]
---@return string, string|number Player job name and job grade
framework.getJob = function(self)
    return playerState.mk_playerData?.job?.name, playerState.mk_playerData?.job?.grade?.level
end

-- Used by [mk_garage]
---@return string, string|number Player gang name and gang grade
framework.getGang = function(self)
    return playerState.mk_playerData?.gang?.name, playerState.mk_playerData?.gang?.grade?.level
end

-- Used by [mk_garage]
---@return table|boolean List of player jobs and grades or false
framework.getJobs = function(self)
    return exports.qbx_core:GetJobs()
end

-- Used by [mk_garage]
---@return table|boolean #List of player gangs and grades or false
framework.getGangs = function(self)
    return exports.qbx_core:GetGangs()
end

-- Used by [mk_vehiclekeys] [mk_mining]
---@param itemName string Name of item to check
---@param metadata table|nil Metadata item should have when checking if the player has it
---@return boolean true if player has item. false if not
inventory.hasItem = function(self, itemName, metadata, checkContainers)
    local hasItem = false

    if GetResourceState('ox_inventory') == 'started' then
        local inv = exports['ox_inventory']:Search('count', itemName, metadata)
        if inv > 0 then
            hasItem = true
        else
            if checkContainers then
                local items = exports['ox_inventory']:GetPlayerItems()
                local containers = {}
                if items and next(items) then
                    for key, value in pairs(items) do
                        if value?.metadata?.container then
                            table.insert(containers, key)
                        end
                    end

                    if containers and next(containers) then
                        local containerItems = lib.callback.await('mk_utils:server:getOxInvContainerItems', false, containers)
                        if containerItems and next(containerItems) then
                            for a, b in pairs(containerItems) do
                                if b.items and next(b.items) then
                                    for key, value in pairs(b.items) do
                                        if value.name == itemName then
                                            if metadata and next(metadata) then
                                                if value.metadata and next(value.metadata) then
                                                    local metaMatch = true
                                                    for index, val in pairs(metadata) do
                                                        for i, v in pairs(value.metadata) do
                                                            if i == index then
                                                                if v ~= val then
                                                                    metaMatch = false
                                                                end
                                                            end
                                                        end
                                                    end

                                                    if metaMatch then hasItem = true break end
                                                end
                                            else
                                                hasItem = true
                                            end
                                        end
                                        if hasItem then break end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    else
        utils.logger:error(GetInvokingResource(), '^1Inventory resource not configured. Setup custom inventory in ^7[^5mk_utils^7]', {console = true})
        return false
    end

    return hasItem
end

-- Used by [mk_mining]
---@param itemName string Name of item to check 
---@return number Amount player has of specific item
inventory.getItemAmount = function(self, itemName)
    local itemAmount = 0

    if GetResourceState('ox_inventory') == 'started' then
        local inv = exports['ox_inventory']:Search('count', itemName)
        if inv > 0 then
            return inv
        else
            return 0
        end
    else
        utils.logger:error(GetInvokingResource(), '^1Inventory resource not configured. Setup custom inventory in ^7[^5mk_utils^7]', {console = true})
        return 0
    end

    return itemAmount
end
