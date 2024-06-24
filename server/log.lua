local craftWebhook ="https://discord.com/api/webhooks/1239676840155680920/B2LAXtdKkGWRKTSlQ-7zO9MRAGx5d6vwcDar5jjwmHD7rH6OZGqyTE5NezeQKxHJ01XI"                      -- Discord Webhook URL

function sendToDiscord(name, message, color)
    local connect = {
        {
            ["color"] = color,
            ["title"] = "**" .. name .. "**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = os.date("%Y-%m-%d %X") .. " | Sharky Crafting",
            },
        }
    }
    PerformHttpRequest(craftWebhook, function(err, text, headers) end, 'POST',
        json.encode({ username = "Craft System", embeds = connect, avatar_url = "" }),
        { ['Content-Type'] = 'application/json' })
end
