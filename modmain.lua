PrefabFiles = {
	"wiltonmod",
	"wiltonmod_none",
	"boneheart",
	"bonepaste",
	"sturdyskeleton",
	"boneshardhound",
	"boneshardself",
	"completelyregularattack",
	"double_bonerang",
	"rockygoop",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/wiltonmod.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/wiltonmod.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/wiltonmod.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/wiltonmod.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/wiltonmod_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/wiltonmod_silho.xml" ),

    Asset( "IMAGE", "bigportraits/wiltonmod.tex" ),
    Asset( "ATLAS", "bigportraits/wiltonmod.xml" ),
	
	Asset( "IMAGE", "bigportraits/wiltonmod_none.tex" ),
    Asset( "ATLAS", "bigportraits/wiltonmod_none.xml" ),
	
	Asset( "IMAGE", "images/names_gold_wiltonmod.tex" ),
	Asset( "ATLAS", "images/names_gold_wiltonmod.xml" ),
	
	Asset( "IMAGE", "images/names_wiltonmod.tex" ),
	Asset( "ATLAS", "images/names_wiltonmod.xml" ),
	
	Asset( "IMAGE", "images/map_icons/wiltonmod.tex" ),
	Asset( "ATLAS", "images/map_icons/wiltonmod.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_wiltonmod.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_wiltonmod.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_wiltonmod.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_wiltonmod.xml" ),
	
	Asset( "ATLAS", "images/inventoryimages/bonepaste.xml" ),
	Asset( "IMAGE", "images/inventoryimages/bonepaste.tex" ),
	
	Asset( "ATLAS", "images/inventoryimages/sturdyskeleton.xml" ),
	Asset( "IMAGE", "images/inventoryimages/sturdyskeleton.tex" ),
	
	Asset( "IMAGE", "images/map_icons/sturdyskeleton.tex" ),
	Asset( "ATLAS", "images/map_icons/sturdyskeleton.xml" ),
	
	Asset("ATLAS", "images/inventoryimages/crafticon.xml"),
    Asset("IMAGE", "images/inventoryimages/crafticon.tex"),	
	
	Asset("ANIM", "anim/bloodpump.zip"),
	Asset("ANIM", "anim/boneheart.zip"),

	Asset("ATLAS", "images/inventoryimages/boneheart.xml"),    
	Asset("IMAGE", "images/inventoryimages/boneheart.tex"),
	
	Asset("ATLAS", "images/inventoryimages/boneshardhound.xml"),    
	Asset("IMAGE", "images/inventoryimages/boneshardhound.tex"),
	
	Asset("ATLAS", "images/inventoryimages/boneshardself.xml"),    
	Asset("IMAGE", "images/inventoryimages/boneshardself.tex"),

	Asset("ATLAS", "images/inventoryimages/completelyregularattack.xml"),    
	Asset("IMAGE", "images/inventoryimages/completelyregularattack.tex"),
	
	Asset("ATLAS", "images/inventoryimages/rockygoop.xml"),    
	Asset("IMAGE", "images/inventoryimages/rockygoop.tex"),

	
	Asset("SOUNDPACKAGE", "sound/wiltonmod.fev"),
    Asset("SOUND", "sound/wiltonmod.fsb"),
}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

-- for CHARACTER_QUOTES


-- for recipes
RECIPETABS = GLOBAL.RECIPETABS
TECH = GLOBAL.TECH
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient

-- for stategraphs
State = GLOBAL.State
TimeEvent = GLOBAL.TimeEvent
EventHandler = GLOBAL.EventHandler
FRAMES = GLOBAL.FRAMES
ACTIONS = GLOBAL.ACTIONS

local Ingredient = GLOBAL.Ingredient -- please dont change any of these, they're necessary
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH





-- The character select screen lines
STRINGS.CHARACTER_TITLES.wiltonmod = "The Haunted"
STRINGS.CHARACTER_NAMES.wiltonmod = "Wilton"
STRINGS.CHARACTER_DESCRIPTIONS.wiltonmod = "*Has no stomach\n*Is very fragile\n*Needs a skeleton to revive"--\n*Can resummon undead"
STRINGS.CHARACTER_SURVIVABILITY.wiltonmod = "Grim"
STRINGS.CHARACTER_QUOTES.wiltonmod = "\"Aaaaaaaaa...\"" 

TUNING.WILTONMOD_HEALTH = 100
TUNING.WILTONMOD_SANITY = 85




RegisterInventoryItemAtlas("images/inventoryimages/bonepaste.xml", "images/inventoryimages/bonepaste.tex") 
RegisterInventoryItemAtlas("images/inventoryimages/completelyregularattack.xml", "images/inventoryimages/completelyregularattack.tex")
RegisterInventoryItemAtlas("images/inventoryimages/rockygoop.xml", "images/inventoryimages/rockygoop.tex")  

TUNING.STARTING_ITEM_IMAGE_OVERRIDE.bonepaste = {atlas = "images/inventoryimages/bonepaste.xml", image = "images/inventoryimages/bonepaste.xml" }
TUNING.STARTING_ITEM_IMAGE_OVERRIDE.completelyregularattack = {atlas = "images/inventoryimages/completelyregularattack.xml", image = "images/inventoryimages/completelyregularattack.tex" }
TUNING.STARTING_ITEM_IMAGE_OVERRIDE.double_bonerang = {atlas = "images/inventoryimages/completelyregularattack.xml", image = "images/inventoryimages/completelyregularattack.tex" }


TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.WILTONMOD = {
	"boneshard",
	"bonepaste",
	"completelyregularattack",
}

-- Custom speech strings
STRINGS.CHARACTERS.WILTONMOD = require "speech_wiltonmod"

-- The character's name as appears in-game 
STRINGS.NAMES.WILTONMOD = "Wilton"

-- The default responses of examining the character
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WILTONMOD = 
{
	GENERIC = "It's Wilton... I guess",
	ATTACKER = "That Wilton looks shifty...",
	MURDERER = "Skeleton murderer!",
	REVIVER = "Wilton, friend of ghosts.",
	GHOST = "Wilton could use a skeleton.",
}

-- Custom sound file
RemapSoundEvent( "dontstarve/characters/wiltonmod/talk_LP", "wiltonmod/characters/wiltonmod/talk_LP" )
RemapSoundEvent( "dontstarve/characters/wiltonmod/hurt", "wiltonmod/characters/wiltonmod/hurt" )
RemapSoundEvent( "dontstarve/characters/wiltonmod/death_voice", "wiltonmod/characters/wiltonmod/death_voice" )
RemapSoundEvent( "dontstarve/characters/wiltonmod/emote", "wiltonmod/characters/wiltonmod/emote" )
RemapSoundEvent( "dontstarve/characters/wiltonmod/yawn", "wiltonmod/characters/wiltonmod/yawn" )
RemapSoundEvent( "dontstarve/characters/wiltonmod/pose", "wiltonmod/characters/wiltonmod/pose" )



----START RECIPES ADD

-- adds custom build tab
local sort_key = 99
local skeleton_tab = AddRecipeTab( 
"Skeleton", -- Display Name.
sort_key, -- Sort Key.
"images/inventoryimages/crafticon.xml", -- Atlas File.
"crafticon.tex", -- Icon File.
"wiltonmod" -- Builder Tag.
)





AddCharacterRecipe("boneheart", -- name
	{ -- ingredients
		GLOBAL.Ingredient("rocks", 1),
		GLOBAL.Ingredient("spidergland", 1),
		Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 50)
	},
	GLOBAL.TECH.NONE, -- tech
	{ -- config
		product = "boneheart",
		builder_tag = "wiltonmod",
		atlas ="images/inventoryimages/boneheart.xml",
		image = "boneheart.tex",
		numtogive = 1,
	}, 
	{ -- filters
	}
)


AddCharacterRecipe("bonepaste", -- name
	{ -- ingredients
		GLOBAL.Ingredient("boneshard", 1),
		GLOBAL.Ingredient("rocks", 1),
		GLOBAL.Ingredient("spidergland", 1),
	},
	GLOBAL.TECH.NONE, -- tech
	{ -- config
		product = "bonepaste",
		builder_tag = "wiltonmod",
		atlas = "images/inventoryimages/bonepaste.xml",
		image = "bonepaste.tex",
		numtogive = 1,
	}, 
	{ -- filters
	}
)

AddCharacterRecipe("rockygoop", -- name
	{ -- ingredients
		GLOBAL.Ingredient("wetgoop", 1),
		GLOBAL.Ingredient("rocks", 1),
	},
	GLOBAL.TECH.NONE, -- tech
	{ -- config
		product = "rockygoop",
		builder_tag = "wiltonmod",
		atlas = "images/inventoryimages/rockygoop.xml",
		image = "rockygoop.tex",
		numtogive = 1,
	}, 
	{ -- filters
	}
)

AddCharacterRecipe("sturdyskeleton", -- name
	{ -- ingredients
		GLOBAL.Ingredient("boneshard", 10),
		GLOBAL.Ingredient("bonepaste", 1, "images/inventoryimages/bonepaste.xml")
	},
	GLOBAL.TECH.NONE, -- tech
	{ -- config
		placer = "sturdyskeleton_placer", 1,
		product = "sturdyskeleton",
		builder_tag = "wiltonmod",
		atlas ="images/inventoryimages/sturdyskeleton.xml",
		image = "sturdyskeleton.tex",
		numtogive = 1,
	}, 
	{ -- filters
	}
)

AddCharacterRecipe("boneshardhound", -- name
	{ -- ingredients
		GLOBAL.Ingredient("houndstooth", 1),
		GLOBAL.Ingredient("rocks", 1),
	},
	GLOBAL.TECH.NONE, -- tech
	{ -- config
		product = "boneshardhound",
		builder_tag = "wiltonmod",
		atlas ="images/inventoryimages/boneshardhound.xml",
		image = "boneshardhound.tex",
		numtogive = 1,
	}, 
	{ -- filters
	}
)



if GLOBAL.TheNet:GetServerGameMode() ~= "endless" then --don't add recipe in endless for balance reasons [portal rez]
	AddCharacterRecipe("boneshardself", -- name
		{ -- ingredients
			GLOBAL.Ingredient("rocks", 1),
			GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.HEALTH, 5)
		},
		GLOBAL.TECH.NONE, -- tech
		{ -- config
			product = "boneshardself",
			builder_tag = "wiltonmod",
			atlas ="images/inventoryimages/boneshardhound.xml",
			image = "boneshardhound.tex",
			numtogive = 1,
		}, 
		{ -- filters
		}
	)
end


AddCharacterRecipe("completelyregularattack", -- name
	{ -- ingredients
		GLOBAL.Ingredient("boneshard", 3),
		GLOBAL.Ingredient("charcoal", 1),
	},
	GLOBAL.TECH.SCIENCE_TWO, -- tech
	{ -- config
		product = "completelyregularattack",
		builder_tag = "wiltonmod",
		atlas ="images/inventoryimages/completelyregularattack.xml",
		image = "completelyregularattack.tex",
		numtogive = 1,
	}, 
	{ -- filters
	"WEAPONS",
	}
)

AddCharacterRecipe("double_bonerang", -- name
	{ -- ingredients
		GLOBAL.Ingredient("boneshard", 3),
		GLOBAL.Ingredient("charcoal", 1),
	},
	GLOBAL.TECH.SCIENCE_TWO, -- tech
	{ -- config
		product = "double_bonerang",
		builder_tag = "wiltonmod",
		atlas ="images/inventoryimages/completelyregularattack.xml",
		image = "completelyregularattack.tex",
		numtogive = 1,
	}, 
	{ -- filters
	"WEAPONS",
	}
)




-- Bone Attack 
STRINGS.RECIPE_DESC.COMPLETELYREGULARATTACK = "It's an absolutely normal boomerang."
STRINGS.NAMES.COMPLETELYREGULARATTACK = "Bonerang"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.COMPLETELYREGULARATTACK = "Tiny bones stronger!"

STRINGS.RECIPE_DESC.DOUBLE_BONERANG = "It's an absolutely normal boomerang."
STRINGS.NAMES.DOUBLE_BONERANG = "Double Bonerang"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DOUBLE_BONERANG = "Tiny bones stronger!"

-- strings for bonepaste item
STRINGS.RECIPE_DESC.BONEPASTE = "Helps hold bones together."
STRINGS.NAMES.BONEPASTE = "Bone Paste"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BONEPASTE = "Wilton could use this."

-- strings for boneshard made from hound tooth
STRINGS.RECIPE_DESC.BONESHARDHOUND = "Teeth crushed into shards."
STRINGS.NAMES.BONESHARDHOUND = "Bone Shards"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BONESHARDHOUND = "Boney."

-- strings for boneshard made from self
STRINGS.RECIPE_DESC.BONESHARDSELF = "This might hurt a little.."
STRINGS.NAMES.BONESHARDSELF = "Bone Shards"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BONESHARDSELF = "Boney."

-- strings for boneheart item
STRINGS.RECIPE_DESC.BONEHEART = "Ghastly revival of a ghostly friend."
STRINGS.NAMES.BONEHEART = "Bone Heart"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BONEHEART = "This grim heart will bring a ghost back to life"

-- strings for sturdy skeleton item
STRINGS.RECIPE_DESC.STURDYSKELETON = "A skeleton that won't decay."
STRINGS.NAMES.STURDYSKELETON = "Sturdy Skeleton"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.STURDYSKELETON = "Wilton?"

STRINGS.RECIPE_DESC.ROCKYGOOP = "Compressed sludge and rocks."
STRINGS.NAMES.ROCKYGOOP = "Rocky Goop"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ROCKYGOOP = "Sluggish."
-- icon for minimap
AddMinimapAtlas("images/map_icons/sturdyskeleton.xml")

----END RECIPES ADD

---START RECIPES REMOVE
AddPlayerPostInit( function ( player ) --thanks to Noggie/Ksizor for the code on klei forums
  
	if not GLOBAL.TheWorld.ismastersim or player.prefab ~= "wiltonmod" then
		return player
	end
	  
	player.components.builder.ignorelist = { }
	  
	function player.components.builder:AddIgnoreRecipe( recname )
		self.ignorelist[ recname ] = recname
	end
	  
	function player.components.builder:RemoveIgnoreRecipe( recname )
		self.ignorelist[ recname ] = nil
	end
	  
	player.components.builder._CanLearn = player.components.builder.CanLearn
	function player.components.builder:CanLearn( recname )
		local ret = self:_CanLearn(recname)
		return ret and self.ignorelist[ recname ] == nil
	end
	  
	  
	player.components.builder:AddIgnoreRecipe("reviver")
	player.components.builder:AddIgnoreRecipe("resurrectionstatue")
	  
	return player
  
end)
---END RECIPES REMOVE

----BEGIN WILTON CHARACTER ADD

-- changes all wiltonmod speech to normal wilton randomized speech
local oldSpecialChar = GLOBAL.GetSpecialCharacterString
GLOBAL.GetSpecialCharacterString = function(character)
    if character == "WILTONMOD" then
		character = "WILTON"
		return oldSpecialChar (character)
	else
		return oldSpecialChar (character)
	end
end

-- makes wilton unable to be fed by other players
local oldFeed = GLOBAL.ACTIONS.FEEDPLAYER.fn
GLOBAL.ACTIONS.FEEDPLAYER.fn = function(act)
    if act.target.prefab ~= "wiltonmod" then
		return oldFeed (act)
	end
end

-- removes stomach from wilton and listens to continually hide it
local function removeStomachWilton(self, inst)
	if inst and inst.prefab == "wiltonmod" then
		self.brain:SetPosition(self.stomach:GetPosition()) --moves brain to where stomach was
		self.stomach:SetPosition(self.heart:GetPosition()) --moves stomach behind heart, JUST in case?
		inst:DoTaskInTime(1, function() self.stomach:Hide() end)
		
		inst:ListenForEvent("ms_playerspawn", function()
			self.stomach:Hide()
		end)
		
		inst:ListenForEvent("playeractivated", function()
			self.stomach:Hide()
		end)
		
		inst:ListenForEvent("ms_respawnedfromghost", function()
			self.stomach:Hide()
		end)
		
		inst:ListenForEvent("hungerdelta", function()
			self.stomach:Hide()
		end)
	end
end
AddClassPostConstruct("widgets/statusdisplays", removeStomachWilton)

-- telltale heart
local function reviverWilton(inst)
	if not GLOBAL.TheWorld.ismastersim then
		return inst
	end
	
	local function onpickup(inst)
		if inst.beattask ~= nil then
			inst.beattask:Cancel()
			inst.beattask = nil
		end
	end
	
	inst.components.inventoryitem:SetOnPickupFn(function(inst, maker)
		inst.components.inventoryitem:SetOnPickupFn(onpickup)
		onpickup(inst)
		
		if maker.prefab == "wiltonmod" then
			inst.AnimState:SetBank("boneheart")
			inst.AnimState:SetBuild("boneheart")
			inst.AnimState:PlayAnimation("idle")
			
			inst.components.inventoryitem.atlasname = "images/inventoryimages/boneheart.xml"
			inst.components.inventoryitem.imagename = "boneheart"
		end
	end)
end
AddPrefabPostInit("reviver", reviverWilton)

-- causes wilton's skeleton to turn to ash shortly after dying
local function noWiltonSkeleton(inst)
	inst:DoTaskInTime(1, function()
		if inst.char == "wiltonmod" then
			local x, y, z = inst.Transform:GetWorldPosition()
			inst:Remove()
			inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
			GLOBAL.SpawnPrefab("ash").Transform:SetPosition(x, y, z)
			GLOBAL.SpawnPrefab("collapse_small").Transform:SetPosition(x, y, z)
		end
	end)
end
AddPrefabPostInit("skeleton_player", noWiltonSkeleton)

-- adds custom respawn animation to SGwilson
local stateWilton = State{
	name = "wilton_rebirth",
    tags = { "busy", "nopredict", "silentmorph" },
	
	onenter = function(inst)
        inst:ClearBufferedAction()
		
		if inst.components.playercontroller ~= nil then
            inst.components.playercontroller:Enable(false)
        end
		
        inst.AnimState:PlayAnimation("amulet_rebirth")
        --inst.AnimState:OverrideSymbol("FX", "player_amulet_resurrect", "FX")
        inst.components.health:SetInvincible(true)
        inst:ShowHUD(false)
        inst:SetCameraDistance(14)
	end,
	
    timeline =
    {
        TimeEvent(60 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/common/rebirth_amulet_poof")
        end),
    },
	
    events =
    {
        EventHandler("animover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },
		
    onexit = function(inst)
        inst:ShowHUD(true)
        inst:SetCameraDistance()
        if inst.components.playercontroller ~= nil then
            inst.components.playercontroller:Enable(true)
        end
        inst.components.health:SetInvincible(false)
        inst.AnimState:ClearOverrideSymbol("FX")
    end,
}
AddStategraphState("wilson", stateWilton)

-- allows wilton to "possess" a skeleton, not his own, and revive with no penalties
local function possessSkeleton(inst)
	if inst and inst.components and not inst.components.hauntable then
		inst:AddComponent("hauntable")
	end
	
	if inst.components.hauntable.onhaunt then
		local oldhauntSkeleton = inst.components.hauntable.onhaunt
	end

	inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
		if haunter.prefab == "wiltonmod" then
			if inst.char and inst.char == "wiltonmod" then
				return false
			else
				-- if skeleton revive was used, set penalty to 50% hp. usable hp: 50
				haunter.components.health:SetPenalty(0.50)
				haunter.components.health:DoDelta(0)
				haunter.Transform:SetPosition(inst.Transform:GetWorldPosition())
				haunter:PushEvent("respawnfromghost", { source = inst })
				GLOBAL.SpawnPrefab("collapse_big").Transform:SetPosition(inst.Transform:GetWorldPosition())
				inst:DoTaskInTime(1, inst:Remove())
				return true
			end
		elseif oldhauntSkeleton then
			return oldhauntSkeleton(inst, haunter)
		end
	end)
end
if GLOBAL.TheNet:GetServerGameMode() ~= "wilderness" then --don't mess with rez in wilderness since it's disabled
	AddPrefabPostInit("skeleton", possessSkeleton)
	AddPrefabPostInit("skeleton_player", possessSkeleton)
end

-- adds sanity auras to random and player skeletons for Wilton only
local function sanitySkeleton(inst)
	local hasSanityAura = false
	
	if inst and inst.components and not inst.components.sanityaura then
		inst:AddComponent("sanityaura")
	else
		hasSanityAura = true
	end
	
	if inst.components.sanityaura.aurafn then
		local oldSanitySkeleton = inst.components.sanityaura.aurafn
	end

	inst.components.sanityaura.aurafn = function(inst, observer)
		if observer:HasTag("wiltonmod") then
			return TUNING.SANITYAURA_SMALL_TINY
		elseif hasSanityAura then
			return oldSanitySkeleton(inst, observer)
		else
			return 0
		end
	end
end
AddPrefabPostInit("skeleton", sanitySkeleton)
AddPrefabPostInit("skeleton_player", sanitySkeleton)

-- touchstone haunt animation fix. makes haunt unsuccessful for wilton
local function touchstoneWilton (inst)
	if not GLOBAL.TheWorld.ismastersim then
		return inst
	end
	
	local oldhauntStone = inst.components.hauntable.onhaunt
	
	inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
		if haunter.prefab == "wiltonmod" then
			return false
		else
			return oldhauntStone(inst, haunter)
		end
	end)
end
if GLOBAL.TheNet:GetServerGameMode() ~= "wilderness" then --don't mess with rez in wilderness since it's disabled
	AddPrefabPostInit("resurrectionstone", touchstoneWilton)
end

-- prevents wilton from attuning with the meat effigy
local function effigyWilton (inst)
	if not GLOBAL.TheWorld.ismastersim then
		return inst
	end
	
	local oldAttunement = inst.components.attunable.onattunecostfn
	
	inst.components.attunable:SetOnAttuneCostFn(function(inst, player)
		if player.prefab == "wiltonmod" then
			return false
		else
			return oldAttunement(inst, player)
		end
	end)
end
AddPrefabPostInit("resurrectionstatue", effigyWilton)

-- stops all haunt reviving except for multiplayer_portal
local function hauntReviveWilton(self)
	local oldHaunt = self.DoHaunt
	
	self.DoHaunt = function (self, doer)
		if doer.prefab == "wiltonmod" then
			if self.onhaunt ~= nil then
				self.haunted = self.onhaunt(self.inst, doer)
				if self.haunted then
					if doer ~= nil then
						if self.hauntvalue == TUNING.HAUNT_INSTANT_REZ and doer:HasTag("playerghost") and self.inst.prefab == "multiplayer_portal" then
							-- only revive if wilton haunted a portal
							doer:PushEvent("respawnfromghost", { source = self.inst })
						end
						if not self.no_wipe_value then
							self.hauntvalue = nil
						end
					end
					if self.cooldown_on_successful_haunt then
						self.cooldowntimer = self.cooldown or TUNING.HAUNT_COOLDOWN_MEDIUM
						self:StartFX(true)
						self:StartShaderFx()
						self.inst:StartUpdatingComponent(self)
					end
				else
					self.haunted = true
					self.cooldowntimer = self.cooldown or TUNING.HAUNT_COOLDOWN_SMALL
					self:StartFX(true)
					self:StartShaderFx()
					self.inst:StartUpdatingComponent(self)
				end
			end
		else
			oldHaunt(self, doer)
		end
	end
end
if GLOBAL.TheNet:GetServerGameMode() ~= "wilderness" then --don't mess with rez in wilderness since it's disabled
	AddComponentPostInit("hauntable", hauntReviveWilton)
end

-- can eat anything but it just 'falls through stomach'
local function eatWilton(self)
    local oldEat = self.Eat
    
    self.Eat = function(self, food, force)
        if self.inst.prefab == "wiltonmod" then
            self.inst:PushEvent("oneat", {food = food})
            
            if food and food.prefab ~= "wetgoop" then
                local position = self.inst:GetPosition()
                local goop = GLOBAL.SpawnPrefab("wetgoop")
                goop.Transform:SetPosition(position:Get())
            end
            
            if food and food.components.stackable then
                food.components.stackable:Get():Remove()
            else
                food:Remove()
            end
            
            self.lasteattime = GLOBAL.GetTime()
            
            return true
        else
            return oldEat(self, food, force)
        end
    end
end

AddPrefabPostInit("wiltonmod", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end

    local old_eat = inst.components.eater.Eat
    inst.components.eater.Eat = function(self, food, ...)
        return old_eat(self, food, ...) -- Eat the food without any effects
    end
end)

AddComponentPostInit("eater", eatWilton)


AddPrefabPostInit("wiltonmod", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end

    local old_eat = inst.components.eater.Eat
    inst.components.eater.Eat = function(self, food, ...)
        return old_eat(self, food, ...) -- Eat the food without any effects
    end
end)

AddComponentPostInit("eater", eatWilton)


-- doesn't take any penalty from player ghosts
local function sanityWilton (self)
	local oldSanity = self.RecalcGhostDrain
	
	self.RecalcGhostDrain = function (self)
		if self.inst.prefab == "wiltonmod" then
			self.ghost_drain_mult = 0
		else
			oldSanity(self)
		end
	end
end
AddComponentPostInit("sanity", sanityWilton)

-- doesn't take any penalty from digging graves
local function moundWilton (inst)
	if not GLOBAL.TheWorld.ismastersim then
		return inst
	end
	
	local oldMound = inst.components.workable.onfinish
	
	inst.components.workable:SetOnFinishCallback(function(inst, worker)
		if worker.prefab == "wiltonmod" then
			oldMound(inst, worker)
			worker.components.sanity:DoDelta(TUNING.SANITY_SMALL)
		else
			oldMound(inst, worker)
		end
	end)
end
AddPrefabPostInit("mound", moundWilton)

-- changes maxhealer to prevent wiltonmod from using boosters
-- stops all characters other than wiltonmod from using bonepaste and adjusts bonepaste calculations
local function maxhealerWilton (self, target)
	local oldMaxheal = self.Heal
	
	self.Heal = function (self, target)
		if not target:HasTag("playerghost") and self.inst.prefab == "bonepaste" then
			if target.components.health and (target.components.health.penalty > 0 or target.components.health.currenthealth < target.components.health.maxhealth) then
				target.components.health.penalty = math.clamp((target.components.health.penalty + -0.20), 0, 1.00) --heals 20%
				target.components.health:DoDelta(20)
				target.components.health:ForceUpdateHUD()
				
				
				if self.inst.components.stackable and self.inst.components.stackable.stacksize > 1 then
					self.inst.components.stackable:Get():Remove()
				else
					self.inst:Remove()
				end
				return true
			end
		elseif not target:HasTag("playerghost") and self.inst.prefab == "rockygoop" then
			if target.components.health and (target.components.health.penalty > 0 or target.components.health.currenthealth < target.components.health.maxhealth) then
				target.components.health.penalty = math.clamp((target.components.health.penalty + -0.03), 0, 1.00) -- heals 3%
				target.components.health:DoDelta(5)
				target.components.health:ForceUpdateHUD()
				
				if self.inst.components.stackable and self.inst.components.stackable.stacksize > 1 then
					self.inst.components.stackable:Get():Remove()
				else
					self.inst:Remove()
				end
				return true
			end
		elseif target.prefab == "wiltonmod" then
			return false
		elseif self.inst.prefab == "bonepaste" or self.inst.prefab == "rockygoop" then
			return false
		else
			return oldMaxheal(self, target)
		end
	end
end
AddComponentPostInit("maxhealer", maxhealerWilton)

-- Skilltree
--[[ local SkillTreeDefs = require("prefabs/skilltree_defs")
local BuildSkillsData = require("prefabs/skilltree_wilton")

local function CreateSkillTree()
    if BuildSkillsData then
        local data = BuildSkillsData(SkillTreeDefs.FN)

        if data then
            SkillTreeDefs.CreateSkillTreeFor("wiltonmod", data.SKILLS)
            SkillTreeDefs.SKILLTREE_ORDERS["wiltonmod"] = data.ORDERS
            --print("created skilltree")
        end
    end
end ]]


-- Skilltree end


--adds minimap icons
AddMinimapAtlas("images/map_icons/wiltonmod.xml")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("wiltonmod", "NEUTRAL")

----END WILTON CHARACTER ADD