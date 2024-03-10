local MyCharacterMod = RegisterMod("Gabriel Character Mod", 1)
local mimuType = Isaac.GetPlayerTypeByName("Gabriel", false) -- Exactly as in the xml. The second argument is if you want the Tainted variant.
-- Exact paths, with the "resources" folder as the root
local hairCostume = Isaac.GetCostumeIdByPath("gfx/characters/mimu_hair.anm2")
local hairCostume2 = Isaac.GetCostumeIdByPath("gfx/characters/felix_hair.anm2")
local hairCostume3 = Isaac.GetCostumeIdByPath("gfx/characters/niya_hair.anm2")
local stolesCostume = Isaac.GetCostumeIdByPath("gfx/characters/mimu_stoles.anm2")
 
function MyCharacterMod:GiveCostumesOnInit(player)
    if player:GetPlayerType() ~= mimuType then
        return -- End the function early. The below code doesn't run, as long as the player isn't Gabriel.
    end

    player:AddNullCostume(hairCostume)
    player:AddNullCostume(stolesCostume)
end
MyCharacterMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, MyCharacterMod.GiveCostumesOnInit)

function MyCharacterMod:ExtraCostumesOnInit(player)
    if WardrobePlus ~= nil then
        OWRP.AddNewCostume("mimuhair", "Mimu's hair", "gfx/characters/mimu_hair.anm2",false,false)
        OWRP.AddNewCostume("felihair", "Felix's hair", "gfx/characters/felix_hair.anm2",false,false)
        OWRP.AddNewCostume("niyahair", "Niya's hair", "gfx/characters/niya_hair.anm2",false,false)
    end
end
MyCharacterMod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, MyCharacterMod.ExtraCostumesOnInit)