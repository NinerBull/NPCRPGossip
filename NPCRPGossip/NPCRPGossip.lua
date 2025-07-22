--[[
========================================
Hidden NPC Gossip Enabler
https://github.com/NinerBull/NPCRPGossip
========================================
]]--
--test

local _, L = ...;

local NPCRPGossip_Frame = CreateFrame("Frame")
NPCRPGossip_Frame:RegisterEvent("ADDON_LOADED")
NPCRPGossip_Frame:RegisterEvent("PLAYER_LOGOUT")
NPCRPGossip_Frame:RegisterEvent("MODIFIER_STATE_CHANGED")


local NPCRPGossip_TextName = BLUE_FONT_COLOR:WrapTextInColorCode("<" .. L.NPCRPGOSSIP_ADDONNAME .. ">")
local NPCRPGossip_TextSlash = BLUE_FONT_COLOR:WrapTextInColorCode("/hiddennpcgossip")
local NPCRPGossip_TextShift = BLUE_FONT_COLOR:WrapTextInColorCode(L.NPCRPGOSSIP_SHIFT)


-- Modifies Blizz's own function: https://warcraft.wiki.gg/wiki/API_C_GossipInfo.ForceGossip
C_GossipInfo.ForceGossip = function()
	return ForceGossipShiftX
end


NPCRPGossip_Frame:SetScript("OnEvent", function(self, event, arg1, arg2)

		if event == "ADDON_LOADED" and arg1 == "NPCRPGossip" then
		
			if NPCRPGossip_AccountEnabled == nil then
				-- No value, enable it
				NPCRPGossip_AccountEnabled = true
			end
						
			
			-- Let the user know if it's enabled or not
			if NPCRPGossip_AccountEnabled == true then
				print(NPCRPGossip_TextName .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_IS, GREEN_FONT_COLOR:WrapTextInColorCode(L.NPCRPGOSSIP_ENABLED)) .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_TYPE_TOGGLE, NPCRPGossip_TextSlash))
				print(NPCRPGossip_TextName .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_SHIFT_TEMP, NPCRPGossip_TextShift, L.NPCRPGOSSIP_DISABLE))
			else
				print(NPCRPGossip_TextName .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_IS, GREEN_FONT_COLOR:WrapTextInColorCode(L.NPCRPGOSSIP_DISABLED)) .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_TYPE_TOGGLE, NPCRPGossip_TextSlash))
				print(NPCRPGossip_TextName .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_SHIFT_TEMP, NPCRPGossip_TextShift, L.NPCRPGOSSIP_ENABLE))
			end
			
			ForceGossipShiftX = NPCRPGossip_AccountEnabled
			
		end
		
		
		if event == "MODIFIER_STATE_CHANGED" then
		
			if (arg1 == "LSHIFT") or (arg1 == "RSHIFT") then
				
				if arg2 == 1 then
					-- SHIFT is pressed
						
					if NPCRPGossip_AccountEnabled == true then
						ForceGossipShiftX = false
					else
						ForceGossipShiftX = true
					end
						
				else
					-- SHIFT was let go 
					ForceGossipShiftX = NPCRPGossip_AccountEnabled
				end
						
			
			end 
		
		end 
		
	
end)






-- Slash toggle to disable/enable RP Gossip
SLASH_RPGOSSIPTOGGLE1 = "/npcrpgossip"
SLASH_RPGOSSIPTOGGLE2 = "/hiddennpcgossip"
function SlashCmdList.RPGOSSIPTOGGLE(msg)
    NPCRPGossip_ToggleX()
end




--Addon Compartment
local NPCRPGossip_Tooltip


function NPCRPGossip_CompartmentClick(addonName, buttonName)
    NPCRPGossip_ToggleX()
end


function NPCRPGossip_CompartmentHover(addonName, buttonName)
	if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
		if (not NPCRPGossip_Tooltip) then
			NPCRPGossip_Tooltip = CreateFrame("GameTooltip", "NPCRPGossip_Tooltip_Compartment", UIParent, "GameTooltipTemplate")
		end
		
		NPCRPGossip_Tooltip:SetOwner(buttonName, "ANCHOR_LEFT");
		NPCRPGossip_Tooltip:SetText(L.NPCRPGOSSIP_ADDONNAME)
		NPCRPGossip_Tooltip:AddLine(" ")
		
		if (NPCRPGossip_AccountEnabled == true) then
			NPCRPGossip_Tooltip:AddLine(string.format(L.NPCRPGOSSIP_GOSSIP_IS, GREEN_FONT_COLOR:WrapTextInColorCode(L.NPCRPGOSSIP_ENABLED) ))
		else
			NPCRPGossip_Tooltip:AddLine(string.format(L.NPCRPGOSSIP_GOSSIP_IS, RED_FONT_COLOR:WrapTextInColorCode(L.NPCRPGOSSIP_DISABLED) ))
		end
		
		NPCRPGossip_Tooltip:AddLine(" ")
		NPCRPGossip_Tooltip:AddLine(L.NPCRPGOSSIP_GOSSIP_CLICK_TOGGLE, GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
		
		NPCRPGossip_Tooltip:Show()
	end
end


function NPCRPGossip_CompartmentLeave(buttonName)
	if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
		NPCRPGossip_Tooltip:Hide()
	end
end


function NPCRPGossip_ToggleX()
	if NPCRPGossip_AccountEnabled == true then
		NPCRPGossip_AccountEnabled = false
		print(NPCRPGossip_TextName .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_IS, GREEN_FONT_COLOR:WrapTextInColorCode(L.NPCRPGOSSIP_DISABLED)) .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_TYPE_TOGGLE, NPCRPGossip_TextSlash))
		print(NPCRPGossip_TextName .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_SHIFT_TEMP, NPCRPGossip_TextShift, L.NPCRPGOSSIP_ENABLE))
	else
		NPCRPGossip_AccountEnabled = true
		
		print(NPCRPGossip_TextName .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_IS, GREEN_FONT_COLOR:WrapTextInColorCode(L.NPCRPGOSSIP_ENABLED)) .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_TYPE_TOGGLE, NPCRPGossip_TextSlash))
		print(NPCRPGossip_TextName .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_SHIFT_TEMP, NPCRPGossip_TextShift, L.NPCRPGOSSIP_DISABLE))
	end
	
	ForceGossipShiftX = NPCRPGossip_AccountEnabled
end

