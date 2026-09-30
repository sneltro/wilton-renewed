local assets =
{
    Asset("ANIM", "anim/bloodpump.zip"),
    Asset("ANIM", "anim/boneheart.zip"),

    Asset("ATLAS", "images/inventoryimages/boneheart.xml"),    
    Asset("IMAGE", "images/inventoryimages/boneheart.tex"),
}

local prefabs =
{
    "reviver",
}

local function onpickup(inst, maker)
	local replacement = SpawnPrefab("reviver")

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

    inst.AnimState:SetBank("boneheart")
    inst.AnimState:SetBuild("boneheart")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/boneheart.xml"
    inst.components.inventoryitem.imagename = "boneheart"

	inst.components.inventoryitem:SetOnPickupFn(onpickup)
	
    inst:AddComponent("inspectable")
    inst:AddComponent("tradable")

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("common/inventory/boneheart", fn, assets)