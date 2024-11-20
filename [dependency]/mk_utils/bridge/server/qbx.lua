---@diagnostic disable: duplicate-set-field
if GetResourceState('qbx_core') == 'missing' then return end

if not lib.checkDependency('qbx_core', '1.18.0') then return print('[^6MANKIND^7] [^1ERROR^7] [^5Utils^7] ^1qbx_core version 1.18.0 or higher is required.^7]') end
if not lib.checkDependency('qbx_vehicles', '1.2.0') then return print('[^6MANKIND^7] [^1ERROR^7] [^5Utils^7] ^1qbx_vehicles version 1.2.0 or higher is required.^7]') end
if GetResourceState('ox_inventory') == 'started' then
    if not lib.checkDependency('ox_inventory', '2.42.0') then return print('[^6MANKIND^7] [^1ERROR^7] [^5Utils^7] ^1ox_inventory version 2.42.0 or higher is required.^7]') end
end

QBX = exports['qb-core']:GetCoreObject()

-- Framework label used by all scripts
framework.name = 'QBOX'

-- Framework core that can be accessed by all scripts if needed
framework.core = QBX

--Show server console prints from mk scripts. Disable will only show version update available print
framework.consoleLogging = true

-- Default garage used by [mk_usedvehicles] and [mk_garage] to store a vehicle if one wasn't found
framework.defaultGarage = GetResourceState('mk_garage') ~= 'missing' and 'legion' or 'pillboxgarage'

-- Used by [mk_garage] [mk_vehiclekeys] [mk_plates] [mk_usedvehicles]
-- Framework database structure
database = {
    ownedVehicles = {
        tableName = 'player_vehicles',
        plateColumn = 'plate',
        fakePlateColumn = 'fakeplate',
        identifierColumn = 'citizenid',
        modsColumn = 'mods',
        garageColumn = 'garage',
        vehicleStoredColumn = 'state',
        vinColumn = false
    },
    players = {
        tableName = 'players',
        identifierColumn = 'citizenid'
    },
    glovebox = false,
    trunk = false
}

-- Used by [mk_plates] [mk_vehiclekeys] [mk_usedvehicles]
---@param itemName string Name of item to make useable
---@param triggerEvent string Event name to trigger when item is used
---@param args table|nil Event args to pass to the triggered event when item is used
inventory.createUseableItem = function(self, itemName, triggerEvent, args)
    exports.qbx_core:CreateUseableItem(itemName, function(source, item)
        local src = source
        local player = exports.qbx_core:GetPlayer(src)
        if player.Functions.GetItemBySlot(item.slot) then
            if player.Functions.GetItemBySlot(item.slot).name == itemName then
                TriggerClientEvent(triggerEvent, src, item, args)
            end
        end
    end)
end

-- Used by [mk_mining] [mk_plates] [mk_usedvehicles] [mk_vehiclekeys]
---@param playerSource number Player server id
---@param itemName string Item name to be removed
---@param amount number Amount to be removed
---@param metadata table|nil Metadata item should have to be removed
---@param slot number|nil Slot number to check for specific item to remove
---@param cb function Callback true if item was removed. false if not
inventory.removeItem = function(self, playerSource, itemName, amount, metadata, slot, cb)
    local src = playerSource

    if GetResourceState('ox_inventory') == 'started' then
        if slot then
            local item = exports['ox_inventory']:GetSlot(src, slot)
            if item then
                if item.name == itemName then
                    local success, response = exports['ox_inventory']:RemoveItem(src, itemName, amount, false, slot)
                    if success then
                        cb(true)
                    else
                        cb(false)
                    end
                else
                    cb(false)
                end
            else
                cb(false)
            end
        else
            local itemAmount = exports['ox_inventory']:Search(src, 'count', itemName, metadata)
            if itemAmount >= amount then
                local success, response = exports['ox_inventory']:RemoveItem(src, itemName, amount, metadata, false)
                if success then
                    cb(true)
                else
                    --debug response
                    cb(false)
                end
            else
                cb(false)
            end
        end
    else
        utils.logger:error(GetInvokingResource(), '^1Inventory resource not configured. Setup custom inventory in ^7[^5mk_utils^7]', {console = true})
        cb(false)
    end
end

-- Used by [mk_garbage] [mk_mining] [mk_plates] [mk_vehiclekeys]
---@param playerSource number Player server id
---@param itemName string Item name to be added
---@param amount number Amount to be added
---@param metadata table|nil Metadata to add onto the item
---@param cb function Callback true if item was added. false if not
inventory.addItem = function(self, playerSource, itemName, amount, metadata, cb)
    local src = playerSource

    if GetResourceState('ox_inventory') == 'started' then
        local carryAmount = exports['ox_inventory']:CanCarryAmount(src, itemName)
        if carryAmount then
            if carryAmount >= amount then 
                local success, response = exports['ox_inventory']:AddItem(src, itemName, amount, metadata, false)
                if success then
                    cb(true)
                else
                    --debug response
                    cb(false)
                end
            else
                utils:notify(src, locale('cant_carry'), 'error', 5000)
                cb(false)
            end
        else
            cb(false)
        end
    else
        utils.logger:error(GetInvokingResource(), '^1Inventory resource not configured. Setup custom inventory in ^7[^5mk_utils^7]', {console = true})
        cb(false)
    end
end

-- Used by [mk_vehiclekeys]
---@param playerSource number Player server id
---@param itemName string Name of item to check
---@param metadata table|nil Metadata item should have when checking if the player has it
---@return boolean true if player has item. false if not
inventory.hasItem = function(self, playerSource, itemName, metadata, checkContainers)
    local src = playerSource
    local hasItem = false

    if GetResourceState('ox_inventory') == 'started' then
        local item = exports['ox_inventory']:Search(src, 'count', itemName, metadata)
        if item > 0 then
            hasItem = true
        else
            if checkContainers then
                local items = exports['ox_inventory']:GetInventoryItems(playerSource)
                local containers = {}
                if items and next(items) then
                    for key, value in pairs(items) do
                        if value?.metadata?.container then
                            table.insert(containers, key)
                        end
                    end

                    if containers and next(containers) then
                        local containerItems = {}
                        for key, value in pairs(containers) do
                            local inv = exports['ox_inventory']:GetContainerFromSlot(playerSource, value)
                            if inv?.items then
                                table.insert(containerItems, inv)
                            end
                        end

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
---@param playerSource number Player server id
---@param itemName string Name of item to check
---@return table List of each slot a specific item is in the inventory
inventory.getItemSlots = function(self, playerSource, itemName)
    local src = playerSource
    local slots = {}

    if GetResourceState('ox_inventory') == 'started' then
        local inv = exports['ox_inventory']:Search(src, 'slots', itemName)
        if inv then
            slots = inv
        end
    else
        utils.logger:error(GetInvokingResource(), '^1Inventory resource not configured. Setup custom inventory in ^7[^5mk_utils^7]', {console = true})
    end

    return slots
end

-- Used by [mk_vehiclekeys]
---@param playerSource number Player server id
---@param slot number Inventory slot to get item data
---@return table|boolean Item data if exists or false
inventory.getItemBySlot = function(self, playerSource, slot)
    local src = playerSource

    if GetResourceState('ox_inventory') == 'started' then
        local item = exports['ox_inventory']:GetSlot(src, slot)
        if item then
            return item
        else
            return false
        end
    else
        utils.logger:error(GetInvokingResource(), '^1Inventory resource not configured. Setup custom inventory in ^7[^5mk_utils^7]', {console = true})
        return false
    end
end

-- Used by [mk_vehiclekeys]
---@param item table Item to locate metadata from
---@return table|boolean Item metadata or false
inventory.getMetadata = function(self, item)
    if item then
        if GetResourceState('ox_inventory') == 'started' then
            return item.metadata
        else
            utils.logger:error(GetInvokingResource(), '^1Inventory resource not configured. Setup custom inventory in ^7[^5mk_utils^7]', {console = true})
            return false
        end
    else
        return false
    end
end

-- Used by [mk_vehiclekeys]
---@param item table Item to check its metadata
---@param metadataKey string Table key of item metadata to check
---@param metadataValue string Table value of item metadata to check
---@return boolean true if metadata value exists. false if not
inventory.compareMetadata = function(self, item, metadataKey, metadataValue)
    if GetResourceState('ox_inventory') == 'started' then
        if item.metadata?[metadataKey] == metadataValue then
            return true
        else
            return false
        end
    else
        utils.logger:error(GetInvokingResource(), '^1Inventory resource not configured. Setup custom inventory in ^7[^5mk_utils^7]', {console = true})
        return false
    end
end

-- Used by [mk_vehiclekeys]
---@param playerSource number Player server id
---@param item table Item to set new metadata on
---@param slot number Inventory slot where item is located
---@param metadataKey string Metadata table key
---@param metadataValue string New metadata value for the provided metadata key
inventory.setNewMetadata = function(self, playerSource, item, slot, metadataKey, metadataValue)
    local src = playerSource

    if GetResourceState('ox_inventory') == 'started' then
        item.metadata[metadataKey] = metadataValue
        exports['ox_inventory']:SetMetadata(src, slot, item.metadata)
    else
        utils.logger:error(GetInvokingResource(), '^1Inventory resource not configured. Setup custom inventory in ^7[^5mk_utils^7]', {console = true})
    end
end

-- Used by [mk_garage] [mk_usedvehicles] [mk_vehicleshop]
---@param data { shared: true|nil (true if a shared vehicle), userData: table|nil (owners row from the players database or nil if shared vehicle), modelString: string (vehicle model name), 
---@param data      modelHash: number (vehicle model number), mods: table (vehicle mods), plate: string (vehicle plate), vin: string|nil (vehicle vin number), garage: string (garage name),
---@param data      state: number (0 - out 1 - garaged 2 - impounded), fuelLevel: number (vehicle fuel amount), engineHealth: number (vehicle engine health), bodyHealth: number (vehicle body health),
---@param data      vehicleData: table|nil (data set by mk_garage) } 
---@param cb function Callsback upson SQL query finish
database.addPlayerVehicle = function(self, data, cb)
    local insertQuery, insertData

    if database.ownedVehicles.vinColumn and data.vin then
        if data.vehicleData then
            insertQuery = 'INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, '..database.ownedVehicles.vinColumn..', garage, state, fuel, engine, body, vehicleData) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
            insertData = {
                data.shared and nil or data.userData?.license,
                data.shared and data.shared or data.userData?.citizenid,
                data.modelString,
                data.modelHash,
                json.encode(data.mods),
                data.plate,
                data.vin,
                data.garage and data.garage or framework.defaultGarage,
                data.state,
                data.fuelLevel and data.fuelLevel or 100,
                data.engineHealth and data.engineHealth or 1000,
                data.bodyHealth and data.bodyHealth or 1000,
                data.vehicleData
            }
        else
            insertQuery = 'INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, '..database.ownedVehicles.vinColumn..', garage, state, fuel, engine, body) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
            insertData = {
                data.shared and nil or data.userData?.license,
                data.shared and data.shared or data.userData?.citizenid,
                data.modelString,
                data.modelHash,
                json.encode(data.mods),
                data.plate,
                data.vin,
                data.garage and data.garage or framework.defaultGarage,
                data.state,
                data.fuelLevel and data.fuelLevel or 100,
                data.engineHealth and data.engineHealth or 1000,
                data.bodyHealth and data.bodyHealth or 1000
            }
        end
    else
        if data.vehicleData then
            insertQuery = 'INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state, fuel, engine, body, vehicleData) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
            insertData = {
                data.shared and nil or data.userData?.license,
                data.shared and data.shared or data.userData?.citizenid,
                data.modelString,
                data.modelHash,
                json.encode(data.mods),
                data.plate,
                data.garage and data.garage or framework.defaultGarage,
                data.state,
                data.fuelLevel and data.fuelLevel or 100,
                data.engineHealth and data.engineHealth or 1000,
                data.bodyHealth and data.bodyHealth or 1000,
                data.vehicleData
            }
        else
            insertQuery = 'INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state, fuel, engine, body) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
            insertData = {
                data.shared and nil or data.userData?.license,
                data.shared and data.shared or data.userData?.citizenid,
                data.modelString,
                data.modelHash,
                json.encode(data.mods),
                data.plate,
                data.garage and data.garage or framework.defaultGarage,
                data.state,
                data.fuelLevel and data.fuelLevel or 100,
                data.engineHealth and data.engineHealth or 1000,
                data.bodyHealth and data.bodyHealth or 1000
            }
        end
    end

    MySQL.insert(insertQuery, insertData, cb)
end

-- Used by [mk_usedvehicles]
---@param data { identifier: string (player identifier), plate: string (vehicle plate) }
---@param cb function Callback upson SQL query finish
database.removePlayerVehicle = function(self, data, cb)
    MySQL.query('DELETE FROM player_vehicles WHERE citizenid = :id AND '..(database.ownedVehicles.fakePlateColumn and '(plate = :plate OR '..database.ownedVehicles.fakePlateColumn..' = :plate)' or 'plate = :plate'), {id = data.identifier, plate = data.plate}, cb)
end

-- Used by [mk_usedvehicles]
---@param data { userData: table (owners row from the players database), plate: string (vehicle plate) }
---@param cb function Callback upson SQL query finish
database.updateVehicleOwner = function(self, data, cb)
    MySQL.update('UPDATE player_vehicles SET license = ?, citizenid = ? WHERE plate = ?', {data.userData.license, data.userData.citizenid, data.plate}, cb)
end

-- Used by [mk_garage]
---@param data { garageName: string (garage name), vehicleState: number (1 - stored), fuelLevel: number (vehicle fuel), engineHealth: number (vehicle engine health), bodyHealth: number (vehicle body health), mods: table (vehicle mods), plate: string (vehicle plate) }
---@param cb function Callback upson SQL query finish
database.storeVehicle = function(self, data, cb)
    MySQL.update('UPDATE player_vehicles SET garage = ?, state = ?, fuel = ?, engine = ?, body = ?, mods = ? WHERE plate = ?', {
        data.garageName,
        data.vehicleState,
        data.fuelLevel,
        data.engineHealth,
        data.bodyHealth,
        data.mods,
        data.plate
    }, cb)
end

-- Used by [mk_garage]
---@param data { garageName: string (garage name), vehicleState: number (2 - impounded), fuelLevel: number (vehicle fuel), engineHealth: number (vehicle engine health), bodyHealth: number (vehicle body health), mods: table (vehicle mods), impoundData: table (data set by mk_garage) plate: string (vehicle plate) }
---@param cb function Callback upson SQL query finish
database.impoundVehicle = function(self, data, cb)
    MySQL.update('UPDATE player_vehicles SET garage = ?, state = ?, fuel = ?, engine = ?, body = ?, mods = ?, impound = ? WHERE plate = ?', {
        data.garageName,
        data.vehicleState,
        data.fuelLevel,
        data.engineHealth,
        data.bodyHealth,
        data.mods,
        data.impoundData,
        data.plate
    }, cb)
end

-- Used by [mk_garage] [mk_vehicleshop]
---@param playerSource number Player server id
---@param playerIdentifier string Player identifier
---@return string|boolean player firstname, player lastname or false, false
framework.getPlayerName = function(self, playerSource, playerIdentifier)
    if playerIdentifier then --get name of another player
        local result = MySQL.query.await('SELECT charinfo FROM players WHERE citizenid = ?', { playerIdentifier })
        if result and result[1] then
            local charInfo = json.decode(result[1].charinfo)
            return charInfo.firstname, charInfo.lastname
        else
            return false, false
        end
    else --get own name
        local src = playerSource 
        local player = exports.qbx_core:GetPlayer(src)

        return player?.PlayerData?.charinfo?.firstname, player?.PlayerData?.charinfo?.lastname
    end
end

-- Used by [mk_garage] [mk_plates] [mk_vehicleshop]
---@param playerSource number Player server id
---@return string|boolean player job name, player job grade or false, false
framework.getJob = function(self, playerSource)
    local src = playerSource
    local player = exports.qbx_core:GetPlayer(src)
    return player?.PlayerData?.job?.name, player?.PlayerData?.job?.grade?.level
end

--- Used by [mk_garbage] [mk_plates] [mk_usedvehicles]
---@param playerIdentifier string Player identifier
---@return number Player server id
framework.getPlayerSourceByIdentifier = function(self, playerIdentifier)
    local player = exports.qbx_core:GetPlayerByCitizenId(playerIdentifier)

    return tonumber(player?.PlayerData?.source) or false
end

-- Used by [mk_garage] [mk_mining] [mk_usedvehicles] [mk_garbage] [mk_vehiclekeys] [mk_vehicleshop]
---@param playerSource number Player server id
---@param moneyType string 'cash'|'bank' Account to check
---@return number Account balance or 0
framework.checkMoney = function(self, playerSource, moneyType)
    local src = playerSource
    local player = exports.qbx_core:GetPlayer(src)

    if player?.PlayerData?.money?[moneyType] then
        return tonumber(player.PlayerData.money[moneyType])
    else
        return 0
    end
end

-- Used by [mk_garage] [mk_mining] [mk_usedvehicles] [mk_garbage] [mk_vehiclekeys] [mk_vehicleshop]
---@param playerSource number Player server id
---@param moneyType string 'cash'|'bank' Account to remove money from
---@param amount number Amount to remove
---@return boolean true if money was removed. false if not
framework.removeMoney = function(self, playerSource, moneyType, amount)
    local src = playerSource 
    local player = exports.qbx_core:GetPlayer(src)

    if player then
        if player.Functions.RemoveMoney(moneyType, tonumber(amount)) then
            return true
        else
            return false
        end
    else
        return false
    end
end

-- Used by [mk_garbage] [mk_mining] [mk_usedvehicles] [mk_vehicleshop]
---@param playerSource number Player server id
---@param moneyType string 'cash'|'bank' Account to add money to
---@param amount number Amount to add
---@return boolean true if money was added. false if not
framework.addMoney = function(self, playerSource, moneyType, amount)
    local src = playerSource
    local player = exports.qbx_core:GetPlayer(src)

    if player then
        if player.Functions.AddMoney(moneyType, amount) then
            return true
        else
            return false
        end
    else
        return false
    end
end

-- Used by [mk_usedvehicles]
---@param identifier string Player identifier
---@param moneyType string 'cash'|'bank' Account to add money to
---@param amount number Amount to add
---@return boolean true if money was added. false if not
framework.addMoneyToOfflinePlayer = function(self, identifier, moneyType, amount)
    local result = MySQL.query.await("SELECT * FROM players WHERE citizenid = ?", {identifier})
    if result and result[1] then
        local money = json.decode(result[1].money)
        if money[moneyType] then
            money[moneyType] = math.ceil(money[moneyType] + amount)
            local updateResult = MySQL.update.await("UPDATE players SET money = ? WHERE citizenid = ?", {json.encode(money), result[1].citizenid})
            if updateResult then return true else return false end
        else
            return false
        end
    else
        return false
    end
end

-- Used by [mk_garage] [mk_vehicleshop]
---@param playerSource number Player server id requesting balance
---@param societyType string 'job'|'gang' Job or gang society
---@param societyName string Job or gang name
---@return number|boolean Account balance or false
society.getBalance = function(self, playerSource, societyType, societyName)
    local query, params

    if GetResourceState('Renewed-Banking') == 'started' then
        return exports['Renewed-Banking']:getAccountMoney(societyName)
    elseif GetResourceState('okokBanking') == 'started' then
        query = 'SELECT value FROM okokbanking_societies WHERE society = ?'
        params = {
            societyName
        }
    elseif GetResourceState('qbx_management') == 'started' then
        query = 'SELECT amount FROM management_funds WHERE job_name = ? AND `type` = ?'
        params = {
            societyName,
            societyType == 'job' and 'boss' or 'gang'
        }
    else
        utils.logger:error(GetInvokingResource(), '^1Society resource not configured. Setup custom society in ^7[^5mk_utils^7]', {console = true})
        return false
    end

    local result = MySQL.query.await(query, params)

    if result and result[1] then
        if result[1].amount then
            return tonumber(result[1].amount)
        elseif result[1].account_balance then
            return tonumber(result[1].account_balance)
        elseif result[1].value then
            return tonumber(result[1].value)
        else
            return false
        end
    else
        return false
    end
end

-- Used by [mk_garage] [mk_vehicleshop]
---@param playerSource number Player server id requesting update balance
---@param deposit boolean true if depositing money. false if withdrawing
---@param societyType string 'job'|'gang' Job or gang society
---@param societyName string Job or gang name
---@param amount number Amount to add or remove from society account
---@return number|boolean New balance amount or false
society.updateBalance = function(self, playerSource, deposit, societyType, societyName, amount)
    local currentBalance, newBalance = self:getBalance(playerSource, societyType, societyName), 0
    if not currentBalance then return false end 

    amount = tonumber(amount)

    if deposit then
        newBalance = math.ceil(currentBalance + amount)
        if newBalance <= currentBalance then return false end 
    else
        newBalance = math.ceil(currentBalance - amount)
        if newBalance >= currentBalance then return false end
        if newBalance < 0 then return false end
    end

    local query, params

    if GetResourceState('Renewed-Banking') == 'started' then
        if deposit then
            if exports['Renewed-Banking']:addAccountMoney(societyName, amount) then
                return newBalance
            else
                return false
            end
        else
            if exports['Renewed-Banking']:removeAccountMoney(societyName, amount) then
                return newBalance
            else
                return false
            end
        end
    elseif GetResourceState('okokBanking') == 'started' then
        query = 'UPDATE okokbanking_societies SET value = ? WHERE society = ?'
        params = {
            newBalance,
            societyName
        }
    elseif GetResourceState('qbx_management') == 'started' then
        query = 'UPDATE management_funds SET amount = ? WHERE job_name = ? AND `type` = ?'
        params = {
            newBalance,
            societyName,
            societyType == 'job' and 'boss' or 'gang'
        }
    else
        utils.logger:error(GetInvokingResource(), '^1Society resource not configured. Setup custom society in ^7[^5mk_utils^7]', {console = true})
        return false
    end

    local result = MySQL.query.await(query, params)

    if result then
        return newBalance
    else
        return false
    end
end

--Used by [mk_vehicleshop]
---@param shopName string Vehicle shop name from [mk_vehicleshop] locations.lua
---@return table|false shopVehicles Table containing shop vehicles and shop categories
--[[ example return
    shopVehicles = {
        categories = {
            {
                name = 'compacts',
                label = 'Compacts'
            },
            {
                name = 'sports',
                label = 'Sports'
            }
        },
        compacts = {
            {
                name = 'Club',
                model = 'club',
                price = 8000
            },
            {
                name = 'Issi Classic',
                model = 'issi3',
                price = 5000
            }
        },
        sports = {
            {
                name = 'Comet Retro Custom',
                model = 'comet3',
                price = 175000
            }
        } 
    }
]]
framework.getShopVehicles = function(self, shopName, shopCategories)
    local vehicleReturn = promise.new()
    local next = next
    local shopVehicles = {}
    local vehicles = exports.qbx_core:GetVehiclesByName()

    if shopCategories and next(shopCategories) then
        for key, value in pairs(shopCategories) do
            shopCategories[key] = value:lower()
        end
    end

    local blacklistedVehicles = {}
    local config = lib.load('@qbx_smallresources.qbx_entitiesblacklist.config')
    if config?.blacklisted and next(config?.blacklisted) then
       for key, value in pairs(config.blacklisted) do
            if value then
                if not lib.table.contains(blacklistedVehicles, key) then table.insert(blacklistedVehicles, key) end
            end
       end
    end

    if vehicles and next(vehicles) then
        for _, value in pairs(vehicles) do
            if (not blacklistedVehicles or not next(blacklistedVehicles)) or (blacklistedVehicles and next(blacklistedVehicles) and not lib.table.contains(blacklistedVehicles, joaat(value.model))) then
                if (value.shop and value.shop:lower() == shopName) or (not value.shop and (value.category and shopCategories and next(shopCategories) and lib.table.contains(shopCategories, value.category:lower()))) then
                    if value.category then
                        if not shopVehicles[value.category] then
                            shopVehicles[value.category] = {}

                            if not shopVehicles.categories then shopVehicles.categories = {} end
                            table.insert(shopVehicles.categories, {name = value.category, label = value.categoryLabel and value.categoryLabel or value.category})
                        end

                        if value.name and value.model and tonumber(value.price) then
                            table.insert(shopVehicles[value.category], {
                                name = value.name,
                                model = value.model,
                                price = tonumber(value.price)
                            })
                        else
                            --missing data
                        end
                    else
                        utils.logger:info(GetInvokingResource(), 'Vehicle model ['..value.model..'] name ['..value.name..'] has no defined category.', {console = true})
                    end
                end
            else
                --this model is blacklisted by the server
            end
        end

        if shopVehicles and next(shopVehicles) then
            for key, value in pairs(shopVehicles) do
                if key ~= 'categories' then
                    table.sort(value, function(a, b) return a.name < b.name end)
                end
            end

            table.sort(shopVehicles.categories, function(a, b) return a.name < b.name end)
            vehicleReturn:resolve(shopVehicles)
        else
            vehicleReturn:resolve(false)
        end
    else
        vehicleReturn:resolve(false)
    end

    return Citizen.Await(vehicleReturn)
end

--Used by [mk_vehicleshop]
---@param playerSource number Player server id
---@param bool boolean On Duty boolean
framework.setjobDuty = function(self, playerSource, bool)
    local player = exports.qbx_core:GetPlayer(playerSource)
    if player then player.Functions.SetJobDuty(bool) end
end
