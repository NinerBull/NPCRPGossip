--[[
========================================
Hidden NPC Gossip Enabler
https://github.com/NinerBull/NPCRPGossip
========================================
]]--

local _, L = ...;

NPCRPGossip = {}

NPCRPGossip.Frame = CreateFrame("Frame")
NPCRPGossip.Frame:RegisterEvent("ADDON_LOADED")
NPCRPGossip.Frame:RegisterEvent("PLAYER_LOGOUT")
NPCRPGossip.Frame:RegisterEvent("MODIFIER_STATE_CHANGED")


NPCRPGossip.TextName = BLUE_FONT_COLOR:WrapTextInColorCode("<" .. L.NPCRPGOSSIP_ADDONNAME .. ">")
NPCRPGossip.TextSlash = BLUE_FONT_COLOR:WrapTextInColorCode("/hiddennpcgossip")
NPCRPGossip.TextShift = BLUE_FONT_COLOR:WrapTextInColorCode(L.NPCRPGOSSIP_SHIFT)



NPCRPGossip.Frame:SetScript("OnEvent", function(self, event, arg1, arg2)

		if event == "ADDON_LOADED" and arg1 == "NPCRPGossip" then
		
			if NPCRPGossip_AccountEnabled == nil then
				-- No value, enable it
				NPCRPGossip_AccountEnabled = true
			end
						
			
			-- Let the user know if it's enabled or not
			if NPCRPGossip_AccountEnabled == true then
				print(NPCRPGossip.TextName .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_IS, GREEN_FONT_COLOR:WrapTextInColorCode(L.NPCRPGOSSIP_ENABLED)) .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_TYPE_TOGGLE, NPCRPGossip.TextSlash))
				print(NPCRPGossip.TextName .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_SHIFT_TEMP, NPCRPGossip.TextShift, L.NPCRPGOSSIP_DISABLE))
			else
				print(NPCRPGossip.TextName .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_IS, RED_FONT_COLOR:WrapTextInColorCode(L.NPCRPGOSSIP_DISABLED)) .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_TYPE_TOGGLE, NPCRPGossip.TextSlash))
				print(NPCRPGossip.TextName .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_SHIFT_TEMP, NPCRPGossip.TextShift, L.NPCRPGOSSIP_ENABLE))
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

function NPCRPGossip.ToggleX()
	if NPCRPGossip_AccountEnabled == true then
		NPCRPGossip_AccountEnabled = false
		print(NPCRPGossip.TextName .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_IS, RED_FONT_COLOR:WrapTextInColorCode(L.NPCRPGOSSIP_DISABLED)) .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_TYPE_TOGGLE, NPCRPGossip.TextSlash))
		print(NPCRPGossip.TextName .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_SHIFT_TEMP, NPCRPGossip.TextShift, L.NPCRPGOSSIP_ENABLE))
	else
		NPCRPGossip_AccountEnabled = true
		
		print(NPCRPGossip.TextName .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_IS, GREEN_FONT_COLOR:WrapTextInColorCode(L.NPCRPGOSSIP_ENABLED)) .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_TYPE_TOGGLE, NPCRPGossip.TextSlash))
		print(NPCRPGossip.TextName .. " " .. string.format(L.NPCRPGOSSIP_GOSSIP_SHIFT_TEMP, NPCRPGossip.TextShift, L.NPCRPGOSSIP_DISABLE))
	end
	
	ForceGossipShiftX = NPCRPGossip_AccountEnabled
end



-- Modifies Blizz's own function: https://warcraft.wiki.gg/wiki/API_C_GossipInfo.ForceGossip
C_GossipInfo.ForceGossip = function()
	return ForceGossipShiftX
end



-- Slash toggle to disable/enable RP Gossip
SLASH_RPGOSSIPTOGGLE1 = "/npcrpgossip"
SLASH_RPGOSSIPTOGGLE2 = "/hiddennpcgossip"
function SlashCmdList.RPGOSSIPTOGGLE(msg)
    NPCRPGossip:ToggleX()
end




--Addon Compartment
if (AddonCompartmentFrame) then

	AddonCompartmentFrame:RegisterAddon({
		text = C_AddOns.GetAddOnMetadata("NPCRPGossip", "Title"),
		icon = C_AddOns.GetAddOnMetadata("NPCRPGossip", "IconTexture"),
		notCheckable = true,
		
		func = function(button)
			NPCRPGossip:ToggleX()
		end,
		
		funcOnEnter = function(button)
			if (not NPCRPGossip.Tooltip) then
				NPCRPGossip.Tooltip = CreateFrame("GameTooltip", "NPCRPGossip.Tooltip_Compartment", UIParent, "GameTooltipTemplate")
			end
			
			NPCRPGossip.Tooltip:SetOwner(button, "ANCHOR_LEFT");
			NPCRPGossip.Tooltip:SetText(L.NPCRPGOSSIP_ADDONNAME)
			NPCRPGossip.Tooltip:AddLine(" ")
			
			if (NPCRPGossip_AccountEnabled == true) then
				NPCRPGossip.Tooltip:AddLine(string.format(L.NPCRPGOSSIP_GOSSIP_IS, GREEN_FONT_COLOR:WrapTextInColorCode(L.NPCRPGOSSIP_ENABLED) ))
			else
				NPCRPGossip.Tooltip:AddLine(string.format(L.NPCRPGOSSIP_GOSSIP_IS, RED_FONT_COLOR:WrapTextInColorCode(L.NPCRPGOSSIP_DISABLED) ))
			end
			
			NPCRPGossip.Tooltip:AddLine(" ")
			NPCRPGossip.Tooltip:AddLine(L.NPCRPGOSSIP_GOSSIP_CLICK_TOGGLE, GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
			
			NPCRPGossip.Tooltip:Show()
		end,
		
		funcOnLeave = function(button)
			NPCRPGossip.Tooltip:Hide()
		end,
	})

end

