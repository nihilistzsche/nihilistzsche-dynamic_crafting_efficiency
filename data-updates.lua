require("setup")
local util = require("data-util")

if mods["modmashsplintergold"] then require("mods/modmashsplintergold") end
if mods["aai-industry"] then require("mods/aai-industry") end
if mods["Krastorio2"] then require("mods/krastorio2") end
if mods["water-processing"] then require("mods/water-processing") end
if mods["dark-matter-replicators-18"] then require("mods/dmr18") end
if mods["MDbobelectronics"] then require("mods/mdbobelectronics") end
if mods["BrassTacks"] then require("mods/brasstacks") end
if mods["IfNickel"] then require("mods/ifnickel") end
if mods["BrimStuff"] then require("mods/brimstuff") end
if mods["ThemTharHills"] then require("mods/themtharhills") end
k2_se_ce_add_recipe("stone-brick")

local eff_data = {}

for i, recipe in pairs(K2_SE_CE_Recipes) do
    -- add remaining recipes with direct items to find the icons
    if
        data.raw.recipe[recipe]
        and (data.raw.item[recipe] or data.raw.fluid[recipe])
        and not eff_data[recipe]
        and (data.raw.recipe[recipe].main_product or util.get_result_count(recipe) == 1)
    then
        local research_level = 6
        if data.raw.recipe[recipe].enabled then
            research_level = 1
        else
            for tech, tbl in pairs(data.raw.technology) do
                for _, effect in pairs(tbl.effects or {}) do
                    if effect.type == "unlock-recipe" and effect.recipe == recipe then
                        research_level = math.min(#tbl.unit.ingredients, research_level)
                    end
                end
            end
        end
        local data_base = data.raw.item[recipe] and data.raw.item[recipe] or data.raw.fluid[recipe]
        if data_base then
            eff_data[recipe] = {
                max = 15,
                icon = data_base.icons and data_base.icons[1].icon or data_base.icon,
                crafting = { efficiency = 10 },
                research = { level = research_level },
            }
        end
    end
end
for recipe, d in pairs(eff_data) do
    log("Adding " .. recipe .. " crafting efficiency")
    d.name = recipe:gsub("^%l", string.upper) .. " efficiency"
    CE_Add_Recipe(d, recipe)
end
