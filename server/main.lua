lib.callback.register("sharky_crafting:server:CraftItem", function(source, recipe, coords)
    if exports.ox_inventory:CanCarryItem(source, recipe.item, recipe.amount) then
        for i = 1, #recipe.requiredItems do
            exports.ox_inventory:RemoveItem(source, recipe.requiredItems[i].name, recipe.requiredItems[i].amount)
        end
        exports.ox_inventory:AddItem(source, recipe.item, recipe.amount)
        sendToDiscord(_U('successful_craft'), _U('craft_format', GetPlayerName(source),GetPlayerIdentifierByType(source, 'license'):gsub('license:', ''), recipe.item, recipe.amount, coords), 65280)
    else
        TriggerClientEvent('ox_lib:notify', source, {
            title = _U('notify_title'),
            description = _U('not_enough_space'),
            position = "top",
            type = 'error'
        })
        sendToDiscord(_U('failed_craft'), _U('craft_format', GetPlayerName(source),GetPlayerIdentifierByType(source, 'license'):gsub('license:', '') , recipe.item, recipe.amount, coords), 16711680)
    end
end)


lib.callback.register("sharky_crafting:server:StartedCraft", function(source, recipe, coords)
    sendToDiscord(_U('craft_started'), _U('craft_format', GetPlayerName(source), GetPlayerIdentifierByType(source, 'license'):gsub('license:', '') ,recipe.item, recipe.amount, coords),  16776960)
end)


lib.callback.register("sharky_crafting:server:StoppedCraft", function(source, recipe, coords)
    sendToDiscord(_U('stopped_craft'), _U('craft_format', GetPlayerName(source),GetPlayerIdentifierByType(source, 'license'):gsub('license:', '') , recipe.item, recipe.amount, coords), 16711680)
end)
