if mods["bzaluminum"] then
    local util = require("__bzaluminum__.data-util")
    local item = "automation-core"
    for i = 1, 15 do
        util.replace_ingredient("ce-" .. item .. "-" .. i, "copper-plate", "aluminum-plate")
    end
    item = "motor"
    for i = 1, 15 do
        util.replace_ingredient("ce-" .. item .. "-" .. i, "iron-plate", "aluminum-plate")
    end
end
if mods["dark-matter-replicators-18"] then
    for recipe, tbl in pairs(data.raw.recipe) do
        if tbl.name:sub(1, string.len("ce-dmr18")) == "ce-dmr18" then tbl.icon_size = 32 end
    end
    for tech, tbl in pairs(data.raw.technology) do
        if tbl.name:sub(1, string.len("ce-dmr18")) == "ce-dm18" then tbl.icon_size = 32 end
    end
end
