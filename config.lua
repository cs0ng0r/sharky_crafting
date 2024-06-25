Config = {}

ESX = exports["es_extended"]:getSharedObject()

Config.Target = true
Config.Locale = "hu"

Config.Locations = {
    [1] = {
        coords = vector4(259.8517, -799.5186, 55.2244, 165.9760),
        propModel = "prop_tool_bench02_ld",
        menuTitle = "Gun Crafting",
        Target = {
            title = "Craft megnyitása",
            icon = "fas fa-gun"
        },
        crafts = {
            {
                item = "weapon_snspistol",
                model = "w_pi_sns_pistol", -- https://gtahash.ru/?c=Weapon%20models
                label = "SNS Pistol",
                amount = 1,
                duration = 5, -- seconds
                requiredItems = {
                    { name = "iron", label = "Iron", amount = 10 },
                }
            },
        }
    },
    [2] = {
        coords = vector4(258.2780, -795.8275, 55.2244, 110.2932),
        propModel = "prop_tool_bench02_ld",
        menuTitle = "Weed Processing",
        Target = {
            title = "Crafting",
            icon = "fas fa-gun"
        },
        crafts = {
            {
                item = "weapon_snspistol",
                model = "w_pi_sns_pistol", -- https://gtahash.ru/?c=Weapon%20models
                label = "SNS Pistol",
                amount = 1,
                duration = 5, -- seconds
                requiredItems = {
                    { name = "iron", label = "Iron", amount = 10 },
                }
            },
        }
    },
}
