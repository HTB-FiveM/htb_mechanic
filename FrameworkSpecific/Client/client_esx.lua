local PlayerData = nil

function RunStartupStuffEsx(msg)
    -- NOTE: If not using legacy then comment out the '@es_extended/imports.lua' line in fxmanifest.lua
    --       Legacy provides a definition for ESX object so this should overwrite the global, but
    --       better to not let it load if not required
    if Config.UsingEsxLegacy == false then
        ESX = nil 

        Citizen.CreateThread(function() 
            while ESX == nil do 
                TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
                Citizen.Wait(1) 
            end 
        end) 
    end
end

function ShowNotificationEsx(msg)
    ESX.ShowNotification(msg)
end

function CurrentJobEsx()
    return PlayerData.job.name
end



-- On player loaded set the PlayerData
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

-- The player's job has changed so refresh the local copy of PlayerData
RegisterNetEvent('esx:playerSwitchJob')
AddEventHandler('esx:playerSwitchJob', function(oldJob, newJob)
  PlayerData = ESX.GetPlayerData()
  jobHasChanged = true
end)
