RegisterNetEvent('rambo-namechange:server:changeName', function(firstname, lastname, citizenID)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local result = MySQL.Async.fetchScalar('SELECT identifier FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    })

    if result then
        local charinfo = json.decode(result) -- Assuming the database column contains valid JSON
        charinfo.firstname = firstname
        charinfo.lastname = lastname
        local updated = json.encode(charinfo)

        MySQL.Async.execute('UPDATE users SET firstname = @firstname, lastname = @lastname WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier,
            ['@firstname'] = firstname,
            ['@lastname'] = lastname
        })

        -- Deduct a specific amount from the player's account
        local amountToDeduct = 100 -- Change this to the desired amount to deduct
        xPlayer.removeAccountMoney('bank', amountToDeduct) -- You can use 'bank' or 'money' depending on your setup

        -- Notify the player of a successful name change and the deducted amount
        TriggerClientEvent('okoknotify', src, 'Your name has been updated. ' .. amountToDeduct .. ' has been deducted from your account.', 'success', 5000)
    else
        -- Notify the player of an error using the 'okoknotify' event
        TriggerClientEvent('okoknotify', src, 'Something went wrong, please try again later.', 'error', 7500)
    end
end)
