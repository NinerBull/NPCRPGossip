local addonName, L = ...;
local function defaultFunc(L, key)
 return key;
end
setmetatable(L, {__index=defaultFunc});


L["NPCRPGOSSIP_ADDONNAME"] = "Hidden NPC Gossip Enabler"
L["NPCRPGOSSIP_ADDONNAME_SHORT"] = "Hidden NPC Gossip"
L["NPCRPGOSSIP_SHIFT"] = SHIFT_KEY_TEXT
L["NPCRPGOSSIP_SHIFT_KEY"] = SHIFT_KEY
L["NPCRPGOSSIP_GOSSIP_IS"] = "Gossip text is currently %s."
L["NPCRPGOSSIP_GOSSIP_TYPE_TOGGLE"] = "Type %s to toggle."
L["NPCRPGOSSIP_GOSSIP_CLICK_TOGGLE"] = "Click to toggle."
L["NPCRPGOSSIP_GOSSIP_SHIFT_TEMP"] = "Hold down the %s key when interacting with an NPC to temporarily %s."
L["NPCRPGOSSIP_ENABLE"] = ENABLE
L["NPCRPGOSSIP_ENABLED"] = VIDEO_OPTIONS_ENABLED
L["NPCRPGOSSIP_DISABLE"] = DISABLE
L["NPCRPGOSSIP_DISABLED"] = VIDEO_OPTIONS_DISABLED