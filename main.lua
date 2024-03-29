local MimuMod = RegisterMod("Mimu Character Mod", 1)
local MimuChar = Isaac.GetPlayerTypeByName("Mimu", false)
 
function MimuMod:PostPlayerInit(player)
    if player:GetPlayerType() ~= MimuChar then
        return
    end

    player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mimu_hair_character.anm2"))
    player:AddEternalHearts(1)
end
MimuMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, MimuMod.PostPlayerInit)

function MimuMod:HandleStartingStats(player, flag)
    if player:GetPlayerType() ~= MimuChar then
        return
    end

    if flag == CacheFlag.CACHE_DAMAGE then
        player.Damage = player.Damage * 2
    end
    if flag == CacheFlag.CACHE_FIREDELAY then
        player.MaxFireDelay = player.MaxFireDelay * 1.75
    end
    if flag == CacheFlag.CACHE_SHOTSPEED then
        player.ShotSpeed = player.ShotSpeed / 3
    end
end
MimuMod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, MimuMod.HandleStartingStats)

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