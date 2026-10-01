local TITLE_Y_OFFSET = 30
local Y_TOP = 160

local ORDERS = {{"bonerang", {-170, Y_TOP + TITLE_Y_OFFSET}}, {"consumption", {0, Y_TOP + TITLE_Y_OFFSET}},
                {"resurrection", {170, Y_TOP + TITLE_Y_OFFSET}}}

local function BuildSkillsData(SkillTreeFns)
    local skills = {
        -----------------------------------------------------------------------
        -- BONERANG
        -----------------------------------------------------------------------
        wilton_bonerang_durability = {
            title = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.BONERANG_DURABILITY_TITLE) or
                "Durable Bonerang",
            desc = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.BONERANG_DURABILITY_DESC) or
                "Bonerang lasts 50% longer.",
            icon = "wx78_reduce_break",
            pos = {-170, Y_TOP},
            group = "bonerang",
            tags = {"bonerang"},
            root = true,
            defaultfocus = true,
            connects = {"wilton_bonerang_damage"}
        },
        wilton_bonerang_damage = {
            title = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.BONERANG_DAMAGE_TITLE) or "Heavy Bonerang",
            desc = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.BONERANG_DAMAGE_DESC) or
                "Bonerang deals 33% more damage.",
            icon = "wathgrithr_arsenal_spear_1",
            pos = {-170, Y_TOP - 50},
            group = "bonerang",
            tags = {"bonerang"},
            connects = {"wilton_bonerang_safecatch"}
        },
        wilton_bonerang_safecatch = {
            title = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.BONERANG_SAFECATCH_TITLE) or
                "Cushioned Catch",
            desc = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.BONERANG_SAFECATCH_DESC) or
                "Bonerang won't deal damage on an unsuccessful catch.",
            icon = "wathgrithr_arsenal_shield_1",
            pos = {-170, Y_TOP - 100},
            group = "bonerang",
            tags = {"bonerang"},
            connects = {"wilton_bonerang_double"}
        },
        wilton_bonerang_double = {
            title = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.BONERANG_DOUBLE_TITLE) or
                "Double Bonerang",
            desc = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.BONERANG_DOUBLE_DESC) or
                "Learn to craft the Double Bonerang. Deals 51 damage, auto-catches, and has 100 uses.",
            icon = "wolfgang_dumbbell_throwing_2",
            pos = {-170, Y_TOP - 150},
            group = "bonerang",
            tags = {"bonerang"},
            onactivate = function(inst, fromload)
                inst:AddTag("wilton_double_bonerang")
                if inst.UpdateSkillModifiers then
                    inst:UpdateSkillModifiers()
                end
            end,
            ondeactivate = function(inst, fromload)
                inst:RemoveTag("wilton_double_bonerang")
                if inst.UpdateSkillModifiers then
                    inst:UpdateSkillModifiers()
                end
            end
        },

        -----------------------------------------------------------------------
        -- CONSUMPTION: Food Recycling
        -----------------------------------------------------------------------
        wilton_food_recycling_1 = {
            title = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.FOOD_RECYCLING_1_TITLE) or
                "Mental Stability I",
            desc = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.FOOD_RECYCLING_1_DESC) or
                "Food gives +3 sanity when recycled.",
            icon = "wormwood_moon_cap_eating",
            pos = {-60, Y_TOP},
            group = "consumption",
            tags = {"consumption", "recycling"},
            root = true,
            connects = {"wilton_food_recycling_2", "wilton_food_recycling_3"}
        },
        wilton_food_recycling_2 = {
            title = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.FOOD_RECYCLING_2_TITLE) or
                "Mental Stability II",
            desc = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.FOOD_RECYCLING_2_DESC) or
                "Food gives +5 sanity when recycled. Max sanity is increased to 100. Night doesn't scare you anymore.",
            icon = "wurt_amphibian_sanity_1",
            pos = {-85, Y_TOP - 50},
            group = "consumption",
            tags = {"consumption", "recycling"},
            onactivate = function(inst, fromload)
                if inst.UpdateSkillModifiers then
                    inst:UpdateSkillModifiers()
                end
            end,
            ondeactivate = function(inst, fromload)
                if inst.UpdateSkillModifiers then
                    inst:UpdateSkillModifiers()
                end
            end
        },
        wilton_food_recycling_3 = {
            title = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.FOOD_RECYCLING_3_TITLE) or "Lavish Teeth",
            desc = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.FOOD_RECYCLING_3_DESC) or
                "Recycling food has a chance to drop valuable resources alongside wet goop.",
            icon = "woodie_curse_beaver_1",
            pos = {-35, Y_TOP - 50},
            group = "consumption",
            tags = {"consumption", "recycling"}
        },

        -----------------------------------------------------------------------
        -- CONSUMPTION: Rocky Goop
        -----------------------------------------------------------------------
        wilton_rocky_goop_1 = {
            title = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.ROCKY_GOOP_1_TITLE) or "Dense Goop",
            desc = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.ROCKY_GOOP_1_DESC) or
                "Rocky goop gives more health when used (5 -> 7).",
            icon = "wilson_alchemy_iky_1",
            pos = {15, Y_TOP},
            group = "consumption",
            tags = {"consumption", "rockygoop"},
            root = true,
            connects = {"wilton_rocky_goop_2"}
        },
        wilton_rocky_goop_2 = {
            title = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.ROCKY_GOOP_2_TITLE) or "Mineral Restoration",
            desc = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.ROCKY_GOOP_2_DESC) or
                "Rocky goop also gives max health when used (0 -> 3).",
            icon = "wilson_alchemy_iky_2",
            pos = {15, Y_TOP - 50},
            group = "consumption",
            tags = {"consumption", "rockygoop"}
        },

        -----------------------------------------------------------------------
        -- CONSUMPTION: Bonepaste
        -----------------------------------------------------------------------
        wilton_bonepaste_1 = {
            title = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.BONEPASTE_1_TITLE) or "Thick Bone Paste",
            desc = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.BONEPASTE_1_DESC) or
                "Bonepaste gives 25% more health and max health.",
            icon = "wilson_alchemy_iky_3",
            pos = {65, Y_TOP},
            group = "consumption",
            tags = {"consumption", "bonepaste"},
            root = true,
            connects = {"wilton_bonepaste_2"}
        },
        wilton_bonepaste_2 = {
            title = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.BONEPASTE_2_TITLE) or "Super Bone Glue",
            desc = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.BONEPASTE_2_DESC) or
                "Bonepaste gives 50% more health and max health and is consumed faster.",
            icon = "wurt_amphibian_healing_2",
            pos = {65, Y_TOP - 50},
            group = "consumption",
            tags = {"consumption", "bonepaste"},
            onactivate = function(inst, fromload)
                if inst.UpdateSkillModifiers then
                    inst:UpdateSkillModifiers()
                end
            end,
            ondeactivate = function(inst, fromload)
                if inst.UpdateSkillModifiers then
                    inst:UpdateSkillModifiers()
                end
            end
        },

        -----------------------------------------------------------------------
        -- RESURRECTION
        -----------------------------------------------------------------------
        wilton_resurrection_1 = {
            title = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.RESURRECTION_1_TITLE) or "Solid Reassembly",
            desc = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.RESURRECTION_1_DESC) or
                "You resurrect with 75% of max health.",
            icon = "wx78_ghostrevive_1",
            pos = {170, Y_TOP},
            group = "resurrection",
            tags = {"resurrection"},
            root = true,
            connects = {"wilton_resurrection_2"}
        },
        wilton_resurrection_2 = {
            title = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.RESURRECTION_2_TITLE) or "Pristine Rebirth",
            desc = (STRINGS.SKILLTREE.WILTON and STRINGS.SKILLTREE.WILTON.RESURRECTION_2_DESC) or
                "You resurrect with 100% of max health and sanity.",
            icon = "wx78_ghostrevive_2",
            pos = {170, Y_TOP - 50},
            group = "resurrection",
            tags = {"resurrection"}
        }
    }

    return {
        SKILLS = skills,
        ORDERS = ORDERS
    }
end

return BuildSkillsData
