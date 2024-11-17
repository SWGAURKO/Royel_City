Citizen.CreateThread(function()
    if Config.UsableItem == "" or Config.UsableItem == false then
        if Config.EnableRegisterKeyMapping then
            RegisterCommand(Config.Command, function()
                OPEN_CARPLAY()
            end)
            
        RegisterKeyMapping(Config.Command, 'CarControl', 'keyboard', Config.EnableRegisterKeyMappingKey)
        else
            RegisterCommand(Config.Command, function()
                OPEN_CARPLAY()
            end)
        end
    end
end)
