Framework = nil
-- ██████╗  ██████╗ ██╗  ██╗   ██╗    ██╗     ███████╗ █████╗ ██╗  ██╗███████╗ 
-- ██╔══██╗██╔═══██╗██║  ╚██╗ ██╔╝    ██║     ██╔════╝██╔══██╗██║ ██╔╝██╔════╝ 
-- ██████╔╝██║   ██║██║   ╚████╔╝     ██║     █████╗  ███████║█████╔╝ ███████╗ 
-- ██╔═══╝ ██║   ██║██║    ╚██╔╝      ██║     ██╔══╝  ██╔══██║██╔═██╗ ╚════██║ 
-- ██║     ╚██████╔╝███████╗██║       ███████╗███████╗██║  ██║██║  ██╗███████║ 
-- ╚═╝      ╚═════╝ ╚══════╝╚═╝       ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝ 
-- [discord.gg/gaJJjnKGpg] 
Citizen.CreateThread(function()
    if Config.Framework == "esx" then
        Framework = exports["es_extended"]:getSharedObject()
    elseif Config.Framework == "qbcore" then
        Framework = exports['qb-core']:GetCoreObject()
    else
        print("[0R SCRIPTS] FRAMEWORK NOT FOUND!")
    end
end)

Citizen.CreateThread(function()
    if Framework == nil then
        print("[0R SCRIPTS] FRAMEWORK NOT FOUND!")
        return
    end
    if Config.Framework == "esx" then

        GetPlayer = function(Id)
            return Framework.GetPlayerFromId(Id)
        end

        AddInventoryItem = function(Id, item, count)
            local xPlayer = Framework.GetPlayerFromId(Id)
            if xPlayer then
                xPlayer.addInventoryItem(item, count)
            end
        end

        RemoveInventoryItem = function(Id, item, count)
            local xPlayer = Framework.GetPlayerFromId(Id)
            if xPlayer then
                xPlayer.removeInventoryItem(item, count)
            end
        end

        GetInventoryItem = function(Id, item)
            local xPlayer = Framework.GetPlayerFromId(Id)
            if xPlayer then
                return xPlayer.getInventoryItem(item)
            end
        end

        UsableItem = Framework.RegisterUsableItem

        AddMoney = function(Id, amount)
            local xPlayer = Framework.GetPlayerFromId(Id)
            if xPlayer then
                xPlayer.addMoney(amount)
            end
        end
        
        GetMoney = function(Id, st)
            --print(type, " type is this")
            local xPlayer = Framework.GetPlayerFromId(Id)
            if xPlayer then
                if st == "card" then
                    return xPlayer.getAccount("bank").money
                else
                    return xPlayer.getMoney()
                end
            end
        end

        RemoveMoney = function(Id, amount, ts)
            local xPlayer = Framework.GetPlayerFromId(Id)
            if xPlayer then
                if ts == "card" then
                    xPlayer.removeAccountMoney("bank", amount)
                else
                    xPlayer.removeMoney(amount)
                end
            end
        end

        Notification = function(Id, message)
            local xPlayer = Framework.GetPlayerFromId(Id)
            if xPlayer then
                xPlayer.showNotification(message)
            end
        end
        
    elseif Config.Framework == "qbcore" then
        
        GetPlayer = function(Id)
            return Framework.Functions.GetPlayer(Id)
        end

        AddInventoryItem = function(Id, item, count)
            local xPlayer = Framework.Functions.GetPlayer(Id)
            if xPlayer then
                xPlayer.Functions.AddItem(item, count)
            end
        end

        RemoveInventoryItem = function(Id, item, count)
            local xPlayer = Framework.Functions.GetPlayer(Id)
            if xPlayer then
                xPlayer.Functions.RemoveItem(item, count)
            end
        end

        GetInventoryItem = function(Id, item)
            local xPlayer = Framework.Functions.GetPlayer(Id)
            if xPlayer then
                return xPlayer.Functions.GetItemByName(item)
            end
        end

        UsableItem = Framework.Functions.CreateUsableItem

        AddMoney = function(Id, amount)
            local xPlayer = Framework.Functions.GetPlayer(Id)
            if xPlayer then
                xPlayer.Functions.AddMoney("cash", amount)
            end
        end

        GetMoney = function(Id, st)
            local xPlayer = Framework.Functions.GetPlayer(Id)
            if xPlayer then
                if st == "card" then
                    return xPlayer.PlayerData.money["bank"]
                else
                    return xPlayer.PlayerData.money["cash"]
                end
            end
        end

        RemoveMoney = function(Id, amount, st)
            --print(st)
            local xPlayer = Framework.Functions.GetPlayer(Id)
            if xPlayer then
                if st == "card" then
                    xPlayer.Functions.RemoveMoney("bank", amount)
                else
                    xPlayer.Functions.RemoveMoney("cash", amount)
                end
            end
        end

        Notification = function(Id, message)
            local xPlayer = Framework.Functions.GetPlayer(Id)
            if xPlayer then
                TriggerClientEvent("QBCore:Notify", Id, message)
            end
        end

    end
end)