Scriptname COV_Bridge extends Quest
{CHIM Vampire Bridge by SaurOff - the AI's vampire actions.
 Vampires drink blood (and can pass on Sanguinare Vampiris), Vampire Lords give the player
 their gift, Vampire Lords and the Volkihar court bind thralls, and anyone can have an enemy
 taken alive. CHIM hands the actions over through COV.DispatchExternalCommand, forwarded as
 the mod event "COV_Command" (npc name, command, parameter); CHIM's fallback event
 "CHIM_CommandReceived" is heard too. Parameters come from the server plugin as
 "<agent>~<target>" ("-" for an empty field). Every outcome is reported back to CHIM as a
 "funcret", so the agent knows what really happened.
 Server half: HerikaServer/ext/cov_vampire_bridge.}

; the agent of the last command, in case a parameter carries no name
string LastCommandNpc = ""
string LastCommandKey = ""
float LastCommandTime = -100.0

; ---------------------------------------------------------------- registration

Event OnInit()
	Hook()
	RegisterForSingleUpdate(15.0)
EndEvent

Event OnUpdate()
	; CHIM's SKSE plugin can finish loading after this quest starts
	Hook()
EndEvent

; COV_Events calls this on every game load too, so the registrations reach existing saves
Function Hook()
	RegisterForModEvent("COV_Command", "OnChimCommand")          ; from COV.DispatchExternalCommand
	RegisterForModEvent("CHIM_CommandReceived", "OnChimCommand") ; CHIM's fallback path
EndFunction

; ---------------------------------------------------------------- entry point

Event OnChimCommand(String npcname, String command, String parameter)
	If StringUtil.Find(command, "ExtCmdCOV_") != 0
		Return
	EndIf
	; the same command can come in both ways; act on it once. Real time restarts with
	; the game, so a time from before a restart (now < LastCommandTime) never matches.
	float now = Utility.GetCurrentRealTime()
	String cmdKey = command + "@" + parameter
	If cmdKey == LastCommandKey && now >= LastCommandTime && now - LastCommandTime < 5.0
		Return
	EndIf
	LastCommandKey = cmdKey
	LastCommandTime = now
	LastCommandNpc = npcname
	COV_Config.Log("command " + command + " from " + npcname + ": " + parameter)
	If !COV_Config.B("bEnabled:General")
		Report(command, parameter, "cannot: the CHIM Vampire Bridge is turned off in its MCM")
		Return
	EndIf
	If command == "ExtCmdCOV_Feed"
		Feed(command, parameter)
	ElseIf command == "ExtCmdCOV_VampireLord"
		VampireLordGift(command, parameter)
	ElseIf command == "ExtCmdCOV_Enthrall" || command == "ExtCmdCOV_Release"
		ThrallAction(command, parameter)
	ElseIf command == "ExtCmdCOV_Spare"
		If ArgOf(parameter, 1) == ""
			Report(command, parameter, "cannot: say whom to spare - a name, or women / men")
		Else
			Report(command, parameter, COV_Thralls.Spare(ArgOf(parameter, 1)))
		EndIf
	Else
		Report(command, parameter, "cannot: unknown action")
	EndIf
EndEvent

; ---------------------------------------------------------------- blood

Function Feed(String command, String parameter)
	Actor npc = ResolveInitiator(parameter)
	If !npc
		Report(command, parameter, "cannot feed: the AI agent could not be identified in the game")
		Return
	EndIf
	If !COV_Config.IsVampire(npc)
		Report(command, parameter, "cannot feed: " + npc.GetDisplayName() + " is not a vampire")
		Return
	EndIf
	Actor victim = ResolvePartner(parameter)
	If !victim
		Report(command, parameter, "cannot feed: " + ArgOf(parameter, 1) + " is not here")
		Return
	EndIf
	If victim == npc
		victim = Game.GetPlayer()
	EndIf
	If npc.IsInCombat() || npc.GetCombatState() > 0
		Report(command, parameter, "refuses: there is a fight going on")
		Return
	EndIf
	If COV_Config.InScene(npc)
		Report(command, parameter, "cannot feed: busy in a scene")
		Return
	EndIf
	If npc.GetDistance(victim) > RangeUnits()
		Report(command, parameter, "cannot feed: " + victim.GetDisplayName() + " is too far away")
		Return
	EndIf
	; the action arrives together with the line that announces it: let that line be
	; spoken first, then bite
	WaitUntilSilent(npc)
	If !BringTogether(npc, victim)
		Report(command, parameter, "cannot feed: " + victim.GetDisplayName() + " is too far away")
		Return
	EndIf
	Idle bite = Game.GetFormFromFile(0x00E6A8, "Dawnguard.esm") as Idle ; IdleVampireStandingFeedFront_Loose
	If bite
		npc.PlayIdleWithTarget(bite, victim)
	EndIf
	; a real bite, but never a dangerous one
	If victim.GetActorValuePercentage("Health") > 0.4
		victim.DamageActorValue("Health", victim.GetActorValue("Health") * 0.1)
	EndIf
	COV_Events.SendState("fed|" + COV_Config.Name(npc.GetDisplayName()))
	Report(command, parameter, npc.GetDisplayName() + " feeds on " + victim.GetDisplayName() + "'s blood" + Infect(victim))
EndFunction

; MCM "The bite passes on vampirism": the game's Sanguinare Vampiris, with the chance
; lowered by disease resistance. The player then follows the game's own course (a vampire
; after 3 days unless cured); NPCs are tracked by COV_Events.CheckInfected. Returns the
; text added to the action result, so the AI knows what happened.
String Function Infect(Actor victim)
	If !COV_Config.B("bBiteCurse:Vampires") || COV_Config.IsVampire(victim)
		Return ""
	EndIf
	Spell disease = COV_Config.SanguinareVampiris()
	If !disease || victim.HasSpell(disease)
		Return ""
	EndIf
	float resist = victim.GetActorValue("DiseaseResist")
	If resist >= 100.0
		Return ""
	EndIf
	int chance = COV_Config.I("iCurseChance:Vampires")
	If resist > 0.0
		chance = (chance * (100.0 - resist) / 100.0) as int
	EndIf
	If !COV_Config.Roll(chance)
		Return ""
	EndIf
	victim.AddSpell(disease, False)
	int days = 3
	If victim != Game.GetPlayer()
		days = COV_Config.I("iTurnDays:Vampires")
		If days <= 0
			days = 3
		EndIf
		StorageUtil.FormListAdd(None, "COV_Infected", victim, False)
		StorageUtil.SetFloatValue(victim, "COV_InfectedAt", Utility.GetCurrentGameTime())
	EndIf
	COV_Config.Note(victim.GetDisplayName() + " caught Sanguinare Vampiris")
	Return "; the bite passed on Sanguinare Vampiris: unless " + victim.GetDisplayName() + " is cured within " + days + " days, they will turn into a vampire"
EndFunction

; A Vampire Lord gives the player their blood the way it happens in Dawnguard. The steps
; are those of Dawnguard's DLC1VampireTurnScript.ReceiveHarkonsGift, but the bite is
; played to its end first: there the vampire change starts in the same instant and its
; race swap cuts the bite off (the quest hides that behind a fade to black). After the
; bite: the vanilla vampire change (skipped when the player already is one), the end of
; lycanthropy like in the game, the Vampire Lord power and its perk tree. Player only.
Function VampireLordGift(String command, String parameter)
	Actor npc = ResolveInitiator(parameter)
	If !npc
		Report(command, parameter, "cannot: the AI agent could not be identified in the game")
		Return
	EndIf
	If !COV_Config.B("bLordGift:Vampires")
		Report(command, parameter, "cannot: giving the Vampire Lord gift is turned off in the MCM")
		Return
	EndIf
	If !COV_Config.IsVampireLord(npc)
		Report(command, parameter, "cannot: " + npc.GetDisplayName() + " is not a Vampire Lord")
		Return
	EndIf
	Actor player = Game.GetPlayer()
	Actor target = ResolvePartner(parameter)
	If target && target != player && target != npc
		Report(command, parameter, "cannot: only " + player.GetDisplayName() + " can receive the Vampire Lord gift")
		Return
	EndIf
	Spell lordPower = Game.GetFormFromFile(0x00283B, "Dawnguard.esm") as Spell ; DLC1VampireChange
	Perk lordPerk = Game.GetFormFromFile(0x00588B, "Dawnguard.esm") as Perk ; DLC1VampireTurnPerk
	PlayerVampireQuestScript vampireQuest = Game.GetFormFromFile(0x0EAFD5, "Skyrim.esm") as PlayerVampireQuestScript ; PlayerVampireQuest
	CompanionsHousekeepingScript companions = Game.GetFormFromFile(0x04B2D9, "Skyrim.esm") as CompanionsHousekeepingScript ; C00
	If !lordPower || !vampireQuest
		Report(command, parameter, "cannot: Dawnguard is not loaded")
		Return
	EndIf
	If player.HasSpell(lordPower)
		Report(command, parameter, "cannot: " + player.GetDisplayName() + " already is a Vampire Lord")
		Return
	EndIf
	If npc.IsInCombat() || player.IsInCombat()
		Report(command, parameter, "refuses: there is a fight going on")
		Return
	EndIf
	If COV_Config.InScene(npc) || COV_Config.InScene(player)
		Report(command, parameter, "cannot: busy in a scene")
		Return
	EndIf
	If npc.GetDistance(player) > RangeUnits()
		Report(command, parameter, "cannot: " + player.GetDisplayName() + " is too far away")
		Return
	EndIf
	WaitUntilSilent(npc)
	BringTogether(npc, player)
	Keyword kVampire = Game.GetFormFromFile(0x0A82BB, "Skyrim.esm") as Keyword
	bool wasVampire = kVampire && player.GetRace().HasKeyword(kVampire)
	PlayBite(npc, player)
	If !wasVampire
		vampireQuest.VampireChange(player)
	EndIf
	If companions && companions.PlayerHasBeastBlood
		companions.CurePlayer()
	EndIf
	player.AddSpell(lordPower, True)
	If lordPerk
		player.AddPerk(lordPerk)
	EndIf
	; the gift cures the disease too; nothing left to track
	Spell disease = COV_Config.SanguinareVampiris()
	If disease && player.HasSpell(disease)
		player.RemoveSpell(disease)
	EndIf
	If !player.HasSpell(lordPower)
		Report(command, parameter, "cannot: the gift did not take, " + player.GetDisplayName() + " has no Vampire Lord power")
		Return
	EndIf
	COV_Thralls.UpdatePlayerPower()
	string who = player.GetDisplayName()
	If wasVampire
		; Dawnguard skips the vampire change for someone who already is a vampire
		Report(command, parameter, npc.GetDisplayName() + " gave " + who + " their blood: " + who + " already was a vampire and now is a Vampire Lord too - the Vampire Lord power is in their powers")
	Else
		Report(command, parameter, npc.GetDisplayName() + " gave " + who + " their blood: " + who + " is now a Vampire Lord")
	EndIf
EndFunction

; ---------------------------------------------------------------- thralls

; A Vampire Lord (or Volkihar noble) binds someone's will with a bite (COV_Thralls), or
; sets a thrall free.
Function ThrallAction(String command, String parameter)
	Actor npc = ResolveInitiator(parameter)
	If !npc
		Report(command, parameter, "cannot: the AI agent could not be identified in the game")
		Return
	EndIf
	String name = ArgOf(parameter, 1)
	If name == ""
		Report(command, parameter, "cannot: say who - the target must be named")
		Return
	EndIf
	Actor target = ResolvePartnerName(name)
	If !target || target == Game.GetPlayer()
		Report(command, parameter, "cannot: " + name + " is not here")
		Return
	EndIf
	If command == "ExtCmdCOV_Release"
		If !COV_Thralls.IsThrall(target)
			Report(command, parameter, "nothing to do: " + target.GetDisplayName() + " is nobody's thrall")
			Return
		EndIf
		Report(command, parameter, COV_Thralls.Release(target))
		Return
	EndIf
	If npc.GetDistance(target) > RangeUnits()
		Report(command, parameter, "cannot: " + target.GetDisplayName() + " is too far away")
		Return
	EndIf
	WaitUntilSilent(npc)
	Report(command, parameter, COV_Thralls.Bite(npc, target))
EndFunction

; ---------------------------------------------------------------- the bite

; the vanilla feeding bite, played to its end: third person so it can be seen, weapons
; away (a paired animation does not start otherwise), a few tries while the game is
; still busy, then wait while the two are locked in the synced animation
Function PlayBite(Actor npc, Actor victim)
	Idle bite = Game.GetFormFromFile(0x00E6A8, "Dawnguard.esm") as Idle ; IdleVampireStandingFeedFront_Loose
	If !bite
		Return
	EndIf
	If victim == Game.GetPlayer()
		Game.ForceThirdPerson()
	EndIf
	If victim.IsWeaponDrawn()
		victim.SheatheWeapon()
	EndIf
	If npc.IsWeaponDrawn()
		npc.SheatheWeapon()
	EndIf
	bool started = False
	int tries = 0
	While !started && tries < 8
		started = npc.PlayIdleWithTarget(bite, victim)
		If !started
			Utility.Wait(0.5)
		EndIf
		tries += 1
	EndWhile
	If !started
		COV_Config.Log("the bite animation did not start (" + npc.GetDisplayName() + " -> " + victim.GetDisplayName() + ")")
		Return
	EndIf
	Utility.Wait(1.0)
	float t = 0.0
	While t < 12.0 && (npc.GetAnimationVariableBool("bIsSynced") || victim.GetAnimationVariableBool("bIsSynced"))
		Utility.Wait(0.25)
		t += 0.25
	EndWhile
	If t == 0.0
		Utility.Wait(3.0) ; no sync flag to watch: give the bite its usual length
	EndIf
	Utility.Wait(0.5)
EndFunction

; waits (at most about half a minute) until the agent has finished speaking; the line
; can start a moment after the command arrives, so first give it a chance to begin
Function WaitUntilSilent(Actor npc)
	string n = npc.GetDisplayName()
	float t = 0.0
	While t < 2.0 && AIAgentFunctions.isActorTalking(n) == 0
		Utility.Wait(0.25)
		t += 0.25
	EndWhile
	t = 0.0
	While t < 30.0 && AIAgentFunctions.isActorTalking(n) != 0
		Utility.Wait(0.25)
		t += 0.25
	EndWhile
	Utility.Wait(0.3)
EndFunction

; ---------------------------------------------------------------- helpers

String Function ArgOf(String parameter, Int index)
	String[] parts = StringUtil.Split(parameter, "~")
	If index < 0 || index >= parts.Length
		Return ""
	EndIf
	String v = COV_Config.Trim(parts[index])
	If v == "-" ; the server writes "-" for an empty field so Split never drops it
		Return ""
	EndIf
	Return v
EndFunction

Actor Function ResolveInitiator(String parameter)
	String name = ArgOf(parameter, 0)
	If name == ""
		name = LastCommandNpc
	EndIf
	Actor a = None
	If name != ""
		a = AIAgentFunctions.getAgentByName(name)
	EndIf
	If !a
		a = AIAgentFunctions.getClosestAgent()
	EndIf
	Return a
EndFunction

Actor Function ResolvePartner(String parameter)
	Return ResolvePartnerName(ArgOf(parameter, 1))
EndFunction

; the player, an AI agent, or anyone around by exact name: whom a vampire bites is often
; not an AI agent (a thrall to be, a bandit, a villager)
Actor Function ResolvePartnerName(String name)
	name = COV_Config.Trim(name)
	Actor player = Game.GetPlayer()
	If name == "" || name == "player" || name == "self" || name == player.GetDisplayName()
		Return player
	EndIf
	Actor a = AIAgentFunctions.getAgentByName(name)
	If a
		Return a
	EndIf
	Actor[] around = MiscUtil.ScanCellNPCs(player, RangeUnits())
	Int i = 0
	While i < around.Length
		If around[i] && !around[i].IsDead() && around[i].GetDisplayName() == name
			Return around[i]
		EndIf
		i += 1
	EndWhile
	; a name was given but nobody by that name is here: refuse rather than biting the player
	Return None
EndFunction

float Function RangeUnits()
	float m = COV_Config.F("fRange:General")
	If m <= 0.0
		m = 50.0
	EndIf
	Return m * 70.0 ; about 70 game units per metre
EndFunction

; within range the one who is not the player is placed next to the other
bool Function BringTogether(Actor a, Actor b)
	If a.GetDistance(b) <= 250.0
		Return True
	EndIf
	If a.GetDistance(b) > RangeUnits() || a.GetParentCell() != b.GetParentCell() && a.GetParentCell().IsInterior()
		Return False
	EndIf
	Actor mover = b
	Actor goal = a
	If b == Game.GetPlayer()
		mover = a
		goal = b
	EndIf
	; PathToReference is latent and never returns when the path is blocked or the goal
	; moves, which froze the whole bridge; place them directly instead
	mover.MoveTo(goal, 60.0, 0.0, 0.0)
	Return True
EndFunction

; The result goes back the way CHIM's own actions report theirs: logMessageForActor with
; "funcret" and the agent's name. CHIM keeps the agent's command open until that arrives;
; an unaddressed requestMessage left it open and broke CHIM's command queue.
Function Report(String command, String parameter, String result)
	COV_Config.Note(command + " -> " + result)
	String npc = ArgOf(parameter, 0)
	If npc == ""
		npc = LastCommandNpc
	EndIf
	AIAgentFunctions.logMessageForActor("command@" + command + "@" + parameter + "@" + result, "funcret", npc)
EndFunction
