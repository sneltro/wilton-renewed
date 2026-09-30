require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/skeletons.zip"),
	
	Asset("ATLAS", "images/inventoryimages/sturdyskeleton.xml"),
    Asset("IMAGE", "images/inventoryimages/sturdyskeleton.tex"),
	
	Asset( "IMAGE", "images/map_icons/sturdyskeleton.tex" ),
    Asset( "ATLAS", "images/map_icons/sturdyskeleton.xml" ),	
}

local prefabs =
{
    "boneshard",
    "collapse_small",
	"collapse_big",
}

SetSharedLootTable('sturdyskeleton',
{
    {'boneshard',   1.00},
    {'boneshard',   1.00},
	{'boneshard',   1.00},
    {'boneshard',   1.00},
})

local function getdesc(inst, viewer)
    if inst.char ~= nil and not viewer:HasTag("playerghost") then
        local mod = GetGenderStrings(inst.char)
        local desc = GetDescription(viewer, inst, mod)
        local name = inst.playername or STRINGS.NAMES[string.upper(inst.char)]

        --no translations for player killer's name
        if inst.pkname ~= nil then
            return string.format(desc, name, inst.pkname)
        end

        --permanent translations for death cause
        if inst.cause == "unknown" then
            inst.cause = "shenanigans"
        elseif inst.cause == "moose" then
            inst.cause = math.random() < .5 and "moose1" or "moose2"
        end

        --viewer based temp translations for death cause
        local cause =
            inst.cause == "nil"
            and (viewer == "waxwell" and
                "charlie" or
                "darkness")
            or inst.cause

        return string.format(desc, name, STRINGS.NAMES[string.upper(cause)] or STRINGS.NAMES.SHENANIGANS)
    end
end

local function decay(inst) -- does not decay!
    
end

local function SetSkeletonDescription(inst, char, playername, cause, pkname)
    inst.char = char
    inst.playername = playername
    inst.pkname = pkname
    inst.cause = pkname == nil and cause:lower() or nil
    inst.components.inspectable.getspecialdescription = getdesc
end

local function CalculateAura(inst, observer)
	if observer:HasTag("wiltonmod") then
		return TUNING.SANITYAURA_SMALL
	end

	return 0
end

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
    inst:Remove()
end

local function onsave(inst, data)
    data.anim = inst.animnum
    data.char = inst.char
    data.playername = inst.playername
    data.pkname = inst.pkname
    data.cause = inst.cause
    if inst.skeletonspawntime ~= nil then
        local time = GetTime()
        if time > inst.skeletonspawntime then
            data.age = time - inst.skeletonspawntime
        end
    end
end

local function onload(inst, data)
    if data ~= nil then
        if data.anim ~= nil then
            inst.animnum = data.anim
            inst.AnimState:PlayAnimation("idle"..inst.animnum)
        end
        if data.char ~= nil and (data.cause ~= nil or data.pkname ~= nil) then
            inst.char = data.char
            inst.playername = data.playername --backward compatibility for nil playername
            inst.pkname = data.pkname --backward compatibility for nil pkname
            inst.cause = data.cause
            if inst.components.inspectable ~= nil then
                inst.components.inspectable.getspecialdescription = getdesc
            end
            if data.age ~= nil and data.age > 0 then
                inst.skeletonspawntime = -data.age
            end
        end
    end
end

local function onhaunt(inst, haunter)
	if haunter.prefab == "wiltonmod" then
		-- if skeleton revive was used, set penalty to 50% hp. usable hp: 50
		haunter.components.health:SetPenalty(0.50)
		haunter.components.health:DoDelta(0)
		haunter.Transform:SetPosition(inst.Transform:GetWorldPosition())
		haunter:PushEvent("respawnfromghost", { source = inst })
		SpawnPrefab("collapse_big").Transform:SetPosition(inst.Transform:GetWorldPosition())
		inst:DoTaskInTime(1, inst:Remove())
		return true
	end
	return false
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeSmallObstaclePhysics(inst, 0.25)
	
	inst.MiniMapEntity:SetIcon("sturdyskeleton.tex")

	inst:AddTag("structure")
	
    inst.AnimState:SetBank("skeleton")
    inst.AnimState:SetBuild("skeletons")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.animnum = 1
    inst.AnimState:PlayAnimation("idle1")

	inst:AddComponent("sanityaura")
    inst.components.sanityaura.aurafn = CalculateAura
	
    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('sturdyskeleton') 

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(3)
    inst.components.workable:SetOnFinishCallback(onhammered)

    inst.OnLoad = onload
    inst.OnSave = onsave
    inst.Decay = decay -- does not decay!
	
	inst:AddComponent("hauntable")
    inst.components.hauntable:SetOnHauntFn(onhaunt)

    inst.skeletonspawntime = nil

    return inst
end

local function fnplayer()
    local inst = fn()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.SetSkeletonDescription = SetSkeletonDescription
    inst.skeletonspawntime = GetTime()
    TheWorld:PushEvent("ms_skeletonspawn", inst)

    return inst
end

return Prefab("common/objects/sturdyskeleton", fn, assets, prefabs),
	MakePlacer("common/sturdyskeleton_placer", "skeleton", "skeletons", "idle1")