local MimuMod = RegisterMod("Mimu Character Mod", 1)
local MimuChar = Isaac.GetPlayerTypeByName("Mimu", false)
local HomuosWater = Isaac.GetItemIdByName("Homuo's Water")

--Add trinkets and items into pools
TrinketType.TRINKET_AXSHAPEDLEAF = Isaac.GetTrinketIdByName("Ax-Shaped Leaf")
CollectibleType.COLLECTIBLE_HOMUOSWATER = Isaac.GetItemIdByName("Homuo's Water")

--Functions & Callbacks

--Mimu's base stats
function MimuMod:HandleStartingStats(player, flag)
    if player:GetPlayerType() ~= MimuChar then
        return
    end

    if flag == CacheFlag.CACHE_DAMAGE then
        player.Damage = player.Damage * 2
    end
    if flag == CacheFlag.CACHE_FIREDELAY then
        player.MaxFireDelay = player.MaxFireDelay * 3
    end
    if flag == CacheFlag.CACHE_SHOTSPEED then
        player.ShotSpeed = player.ShotSpeed / 3
    end
end
MimuMod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, MimuMod.HandleStartingStats)

--Mimu start game
function MimuMod:PostPlayerInit(player)
    player:GetData().mimuCooldown = 0
    if player:GetPlayerType() ~= MimuChar then
        return
    end

    player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mimu_hair_character.anm2"))
    player:AddEternalHearts(1)
    player:AddTrinket(TrinketType.TRINKET_AXSHAPEDLEAF)
    player:AddCollectible(CollectibleType.COLLECTIBLE_HOMUOSWATER, 0, false)
end
MimuMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, MimuMod.PostPlayerInit)

--Homuo's Water
function MimuMod:onNewFloor()
    local player = Isaac.GetPlayer(0)
        if player:HasCollectible(HomuosWater) then
        player:AddEternalHearts(1, false)
        player.Damage = player.Damage + 0.5
    end
end
MimuMod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, MimuMod.onNewFloor)

--custumes 
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

--trinket ax-shaped leaf
function MimuMod:onDamage(entity, damageAmount, damageFlags, damageSource, damageCountdown)
    local enemyOnFullHP = entity:IsActiveEnemy() and entity.HitPoints == entity.MaxHitPoints
    if enemyOnFullHP then
        local player = damageSource and damageSource.Entity and damageSource.Entity:ToPlayer()
        local playerHasTrinket = player and player:HasTrinket(Isaac.GetTrinketIdByName("Ax-Shaped Leaf"))
        if playerHasTrinket and not (player:GetData().mimuCooldown and player:GetData().mimuCooldown > 0) then
            damageAmount = damageAmount * 2
            player:GetData().mimuCooldown = 1
            entity:TakeDamage(damageAmount, damageFlags, damageSource, damageCountdown)
            for i = 1, 100 do
                Game():SpawnParticles(entity.Position, EffectVariant.BLOOD_PARTICLE, 1, 1)
            end
            SFXManager():Play(SoundEffect.SOUND_ROCKET_BLAST_DEATH, 1, 0, false, 1, 0)
            return false
        end
    end
end
MimuMod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, MimuMod.onDamage)

--q porra essa kk
function MimuMod:onNewRoom()
    for i = 1, Game():GetNumPlayers() do
        local player = Game():GetPlayer(i - 1)
        if player:GetData().mimuCooldown then
            player:GetData().mimuCooldown = player:GetData().mimuCooldown - 1
        else
            player:GetData().mimuCooldown = 0
        end
    end
end
MimuMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, MimuMod.onNewRoom)