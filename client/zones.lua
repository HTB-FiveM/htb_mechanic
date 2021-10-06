function DrawZone(coords, type, size, colour, faceConstantly)
    local face = false
    if faceConstantly then
        face = faceConstantly
    end

    DrawMarker(
        type, 
        coords.x, coords.y, coords.z + 0.03, -- x, y, z
        0, 0, 0, -- Direction vector x, y, z
        0, 0, 0, -- Rotation x, y, z
        size.x, size.y, size.z, -- Scale
        colour.r, colour.g, colour.b, colour.a, -- Red, Green, Blue, Alpha
        false, -- Slowly bob up and down?
        face, -- Constantly face camera?
        2, -- P19. Other values don't seem to do anything
        false, -- Rotate
        nil, -- textureDict [[ string ]]
        nil, -- textureName [[ string ]]
        false -- Draw on intesecting entities?
    )

end

function CreateBlip(coords, text, scale, color, sprite)
	local blip = AddBlipForCoord(coords)
	SetBlipSprite(blip, sprite)
	SetBlipColour(blip, color)
	SetBlipScale(blip, scale)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end

function HelpPrompt(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, false, false, -1)

end

local zoneChecks = {}

Citizen.CreateThread(function()
    -- Setup proximity check structure
    for mech, _ in pairs(Config.Mechanics) do
        zoneChecks[mech] = {}
        
        for zoneName, zone in pairs(Config.Mechanics[mech].Zones) do
            zoneChecks[mech][zoneName] = {}
            zoneChecks[mech][zoneName] = {}

            zoneChecks[mech][zoneName]["inRange"] = false
            zoneChecks[mech][zoneName]["in"] = false
        end
    end

    
    local job = CurrentJob()

    -- Update the statuses per game tick
    while true do
        Citizen.Wait(0)
        if job ~= nil then
            
            if jobHasChanged == true then
                job = CurrentJob()
                jobHasChanged = false
            end

            ---
            local player = PlayerPedId()
            local playerCoords = GetEntityCoords(player)

            for zoneName,theZone in pairs(Config.Mechanics[job].Zones) do
                zoneChecks[job][zoneName]["inRange"] = #(theZone.Location - playerCoords) < 15
                zoneChecks[job][zoneName]["in"] = #(theZone.Location - playerCoords) < theZone.Marker.Size.x / 2
            end

        end
    end
end)


Citizen.CreateThread(function()
    -- Draw the Map pBlips, only needs to happen once at startup
    for mechName,mech in pairs(Config.Mechanics) do
            CreateBlip(mech.Blip.Location, mech.Name, mech.Blip.Scale, mech.Blip.Colour, mech.Blip.Sprite)
    end

    local job = CurrentJob()
    local waitTime = 500    

    while true do
        Citizen.Wait(waitTime)
        if job ~= nil then
            waitTime = 0

            if jobHasChanged == true then
                job = CurrentJob()
                jobHasChanged = false
            end

            for zoneName,zone in pairs(Config.Mechanics[job].Zones) do
                --local zone = Config.DropZone.Zones[zoneName]

                if zoneChecks[job][zoneName]["inRange"] == true then
                    DrawZone(zone.Location, zone.Marker.Type, zone.Marker.Size, zone.Marker.Colour)
                end

                if zoneChecks[job][zoneName]["in"] == true then
                    HelpPrompt(zone.ActionText)
                end

            end

        end
    end
end)


-- exports.keybinds:RegisterKeybind('Interact', 'Interaction key', 'e', function()
--     if zoneChecks["Manifest"]["in"] == true then
--         ToggleGUI('manifest', true)
--     elseif zoneChecks["GearStation"]["in"] == true then
--         ToggleGUI('gear', true)
--     elseif zoneChecks["PackingMats"]["in"] == true then
--         print("Gunna pack")
--     end


-- end)
