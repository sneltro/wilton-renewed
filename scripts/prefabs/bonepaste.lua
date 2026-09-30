local assets =
{
    Asset("ANIM", "anim/bonepaste.zip"),
	
	Asset("ATLAS", "images/inventoryimages/bonepaste.xml"),
    Asset("IMAGE", "images/inventoryimages/bonepaste.tex"),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("bonepaste")
    inst.AnimState:SetBuild("bonepaste")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = 20

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/bonepaste.xml"

    inst:AddComponent("maxhealer")

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("common/inventory/bonepaste", fn, assets)