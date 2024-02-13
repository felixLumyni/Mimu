local MyCharacterMod = RegisterMod("Gabriel Character Mod", 1)

local gabrielType = Isaac.GetPlayerTypeByName("Gabriel", false) -- Exactly as in the xml. The second argument is if you want the Tainted variant.
local hairCostume = Isaac.GetCostumeIdByPath("gfx/characters/gabriel_hair.anm2") -- Exact path, with the "resources" folder as the root
local stolesCostume = Isaac.GetCostumeIdByPath("gfx/characters/gabriel_stoles.anm2") -- Exact path, with the "resources" folder as the root

function MyCharacterMod:GiveCostumesOnInit(player)
    if player:GetPlayerType() ~= gabrielType then
        return -- End the function early. The below code doesn't run, as long as the player isn't Gabriel.
    end

    player:AddNullCostume(hairCostume)
    player:AddNullCostume(stolesCostume)
end

MyCharacterMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, MyCharacterMod.GiveCostumesOnInit)


--------------------------------------------------------------------------------------------------


local game = Game() -- We only need to get the game object once. It's good forever!
local DAMAGE_REDUCTION = 0.6
function MyCharacterMod:HandleStartingStats(player, flag)
    if player:GetPlayerType() ~= gabrielType then
        return -- End the function early. The below code doesn't run, as long as the player isn't Gabriel.
    end

    if flag == CacheFlag.CACHE_DAMAGE then
        -- Every time the game reevaluates how much damage the player should have, it will reduce the player's damage by DAMAGE_REDUCTION, which is 0.6
        player.Damage = player.Damage - DAMAGE_REDUCTION
    end
end

MyCharacterMod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, MyCharacterMod.HandleStartingStats)

function MyCharacterMod:HandleHolyWaterTrail(player)
    if player:GetPlayerType() ~= gabrielType then
        return -- End the function early. The below code doesn't run, as long as the player isn't Gabriel.
    end

    -- Every 4 frames. The percentage sign is the modulo operator, which returns the remainder of a division operation!
    if game:GetFrameCount() % 4 == 0 then
        -- Vector.Zero is the same as Vector(0, 0). It is a constant!
        local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL, 0, player.Position, Vector.Zero, player):ToEffect()
        creep.SpriteScale = Vector(0.5, 0.5) -- Make it smaller!
        creep:Update() -- Update it to get rid of the initial red animation that lasts a single frame.
    end
end

MyCharacterMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, MyCharacterMod.HandleHolyWaterTrail)