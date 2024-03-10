local MyCharacterMod = RegisterMod("Gabriel Character Mod", 1)

local mimuType = Isaac.GetPlayerTypeByName("Gabriel", false) -- Exactly as in the xml. The second argument is if you want the Tainted variant.
local hairCostume = Isaac.GetCostumeIdByPath("gfx/characters/mimu_hair.anm2") -- Exact path, with the "resources" folder as the root
local stolesCostume = Isaac.GetCostumeIdByPath("gfx/characters/mimu_stoles.anm2") -- Exact path, with the "resources" folder as the root

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
        OWRP.AddNewCostume("mimuhair", "Mimu's hair", "gfx/characters/mimu_hair",false,false)
        OWRP.AddNewCostume("felixhair", "Felix's hair", "gfx/characters/felix_hair",false,false)
        OWRP.AddNewCostume("niyahair", "Niya's hair", "gfx/characters/niya_hair",false,false)
    end
end
MyCharacterMod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, MyCharacterMod.ExtraCostumesOnInit)