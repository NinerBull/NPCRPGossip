# NPC RP Gossip Text Re-enabler
An addon for World of Warcraft Dragonflight, WotLK Classic and Classic Era!


## About
This addon will show some hidden dialog for NPCs, which by default is not shown to players if there is only a single dialog option to select e.g. Auctioneers.
Ideal for roleplayers and Immersion!


## Compatibility
* **Dragonflight** - 10.1.0
* **WotLK Classic** - 3.4.1
* **Classic Era** - 1.14.3


## Installation
Download the latest version from one of the places below, and unzip it in your `<warcraft>\<_version_>\Interface\Addons` folder if installing manually.

* [CurseForge](https://www.curseforge.com/wow/addons/npc-rp-gossip)
* [WoWInterface](https://www.wowinterface.com/downloads/info25707-NPCRPGossipTextRe-enabler.html)
* [GitHub](https://github.com/NinerBull/NPCRPGossip/releases/latest)
* Or put `https://github.com/NinerBull/NPCRPGossip` into your favourite Addon Manager


## Configuration
You can toggle on-and-off by using the command `/npcrpgossip` in chat.

Holding down the **SHIFT** key before interacting with an NPC will now temporarily disable/enable the RP Gossip, depending whether you have toggled gossip on or off using the command above.

## Caveats
This addon will break gossip windows during combat, which means it will affect your ability to talk to some NPCs during combat.
This is because some of the gossip interface that this addon affects became Protected at some point after this addon's release, which means addons can't do anything with it during combat.
See: https://www.townlong-yak.com/framexml/30920/UIParent.lua#3185


## Notes
Inspired by Humbugged's thread on MMO-Champ: http://www.mmo-champion.com/threads/1467297-NPC-RP-text!-How-to-enable - only this addon enables the Gossip text upon login.

Note: Not all NPCs have gossip text, and will still go straight to the vendor tab anyway.
