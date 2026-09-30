local assets =
{
	Asset( "ANIM", "anim/wiltonmod.zip" ),
	Asset( "ANIM", "anim/ghost_wiltonmod_build.zip" ),
}

local skins =
{
	normal_skin = "wiltonmod",
	ghost_skin = "ghost_wiltonmod_build",
}

local base_prefab = "wiltonmod"

local tags = {"WILTON", "CHARACTER"}

return CreatePrefabSkin("wiltonmod_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})