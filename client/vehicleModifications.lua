function ShowModificationsPage()
    ToggleGUI('service', true)

    for modType = 0, 49, 1 do
        local bestMod = GetNumVehicleMods(veh, modType)
        --print('BestMod: '..modType..' - '..bestMod)
        SetVehicleMod(veh, modType, bestMod - 1, false)
    end

    SendNUIMessage({
        action = "setupForm",
        availableMods = {

        }
    })


end
