local MimuMod = RegisterMod("Mimu Character Mod", 1)
local hairCostume = Isaac.GetCostumeIdByPath("gfx/characters/mimu_hair.anm2")
local hairCostume2 = Isaac.GetCostumeIdByPath("gfx/characters/felix_hair.anm2")
local hairCostume3 = Isaac.GetCostumeIdByPath("gfx/characters/niya_hair.anm2")
 
function MimuMod:GiveCostumesOnInit(player)
    if player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Mimu", false) then
        return
    end

    player:AddNullCostume(hairCostume)
end
MimuMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, MimuMod.GiveCostumesOnInit)

function MimuMod:ExtraCostumesOnInit(player)
    if WardrobePlus ~= nil then
        OWRP.AddNewCostume("mimuhair", "Mimu's hair", "gfx/characters/mimu_hair.anm2",false,false)
        OWRP.AddNewCostume("felihair", "Felix's hair", "gfx/characters/felix_hair.anm2",false,false)
        OWRP.AddNewCostume("niyahair", "Niya's hair", "gfx/characters/niya_hair.anm2",false,false)
        OWRP.AddNewCostume("tobyhair", "Toby's hair", "gfx/characters/toby_hair.anm2",false,false)
        OWRP.AddNewCostume("clarhair", "Clara's hair", "gfx/characters/clara_hair.anm2",false,false)
    end
end
MimuMod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, MimuMod.ExtraCostumesOnInit)