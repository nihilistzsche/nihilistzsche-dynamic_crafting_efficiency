require("setup")
local util = require("data-util")
local hasDMR

local function starts_with(str, start) return str:sub(1, #start) == start end

if mods["modmashsplintergold"] then require("mods/modmashsplintergold") end
if mods["aai-industry"] then require("mods/aai-industry") end
if mods["Krastorio2"] then require("mods/krastorio2") end
if mods["water-processing"] then require("mods/water-processing") end
if mods["dark-matter-replicators-18"] then
    hasDMR = true
    require("mods/dmr18")
end
if mods["MDbobelectronics"] then require("mods/mdbobelectronics") end
if mods["BrassTacks"] then require("mods/brasstacks") end
if mods["IfNickel"] then require("mods/ifnickel") end
if mods["BrimStuff"] then require("mods/brimstuff") end
if mods["ThemTharHills"] then require("mods/themtharhills") end
if mods["LasingAround"] then require("mods/lasingaround") end
if mods["bismuth"] then require("mods/bismuth") end
k2_se_ce_add_recipe("stone-brick")
if mods["bzcarbon"] then k2_se_ce_add_recipe("carbon-black") end
if mods["bztin"] then
    k2_se_ce_add_recipe("bronze-plate")
    k2_se_ce_add_recipe("tinned-cable")
end
if hasDMR then
    local eff_data = {}

    for i, recipe in pairs(K2_SE_CE_Recipes) do
        -- add remaining recipes with direct items to find the icons
        if data.raw.recipe[recipe] and not eff_data[recipe] then
            local research_level = 1
            for tech, tbl in pairs(data.raw.technology) do
                for _, effect in pairs(tbl.effects or {}) do
                    if effect.type == "unlock-recipe" and effect.recipe ==
                        recipe then
                        research_level = math.min(#tbl.unit.ingredients, 6)
                    end
                end
            end
            eff_data[recipe] = research_level
        end
    end
    local repl_per_research_level = {
        "ore", "shape", "alloy", "device4", "device5"
    }
    local blacklist = {"rare-metals", "gold-ingot"}

    for recipe, research_level in pairs(eff_data) do
        if not util.contains(blacklist, recipe) and
            not starts_with(recipe, "dmr18") then
            log("Adding " .. recipe .. " to dark matter replicators")
            repltech_recipe(recipe, repl_per_research_level[research_level] or
                                "device5")
        end
    end
    if mods["IfNickel"] then
        repltech_ore("nickel-ore", 1, mods["aai-industry"] and 6 or 5)
    end
    if mods["ThemTharHills"] then repltech_ore("gold-ore", 1, 4) end
end
