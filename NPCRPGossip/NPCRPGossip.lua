local NPCRPGossip_Frame = CreateFrame("Frame")
NPCRPGossip_Frame:RegisterEvent("ADDON_LOADED")
NPCRPGossip_Frame:RegisterEvent("PLAYER_LOGOUT")
NPCRPGossip_Frame:RegisterEvent("MODIFIER_STATE_CHANGED")


local NPCRPGossip_TextName = BLUE_FONT_COLOR:WrapTextInColorCode("<Hidden NPC Gossip>")
local NPCRPGossip_TextSlash = BLUE_FONT_COLOR:WrapTextInColorCode("/hiddennpcgossip")
local NPCRPGossip_TextShift = BLUE_FONT_COLOR:WrapTextInColorCode("SHIFT")



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
				print(NPCRPGossip_TextName .. " Gossip Text is " .. GREEN_FONT_COLOR:WrapTextInColorCode("Enabled") ..". Type " .. NPCRPGossip_TextSlash .. " to toggle.")
				print(NPCRPGossip_TextName .. " Hold down the " .. NPCRPGossip_TextShift .. " key when interacting with an NPC to temporarily disable.")
			else
				print(NPCRPGossip_TextName .. " Gossip Text is " .. RED_FONT_COLOR:WrapTextInColorCode("Disabled") ..". Type " .. NPCRPGossip_TextSlash .. " to toggle.")
				print(NPCRPGossip_TextName .. " Hold down the " .. NPCRPGossip_TextShift .. " key when interacting with an NPC to temporarily enable.")
			end
			
			ForceGossipShiftX =  NPCRPGossip_AccountEnabled
			
				
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
		NPCRPGossip_Tooltip:SetText("Hidden NPC Gossip Enabler")
		NPCRPGossip_Tooltip:AddLine(" ")
		
		if (NPCRPGossip_AccountEnabled == true) then
			NPCRPGossip_Tooltip:AddLine("Gossip Text is currently " .. GREEN_FONT_COLOR:WrapTextInColorCode("Enabled") .. ".", WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		else
			NPCRPGossip_Tooltip:AddLine("Gossip Text is currently " .. RED_FONT_COLOR:WrapTextInColorCode("Disabled") .. ".", WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		end
		
		NPCRPGossip_Tooltip:AddLine(" ")
		NPCRPGossip_Tooltip:AddLine("Click to toggle.", GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
		
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
		print(NPCRPGossip_TextName .. " Gossip Text is " .. RED_FONT_COLOR:WrapTextInColorCode("Disabled") .. ". Type " .. NPCRPGossip_TextSlash .. " to toggle.")
		print(NPCRPGossip_TextName .. " Hold down the " .. NPCRPGossip_TextShift .. " key when interacting with an NPC to temporarily enable.")
	else
		NPCRPGossip_AccountEnabled = true
		print(NPCRPGossip_TextName .. " Gossip Text is " .. GREEN_FONT_COLOR:WrapTextInColorCode("Enabled") .. ". Type " .. NPCRPGossip_TextSlash .. " to toggle.")
		print(NPCRPGossip_TextName .. " Hold down the " .. NPCRPGossip_TextShift .. " key when interacting with an NPC to temporarily disable.")
	end
	
	ForceGossipShiftX = NPCRPGossip_AccountEnabled
end

