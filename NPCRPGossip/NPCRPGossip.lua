local npcrpframe = CreateFrame("Frame")
npcrpframe:RegisterEvent("ADDON_LOADED")
npcrpframe:RegisterEvent("PLAYER_LOGOUT")
npcrpframe:RegisterEvent("MODIFIER_STATE_CHANGED")


local useNewAPI = true


if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) or (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC) then
	useNewAPI = true
end

if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) or (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC)    then
	useNewAPI = false
end




if (useNewAPI == true) then

	--/Interface/FrameXML/GossipFrameShared.lua
	function GossipFrameSharedMixin:HandleShow()
		
		self.gossipOptions = C_GossipInfo.GetOptions();
		table.sort(self.gossipOptions, GossipOptionSort);
		
		if (ForceGossipShiftX == false) then
			if ( (C_GossipInfo.GetNumAvailableQuests() == 0) and (C_GossipInfo.GetNumActiveQuests()  == 0) and (#self.gossipOptions == 1) and not C_GossipInfo.ForceGossip() ) then
				if (self.gossipOptions and self.gossipOptions[1].selectOptionWhenOnlyOption) then
					C_GossipInfo.SelectOptionByIndex(self.gossipOptions[1].orderIndex);
					return;
				end
			end
		end

		if ( not self:IsShown() ) then
			ShowUIPanel(self);
			if ( not self:IsShown() ) then
				C_GossipInfo.CloseGossip();
				return;
			end
		end
		
	end
		
	
	
else
	ForceGossip = function()
		return ForceGossipShiftX
	end
end


npcrpframe:SetScript("OnEvent", function(self, event, arg1, arg2)


		if event == "ADDON_LOADED" and arg1 == "NPCRPGossip" then
		
			
			if NPCRPGossipEnable == nil then
				-- No value, enable it
				NPCRPGossipEnable = true
			
			end
			
			if NPCRPGossipStoryline == nil then
				NPCRPGossipStoryline = true
			end
			
			
			-- Let the user know if it's enabled or not
			
			if NPCRPGossipEnable == true then
				print("|cffF58CBA<NPC RP Gossip>:|r Gossip Text is |cff00ff00ENABLED!|r Type |cffF58CBA/npcrpgossip|r to toggle.")
				print("|cffF58CBA<NPC RP Gossip>:|r Hold down the |cffF58CBASHIFT|r key when interacting with an NPC to temporarily disable.")
			else
				print("|cffF58CBA<NPC RP Gossip>:|r Gossip Text is |cffff0000DISABLED!|r Type |cffF58CBA/npcrpgossip|r to toggle.")
				print("|cffF58CBA<NPC RP Gossip>:|r Hold down the |cffF58CBASHIFT|r key when interacting with an NPC to temporarily enable.")
			end
			
			ForceGossipShiftX =  NPCRPGossipEnable
			
				
		end
		
		
		if event == "MODIFIER_STATE_CHANGED" then
		
			if (arg1 == "LSHIFT") or (arg1 == "RSHIFT") then
				
				if arg2 == 1 then
					-- SHIFT is pressed
						
					if NPCRPGossipEnable == true then
						ForceGossipShiftX = false
					else
						ForceGossipShiftX = true
					end
						
				else
					-- SHIFT was let go 
					ForceGossipShiftX =  NPCRPGossipEnable
				end
						
			
			end 
		
		end 
		
	
end)

-- Slash toggle to disable/enable RP Gossip
SLASH_RPGOSSIPTOGGLE1 = "/npcrpgossip"
function SlashCmdList.RPGOSSIPTOGGLE(msg)
    NPCRPGossipToggleX()
end

function NPCRPGossip_CompartmentClick(addonName, buttonName)
    NPCRPGossipToggleX()
end

function NPCRPGossipToggleX()
	if NPCRPGossipEnable == true then
		NPCRPGossipEnable = false
		print("|cffF58CBA<NPC RP Gossip>:|r Gossip Text is |cffff0000DISABLED!|r Type |cffF58CBA/npcrpgossip|r to toggle.")
		print("|cffF58CBA<NPC RP Gossip>:|r Hold down the |cffF58CBASHIFT|r key when interacting with an NPC to temporarily enable.")
	else
		NPCRPGossipEnable = true
		print("|cffF58CBA<NPC RP Gossip>:|r Gossip Text is |cff00ff00ENABLED!|r Type |cffF58CBA/npcrpgossip|r to toggle.")
		print("|cffF58CBA<NPC RP Gossip>:|r Hold down the |cffF58CBASHIFT|r key when interacting with an NPC to temporarily disable.")
	end
	
	ForceGossipShiftX =  NPCRPGossipEnable
end
