local util = require("data-util")

K2_SE_CE_Recipes = {}
function k2_se_ce_add_recipe(name, extra_data)
    if not util.contains(K2_SE_CE_Recipes, name) then
        if not extra_data then
            table.insert(K2_SE_CE_Recipes, name)
        else
            table.insert(K2_SE_CE_Recipes, {name, extra_data})
        end
    end
end

