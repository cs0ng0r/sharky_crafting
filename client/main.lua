local props, isCrafting = {}, false

CreateThread(function()
    for k, v in pairs(Config.Locations) do
        lib.requestModel(v.propModel, 10000)
        local craftTable = CreateObject(v.propModel, v.coords.x, v.coords.y, v.coords.z, false, false, false)
        props[props] = props

        Wait(2000)
        PlaceObjectOnGroundProperly(craftTable)
        PlaceObjectOnGroundProperly_2(craftTable)
        SetEntityAsMissionEntity(craftTable, true, true)
        FreezeEntityPosition(craftTable, true)

        local CraftPoint = lib.points.new({
            coords = v.coords.xyz,
            distance = 5
        })


        if Config.Target then
            exports.ox_target:addSphereZone({
                coords = v.coords.xyz,
                size = vec3(2, 2, 2),
                rotation = 45,
                debug = false,
                options = {
                    {
                        name = "target",
                        icon = v.Target.icon,
                        label = v.Target.title,
                        onSelect = function()
                            OpenCraft(k)
                        end
                    }
                }
            })
        else
            function CraftPoint:nearby()
                if self.currentDistance < 2 and not isCrafting then
                    ESX.ShowHelpNotification(_U('open_craft'))
                    if IsControlJustReleased(0, 38) then
                        OpenCraft(k)
                    end
                end
            end
        end
    end
end)

function hasRequiredItems(inventory, requiredItems)
    for _, requiredItem in ipairs(requiredItems) do
        local found = false
        for _, item in ipairs(inventory) do
            if item.name == requiredItem.name and item.amount >= requiredItem.amount then
                found = true
                break
            end
        end
        if not found then
            return false
        end
    end
    return true
end

function OpenCraft(craftLocId)
    local CraftOptions = {}
    for k, v in pairs(Config.Locations[craftLocId].crafts) do
        local PlayerItems = {}
        local CraftMetadata = {
            {
                label = _U('ingredients'),
                value = ""
            }
        }
        for i = 1, #v.requiredItems do
            PlayerItems[#PlayerItems + 1] = {
                name = v.requiredItems[i].name,
                amount = exports.ox_inventory:GetItemCount(v.requiredItems[i].name)
            }
            local itemamounttext

            if exports.ox_inventory:GetItemCount(v.requiredItems[i].name) < v.requiredItems[i].amount then
                itemamounttext = exports.ox_inventory:GetItemCount(v.requiredItems[i].name) ..
                    "/" .. v.requiredItems[i].amount .. " *"
            else
                itemamounttext = exports.ox_inventory:GetItemCount(v.requiredItems[i].name) ..
                    "/" .. v.requiredItems[i].amount .. ""
            end
            CraftMetadata[#CraftMetadata + 1] = {
                label = " - " .. v.requiredItems[i].label,
                value = itemamounttext
            }
        end

        CraftOptions[#CraftOptions + 1] = {
            title = v.label,
            description = v.description,
            metadata = CraftMetadata,
            image = "nui://ox_inventory/web/images/" .. v.item .. ".png",
            onSelect = function()
                if hasRequiredItems(PlayerItems, v.requiredItems) then
                    OpenAdvancedOptions(k, craftLocId)
                else
                    lib.notify({
                        title = _U('notify_title'),
                        description = _U('not_enough_items'),
                        position = 'top',
                        type = 'error'
                    })
                end
            end
        }
    end


    lib.registerContext({
        id = 'CraftMenu',
        title = Config.Locations[craftLocId].menuTitle,
        options = CraftOptions
    })
    lib.showContext('CraftMenu')
end

function OpenAdvancedOptions(recipe, craftLocId)
    lib.registerContext({
        id = 'AdvancedOptions',
        title = Config.Locations[craftLocId].crafts[recipe].label,
        menu = 'CraftMenu',
        options = {
            {
                title = _U('craft_item', Config.Locations[craftLocId].crafts[recipe].label)
            },
            {
                title = _U('yes'),
                onSelect = function()
                    StartItemCraft(recipe, craftLocId)
                end
            },
            {
                title = _U('no'),
                menu = "CraftMenu"
            }
        }
    })
    lib.showContext('AdvancedOptions')
end

function StartItemCraft(recipe, craftLocId)
    isCrafting = true
    FreezeEntityPosition(cache.ped, false)
    FreezeEntityPosition(cache.ped, true)
    local ItemProp = nil
    if type(Config.Locations[craftLocId].crafts[recipe].model) == "string" or type(Config.Locations[craftLocId].crafts[recipe].model) == "integer" then
        lib.requestModel(Config.Locations[craftLocId].crafts[recipe].model)
        ItemProp = CreateObject(Config.Locations[craftLocId].crafts[recipe].model, Config.Locations[craftLocId].coords.x,
            Config.Locations[craftLocId].coords.y, Config.Locations[craftLocId].coords.z - 0.05, true, false, false)
    end
    lib.callback("sharky_crafting:server:StartedCraft", false, function()
    end, Config.Locations[craftLocId].crafts[recipe], cache.coords)

    Wait(200)
    -- PlaceObjectOnGroundProperly_2(ItemProp)


    if lib.progressBar({
            duration = Config.Locations[craftLocId].crafts[recipe].duration * 1000,
            label = _U('crafting'),
            useWhileDead = false,
            canCancel = false,
            anim = {
                dict = "anim@amb@nightclub@djs@dixon@",
                clip = "dixn_end_dix",
            }
        }) then
        FreezeEntityPosition(cache.ped, false)
        lib.callback("sharky_crafting:server:CraftItem", false, function()
        end, Config.Locations[craftLocId].crafts[recipe], cache.coords)

        if ItemProp then
            DeleteEntity(ItemProp)
        end
        isCrafting = false
    else
        FreezeEntityPosition(cache.ped, false)
        lib.callback("sharky_crafting:server:StoppedCraft", false, function()
        end, Config.Locations[craftLocId].crafts[recipe], cache.coords)
        if ItemProp then
            DeleteEntity(ItemProp)
        end
        isCrafting = false
    end
end
