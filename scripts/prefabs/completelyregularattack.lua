local assets =
{
    Asset("ANIM", "anim/completelyregularattack.zip"),
    Asset("ANIM", "anim/swap_completelyregularattack.zip"),
	
	Asset("ATLAS", "images/inventoryimages/completelyregularattack.xml"),
	Asset("IMAGE", "images/inventoryimages/completelyregularattack.tex"),
}

local function OnFinished(inst)
    inst.AnimState:PlayAnimation("used")
    inst:ListenForEvent("animover", inst.Remove)
end

local function OnEquip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_completelyregularattack", "swap_boomerang")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 

    if owner.components.skilltreeupdater and owner.components.skilltreeupdater:IsActivated("wilton_bonerang_durability") then
        inst.components.weapon.attackwearmultipliers:SetModifier(inst, 1 / 1.5, "wilton_bonerang_durability")
    else
        inst.components.weapon.attackwearmultipliers:RemoveModifier(inst, "wilton_bonerang_durability")
    end

    if owner.components.skilltreeupdater and owner.components.skilltreeupdater:IsActivated("wilton_bonerang_damage") then
        inst.components.weapon:SetDamage(34 * 1.5)
    else
        inst.components.weapon:SetDamage(34)
    end
end

local function OnDropped(inst)
    if inst.components.finiteuses ~= nil and inst.components.finiteuses:GetUses() <= 0 then
        return
    end
    inst.AnimState:PlayAnimation("idle")
end

local function OnUnequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    inst.components.weapon.attackwearmultipliers:RemoveModifier(inst, "wilton_bonerang_durability")
    inst.components.weapon:SetDamage(34)
end

local function OnThrown(inst, owner, target)
    if target ~= owner then
        owner.SoundEmitter:PlaySound("dontstarve/wilson/boomerang_throw")
    end
    inst.AnimState:PlayAnimation("spin_loop", true)
end

local function OnCaught(inst, catcher)
    if catcher ~= nil and catcher.components.inventory ~= nil and catcher.components.inventory.isopen then
        if inst.components.equippable ~= nil and not catcher.components.inventory:GetEquippedItem(inst.components.equippable.equipslot) then
            catcher.components.inventory:Equip(inst)
        else
            catcher.components.inventory:GiveItem(inst)
        end
        catcher:PushEvent("catch")
    end
end

local function ReturnToOwner(inst, owner)
    if owner ~= nil and not (inst.components.finiteuses ~= nil and inst.components.finiteuses:GetUses() < 1) then
        owner.SoundEmitter:PlaySound("dontstarve/wilson/boomerang_return")
        inst.components.projectile:Throw(owner, owner)
    end
end

local function OnHit(inst, owner, target)
    if owner == nil or owner == target or owner:HasTag("playerghost") then
        OnDropped(inst)
    else
        ReturnToOwner(inst, owner)
    end
    if target ~= nil and target:IsValid() and target.components.combat then
        local impactfx = SpawnPrefab("impact")
        if impactfx ~= nil then
            local follower = impactfx.entity:AddFollower()
            follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0)
            impactfx:FacePoint(inst.Transform:GetWorldPosition())
        end
    end
end

local function OnMiss(inst, owner, target)
    if owner == nil or owner == target then
        OnDropped(inst)
    else
        ReturnToOwner(inst, owner)
    end
end

	--local function setAutoCatch(inst)
		--local oldhit = inst.components.projectile.Hit
		--function inst.components.projectile:Hit(target)
		--	if target == self.owner and target.components.catcher then
	--			target:PushEvent("catch", {projectile = self.inst})
	--			self.inst:PushEvent("caught", {catcher = target})
	--			self:Catch(target)
	--			target.components.catcher:StopWatching(self.inst)
	--		else
	--			oldhit(self, target)
	--		end
	--	end
	--end
	
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)
    inst.AnimState:SetBank("boomerang")
    inst.AnimState:SetBuild("completelyregularattack")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetRayTestOnBB(true)

    inst:AddTag("projectile")
    inst:AddTag("thrown")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(34)
    inst.components.weapon:SetRange(TUNING.BOOMERANG_DISTANCE, TUNING.BOOMERANG_DISTANCE+2)
    -------

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.BOOMERANG_USES*2)
    inst.components.finiteuses:SetUses(TUNING.BOOMERANG_USES*2)

    inst.components.finiteuses:SetOnFinished(OnFinished)

    inst:AddComponent("inspectable")

    inst:AddComponent("projectile")
    inst.components.projectile:SetSpeed(15)
    inst.components.projectile:SetCanCatch(true)
    inst.components.projectile:SetOnThrownFn(OnThrown)
    inst.components.projectile:SetOnHitFn(OnHit)
    inst.components.projectile:SetOnMissFn(OnMiss)
    inst.components.projectile:SetOnCaughtFn(OnCaught)

    local old_hit = inst.components.projectile.Hit
    inst.components.projectile.Hit = function(self, target)
        local attacker = self.owner
        if target == attacker and target ~= nil and target:HasTag("wiltonmod") and target.components.skilltreeupdater and target.components.skilltreeupdater:IsActivated("wilton_bonerang_safecatch") then
            self:Stop()
            self.inst.Physics:Stop()

            if self.inst.components.finiteuses ~= nil then
                local uses = 1
                if self.inst.components.weapon ~= nil then
                    uses = (self.inst.components.weapon.attackwear or 1) * self.inst.components.weapon.attackwearmultipliers:Get()
                end
                self.inst.components.finiteuses:Use(uses)
            end

            if self.onhit ~= nil then
                self.onhit(self.inst, attacker, target)
            end
            return
        end
        return old_hit(self, target)
    end

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/completelyregularattack.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("completelyregularattack", fn, assets)


