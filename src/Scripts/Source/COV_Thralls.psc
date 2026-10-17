Scriptname COV_Thralls Hidden
{CHIM Vampire Bridge by SaurOff - thralls.
 A Vampire Lord (an AI agent, or the player once they are one), a noble of the Volkihar
 court or anyone named in the MCM bites someone who is not of the ancient blood - ordinary
 vampires included - and binds their will: from then on they obey their master and the
 player in everything (the CHIM server tells them so), are on the player's side and never
 turn hostile. The same bite on one's own thrall sets them free. Shared by COV_Bridge
 (the AI actions Enthrall / Release_Thrall / Spare) and COV_EnthrallEffect (the player's
 lesser power "Vampire's Thrall").
 Kept in StorageUtil: form list "COV_Thralls", per thrall "COV_ThrallMaster" (name),
 "COV_ThrallAggression" (to restore) and "COV_ThrallTeammate". Other mods may read the
 list: CHIM OStim Bridge lets a thrall be undressed and brought into scenes by name.}

bool Function IsThrall(Actor a) Global
	Return a && StorageUtil.FormListFind(None, "COV_Thralls", a) > -1
EndFunction

; who can enthrall: the Vampire Lords (Dawnguard's, see COV_Config.IsVampireLord, and anyone
; listed in the MCM), the Volkihar court (MCM, on by default), the names in the MCM list
; sThrallMasters, and the player once they have Dawnguard's Vampire Lord power
bool Function IsLord(Actor a) Global
	If a == Game.GetPlayer()
		Spell lordPower = Game.GetFormFromFile(0x00283B, "Dawnguard.esm") as Spell ; DLC1VampireChange
		Return lordPower && a.HasSpell(lordPower)
	EndIf
	Return COV_Config.IsVampireLord(a) || IsMaster(a)
EndFunction

; can enthrall without being a Vampire Lord: the Volkihar court, or listed in the MCM
bool Function IsMaster(Actor a) Global
	If !a || a == Game.GetPlayer()
		Return False
	EndIf
	Return COV_Config.InList("sThrallMasters:Thralls", a.GetDisplayName()) || (COV_Config.B("bThrallCourt:Thralls") && IsCourt(a))
EndFunction

; the vampire nobility of Castle Volkihar (everyone in Dawnguard's DLC1VampireFaction):
; not Vampire Lords, but masters of thralls all the same
bool Function IsCourt(Actor a) Global
	Faction court = Game.GetFormFromFile(0x003376, "Dawnguard.esm") as Faction ; DLC1VampireFaction
	Return a && court && a != Game.GetPlayer() && a.IsInFaction(court) && !a.IsDead()
EndFunction

; why master cannot enthrall target right now, or "" when they can
string Function Refusal(Actor master, Actor target) Global
	If !COV_Config.B("bThralls:Thralls")
		Return "cannot: enthralling is turned off in the MCM"
	EndIf
	If !IsLord(master)
		Return "cannot: only a Vampire Lord or a Volkihar noble can enthrall"
	EndIf
	If !target || target == master || target == Game.GetPlayer()
		Return "cannot: nobody to enthrall"
	EndIf
	string who = target.GetDisplayName()
	If target.IsDead() || target.IsChild()
		Return "cannot: " + who + " cannot be enthralled"
	EndIf
	If IsLord(target)
		Return "cannot: " + who + " is of the ancient blood too (a Vampire Lord or Volkihar noble); their will cannot be bound"
	EndIf
	If COV_Config.InScene(master) || COV_Config.InScene(target)
		Return "cannot: busy in a scene"
	EndIf
	Return ""
EndFunction

; the bite, then the thrall (or freedom for one's own thrall). Returns the outcome.
string Function Bite(Actor master, Actor target) Global
	If IsThrall(target)
		If StorageUtil.GetStringValue(target, "COV_ThrallMaster") == master.GetDisplayName() || master == Game.GetPlayer()
			Return Release(target)
		EndIf
		Return "nothing to do: " + target.GetDisplayName() + " already is a thrall of " + StorageUtil.GetStringValue(target, "COV_ThrallMaster")
	EndIf
	string why = Refusal(master, target)
	If why != ""
		Return why
	EndIf
	; an enemy can be enthralled too, even mid-fight: the two stop fighting for the bite
	If master.IsInCombat() || target.IsInCombat()
		Calm(target)
		master.StopCombat()
	EndIf
	COV_Bridge bridge = Game.GetFormFromFile(0x000800, "CHIMVampireBridge.esp") as COV_Bridge
	If bridge
		bridge.BringTogether(master, target)
		bridge.PlayBite(master, target)
	EndIf
	Return Bind(target, master)
EndFunction

; target stops fighting, and so does everyone near the player who was attacking them
Function Calm(Actor target) Global
	target.StopCombat()
	target.StopCombatAlarm()
	Actor[] around = MiscUtil.ScanCellNPCs(Game.GetPlayer(), 4000.0)
	int i = 0
	While i < around.Length
		If around[i] && around[i].GetCombatTarget() == target
			around[i].StopCombat()
		EndIf
		i += 1
	EndWhile
EndFunction

; Keeps someone alive: only the player can kill a protected actor; anyone else only beats
; them down (bleedout). For enemies the player wants to enthrall later.
bool Function Protect(Actor a) Global
	ActorBase b = a.GetLeveledActorBase()
	If !b || b.IsProtected() || b.IsEssential()
		Return False
	EndIf
	b.SetProtected(True)
	StorageUtil.SetIntValue(a, "COV_Protected", 1)
	Return True
EndFunction

Function Unprotect(Actor a) Global
	If StorageUtil.GetIntValue(a, "COV_Protected") == 1
		ActorBase b = a.GetLeveledActorBase()
		If b
			b.SetProtected(False)
		EndIf
		StorageUtil.UnsetIntValue(a, "COV_Protected")
	EndIf
EndFunction

; "Spare": by exact name, or every hostile woman / man near the player
string Function Spare(string what) Global
	Actor p = Game.GetPlayer()
	string w = what
	int sex = -1
	If StringUtil.Find(w, "wom") > -1 || StringUtil.Find(w, "female") > -1 || StringUtil.Find(w, "girl") > -1 || StringUtil.Find(w, "lady") > -1
		sex = 1
	ElseIf w == "men" || w == "man" || StringUtil.Find(w, "male") == 0
		sex = 0
	EndIf
	Actor[] around = MiscUtil.ScanCellNPCs(p, 6000.0)
	string names = ""
	int n = 0
	int i = 0
	While i < around.Length
		Actor a = around[i]
		If a && a != p && !a.IsDead() && !a.IsChild()
			bool pick = False
			If sex >= 0
				pick = a.GetLeveledActorBase().GetSex() == sex && (a.IsHostileToActor(p) || a.IsInCombat())
			Else
				pick = a.GetDisplayName() == what
			EndIf
			If pick
				Protect(a)
				n += 1
				If n <= 4
					If names != ""
						names += ", "
					EndIf
					names += a.GetDisplayName()
				EndIf
			EndIf
		EndIf
		i += 1
	EndWhile
	If n == 0
		Return "cannot: nobody here matches \"" + what + "\""
	EndIf
	Return "spared " + n + " (" + names + "): companions will only beat them down, not kill them"
EndFunction

string Function Bind(Actor target, Actor master) Global
	Actor player = Game.GetPlayer()
	string who = target.GetDisplayName()
	string lord = master.GetDisplayName()
	StorageUtil.FormListAdd(None, "COV_Thralls", target, False)
	StorageUtil.SetStringValue(target, "COV_ThrallMaster", lord)
	StorageUtil.SetFloatValue(target, "COV_ThrallAggression", target.GetBaseActorValue("Aggression"))
	; an enemy leaves the factions that made them one (bandits, hostile clans...), so the
	; player's companions no longer attack them; ordinary people keep theirs
	If target.IsHostileToActor(player) || target.IsInCombat()
		target.RemoveFromAllFactions()
	EndIf
	Calm(target)
	target.SetActorValue("Aggression", 0.0)
	Protect(target) ; a thrall is not killed by a stray blow of the player's companions
	target.SetRelationshipRank(player, 3)
	player.SetRelationshipRank(target, 3)
	If COV_Config.B("bThrallTeammate:Thralls") && !target.IsPlayerTeammate()
		target.SetPlayerTeammate(True)
		StorageUtil.SetIntValue(target, "COV_ThrallTeammate", 1)
	EndIf
	SendThralls()
	string result = who + " is now the thrall of " + lord
	If master != player
		result += " and " + player.GetDisplayName()
	EndIf
	result += ": their will is bound, they obey every order"
	COV_Config.Note(result)
	If COV_Config.B("bEnabled:General")
		AIAgentFunctions.requestMessage("(" + lord + " bit " + who + " and bound their will: " + who + " is now a thrall and obeys " + lord + " and " + player.GetDisplayName() + " in everything)", "cov_thrall")
	EndIf
	Return result
EndFunction

string Function Release(Actor target) Global
	string who = target.GetDisplayName()
	; the server keeps this for good: the freed one remembers having been a thrall
	COV_Events.SendState("released|" + COV_Config.Name(who) + "=" + COV_Config.Name(StorageUtil.GetStringValue(target, "COV_ThrallMaster")))
	StorageUtil.FormListRemove(None, "COV_Thralls", target, True)
	target.SetActorValue("Aggression", StorageUtil.GetFloatValue(target, "COV_ThrallAggression", target.GetBaseActorValue("Aggression")))
	If StorageUtil.GetIntValue(target, "COV_ThrallTeammate") == 1
		target.SetPlayerTeammate(False)
	EndIf
	Unprotect(target)
	StorageUtil.UnsetStringValue(target, "COV_ThrallMaster")
	StorageUtil.UnsetFloatValue(target, "COV_ThrallAggression")
	StorageUtil.UnsetIntValue(target, "COV_ThrallTeammate")
	SendThralls()
	COV_Config.Note(who + " is free again")
	If COV_Config.B("bEnabled:General")
		AIAgentFunctions.requestMessage("(" + who + " was released from the thrall and has their own will again)", "cov_thrall")
	EndIf
	Return who + " is released and has their own will again"
EndFunction

; "thralls|Name=Master,Name2=Master2" (or "thralls|-" when there are none) for the server
Function SendThralls() Global
	string s = ""
	int i = StorageUtil.FormListCount(None, "COV_Thralls") - 1
	While i >= 0
		Actor a = StorageUtil.FormListGet(None, "COV_Thralls", i) as Actor
		If !a || a.IsDead()
			StorageUtil.FormListRemoveAt(None, "COV_Thralls", i)
		Else
			If s != ""
				s += ","
			EndIf
			s += COV_Config.Name(a.GetDisplayName()) + "=" + COV_Config.Name(StorageUtil.GetStringValue(a, "COV_ThrallMaster"))
		EndIf
		i -= 1
	EndWhile
	If s == ""
		s = "-"
	EndIf
	COV_Events.SendState("thralls|" + s)
EndFunction

; the player's lesser power comes with being a Vampire Lord (and goes when they are cured)
Function UpdatePlayerPower() Global
	Actor p = Game.GetPlayer()
	Spell power = Game.GetFormFromFile(0x000804, "CHIMVampireBridge.esp") as Spell ; COV_ThrallPower
	If !power
		Return
	EndIf
	bool want = COV_Config.B("bEnabled:General") && COV_Config.B("bThralls:Thralls") && COV_Config.B("bThrallPower:Thralls") && IsLord(p)
	If want && !p.HasSpell(power)
		p.AddSpell(power, False)
		Debug.Notification("You can bind a mortal's will with a bite: Vampire's Thrall")
		COV_Config.Log("the player got the lesser power Vampire's Thrall")
	ElseIf !want && p.HasSpell(power)
		p.RemoveSpell(power)
		COV_Config.Log("the lesser power Vampire's Thrall was taken away")
	EndIf
EndFunction
