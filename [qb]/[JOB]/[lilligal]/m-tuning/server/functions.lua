
Core = nil
CreateThread(function()
    Core, Config.Framework = GetCore()
end)

function ExecuteSQL(query, params)
    local IsBusy = true
    local result = nil
    
    if Config.Database == "oxmysql" then
        exports.oxmysql:execute(query, params, function(data)
            result = data
            IsBusy = false
        end)
    
    elseif Config.Database == "ghmattimysql" then
        exports.ghmattimysql:execute(query, params, function(data)
            result = data
            IsBusy = false
        end)
    elseif Config.Database == "mysql-async" then
        exports['mysql-async']:mysql_fetch_all(query, params, function(data)
            result = data
            IsBusy = false
        end)
    end
    
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end

Citizen.CreateThread(function ()
    while not Core do
        Citizen.Wait(0)
    end
    if Config.Framework == "ESX" then
        Core.RegisterUsableItem(Config.TabletItemName, function(source)
            TriggerClientEvent("m-tuning:tabletCheck", source, true)
        end)
        Core.RegisterUsableItem(Config.CheckerItemName, function(source)
            TriggerClientEvent("m-tuning:tunerCheckerCheck", source, true)
        end)
    else 
        Core.Functions.CreateUseableItem(Config.TabletItemName, function(source)
            TriggerClientEvent("m-tuning:tabletCheck", source, true)
        end)
        Core.Functions.CreateUseableItem(Config.CheckerItemName, function(source)
            TriggerClientEvent("m-tuning:tunerCheckerCheck", source, true)
        end)
    end
end)

Citizen.CreateThread(function ()
    while not Core do
        Citizen.Wait(0)
    end
    if Config.AdvancedAuthorize then
        RegisterServerEvent('m-tuning:CheckPermission')
        AddEventHandler('m-tuning:CheckPermission', function()
            local src = source
            local authorizedGroups = Config.AdvancedAuthorizedGroup
                
            local permissions = {} 
            
            for _, group in pairs(authorizedGroups) do
                local hasPerm = false
                
                if Config.Framework == "ESX" then 
                    local xPlayer = Core.GetPlayerFromId(src)
                    local playerGroup = xPlayer.getGroup()
                    hasPerm = (playerGroup == group)
                else
                    hasPerm = Core.Functions.HasPermission(src, group)
                end
                
                permissions[group] = hasPerm 
            end
        
            TriggerClientEvent("m-tuning:SendPermission", src, permissions)
        end)
    end
end)


Citizen.CreateThread(function()
    local resource_name = 'codem_tuning'
    local current_version = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
    PerformHttpRequest('https://raw.githubusercontent.com/Aiakos232/versionchecker/main/version.json',
        function(error, result, headers)
            if not result then
                print('^1Version check disabled because github is down.^0')
                return
            end
            local result = json.decode(result)
            if tonumber(result[resource_name]) ~= nil then
                if tonumber(result[resource_name]) > tonumber(current_version) then
                    print('\n')
                    print('^1======================================================================^0')
                    print('^1' .. resource_name ..
                        ' is outdated, new version is available: ' .. result[resource_name] .. '^0')
                    print('^1======================================================================^0')
                    print('\n')
                elseif tonumber(result[resource_name]) == tonumber(current_version) then
                    print('^2' .. resource_name .. ' is up to date! -  ^4 Thanks for choose CodeM ^4 ^0')
                elseif tonumber(result[resource_name]) < tonumber(current_version) then
                    print('^3' .. resource_name .. ' is a higher version than the official version!^0')
                end
            else
                print('^1' .. resource_name .. ' is not in the version database^0')
            end
        end, 'GET')
end)