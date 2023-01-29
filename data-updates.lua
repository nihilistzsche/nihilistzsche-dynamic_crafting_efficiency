require("util")
if mods["modmashsplintergold"] then require("mods/modmashsplintergold") end
if mods["aai-industry"] then require("mods/aai-industry") end
if mods["Krastorio2"] then require("mods/krastorio2") end
if mods["water-processing"] then require("mods/water-processing") end
k2_se_ce_add_recipe("stone-brick", {
    name = "Stone brick efficiency",
    max = 15,
    crafting = {
        effciency = 20,
        category = "smelting",
    },
    research = {
        level = 1,
    },
})
for name, _data in pairs(K2_SE_CE_Recipes) do
    if data.raw.recipe[name] then
        log("Adding crafting effiency for " .. name)
        CE_Add_Recipe(_data, name)
    end
end
