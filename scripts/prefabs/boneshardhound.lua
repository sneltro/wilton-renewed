local assets =
{
    Asset("ANIM", "anim/bone_shards.zip")
	
	--Asset("ATLAS", "images/inventoryimages/boneshardhound.xml"),
	--Asset("IMAGE", "images/inventoryimages/boneshardhound.tex"),
}

local prefabs =
{
    "boneshard",
}

local function onpickup(inst, maker)
	local replacement = SpawnPrefab("boneshard")

	if maker ~= nil then
		inst:Remove()
		maker.components.inventory:GiveItem(replacement)
		return true
	end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("bone_shards")
    inst.AnimState:SetBuild("bone_shards")
    inst.AnimState:PlayAnimation("idle", false)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem:SetOnPickupFn(onpickup)
	
    inst:AddComponent("inspectable")

    inst.components.inventoryitem.atlasname = "images/inventoryimages/boneshardhound.xml"
	inst.components.inventoryitem.imagename = "boneshardhound"

    inst:AddComponent("stackable")

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("common/inventory/boneshardhound", fn, assets)