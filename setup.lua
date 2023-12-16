local util = require("data-util")

K2_SE_CE_Recipes = {}

function k2_se_ce_add_recipe(name)
    if not util.contains(K2_SE_CE_Recipes, name) then
        table.insert(K2_SE_CE_Recipes, name)
    end
end

