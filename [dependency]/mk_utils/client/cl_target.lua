target.debug = false --If enabled shows debug into F8 when an entity is added (framework.consoleLogging must be enabled)

-- Used by [mk_garbage] [mk_mining] [mk_vehiclekeys] [mk_mining] [mk_vehicleshop]
target.addEntity = function(self, entity, options, distance)
    local opts = {
        options = options,
        distance = distance
    }

    if GetResourceState('qb-target') == 'started' then
        exports['qb-target']:AddTargetEntity(entity, opts)

        if target.debug then utils.logger:debug(GetInvokingResource(), 'Target option added to '..(IsEntityAVehicle(entity) and 'vehicle '..GetVehicleNumberPlateText(entity) or 'entity '..entity), {console = true}) end
    elseif GetResourceState('ox_target') == 'started' then
        if NetworkGetEntityIsNetworked(entity) then
            exports.ox_target:addEntity(NetworkGetNetworkIdFromEntity(entity), ConvertQBTargetOptions(opts))
        else
            exports.ox_target:addLocalEntity(entity, ConvertQBTargetOptions(opts))
        end

        if target.debug then utils.logger:debug(GetInvokingResource(), 'Target option added to '..(IsEntityAVehicle(entity) and 'vehicle '..GetVehicleNumberPlateText(entity) or 'entity '..entity), {console = true}) end
    else
        utils.logger:error(GetInvokingResource(), locale('no_target_resource'), {console = true})
    end
end

-- Used by [mk_garbage] [mk_mining] [mk_vehiclekeys] [mk_mining] [mk_vehicleshop]
target.removeEntity = function(self, entity, label)
    if GetResourceState('qb-target') == 'started' then
        exports['qb-target']:RemoveTargetEntity(entity, label)
    elseif GetResourceState('ox_target') == 'started' then
        if NetworkGetEntityIsNetworked(entity) then
            exports.ox_target:removeEntity(NetworkGetNetworkIdFromEntity(entity), label)
        else
            exports.ox_target:removeLocalEntity(entity, label)
        end
    else
        utils.logger:error(GetInvokingResource(), locale('no_target_resource'), {console = true})
    end
end

-- Used by [mk_garbage] [mk_mining] (disables target usage while running tasks to prevent duplicate uses)
target.disable = function(self, bool)
    if GetResourceState('ox_target') == 'started' then
        exports.ox_target:disableTargeting(bool)
    elseif GetResourceState('qb-target') == 'started' then
        if bool then
            exports['qb-target']:AllowTargeting(false)
        else
            exports['qb-target']:AllowTargeting(true)
        end
    end
end

-- Used by [mk_garbage] [mk_mining] (closes target menu when a task is ran to prevent duplicate triggers. Not all targets have this option so its not required)
target.forceClose = function(self)
    if GetResourceState('qb-target') == 'started' and GetResourceState('ox_target') ~= 'started' then
        exports['qb-target']:DisableTarget(true)
    end
end

-- Used by [mk_garbage] [mk_mining] 
target.removeZone = function(self, zoneName)
    if GetResourceState('ox_target') == 'started' then
        exports.ox_target:removeZone(zoneName)
    elseif GetResourceState('qb-target') == 'started' then
        exports['qb-target']:RemoveZone(zoneName)
    end
end

-- Used by [mk_mining] to setup polyzones for Stone Washing
target.addPolyZone = function(self, zoneName, coords, minZ, maxZ, debugZone, options, distance)
    if GetResourceState('ox_target') == 'started' then
        local newPoints = table.create(#coords, 0)
        local thickness = math.abs(maxZ - minZ)

        for i = 1, #coords do
            local point = coords[i]
            newPoints[i] = vec3(point.x, point.y, maxZ - (thickness / 2))
        end

        local opts = {
            options = options,
            distance = distance
        }

        exports.ox_target:addPolyZone({
            name = zoneName,
            points = newPoints,
            thickness = thickness,
            debug = debugZone,
            options = ConvertQBTargetOptions(opts),
        })
    elseif GetResourceState('qb-target') == 'started' then
        exports['qb-target']:AddPolyZone(zoneName, coords, {
            name = zoneName,
            minZ = minZ,
            maxZ = maxZ,
            debugPoly = debugZone,
        }, {
            options = options,
            distance = distance
        })
    end
end

-- Used by [mk_garbage] to setup Job Start zone
target.addBoxZone = function(self, zoneName, center, length, width, options, targetOptions)
    if GetResourceState('ox_target') == 'started' then
        local z = center.z

        if not options.minZ then
            options.minZ = -100
        end

        if not options.maxZ then
            options.maxZ = 800
        end

        if not options.useZ then
            z = z + math.abs(options.maxZ - options.minZ) / 2
            center = vec3(center.x, center.y, z)
        end

        exports.ox_target:addBoxZone({
            name = zoneName,
            coords = center,
            size = vec3(width, length, (options.useZ or not options.maxZ) and center.z or math.abs(options.maxZ - options.minZ)),
            debug = options.debugPoly,
            rotation = options.heading,
            options = ConvertQBTargetOptions(targetOptions),
        })
    elseif GetResourceState('qb-target') == 'started' then
        exports['qb-target']:AddBoxZone(zoneName, center, length, width, options, targetOptions)
    end
end

function ConvertQBTargetOptions(options)
    local distance = options.distance
    options = options.options

    -- People may pass options as a hashmap (or mixed, even)
    for k, v in pairs(options) do
        if type(k) ~= 'number' then
            table.insert(options, v)
        end
    end

    for id, v in pairs(options) do
        if type(id) ~= 'number' then
            options[id] = nil
            goto continue
        end

        v.onSelect = v.action
        v.distance = v.distance or distance
        v.name = v.name or v.label
        v.items = v.item
        v.icon = v.icon
        v.groups = v.job

        local groupType = type(v.groups)
        if groupType == 'nil' then
            v.groups = {}
            groupType = 'table'
        end
        if groupType == 'string' then
            local val = v.gang
            if type(v.gang) == 'table' then
                if table.type(v.gang) ~= 'array' then
                    val = {}
                    for k in pairs(v.gang) do
                        val[#val + 1] = k
                    end
                end
            end

            if val then
                v.groups = {v.groups, type(val) == 'table' and table.unpack(val) or val}
            end

            val = v.citizenid
            if type(v.citizenid) == 'table' then
                if table.type(v.citizenid) ~= 'array' then
                    val = {}
                    for k in pairs(v.citizenid) do
                        val[#val+1] = k
                    end
                end
            end

            if val then
                v.groups = {v.groups, type(val) == 'table' and table.unpack(val) or val}
            end
        elseif groupType == 'table' then
            local val = {}
            if table.type(v.groups) ~= 'array' then
                for k in pairs(v.groups) do
                    val[#val + 1] = k
                end
                v.groups = val
                val = nil
            end

            val = v.gang
            if type(v.gang) == 'table' then
                if table.type(v.gang) ~= 'array' then
                    val = {}
                    for k in pairs(v.gang) do
                        val[#val + 1] = k
                    end
                end
            end

            if val then
                v.groups = {table.unpack(v.groups), type(val) == 'table' and table.unpack(val) or val}
            end

            val = v.citizenid
            if type(v.citizenid) == 'table' then
                if table.type(v.citizenid) ~= 'array' then
                    val = {}
                    for k in pairs(v.citizenid) do
                        val[#val+1] = k
                    end
                end
            end

            if val then
                v.groups = {table.unpack(v.groups), type(val) == 'table' and table.unpack(val) or val}
            end
        end

        if type(v.groups) == 'table' and table.type(v.groups) == 'empty' then
            v.groups = nil
        end

        if v.event and v.type and v.type ~= 'client' then
            if v.type == 'server' then
                v.serverEvent = v.event
            elseif v.type == 'command' then
                v.command = v.event
            end

            v.event = nil
            v.type = nil
        end

        v.action = nil
        v.job = nil
        v.gang = nil
        v.citizenid = nil
        v.item = nil
        v.qtarget = true

        ::continue::
    end

    return options
end