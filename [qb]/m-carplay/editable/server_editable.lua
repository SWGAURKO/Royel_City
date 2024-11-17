bot_Token = ""

Citizen.CreateThread(function()
    while Core == nil do
        Citizen.Wait(0)
    end
    Citizen.Wait(500)

    RegisterCallback('mCarplay:getNeon', function(source, cb, plate)
        local src = source
        local getNeonData
        if Config.vehicleData == 'player_vehicles' then
            getNeonData = ExecuteSql('SELECT mods FROM `player_vehicles` WHERE `plate` = @plate', {
                ['@plate'] = plate
            })
            if getNeonData and next(getNeonData) then
                local neonData = json.decode(getNeonData[1].mods)
                if neonData and neonData.neonEnabled then
                    for _, isEnabled in pairs(neonData.neonEnabled) do
                        if isEnabled then
                            cb(true)
                        end
                    end
                end
            end
        elseif Config.vehicleData == 'owned_vehicles' then
            getNeonData = ExecuteSql('SELECT vehicle FROM `owned_vehicles` WHERE `plate` = @plate', {
                ['@plate'] = plate
            })
            if getNeonData and next(getNeonData) then
                local neonData = json.decode(getNeonData[1].vehicle)
                if neonData and neonData.neonEnabled then
                    for _, isEnabled in pairs(neonData.neonEnabled) do
                        if isEnabled then
                            cb(true)
                        end
                    end
                end
            end
        end

        cb(false)
    end)
end)



Citizen.CreateThread(function()
    local resource_name = 'codem_carplay'
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
