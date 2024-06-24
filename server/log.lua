local craftWebhook ="https://discord.com/api/webhooks/1254878305597788181/eAuJJ9ckhLo9OJqT9s57Nk1_ZiyzmmyQkEmbjd8F4IAcGJNqMxyfg9piYeiLeXIs_9_Q"                      -- Discord Webhook URL

function sendToDiscord(name, message, color)
    local connect = {
        {
            ["color"] = color,
            ["title"] = "**" .. name .. "**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = os.date("%Y-%m-%d %X") .. " | KO Crafting",
            },
        }
    }
    PerformHttpRequest(craftWebhook, function(err, text, headers) end, 'POST',
        json.encode({ username = "Craft System", embeds = connect, avatar_url = "" }),
        { ['Content-Type'] = 'application/json' })
end
