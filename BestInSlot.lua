local LibExtraTip = LibStub("LibExtraTip-1") -- Init LibExtraTip lib

local addonName, addonTable = ...
local iconpath = "Interface\\GLUES\\CHARACTERCREATE\\UI-CharacterCreate-Classes" -- Classes icon path
local iconCutoff = 6

BIS.Class = {}  -- Class Info
BIS.Items = {}  -- BIS item infos

-- Generate the icon offset string
local function iconOffset(col, row)
	local offsetString = (col * 64 + iconCutoff) .. ":" .. ((col + 1) * 64 - iconCutoff)
	return offsetString .. ":" .. (row * 64 + iconCutoff) .. ":" .. ((row + 1) * 64 - iconCutoff)
end

-- Generate BIS Tip Lines
local function buildExtraTip(tooltip, entry)
    local r,g,b = .9,.8,.5
    LibExtraTip:AddLine(tooltip," ",r,g,b,true)
	LibExtraTip:AddLine(tooltip,"# BIS:",r,g,b,true)

	for k, v in pairs(entry) do
		local entry = BIS.Class[k]
		local class = entry.class:upper()
		local color = RAID_CLASS_COLORS[class]
		local coords = CLASS_ICON_TCOORDS[class]
		local classfontstring = "|T" .. iconpath .. ":14:14:::256:256:" .. iconOffset(coords[1] * 4, coords[3] * 4) .. "|t"
		
		LibExtraTip:AddDoubleLine(tooltip, classfontstring .. " " .. entry.class .. " " .. entry.spec .. " " .. entry.comment, v, color.r, color.g, color.b, color.r, color.g, color.b, true)
	end
	
	LibExtraTip:AddLine(tooltip," ",r,g,b,true)
end

-- The callback func when the item tooltip displayed
local function onTooltipSetItem(tooltip, itemLink, quantity)
    if not itemLink then return end
    
	local itemString = string.match(itemLink, "item[%-?%d:]+")
	local itemId = ({ string.split(":", itemString) })[2]

	if BIS.Items[itemId] then
		buildExtraTip(tooltip, BIS.Items[itemId])
	end
end

-- Init a frame to contains the BIS info
local eventframe = CreateFrame("FRAME",addonName.."Events")

-- The event handler
local function onEvent(self,event,arg)
    if event == "PLAYER_ENTERING_WORLD" then
        eventframe:UnregisterEvent("PLAYER_ENTERING_WORLD")

        -- Use LibExtraTip to generate BIS Info
        -- Add a BIS Info tool tip generator
        LibExtraTip:AddCallback({type = "item", callback = onTooltipSetItem, allevents = true})
        -- Add tooltip which want to display info
        LibExtraTip:RegisterTooltip(GameTooltip)
        LibExtraTip:RegisterTooltip(ItemRefTooltip)
    end
end

eventframe:RegisterEvent("PLAYER_ENTERING_WORLD")  -- Regist a handler point when player entering the world
eventframe:SetScript("OnEvent", onEvent)  -- The handler when recieved registed event.

--[[
    Regist the Class info from Data/{Class}.lua
    @class The class name string, e.g "Druid"
    @spec The class readable string, e.g "熊德" / "Druid Tank"
]]--
function BIS:RegisterClass(class, spec)
	if not spec then spec = "" end
	
    local bis = {
		class = class,
		spec = spec
	}
	
	bis.ID = class..spec

    BIS.Class[bis.ID] = bis
    return bis
end

--[[
    Add the BIS Item info with Class info from Data/{Class}.lua
    @bisEntry The class info.
    @ID The BIS gear item ID
    @slot The slot of gear 
    @description The desc whatever you want to add, e.g "不考虑，太特么贵了"
    @phase The gear release phase, e.g "P0, P1"
]]--
function BIS:BISItem(bisEntry, ID, slot, description, phase)
	if not BIS.Items[ID] then
		BIS.Items[ID] = {}
	end

	BIS.Items[ID][bisEntry.ID] = phase
end
