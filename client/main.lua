-- BACKEND

local ESX = nil
local salgStatus = false
local lastPeds = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

-- FUNTKIONER

function canSellToPed(ped)
	if not IsPedAPlayer(ped) and not IsPedInAnyVehicle(ped,false) and not IsEntityDead(ped) and IsPedHuman(ped) and GetEntityModel(ped) ~= GetHashKey("s_m_y_cop_01") and GetEntityModel(ped) ~= GetHashKey("s_m_y_dealer_01") and GetEntityModel(ped) ~= GetHashKey("mp_m_shopkeep_01") and ped ~= oldped then 
		return true
	end
	return false
end

function random(procent)
    if procent < 0 then
        procent = 0
    elseif procent > 100 then
        procent = 100
    end
    return procent >= math.random(1, 100)
end

-- EVENTS
RegisterNetEvent('eske_drug:salgNotifyBetjent')
AddEventHandler('eske_drug:salgNotifyBetjent', function(alert, pos)
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then
        ESX.ShowNotification(alert)
        local Blip = AddBlipForCoord(pos)
        SetBlipSprite(Blip,  10)
        SetBlipColour(Blip,  1)
        SetBlipScale(Blip, 0.6)
        SetBlipAlpha(Blip,  255)
        SetBlipAsShortRange(Blip,  false)
        Citizen.Wait(25000)
        SetBlipSprite(Blip, 2)
        SetBlipAlpha(Blip,  0)
        RemoveBlip(Blip)
    end
end)

RegisterNetEvent('eske_drug:salgNotifyGang')
AddEventHandler('eske_drug:salgNotifyGang', function(alert, pos, gang)
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == gang then
        ESX.ShowNotification(alert)
        local Blip = AddBlipForCoord(pos)
        SetBlipSprite(Blip,  10)
        SetBlipColour(Blip,  1)
        SetBlipScale(Blip, 0.6)
        SetBlipAlpha(Blip,  255)
        SetBlipAsShortRange(Blip,  false)
        Citizen.Wait(25000)
        SetBlipSprite(Blip, 2)
        SetBlipAlpha(Blip,  0)
        RemoveBlip(Blip)
    end
end)

-- THREADS

RequestAnimDict("mp_common")
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
        local player = PlayerPedId(-1)
        local playerPos = GetEntityCoords(player, 0)
		local handle, ped = FindFirstPed()
		local success
		repeat
            Citizen.Wait(100)
			success, ped = FindNextPed(handle)
			local pos = GetEntityCoords(ped)
			local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerPos.x, playerPos.y, playerPos.z, true)
			
            if distance < 2 and canSellToPed(ped) and not IsPedInAnyVehicle(player, true) and not salgStatus then
				if IsControlPressed(1,54) and not salgStatus then
                    salgStatus = true       
                    ESX.TriggerServerCallback('eske_drug:hasDrugs', function(drugResult)
                        if drugResult then
                            oldped = ped
                            TaskStandStill(ped,5000.0)
                            SetEntityAsMissionEntity(ped)
                            FreezeEntityPosition(ped,true)
                            FreezeEntityPosition(player,true)
                            SetEntityHeading(ped,GetHeadingFromVector_2d(pos.x-playerPos.x,pos.y-playerPos.y)+180)
                            SetEntityHeading(player,GetHeadingFromVector_2d(pos.x-playerPos.x,pos.y-playerPos.y))
                            local chance = math.random(1,3)
                            exports['progressBars']:startUI((ConfigClient.salgstid * 1000), "Sælger Stoffer")
                            Citizen.Wait((ConfigClient.salgstid * 1000))
                            if chance == 1 or chance == 2 then
                                local currentZone = GetNameOfZone(playerPos)
                                ESX.TriggerServerCallback('eske_drug:zoneOwner', function(zoneResult)
                                    RequestAnimDict("mp_common")
                                    while not HasAnimDictLoaded("mp_common") do
                                        Citizen.Wait(0)
                                    end
                                    SetEntityAsMissionEntity(ped)
                                    ClearPedTasks(ped)
                                    FreezeEntityPosition(ped, true)
                                    FreezeEntityPosition(player, true)
                                    TaskStandStill(player, ConfigClient.salgstid)
                                    TaskStandStill(player, ConfigClient.salgstid)
                                    TaskPlayAnim(player, 'mp_common', 'givetake1_a', 2.0, 2.0, 2000, 51, 0, false, false, false)
                                    TaskPlayAnim(ped, 'mp_common', 'givetake1_b', 2.0, 2.0, 2000, 51, 0, false, false, false)
                                    Citizen.Wait(2000)
                                    local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
                                    local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
                                    local street1 = GetStreetNameFromHashKey(s1)
                                    local street2 = GetStreetNameFromHashKey(s2)
                                    TriggerServerEvent('eske_drug:addGangToZone', currentZone)
                                    TriggerServerEvent('eske_drug:addPointToGang', currentZone)
                                    TriggerServerEvent('eske_drug:removePointFromGang', currentZone, plyPos, street1)
                                    TriggerServerEvent('eske_drug:sellDrug', zoneResult, currentZone)
                                    Citizen.Wait(500)
                                    SetPedAsNoLongerNeeded(oldped)
                                    FreezeEntityPosition(ped,false)
                                    FreezeEntityPosition(player,false)
                                    salgStatus = false
                                end, currentZone)
                            else
                                chance = math.random(1,2)
                                if chance == 2 or chance == 1 then
                                    local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
                                    local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
                                    local street1 = GetStreetNameFromHashKey(s1)
                                    local street2 = GetStreetNameFromHashKey(s2)
                                    TriggerServerEvent('eske_drug:alertCops', plyPos, 'mand', street1)
                                    ESX.ShowNotification("Dit tilbud blev ~r~afvist~s~")
                                    Citizen.Wait(500)
                                    SetPedAsNoLongerNeeded(oldped)
                                    FreezeEntityPosition(ped,false)
                                    FreezeEntityPosition(player,false)
                                    salgStatus = false
                                else
                                    ESX.ShowNotification("Dit tilbud blev ~r~afvist~s~")	
                                    Citizen.Wait(500)
                                    SetPedAsNoLongerNeeded(oldped)
                                    FreezeEntityPosition(ped,false)
                                    FreezeEntityPosition(player,false)
                                    salgStatus = false
                                end
                            end
                        else
                            salgStatus = false
                        end
                    end)
                    

                    break
                end
			end
		until not success
		EndFindPed(handle)
	end
end)