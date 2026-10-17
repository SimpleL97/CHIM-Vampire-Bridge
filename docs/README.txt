CHIM Vampire Bridge 1.0.0 by SaurOff
=====================================

Vampires for CHIM AI agents: they drink blood and can pass on vampirism with the
bite, Vampire Lords turn you into a Vampire Lord the way Dawnguard does, and the
Vampire Lords and the Volkihar court bind thralls who obey them and you in
everything. Everything is configured in the MCM.

Until version 1.2 these features were part of my CHIM OStim Bridge; they live here
now. Both mods work on their own and work together (see TOGETHER WITH MY OTHER MODS).


REQUIREMENTS
------------
- Skyrim Special / Anniversary Edition with SKSE64 and Address Library
- Dawnguard (part of every SE/AE install)
- CHIM (AI agents, Nexus 126330), plugin and server (tested with 3.4.2)
- PapyrusUtil SE/AE (Nexus 13048)
- SkyUI (Nexus 12604) and MCM Helper (Nexus 53000)
OStim Standalone is not needed.


INSTALLATION
------------
1. Install with Vortex or MO2 and enable CHIMVampireBridge.esp (ESL flagged, it
   does not use a load order slot). Load order does not matter.
2. Start the CHIM server as usual, then the game. The server side installs itself:
   the mod ships it as Data/CHIM/server-plugins/cov_vampire_bridge/1.0.0.dwpkg, and
   CHIM's game plugin uploads bundled server plugins to its server at startup
   (HerikaServer/ext/cov_vampire_bridge). The five actions are added to CHIM's
   action list on the first request.
3. Load a save. The MCM "CHIM Vampire Bridge" appears after a few seconds.

Coming from CHIM OStim Bridge 1.2 or older: install this mod and update CHIM OStim
Bridge to 2.0. Bitten, turned and thrall NPCs of your save, the vampire state on
the server, and the actions (with the same names) move over by themselves.

If your CHIM version does not install bundled server plugins (SKSE/AIAgent.log has
no "[SERVER_PLUGIN_SYNC] Installed cov_vampire_bridge" line), choose "Manual server
install tools" in the installer and run CHIM Vampire Bridge Server
Tools/Install-ServerPlugin.bat once.

Updating: install the new version; CHIM updates the server side on the next game
start. Uninstalling: run Uninstall-ServerPlugin.bat from the manual tools (removes
the server folder and the five actions), then remove the mod.

The MCM is translated into English, Russian, Ukrainian, German, French, Spanish,
Italian, Polish, Czech, Portuguese, Japanese and Chinese and follows the game
language; other game languages show it in English.


WHAT IT DOES
------------
Actions the AI can use (they show up in CHIM's action list and can be switched off
there like any other action):
  Feed_On_Blood          vampires only (real game vampires, or NPCs you list in
                         the MCM): bite someone present, after finishing the line
                         that announces it. The bite can pass on the game's
                         Sanguinare Vampiris (MCM).
  Turn_Into_Vampire_Lord Vampire Lords only (Dawnguard's own, anyone in Vampire
                         Lord form, or NPCs you list in the MCM): turn you into a
                         Vampire Lord at once, through Dawnguard's own code - the
                         bite, the vampire change, the Vampire Lord power and its
                         perk tree. A werewolf loses lycanthropy, as in the game.
  Enthrall               Vampire Lords and the Volkihar court: bite someone who is
                         not of the ancient blood (ordinary vampires too) and bind
                         their will - the thrall obeys their master and you in
                         everything and is never hostile again. Enemies too, even
                         in the middle of a fight.
  Release_Thrall         set a thrall free; they remember having been a thrall.
  Spare                  keep an enemy alive: companions only beat them down
                         instead of killing them (by name, or "women" / "men").
                         Then a Vampire Lord can make them a thrall.
Once you are a Vampire Lord yourself you get the lesser power "Vampire's Thrall":
equip it like a shout, look at someone close and use it (Z by default) - you bite
them and they become your thrall; used on your own thrall it sets them free.
Who can enthrall (MCM, Thralls): the Vampire Lords, the Volkihar court (a toggle,
on by default) and the names you list under "Can also enthrall".
Every outcome is reported back to CHIM, so a refused action ("there is a fight
going on", "she is not here") is answered in character instead of failing quietly.

Blood thirst: vampires (real game vampires, NPCs turned by a bite, the names in the
MCM) get thirsty, then starving, the longer they go without blood.

Vampirism by bite (can be switched off): whoever a vampire bites catches Sanguinare
Vampiris (chance in the MCM, lowered by disease resistance). Cure it in time (Cure
Disease potion, a shrine) or turn: the player after the game's own 3 days, an NPC
after the days set in the MCM - from then on the mod treats that NPC as a vampire
(blood thirst, can bite). The NPC's race and looks do not change.

Thralls remember: the AI agents who are thralls answer and act as thralls; the
others know who obeys whom; a released thrall remembers what they were made to do.


TOGETHER WITH MY OTHER MODS
---------------------------
Each mod works on its own; installed together they see each other:
- CHIM OStim Bridge (Nexus 194761, github.com/SimpleL97/CHIM-OStim-Bridge): a
  thrall can be undressed, dressed and brought into OStim scenes by name - also a
  thrall who is not an AI agent and cannot answer.
- CHIM ORomance Bridge (github.com/SimpleL97/CHIM-ORomance-Bridge): love, marriage
  and children through ORomance Plus.
What happens in one mod (a thrall bound, an NPC turned, a wedding, a scene) reaches
every AI agent nearby, so they can talk about it.


NOTIFICATIONS AND LOG
---------------------
MCM > General > Debug:
- Show notifications: every action result and every event, in the top left corner.
- Write a log file (on by default): Data/SKSE/Plugins/CHIMVampireBridge.log in the
  game (a new file every time the game starts) and log/cov_vampire_bridge.log on the
  CHIM server. Attach both to a bug report.


COMPATIBILITY
-------------
- Uses its own plugin, scripts (COV_*) and CHIM action codes (ExtCmdCOV_*).
- Do not install it together with other mods that add the same action names to
  CHIM (Feed_On_Blood, Enthrall, ...): the installer skips names already in use and
  logs it. The old ExtCmdCOB_* actions of CHIM OStim Bridge 1.x are taken over.
- Safe to add to an existing save. To remove: uninstall the server plugin first.


CREDITS
-------
CHIM by Dwemer Dynamics, PapyrusUtil by exiledviper and meh321, SkyUI by the SkyUI
team, MCM Helper by Exit-9B, Dawnguard by Bethesda.
