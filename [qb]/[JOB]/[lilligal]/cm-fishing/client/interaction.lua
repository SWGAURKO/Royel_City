CreateThread(function()
    while true do
        if not Config.TextUIHandler.type then
            break
        end
        local cooldown = 1500
        local coords = GetEntityCoords(PlayerPedId())
        local near = false
        for _,v in pairs(Config.Spots) do
            local dist = #(coords - v.coords)
            if dist < Config.TextUIHandler.distance and not menuOpen then
                near = true
                cooldown = 0
                ShowHelpNotification(Config.TextUIHandler.text)
                if IsControlJustPressed(0, Config.MenuOpenKey) then
                    OpenMenu(false, v)
                end
            end
        end
        if not near then
            HideHelpNotification()
        end
        Wait(cooldown)
    end
end)

function NearSpot()
    local Player = PlayerPedId()
    local coords = GetEntityCoords(Player)
    for _,v in pairs(Config.Spots) do
       local dist = #(coords - v.coords)
       if dist < Config.TextUIHandler.distance then
          return v
       end
    end
    return false
end

local textUICache = false 

function ShowHelpNotification(text)
    if Config.TextUIHandler.type == 'default' then
        AddTextEntry('helpNotification', text)
        DisplayHelpTextThisFrame('helpNotification', false)
    end
    if not textUICache then
        if Config.TextUIHandler.type == 'esx_textui' then
            TriggerEvent('ESX:TextUI', text)
        end
        if Config.TextUIHandler.type == 'qb_default_textui' then
            TriggerEvent('qb-core:client:DrawText', text, 'left')
        end
    
        if Config.TextUIHandler.type == 'custom' then
            -- Your code here
        end
        textUICache = true
    end
end

function HideHelpNotification()
    if textUICache then
        if Config.TextUIHandler.type == 'esx_textui' then
            TriggerEvent('ESX:HideUI')
        end
        if Config.TextUIHandler.type == 'qb_default_textui' then
            TriggerEvent('qb-core:client:HideText')
        end
        if Config.TextUIHandler.type == 'custom' then
            -- Your code here
        end
        textUICache = false
    end
end