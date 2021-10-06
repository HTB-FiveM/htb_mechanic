-- Demo code from https://www.youtube.com/watch?v=6LYL2A5UShQ


function spawnVeh(car, persistent)
    persistent = persistent or false
    local car = GetHashKey(car)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(50)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, x + 2, y + 2, z + 1, GetEntityHeading(PlayerPedId()), true, false)
    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)

    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(veh)

    if persistent then
        SetEntityAsMissionEntity(vehicle, true, true)
    end
    return vehicle
end

function ApplyVehicleMod(vehicle, modType, mod)
    if type(mod) == "boolean" then
        ToggleVehicleMod(vehicle, modType, mod)
    else
        SetVehicleMod(vehicle, modType, mod, false)
    end
end

if Config.Debug == true then
    RegisterCommand('car', function(source, args, rawcommand)
        local category = args[1]
        if category == 'spawn' then-- /car spawn <name>
            local vehicle = args[2]
            local carPaint = 158 -- Pure gold
            local veh = spawnVeh(vehicle,  true)
            SetVehicleColours(veh, carPaint, carPaint)

        elseif category == 'customise' then -- /car customise
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            SetVehicleModKit(veh, 0) -- Must  be called before modifying anything
            for modType = 0, 10, 1 do
                local bestMod = GetNumVehicleMods(veh, modType)
                --print('BestMod: '..modType..' - '..bestMod)
                SetVehicleMod(veh, modType, bestMod - 1, false)
            end

        elseif category == 'extras' then -- /car extras
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            for id = 0, 20, 1 do
                if DoesExtraExist(veh, id) then
print('Found extra ' .. id)
                    SetVehicleExtra(veh, id, 1)
                end
            end
            
        elseif category == 'repair' then -- /car extras
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            SetVehicleFixed(veh)
            SetVehicleEngineHealth(veh, 1000.0)

        elseif category == 'doors' then -- /car doors
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            local closed = GetVehicleDoorAngleRatio(veh, 0) < 0.1

            if closed then 
                for i = 0, 7, 1 do
                    SetVehicleDoorOpen(veh, i, false, false)
                end
            else
                SetVehicleDoorsShut(veh, false)
            end

        elseif category == 'upgrade' then -- /car upgrade
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            local color = colors.matte["Red"]
            local ourSelection = {
                ["Armour"] = "Armor Upgrade 100%",
                ["Engine"] = "EMS Upgrade, Level 4",
                ["Transmission"] = "Race Transmission",
                ["Suspension"] = "Competition Suspension",
                ["Horns"] = "Sadtrombone Horn",
                ["Brakes"] = "Race Brakes",
                ["Lights"] = "Xenon Lights",
                ["Turbo"] = "Turbo Tuning"
            }

            SetVehicleModKit(veh, 0)
            for k, v in pairs(ourSelection) do
                local modType = upgrades[k].type
                local mod = upgrades[k].types[v].index

                ApplyVehicleMod(veh, modType, mod)

            end

            SetVehicleColours(veh, color, color)
            ToggleVehicleMod(veh, upgrades["Lights"].type, true)
            SetVehicleXenonLightsColour(veh, upgrades["Lights"].xenonHeadlightColors["Red"].index)
        end
    end)

end