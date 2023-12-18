local eff_data = {}

for i, recipe in pairs(K2_SE_CE_Recipes) do
    -- add remaining recipes with direct items to find the icons
    if
        data.raw.recipe[recipe]
        and not eff_data[recipe]
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
        local data_base = data.raw.item[recipe] and data.raw.item[recipe] or data.raw.fluid[recipe] and data.raw.fluid[recipe] or data.raw.tool[recipe]
        if data_base then
            eff_data[recipe] = {
                max = 15,
                icon = data_base.icons and data_base.icons[1].icon or data_base.icon,
                crafting = { efficiency = 10 },
                research = { level = research_level },
            }
            if recipe:starts_with("dmr18-") then
                eff_data[recipe].icon = "__k2_se_crafting_efficiency__/graphics/icons/"..recipe:sub(7)..".png"
                eff_data[recipe].icon_size = 32
            end
        end
    end
end

for recipe, d in pairs(eff_data) do
    log("Adding " .. recipe .. " crafting efficiency")
    d.name = recipe:gsub("^%l", string.upper) .. " efficiency"
    CE_Add_Recipe(d, recipe)
end
