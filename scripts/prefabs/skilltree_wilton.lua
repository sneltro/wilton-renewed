--[[ local ORDERS =
{
    {"bonerang",           { -214+19   , 176 + 20 }}, --was +30
    {"nercomancy",         { -62+5       , 176 + 30 }},
    {"consumption",           { 66+19     , 176 + 30 }},
    {"allegiance",      { 190       , 176 + 30 }},
}


local H_GAP = 38
local W_GAP = 38
local H_GAP_SMALL = 30
local W_GAP_SMALL = 30
local H_GAP_LARGE = 48
local W_GAP_LARGE = 48

local STORAGEORIGIN_W = -214
local STORAGEORIGIN_H = 160 --was 176
local TAPEORIGIN_W = -56
local STATORIGIN_W = 65.5 --was 66
local AFFINITYORIGIN_W = 190

local function BuildSkillsData(SkillTreeFns)
    local function MakeCleanFreakLock1(pos, connects, opentag)
        return {
            desc = "Increases the damage of your bonerang by 50%",
            {TAPEORIGIN_W,176-H_GAP_SMALL*4},
            group = "bonerang",
            root = true,
            
            connects = connects,
        }
    end

local skills = {}

return {
    SKILLS = skills,
    ORDERS = ORDERS,
}
end

return BuildSkillsData ]]