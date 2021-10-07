

-------------------------------------------------------------------------------------------
if Config.RolePlayFramework == nil or Config.RolePlayFramework ~= 'none' then    
    frameworkFunctionMappings[Config.RolePlayFramework]['runStartupStuff']()
end

-------------------------------------------------------------------------------------------
RegisterCommand('gomech', function(source, args, rawcommand)
    local loc = Config.Mechanics.Mech1.Blip.Location
    SetEntityCoords(PlayerPedId(), loc.x, loc.y, loc.z, true, true, false, false)
end)

-------------------------------------------------------------------------------------------
local isVisible = false

function ToggleGUI(mode, explicit_status)
    if explicit_status ~= nil then
        isVisible = explicit_status
    else
        isVisible = not isVisible
    end

    SetNuiFocus(isVisible, isVisible)
    SendNUIMessage({
        action = "enable",
        isVisible = isVisible,
        mode = mode
    })
end

Citizen.CreateThread(function()
    local waitTime = 0
    while true do
        Citizen.Wait(waitTime)

        if isVisible == true then
            DisableControlAction(0, 1, true) -- LookLeftRight
            DisableControlAction(0, 2, true) -- LookUpDown
            DisableControlAction(0, 142, true) -- MeleeAttackAlternate
            DisableControlAction(0, 18, true) -- Enter
            DisableControlAction(0, 322, true) -- ESC
            DisableControlAction(0, 106, true) -- VehicleMouseControlOverride

            waitTime = 0
        else
            waitTime = 50
        end
    end
end)

--------------------
-- NUI Callbacks
--------------------
RegisterNUICallback("close", function(data, cb)
    ToggleGUI(false)
    cb('ok')
end)




