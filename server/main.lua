local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- CALLBACKS

ESX.RegisterServerCallback('eske_drug:hasDrugs', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        for k,v in ipairs(ConfigServer.stoffer) do
            if xPlayer.getInventoryItem(v.drug) then
                if xPlayer.getInventoryItem(v.drug).count > 0 then
                    cb(true)
                    break
                end
            end
        end
        cb(false)
    else
        cb(false)
        -- error print
    end
end)

ESX.RegisterServerCallback('eske_drug:zoneOwner', function(source, cb, currentZone)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and currentZone ~= nil then
        local rawdata = MySQL.Sync.fetchAll('SELECT * from eske_drugzones WHERE zone = @zone', {['@zone'] = currentZone})
        local zoneOwner = rawdata[1].owner
        if zoneOwner ~= nil then
            if zoneOwner == xPlayer.getJob().name then
                cb(true)
            else
                cb(false)
            end
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

-- FUNKTIONER
function isJobAllowed(gang)
    for i=1, #ConfigServer.gangs, 1 do
        if ConfigServer.gangs[i] == gang then
            return true
        end
    end
    return false
end

-- EVENTS
RegisterNetEvent('eske_drug:sellDrug')
AddEventHandler('eske_drug:sellDrug', function(ownerStatus, zone)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    local betjenteOnline = 0
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.getJob().name == 'police' then
            betjenteOnline = betjenteOnline + 1
        end
    end

    if xPlayer ~= nil and zone ~= nil and ownerStatus ~= nil then
        local pris
        local xItem
        for k,v in pairs(ConfigServer.stoffer) do
            if xPlayer.getInventoryItem(v.drug) then
                xItem = xPlayer.getInventoryItem(v.drug)
                if xItem.count > 0 then
                    pris = v.price
                    if betjenteOnline >= ConfigServer.politiMaks then
                        pris = pris * (1 + ((ConfigServer.politiMulti/100) * ConfigServer.politiMaks))
                    elseif betjenteOnline >= ConfigServer.politiMin then
                        pris = pris * (1 + ((ConfigServer.politiMulti/100) * betjenteOnline))
                    end

                    if v.favoritzone == zone then
                        pris = pris * (1 + (ConfigServer.favoritMultiply/100))
                    end
                    break
                end
            end
        end

        if xItem.count >= 8 then
            local antalStoffer = math.random(1,8)
            local salgsPris = pris * antalStoffer
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Du har solgt ' .. antalStoffer .. ' gram ' .. xItem.name .. ' for ' .. salgsPris .. ' DKK.' , length = 10000})
            if ownerStatus then
                local bonusSalg = math.random(ConfigServer.minimalReward, ConfigServer.maksimalReward)
                salgsPris = salgsPris + bonusSalg
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Du har fået ' .. bonusSalg .. ' DKK i bonus, da du kontrollerer området.', length = 10000})
                TriggerEvent("eske_logs:createLog", "bonusZone", "Salgsbonus", "green", "[" .. xPlayer.source .. "] " .. xPlayer.getName() .. ' fik ' .. bonusSalg .. ' DKK for at kontrollere ' .. zone .. '.' , true)
            end
            xPlayer.removeInventoryItem(xItem.name, antalStoffer)
            Citizen.Wait(200)
            xPlayer.addAccountMoney('black_money', salgsPris)
            TriggerEvent("eske_logs:createLog", "salgZone", "Drug Sale", "green", "[" .. xPlayer.source .. "] " .. xPlayer.getName() .. ' solgte ' .. antalStoffer .. ' styk ' .. xItem.name .. ' for ' .. salgsPris .. ' DKK i ' .. zone .. '.', true)
        elseif xItem.count >= 5 then
            local antalStoffer = math.random(1,5)
            local salgsPris = pris * antalStoffer
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Du har solgt ' .. antalStoffer .. ' gram ' .. xItem.name .. ' for ' .. salgsPris .. ' DKK.' , length = 10000})
            if ownerStatus then
                local bonusSalg = math.random(ConfigServer.minimalReward, ConfigServer.maksimalReward)
                salgsPris = salgsPris + bonusSalg
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Du har fået ' .. bonusSalg .. ' DKK i bonus, da du kontrollerer området.', length = 10000})
                TriggerEvent("eske_logs:createLog", "bonusZone", "Salgsbonus", "green", "[" .. xPlayer.source .. "] " .. xPlayer.getName() .. ' fik ' .. bonusSalg .. ' DKK for at kontrollere ' .. zone .. '.' , true)
            end
            xPlayer.removeInventoryItem(xItem.name, antalStoffer)
            Citizen.Wait(200)
            xPlayer.addAccountMoney('black_money', salgsPris)
            TriggerEvent("eske_logs:createLog", "salgZone", "Drug Sale", "green", "[" .. xPlayer.source .. "] " .. xPlayer.getName() .. ' solgte ' .. antalStoffer .. ' styk ' .. xItem.name .. ' for ' .. salgsPris .. ' DKK i ' .. zone .. '.', true)
        elseif xItem.count >= 4 then
            local antalStoffer = math.random(1,4)
            local salgsPris = pris * antalStoffer
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Du har solgt ' .. antalStoffer .. ' gram ' .. xItem.name .. ' for ' .. salgsPris .. ' DKK.' , length = 10000})
            if ownerStatus then
                local bonusSalg = math.random(ConfigServer.minimalReward, ConfigServer.maksimalReward)
                salgsPris = salgsPris + bonusSalg
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Du har fået ' .. bonusSalg .. ' DKK i bonus, da du kontrollerer området.', length = 10000})
                TriggerEvent("eske_logs:createLog", "bonusZone", "Salgsbonus", "green", "[" .. xPlayer.source .. "] " .. xPlayer.getName() .. ' fik ' .. bonusSalg .. ' DKK for at kontrollere ' .. zone .. '.' , true)
            end
            xPlayer.removeInventoryItem(xItem.name, antalStoffer)
            Citizen.Wait(200)
            xPlayer.addAccountMoney('black_money', salgsPris)
            TriggerEvent("eske_logs:createLog", "salgZone", "Drug Sale", "green", "[" .. xPlayer.source .. "] " .. xPlayer.getName() .. ' solgte ' .. antalStoffer .. ' styk ' .. xItem.name .. ' for ' .. salgsPris .. ' DKK i ' .. zone .. '.', true)
        elseif xItem.count >= 3 then
            local antalStoffer = math.random(1,3)
            local salgsPris = pris * antalStoffer
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Du har solgt ' .. antalStoffer .. ' gram ' .. xItem.name .. ' for ' .. salgsPris .. ' DKK.' , length = 10000})
            if ownerStatus then
                local bonusSalg = math.random(ConfigServer.minimalReward, ConfigServer.maksimalReward)
                salgsPris = salgsPris + bonusSalg
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Du har fået ' .. bonusSalg .. ' DKK i bonus, da du kontrollerer området.', length = 10000})
                TriggerEvent("eske_logs:createLog", "bonusZone", "Salgsbonus", "green", "[" .. xPlayer.source .. "] " .. xPlayer.getName() .. ' fik ' .. bonusSalg .. ' DKK for at kontrollere ' .. zone .. '.' , true)
            end
            xPlayer.removeInventoryItem(xItem.name, antalStoffer)
            Citizen.Wait(200)
            xPlayer.addAccountMoney('black_money', salgsPris)
            TriggerEvent("eske_logs:createLog", "salgZone", "Drug Sale", "green", "[" .. xPlayer.source .. "] " .. xPlayer.getName() .. ' solgte ' .. antalStoffer .. ' styk ' .. xItem.name .. ' for ' .. salgsPris .. ' DKK i ' .. zone .. '.', true)
        elseif xItem.count >= 2 then
            local antalStoffer = math.random(1,3)
            local salgsPris = pris * antalStoffer
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Du har solgt ' .. antalStoffer .. ' gram ' .. xItem.name .. ' for ' .. salgsPris .. ' DKK.' , length = 10000})
            if ownerStatus then
                local bonusSalg = math.random(ConfigServer.minimalReward, ConfigServer.maksimalReward)
                salgsPris = salgsPris + bonusSalg
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Du har fået ' .. bonusSalg .. ' DKK i bonus, da du kontrollerer området.', length = 10000})
                TriggerEvent("eske_logs:createLog", "bonusZone", "Salgsbonus", "green", "[" .. xPlayer.source .. "] " .. xPlayer.getName() .. ' fik ' .. bonusSalg .. ' DKK for at kontrollere ' .. zone .. '.' , true)
            end
            xPlayer.removeInventoryItem(xItem.name, antalStoffer)
            Citizen.Wait(200)
            xPlayer.addAccountMoney('black_money', salgsPris)
            TriggerEvent("eske_logs:createLog", "salgZone", "Drug Sale", "green", "[" .. xPlayer.source .. "] " .. xPlayer.getName() .. ' solgte ' .. antalStoffer .. ' styk ' .. xItem.name .. ' for ' .. salgsPris .. ' DKK i ' .. zone .. '.', true)
        elseif xItem.count > 0 then
            local antalStoffer = 1
            local salgsPris = pris * antalStoffer
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Du har solgt ' .. antalStoffer .. ' gram ' .. xItem.name .. ' for ' .. salgsPris .. ' DKK.' , length = 10000})
            if ownerStatus then
                local bonusSalg = math.random(ConfigServer.minimalReward, ConfigServer.maksimalReward)
                salgsPris = salgsPris + bonusSalg
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Du har fået ' .. bonusSalg .. ' DKK i bonus, da du kontrollerer området.', length = 10000})
                TriggerEvent("eske_logs:createLog", "bonusZone", "Salgsbonus", "green", "[" .. xPlayer.source .. "] " .. xPlayer.getName() .. ' fik ' .. bonusSalg .. ' DKK for at kontrollere ' .. zone .. '.' , true)
            end
            xPlayer.removeInventoryItem(xItem.name, antalStoffer)
            Citizen.Wait(200)
            xPlayer.addAccountMoney('black_money', salgsPris)
            TriggerEvent("eske_logs:createLog", "salgZone", "Drug Sale", "green", "[" .. xPlayer.source .. "] " .. xPlayer.getName() .. ' solgte ' .. antalStoffer .. ' styk ' .. xItem.name .. ' for ' .. salgsPris .. ' DKK i ' .. zone .. '.', true)
        else
            -- log server
        end
    else
        print('123')
    end
end)

RegisterNetEvent('eske_drug:addGangToZone')
AddEventHandler('eske_drug:addGangToZone', function(zone)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        local rawdata = MySQL.Sync.fetchAll('SELECT * FROM eske_drugzones WHERE zone = @zone', {['@zone'] = zone})
        local rawdataJSON = json.decode(rawdata[1]['gangs'])
        local fundet = false
        for _, v in ipairs(rawdataJSON) do
            if v.bande == xPlayer.getJob().name then
                fundet = true
                break
            end
        end
        if not fundet then
            table.insert(rawdataJSON, {bande = xPlayer.getJob().name, point = ConfigServer.startPoint})
            rawdata = json.encode(rawdataJSON)
            MySQL.Async.execute('UPDATE eske_drugzones SET gangs = @data WHERE zone = @zone', {
                ['@data'] = rawdata,
                ['@zone'] = zone
            }, function(rowsChanged)
                if not rowsChanged then
                    -- error print
                    -- log
                    print('123')
                end
            end)
        end
    else
        -- error print
    end
end)

RegisterServerEvent('eske_drug:alertCops')
AddEventHandler('eske_drug:alertCops', function(coords, sex, street1, street2)
    if street2 then
        TriggerClientEvent("eske_drug:salgNotifyBetjent", -1, "Salg af stoffer af en " .. sex .. " i nærheden af" .. street1 .. " og " .. street2, coords)
    else
        TriggerClientEvent("eske_drug:salgNotifyBetjent", -1, "Salg af stoffer af en ~w~" .. sex .. " i nærheden af " .. street1, coords)
    end
end)

RegisterNetEvent('eske_drug:removePointFromGang')
AddEventHandler('eske_drug:removePointFromGang', function(zone, plyPos, street1)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and zone ~= nil then
        if isJobAllowed(xPlayer.getJob().name) then
            local rawdata = MySQL.Sync.fetchAll('SELECT * FROM eske_drugzones WHERE zone = @zone', {['@zone'] = zone})
            local rawdataJSON = json.decode(rawdata[1].gangs)
            local zoneOwner = rawdata[1].owner
            if zoneOwner ~= xPlayer.getJob().name then
                for k, v in ipairs(rawdataJSON) do
                    if zoneOwner == v.bande then
                        rawdataJSON[k]['point'] = rawdataJSON[k]['point'] - 1
                        local xPlayers = ESX.GetExtendedPlayers()
                        for _, xTarget in pairs(xPlayers) do
                            if xTarget.getJob().name == zoneOwner then
                                TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'inform', text = 'En person sælger i ' .. zone .. '.', length = 10000})
                                TriggerClientEvent("eske_drug:salgNotifyGang", xTarget.source, "Salg af stoffer af en person i nærheden af " .. street1, coords)
                            end
                        end
                        rawdata = json.encode(rawdataJSON)
                        TriggerEvent("eske_logs:createLog", "pointChange", "Point Fjernet", "lightgreen", "[" .. xPlayer.source .. "] " .. xPlayer.getName() .. ' solgte i ' .. zone .. ' og fjernede 1 point. ' .. zoneOwner .. ' har nu ' .. rawdataJSON[k]['point'] .. ' point.' , true)
                        MySQL.Sync.execute('UPDATE eske_drugzones SET gangs = @data WHERE zone = @zone', {
                            ['@data'] = rawdata,
                            ['@zone'] = zone
                        }, function(rowsChanged)
                            if not rowsChanged then
                                print('error 1')
                            end
                        end)
                    end
                end
            end
        else
            -- log to server
        end
    else
        -- error print
    end
end)

RegisterNetEvent('eske_drug:addPointToGang')
AddEventHandler('eske_drug:addPointToGang', function(zone)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and zone ~= nil then
        if isJobAllowed(xPlayer.getJob().name) then
            local rawdata = MySQL.Sync.fetchAll('SELECT * FROM eske_drugzones WHERE zone = @zone', {['@zone'] = zone})
            local rawdataJSON = json.decode(rawdata[1].gangs)
            for k, v in ipairs(rawdataJSON) do
                if v.bande == xPlayer.getJob().name then
                    if v.point < ConfigServer.maksimalPoint then
                        rawdataJSON[k]['point'] = rawdataJSON[k]['point'] + 1
                        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Du har optjent 1 point i zonen.', length = 5000})
                        rawdata = json.encode(rawdataJSON)
                        TriggerEvent("eske_logs:createLog", "pointChange", "Point Tilføjet", "blue", "[" .. xPlayer.source .. "] " .. xPlayer.getName() .. ' solgte i ' .. zone .. ' og optjente 1 point. ' .. v.bande .. ' har nu ' .. rawdataJSON[k]['point'] .. ' point.' , true)
                        MySQL.Sync.execute('UPDATE eske_drugzones SET gangs = @data WHERE zone = @zone', {
                            ['@data'] = rawdata,
                            ['@zone'] = zone
                        }, function(rowsChanged)
                            if not rowsChanged then
                                -- error print
                                -- log
                                print('error 2')
                            end
                        end)
                        break
                    else
                        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Jeres gruppering har allerede optjent det maksimale antal point i denne zone.', length = 10000})
                    end
                end
            end
        else
            -- server log
        end
    else
        -- error print
    end
end)

-- THREADS

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        local rawdata = MySQL.Sync.fetchAll('SELECT * FROM eske_drugzones')
        for i=1, #rawdata, 1 do
            local rawdataJSON = json.decode(rawdata[i]['gangs'])
            local zoneOwner = rawdata[i]['owner']
            local currentOwner = zoneOwner
            local highestP = 0
            for k, v in ipairs(rawdataJSON) do
                if v.point > highestP then
                    highestP = v.point
                    currentOwner = v.bande
                end
            end
            if zoneOwner ~= currentOwner then
                local data = json.encode(rawdataJSON)
                MySQL.Async.execute('UPDATE eske_drugzones SET owner = @data WHERE zone = @zone', {
                    ['@data'] = currentOwner,
                    ['@zone'] = rawdata[i]['zone']
                }, function(rowsChanged)
                    if not rowsChanged then
                        -- error print
                        -- log
                        print('error 3')
                    else
                        TriggerEvent("eske_logs:createLog", "zoneTakeover", "Zone Overtaget", "red", "**" .. currentOwner .. '** tog ' .. rawdata[i]['zone'] .. ' fra **' .. zoneOwner .. '**.', true)
                    end
                end)
            end
        end
    end
end)