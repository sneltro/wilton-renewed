local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
	Asset("SCRIPT", "scripts/prefabs/skilltree_wilton.lua")

	
}

Assets = {
	Asset( "ATLAS", "images/inventoryimages/bonepaste.xml" ),
	Asset( "IMAGE", "images/inventoryimages/bonepaste.tex" ),

	Asset("ATLAS", "images/inventoryimages/completelyregularattack.xml"),    
	Asset("IMAGE", "images/inventoryimages/completelyregularattack.tex"),
}

local prefabs = {
	"bonepaste",
	"completelyregularattack",
	"double_bonerang",
}

TUNING.STARTING_ITEM_IMAGE_OVERRIDE["bonepaste"] = {atlas = "images/inventoryimages/bonepaste.xml", image = "bonepaste.tex"}
TUNING.STARTING_ITEM_IMAGE_OVERRIDE["completelyregularattack"] = {atlas = "images/inventoryimages/completelyregularattack.xml", image = "completelyregularattack.tex"}
TUNING.STARTING_ITEM_IMAGE_OVERRIDE["double_bonerang"] = {atlas = "images/inventoryimages/completelyregularattack.xml", image = "completelyregularattack.tex"}


----------------------------OLD
----------------------------NEW INV
local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
   start_inv[string.lower(k)] = v.WILTON
end
local prefabs = FlattenTree(start_inv, true)

-- Custom starting items
local start_inv = {
	"boneshard",
	"boneshard",
	"boneshard",
	"boneshard",
	"boneshard",
	"bonepaste",
	"bonepaste",
	"bonepaste",
	"completelyregularattack",
}




TUNING.GAMEMODE_STARTING_ITEMS.LAVAARENA.WILTONMOD = {}
TUNING.GAMEMODE_STARTING_ITEMS.QUAGMIRE.WILTONMOD = {}

-- sets damage multiplier based on current hp
local function recalculateDamageMultiplier (inst)
	local dmgMult = 0.5
	local currentHealth = inst.components.health.currenthealth
	
	if currentHealth >= 100 then
		dmgMult = 1
	elseif currentHealth >= 95 then
		dmgMult = 0.95
	elseif currentHealth >= 90 then
		dmgMult = 0.90
	elseif currentHealth >= 85 then
		dmgMult = 0.85
	elseif currentHealth >= 80 then 
		dmgMult = 0.80
	elseif currentHealth >= 75 then
		dmgMult = 0.75
	elseif currentHealth >= 70 then
		dmgMult = 0.70
	elseif currentHealth >= 65 then 
		dmgMult = 0.65
	elseif currentHealth >= 60 then 
		dmgMult = 0.60
	elseif currentHealth >= 55 then
		dmgMult = 0.55
	else
		dmgMult = 0.5
	end
	
	inst.components.combat.damagemultiplier = dmgMult
end

-- loses hp via penalties when taking damage / recalculates damage multiplier
local function reduceHealth(inst, data)
	if data.amount < 0 then
		if inst.components.health.currenthealth <= 0 then
			--player died, don't change penalty
		else			
			local dmgPct = (data.amount / inst.components.health.maxhealth) -- (damage / maxhealth) = % of health penalty
			
			inst.components.health.penalty = math.clamp((inst.components.health.penalty + -dmgPct/2.5), 0, 1.00)
			inst.components.health:ForceUpdateHUD()
		end
	end
	recalculateDamageMultiplier(inst)
end

-- if hunger ever falls below 100%, resets all hunger settings (in case of mods/ect that change rate?)
local function hungerCheck(inst)
	if inst.components.hunger.max then
		inst.components.hunger:SetMax(10)
		inst.components.hunger:Pause()
		inst.components.hunger:SetRate(0)
		inst.components.hunger:SetKillRate(0)

	end
end

-- prevents revival via telltale heart
local function ShouldAcceptItem(inst, item)
    if inst:HasTag("playerghost") and inst.prefab == "wiltonmod" then
		return false
	elseif inst:HasTag("playerghost") then
        return item.prefab == "reviver"
    else
        return item.components.inventoryitem ~= nil
    end
end

-- changes sanity gain when near creature
local function sanityfn(inst)
	-- sanity gain when near SKELETONS
    local x,y,z = inst.Transform:GetWorldPosition()    
    local delta = 0
    local ents = TheSim:FindEntities(x,y,z, 20, {"skeleton"})
    for k,v in pairs(ents) do
		if v.prefab == "wiltonmod" then --wilton has the skeleton tag. would gain sanity from being near himself without this
			-- 0 sanity gain
		elseif v.components.follower and v.components.follower.leader == inst then --turn off sanity gain if skeleton is follower [0 gain/loss]
			-- 0 sanity gain
		else -- add SANITYAURA_MED gain to counter skeleton med drain
			local bonus_sanity = TUNING.SANITYAURA_MED
			local distsq = math.max(inst:GetDistanceSqToInst(v),1)
			delta = delta + bonus_sanity/distsq
		end
    end
 
    return delta
end

-- When the character is revived from human
local function onbecamehuman(inst)
	-- speed when reviving [becoming ghost resets speed?]
	inst.components.locomotor.walkspeed = 4
	inst.components.locomotor.runspeed = 6
	
	-- sets health to max with the current penalty, if any
	inst.components.health:SetCurrentHealth(inst.components.health:GetMaxWithPenalty())
	inst.components.health:DoDelta(0)
	-- sets sanity to max with the current penalty, if any
	inst.components.sanity:SetPercent(1, 0)
end

local function onbecameghost(inst)
end

-- override revive animation to use the custom one.
-- also, if reviving from a portal, makes sure health penalties are correct
local function reviveAnimation(inst)
	if inst.sg.currentstate.name ~= "portal_rez" then
		inst.DynamicShadow:Enable(true)
		inst.AnimState:SetBank("wilson")
		inst.AnimState:SetBuild(inst.skin_name or inst.prefab)
		inst.AnimState:ClearBloomEffectHandle()
		inst.AnimState:SetLightOverride(0)
		inst.AnimState:Hide("HAT")
		inst.AnimState:Hide("HatFX")
	
		inst.sg:GoToState("wilton_rebirth")
	else -- if reviving from portal, set 70% hp penalty. spawn hp: 30
		inst.components.health:SetPenalty(0.70)
		inst.components.health:DoDelta(0)
		inst.components.health:SetCurrentHealth(inst.components.health:GetMaxWithPenalty())
		inst.components.health:DoDelta(0)
	end
end

-- When loading or spawning the character
local function onload(inst)
	inst:ListenForEvent("ms_respawnedfromghost", reviveAnimation)
	inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)

    --if not inst:HasTag("playerghost") then
    --    onbecamehuman(inst)
    --end
end

-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- cannot sleep
	inst:AddTag("insomniac")
	inst:AddTag("wiltonmod")
	inst:AddTag("skeleton")
	inst:AddTag("player")
	inst:AddTag("wiltoncraft")

	-- Minimap icon
	inst.MiniMapEntity:SetIcon("wiltonmod.tex")
end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- sets custom sounds
	inst.soundsname = "wiltonmod"
	
	-- doesn't need setdiet. can eat anything via modmain code
		--inst.components.eater:SetDiet({FOODGROUP.OMNI})
	-- adds options to eat horrible and raw
	inst.components.eater:SetCanEatHorrible()
	inst.components.eater:SetCanEatRaw()
	
	-- makes it so sanity is gained when near 'skeletons'
	inst.components.sanity.custom_rate_fn = sanityfn
	
	-- loses max hp when taking damage
	inst:ListenForEvent("healthdelta", reduceHealth)
	
	-- if hunger ever ticks, check and reset all hunger to "off"
	inst:ListenForEvent("hungerdelta", hungerCheck)
	
	-- starting stats
	-- speed
	inst.components.locomotor.walkspeed = 4
	inst.components.locomotor.runspeed = 6
	-- low max hp. very low spawn hp due to penalty
	inst.components.health:SetMaxHealth(100)
	inst.components.health:DeltaPenalty(0)
	inst.components.health:SetCurrentHealth(inst.components.health:GetMaxWithPenalty())
	inst.components.health:DoDelta(0)
	-- turn hunger off
	inst.components.hunger:SetMax(10)
	inst.components.hunger:Pause()
	inst.components.hunger:SetRate(0)
	inst.components.hunger:SetKillRate(0)
	-- very low sanity
	inst.components.sanity:SetMax(85)
	-- sets damage multiplier based on current health. starting: 0.5 multiplier
	recalculateDamageMultiplier(inst)
	-- is less afraid of night
	inst.components.sanity.night_drain_mult = 0.5
	-- resistant to temperature change
	inst.components.temperature.inherentinsulation = 90
    inst.components.temperature.inherentsummerinsulation = 90
	-- disables telltale heart revival
	inst.components.trader:SetAcceptTest(ShouldAcceptItem)
	
	-- initial spawn health penalty. 50 hp penalty. starting hp: 50
	inst.components.health:SetPenalty(0) -- 50% health penalty
	inst.components.health:DeltaPenalty(0)
	inst.components.health:SetCurrentHealth(inst.components.health:GetMaxWithPenalty())
	inst.components.health:DoDelta(0)
 
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
end

return MakePlayerCharacter("wiltonmod", prefabs, assets, common_postinit, master_postinit, start_inv)
