# Hidden NPC Gossip Enabler
An addon for World of Warcraft - The War Within, Cataclysm Classic and Classic Era!


## About
This addon will show some hidden dialog for NPCs, which by default is not shown to players if there is only a single dialog option to select e.g. Auctioneers.
Ideal for roleplayers and Immersion!


## Compatibility
* **The War Within** - 11.2.0
* **MoP Classic** - 5.5.0
* **Classic Era** - 1.15.7


## Installation
Download the latest version from one of the places below, and unzip it in your `<warcraft>\<_version_>\Interface\Addons` folder if installing manually.

* [CurseForge](https://www.curseforge.com/wow/addons/npc-rp-gossip)
* [WoWInterface](https://www.wowinterface.com/downloads/info25707-NPCRPGossipTextRe-enabler.html)
* [Wago](https://addons.wago.io/addons/npc-rp-gossip)
* [GitHub](https://github.com/NinerBull/NPCRPGossip/releases/latest)
* Or put `https://github.com/NinerBull/NPCRPGossip` into your favourite Addon Manager


## Configuration
You can toggle on-and-off by using the command `/hiddennpcgossip` in chat.

Holding down the **SHIFT** key before interacting with an NPC will now temporarily disable/enable the RP Gossip, depending whether you have toggled gossip on or off using the command above.


## :warning: Caveats
**Gossip Windows will no longer work in combat**, due to a change made in 8.2, which means it will affect your ability to open quest dialogues while in combat with enemies.

This is because showing and hiding UI windows is protected during combat, which includes NPC Gossip windows, that this addon modifies.

Examples: Chess Pieces in Karazhan Chess Event, and Torghast Anima Powers.

See: https://www.townlong-yak.com/framexml/30920/UIParent.lua#3185


## Notes
Inspired by Humbugged's thread on MMO-Champ: http://www.mmo-champion.com/threads/1467297-NPC-RP-text!-How-to-enable - only this addon enables the Gossip text upon login.

Note: Not all NPCs have gossip text, and will still go straight to the vendor tab anyway.

## Translations
* **Russian** by [ZamestoTV](https://github.com/Hubbotu)