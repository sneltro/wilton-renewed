local assets =
{
	Asset("ANIM", "anim/rockygoop.zip"),
	
	Asset("ATLAS", "images/inventoryimages/rockygoop.xml"),
    Asset("IMAGE", "images/inventoryimages/rockygoop.tex"),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("rockygoop")
    inst.AnimState:SetBuild("rockygoop")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = 40
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/rockygoop.xml"

    inst:AddComponent("maxhealer")


    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("common/inventory/rockygoop", fn, assets)

