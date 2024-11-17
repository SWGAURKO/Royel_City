RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(src)
    local identifier = GetIdentifier(src)
    local name = GetName(src)
    local data = ExecuteSql("SELECT `identifier` FROM `" ..
        Config.DatabaseName .. "` WHERE `identifier` = '" .. identifier .. "'")

    if next(data) then
        return
    else
        if identifier and src then
            ExecuteSql(string.format('INSERT INTO `%s` (`identifier`, `playername`) VALUES ("%s", "%s")',
                Config.DatabaseName, identifier, name))
            ExecuteSql(string.format('INSERT INTO `%s` (`identifier`) VALUES ("%s")', Config.DatabaseRewardName,
                identifier))
            Citizen.Wait(300)
            local data = ExecuteSql("SELECT * FROM `" .. Config.DatabaseName .. "`")
            for _, v in pairs(data) do
                fishingData[v.identifier] = v
            end
        end
    end
end)

RegisterNetEvent('QBCore:Server:OnPlayerLoaded')
AddEventHandler('QBCore:Server:OnPlayerLoaded', function()
    local src = source
    local identifier = GetIdentifier(src)
    local name = GetName(src)
    local data = ExecuteSql("SELECT `identifier` FROM `" ..
        Config.DatabaseName .. "` WHERE `identifier` = '" .. identifier .. "'")
    if next(data) then
        return
    else
        if identifier and src then
            ExecuteSql(string.format('INSERT INTO `%s` (`identifier`, `playername`) VALUES ("%s", "%s")',
                Config.DatabaseName, identifier, name))
            ExecuteSql(string.format('INSERT INTO `%s` (`identifier`) VALUES ("%s")', Config.DatabaseRewardName,
                identifier))
            Citizen.Wait(300)
            local data = ExecuteSql("SELECT * FROM `" .. Config.DatabaseName .. "`")
            for _, v in pairs(data) do
                fishingData[v.identifier] = v
            end
        end
    end
end)

RegisterServerEvent('codem-fishing:buyitem')
AddEventHandler('codem-fishing:buyitem', function(playeritems)
    if Config.Framework == 'esx' then
        local xPlayer = frameworkObject.GetPlayerFromId(source)
        if xPlayer then
            for k, v in pairs(playeritems) do
                if Config.useOxInventory then
                    if exports.ox_inventory:CanCarryItem(source, v.itemname, 1) then -- for ox inventory CanCarryItem
                        xPlayer.addInventoryItem(v.itemname, 1)
                    end
                else
                    xPlayer.addInventoryItem(v.itemname, 1)
                end
            end
        end
    else
        local xPlayer = frameworkObject.Functions.GetPlayer(source)
        if xPlayer then
            for k, v in pairs(playeritems) do
                if Config.useOxInventory then
                    if exports.ox_inventory:CanCarryItem(source, v.itemname, 1) then -- for ox inventory CanCarryItem
                        xPlayer.Functions.AddItem(v.itemname, 1)
                    end
                else
                    xPlayer.Functions.AddItem(v.itemname, 1)
                end
            end
        end
    end
end)

RegisterServerEvent('codem-fishing:AddItem')
AddEventHandler('codem-fishing:AddItem', function(item, amount)
    local src = source
    local findItemsConfig = FindItemsInConfig(item, true)
    if findItemsConfig then
        if Config.Framework == 'esx' then
            local Player = frameworkObject.GetPlayerFromId(src)
            if Player then
                if Config.useOxInventory then
                    if exports.ox_inventory:CanCarryItem(src, item, amount) then -- for ox inventory CanCarryItem
                        Player.addInventoryItem(item, amount)
                    end
                else
                    Player.addInventoryItem(item, amount)
                end
            end
        else
            local Player = frameworkObject.Functions.GetPlayer(source)
            if Player then
                if Config.useOxInventory then
                    if exports.ox_inventory:CanCarryItem(src, item, amount) then -- for ox inventory CanCarryItem
                        Player.Functions.AddItem(item, amount)
                    end
                else
                    Player.Functions.AddItem(item, amount)
                end
            end
        end
    end
end)

RegisterServerEvent('codem-fishing:sellitem')
AddEventHandler('codem-fishing:sellitem', function(playeritems, totalprice)
    if Config.Framework == 'esx' then
        local xPlayer = frameworkObject.GetPlayerFromId(source)
        if xPlayer then
            if playeritems then
                local findItemsConfig = FindItemsInConfig(playeritems, false)
                for k, v in pairs(playeritems) do
                    xPlayer.removeInventoryItem(v.itemname, v.itemcount)
                end
                if findItemsConfig then
                    xPlayer.addMoney(tonumber(totalprice))
                end
            end
        end
    else
        local xPlayer = frameworkObject.Functions.GetPlayer(source)
        if xPlayer then
            if playeritems then
                local findItemsConfig = FindItemsInConfig(playeritems, false)
                for k, v in pairs(playeritems) do
                    xPlayer.Functions.RemoveItem(v.itemname, v.itemcount)
                end
                if findItemsConfig then
                    xPlayer.Functions.AddMoney('cash', tonumber(totalprice))
                end
            end
        end
    end
end)

function FindItemsInConfig(playeritems, bool)
    local items = {}
    local found = false

    if bool then
        for _, v2 in pairs(Config.Fish) do
            if playeritems == v2.itemname and v2.sell then
                found = true
            end
        end
    else
        for k, v in pairs(playeritems) do
            for _, v2 in pairs(Config.Fish) do
                if v.itemname == v2.itemname and v2.sell then
                    found = true
                end
            end
        end
    end
    return found
end

RegisterServerEvent('codem-fishing:RemoveItem')
AddEventHandler('codem-fishing:RemoveItem', function(item, amount)
    local src = source
    if Config.Framework == 'esx' then
        if Player then
            local Player = frameworkObject.GetPlayerFromId(src)
            Player.removeInventoryItem(item, amount)
        end
    else
        local Player = frameworkObject.Functions.GetPlayer(src)
        if Player then
            Player.Functions.RemoveItem(item, amount)
        end
    end
end)

function itemcallback()
    frameworkObject = GetFrameworkObject()
    if Config.Framework == 'esx' then
        frameworkObject.RegisterServerCallback('codem-fishing:GetItems', function(source, cb)
            local xPlayer = frameworkObject.GetPlayerFromId(source)
            if xPlayer then
                local items = {}
                for _, v in pairs(xPlayer.getInventory()) do
                    local count = v.count or v.amount
                    if tonumber(count) > 0 then
                        table.insert(items, v)
                    end
                end
                cb(items)
            else
                cb(false)
            end
        end)
    else
        frameworkObject.Functions.CreateCallback('codem-fishing:GetItems', function(source, cb)
            local xPlayer = frameworkObject.Functions.GetPlayer(source)
            if xPlayer then
                local items = {}
                for _, v in pairs(xPlayer.PlayerData.items) do
                    table.insert(items, v)
                end
                cb(items)
            else
                cb(false)
            end
        end)
    end
end

Citizen.CreateThread(function()
    frameworkObject = GetFrameworkObject()
    if Config.Framework == 'esx' then
        frameworkObject.RegisterCommand('addxp', 'admin', function(source, args, showError)
            local src = source
            local xPlayer = frameworkObject.GetPlayerFromId(tonumber(args[1]))
            local xp = args[2]
            if xPlayer then
                AddXP(xPlayer.source, xp)
            else
                Config.Notification(Config.Notifications["notonline"].message, Config.Notifications["notonline"].type,
                    true, src)
            end
        end, true, {
            help = "Add xp fishing.",
            validate = true,
            arguments = {
                { name = 'id', help = "xp count", type = 'player' }
            }
        })

        frameworkObject.RegisterCommand('removexp', 'admin', function(source, args, showError)
            local src = source
            local xPlayer = frameworkObject.GetPlayerFromId(tonumber(args[1]))
            local xp = args[2]
            if xPlayer then
                RemoveXP(xPlayer.source, xp)
            else
                Config.Notification(Config.Notifications["notonline"].message, Config.Notifications["notonline"].type,
                    true, src)
            end
        end, true, {
            help = "Remove xp fishing.",
            validate = true,
            arguments = {
                { name = 'id', help = "xp count", type = 'player' }
            }
        })

        frameworkObject.RegisterCommand('setlevel', 'admin', function(source, args, showError)
            local src = source
            local xPlayer = frameworkObject.GetPlayerFromId(tonumber(args[1]))
            local level = args[2]
            if xPlayer then
                SetLevel(xPlayer.source, level)
            else
                Config.Notification(Config.Notifications["notonline"].message, Config.Notifications["notonline"].type,
                    true, src)
            end
        end, true, {
            help = "Remove xp fishing.",
            validate = true,
            arguments = {
                { name = 'id', help = "xp count", type = 'player' }
            }
        })
    else
        frameworkObject.Commands.Add('addxp', "Add xp fishing", {}, false, function(source, args)
            local src = source
            local Player = frameworkObject.Functions.GetPlayer(tonumber(args[1]))
            local xp = tonumber(args[2])
            if Player then
                AddXP(Player.PlayerData.source, xp)
            else
                Config.Notification(Config.Notifications["notonline"].message, Config.Notifications["notonline"].type,
                    true, src)
            end
        end, 'admin')
        frameworkObject.Commands.Add('removexp', "Remove xp fishing", {}, false, function(source, args)
            local src = source
            local Player = frameworkObject.Functions.GetPlayer(tonumber(args[1]))
            local xp = tonumber(args[2])
            if Player then
                RemoveXP(Player.PlayerData.source, xp)
            else
                Config.Notification(Config.Notifications["notonline"].message, Config.Notifications["notonline"].type,
                    true, src)
            end
        end, 'admin')
        frameworkObject.Commands.Add('setlevel', "Add xp fishing", {}, false, function(source, args)
            local src = source
            local Player = frameworkObject.Functions.GetPlayer(tonumber(args[1]))
            local level = tonumber(args[2])
            if Player then
                SetLevel(Player.PlayerData.source, level)
            else
                Config.Notification(Config.Notifications["notonline"].message, Config.Notifications["notonline"].type,
                    true, src)
            end
        end, 'admin')
    end
end)
