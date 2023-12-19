local function starts_with(str, start) return str:sub(1, #start) == start end

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
if mods["LasingAround"] then
    for recipe, tbl in pairs(data.raw.recipe) do
        if starts_with(recipe, "ce-micron-tolerance-components") then
            tbl.category = "crafting"
        end
    end
end
if mods["dark-matter-replicators-18"] then
    for tech, tbl in pairs(data.raw.technology) do
        if starts_with(tech, "dmr18-repl-") then
            local new_ingredients = {}
            for _, i in ipairs(tbl.unit.ingredients) do
                if starts_with(i[1], "dmr18-") then
                    table.insert(new_ingredients, i)
                end
            end
            tbl.unit.ingredients = new_ingredients
        end
    end
    local repl_lab = data.raw.lab["dmr18-replication-lab"]
    local new_inputs = {}
    for _, input in ipairs(repl_lab.inputs) do
        if starts_with(input, "dmr18-") then
            table.insert(new_inputs, input)
        end
    end
    repl_lab.inputs = new_inputs
end
