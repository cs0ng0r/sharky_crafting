Config = {}

ESX = exports["es_extended"]:getSharedObject()

Config.Locale = "hu"

Config.CraftLocs = {
    [1] = {
        coords = vector4(410.6823, -546.9344, 9.0620, 280.6938),
        propModel = "prop_tool_bench02_ld",
        recipes = {
            {
                item = "weapon_snspistol",
                model = "w_pi_sns_pistol", -- https://gtahash.ru/?c=Weapon%20models
                label = "SNS Pistol",
                description = "A low caliber pistol, perfect for concealed carry.",
                amount = 1,
                duration= 5, -- seconds
                requiredItems = {
                    { name = "iron", label = "Iron", amount = 10 },
                }
            },
        }
    },
}
