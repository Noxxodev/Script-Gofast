ESX = exports["es_extended"]:getSharedObject()


RegisterServerEvent("KraKss:giveMoneyForDelivery")
AddEventHandler("KraKss:giveMoneyForDelivery", function(etat)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local randomAmount1 = math.random(Config.minMoney100, Config.maxMoney100)   
    local randomAmount2 = math.random(Config.minMoney75, Config.maxMoney75)
    local randomAmount3 = math.random(Config.minMoney50, Config.maxMoney50)
    local randomAmount4 = math.random(Config.minMoney0, Config.maxMoney0)
    local money = Config.money
    if etat == 100 then 
        xPlayer.addAccountMoney("black_money", randomAmount1)
        TriggerClientEvent('esx:showAdvancedNotification', source, money, "~g~Virement", "Vous avez reçu un virement de ~g~$" ..randomAmount1, "CHAR_BANK_FLEECA", 1)
    elseif etat >= 85 then 
        xPlayer.addAccountMoney("black_money", randomAmount2)
        TriggerClientEvent('esx:showAdvancedNotification', source, money, "~g~Virement", "Vous avez reçu un virement de ~g~$" ..randomAmount2, "CHAR_BANK_FLEECA", 1)
    elseif etat >= 60 then
        xPlayer.addAccountMoney("black_money", randomAmount3)
        TriggerClientEvent('esx:showAdvancedNotification', source, money, "~g~Virement", "Vous avez reçu un virement de ~g~$" ..randomAmount3, "CHAR_BANK_FLEECA", 1)
    elseif etat >= 0 then
        xPlayer.addAccountMoney("black_money", randomAmount4)
        TriggerClientEvent('esx:showAdvancedNotification', source, money, "~g~Virement", "Vous avez reçu un virement de ~g~$" ..randomAmount4, "CHAR_BANK_FLEECA", 1)
    end
end)

RegisterServerEvent("KraKss:sendNotifToCops")
AddEventHandler("KraKss:sendNotifToCops", function()
    local xPlayers = ESX.GetPlayers()

    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == "police" then 
            TriggerClientEvent("esx:showAdvancedNotification", xPlayers[i], "LSPD", "~r~Alerte", "Un GO-FAST à commencé soyez vigilants !", "CHAR_CALL911", 3)
        end
    end
end)
