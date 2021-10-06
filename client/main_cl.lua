

-------------------------------------------------------------------------------------------
if Config.RolePlayFramework == nil or Config.RolePlayFramework ~= 'none' then    
    frameworkFunctionMappings[Config.RolePlayFramework]['runStartupStuff']()
end

-------------------------------------------------------------------------------------------
RegisterCommand('godz', function(source, args, rawcommand)
    local loc = Config.DropZone.Zones.Manifest.Location
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

--------------------
-- NUI Callbacks
--------------------
RegisterNUICallback("close", function(data, cb)
    ToggleGUI(false)
    cb('ok')
end)

