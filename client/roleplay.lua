function ShowNotification(msg)
    if Config.RolePlayFramework == nil or Config.RolePlayFramework == 'none' then
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0,1)
    else
        frameworkFunctionMappings[Config.RolePlayFramework]['showNotification'](msg)
    end
end

function CurrentJob()
    if Config.RolePlayFramework == nil or Config.RolePlayFramework == 'none' then
        -- There actually shouldn't be a job if there is no framework.
        -- This could be used for a non whitelisted mechanic to allow players to upgrade their vehicles
        return 'Mech1'
    else
        frameworkFunctionMappings[Config.RolePlayFramework]['currentJob']()
    end

end

function ExtraZoneDisplayConditionsMet(zoneName)
    local ret = true
    if zoneName == 'Service' then
        ret = ret and IsPedInAnyVehicle(PlayerPedId(), false)
    end

    -- Stack more conditions here if needed

    return ret
end