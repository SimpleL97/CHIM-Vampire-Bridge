Scriptname COV_Service Hidden
{CHIM Vampire Bridge by SaurOff - thralls at work, and a Vampire Lord's own form.
 Thrall_Task (MCM bTasks:Thralls): a thread of the thrall's day set by its master or itself.
   follow / stay (also "guard"): a package override (PapyrusUtil ActorUtil) over the thrall's
     own packages - Skyrim's DefaultFollowPlayer (0x04B037) or DefaultSandboxCurrentLocation1024
     (0x0BFB6B, they keep to where they are now); "free" takes it off again. Kept in
     StorageUtil "COV_ThrallTask"; Release and the end of the bond take it off too.
   serve: a meal and a drink brought to the player. carry: the thrall's inventory opens.
 Take_Vampire_Lord_Form (MCM bLordForm:Vampires): a Vampire Lord takes the form of one
   (Dawnguard's DLC1VampireBeastRace) or leaves it, the race before kept in StorageUtil
   "COV_HumanRace". In a fight a Vampire Lord who follows the player and is hard pressed
   (MCM health) takes it by themselves, and leaves it a little after the fight.}

; ---------------------------------------------------------------- thrall tasks

Package Function FollowPackage() Global
	Return Game.GetFormFromFile(0x04B037, "Skyrim.esm") as Package ; DefaultFollowPlayer
EndFunction

Package Function StayPackage() Global
	Return Game.GetFormFromFile(0x0BFB6B, "Skyrim.esm") as Package ; DefaultSandboxCurrentLocation1024
EndFunction

; the task asked for, in one word ("" = not known)
string Function TaskWord(string what) Global
	string w = what
	If StringUtil.Find(w, "follow") > -1 || StringUtil.Find(w, "come") > -1
		Return "follow"
	ElseIf StringUtil.Find(w, "guard") > -1
		Return "guard"
	ElseIf StringUtil.Find(w, "stay") > -1 || StringUtil.Find(w, "wait") > -1
		Return "stay"
	ElseIf StringUtil.Find(w, "serve") > -1 || StringUtil.Find(w, "food") > -1 || StringUtil.Find(w, "meal") > -1 || StringUtil.Find(w, "drink") > -1
		Return "serve"
	ElseIf StringUtil.Find(w, "carry") > -1 || StringUtil.Find(w, "inventory") > -1 || StringUtil.Find(w, "items") > -1
		Return "carry"
	ElseIf StringUtil.Find(w, "free") > -1 || StringUtil.Find(w, "own") > -1 || StringUtil.Find(w, "dismiss") > -1
		Return "free"
	EndIf
	Return ""
EndFunction

string Function Task(Actor thrall, string what) Global
	string who = thrall.GetDisplayName()
	Actor p = Game.GetPlayer()
	string task = TaskWord(what)
	If task == ""
		Return "cannot: no such task for a thrall (follow, stay, guard, serve, carry or free)"
	EndIf
	If task == "serve"
		Serve(thrall)
		Return who + " brings " + p.GetDisplayName() + " a meal and a drink"
	ElseIf task == "carry"
		thrall.OpenInventory(True)
		Return who + " holds out what they carry for " + p.GetDisplayName()
	EndIf
	ClearTask(thrall)
	If task == "follow"
		ActorUtil.AddPackageOverride(thrall, FollowPackage(), 90)
		StorageUtil.SetStringValue(thrall, "COV_ThrallTask", task)
		thrall.EvaluatePackage()
		Return who + " follows " + p.GetDisplayName() + " now"
	ElseIf task == "stay" || task == "guard"
		ActorUtil.AddPackageOverride(thrall, StayPackage(), 90)
		StorageUtil.SetStringValue(thrall, "COV_ThrallTask", task)
		thrall.EvaluatePackage()
		If task == "guard"
			Return who + " stays here and guards this place"
		EndIf
		Return who + " stays here"
	EndIf
	thrall.EvaluatePackage()
	Return who + " goes back to their own day"
EndFunction

; takes the standing task off (Release, "free", a new task)
Function ClearTask(Actor thrall) Global
	If StorageUtil.GetStringValue(thrall, "COV_ThrallTask") != ""
		ActorUtil.RemovePackageOverride(thrall, FollowPackage())
		ActorUtil.RemovePackageOverride(thrall, StayPackage())
		StorageUtil.UnsetStringValue(thrall, "COV_ThrallTask")
		thrall.EvaluatePackage()
	EndIf
EndFunction

; a hot dish and a drink from Skyrim's kitchens, handed to the player
Function Serve(Actor thrall) Global
	int[] dishes = new int[5]
	dishes[0] = 0x0F431D ; FoodVenisonStew
	dishes[1] = 0x0F4314 ; FoodBeefStew
	dishes[2] = 0x0F431E ; FoodVegetableSoup
	dishes[3] = 0x0F4315 ; FoodHorkerStew
	dishes[4] = 0x0F4320 ; FoodElsweyrFondue
	int[] drinks = new int[2]
	drinks[0] = 0x034C5D ; FoodMead
	drinks[1] = 0x03133B ; FoodWineAlto
	Actor p = Game.GetPlayer()
	p.AddItem(Game.GetFormFromFile(dishes[Utility.RandomInt(0, dishes.Length - 1)], "Skyrim.esm"), 1)
	p.AddItem(Game.GetFormFromFile(drinks[Utility.RandomInt(0, drinks.Length - 1)], "Skyrim.esm"), 1)
	p.AddItem(Game.GetFormFromFile(0x065C97, "Skyrim.esm"), 1) ; FoodBread01A
EndFunction

; ---------------------------------------------------------------- the Vampire Lord form

Race Function LordRace() Global
	Return Game.GetFormFromFile(0x00283A, "Dawnguard.esm") as Race ; DLC1VampireBeastRace
EndFunction

bool Function InLordForm(Actor a) Global
	Return a && a.GetRace() == LordRace()
EndFunction

; Can this one take the form at all: a Vampire Lord of Dawnguard or of the MCM list, not the player
bool Function CanTakeLordForm(Actor a) Global
	Return a && a != Game.GetPlayer() && !a.IsDead() && LordRace() && COV_Config.IsVampireLord(a)
EndFunction

string Function TakeLordForm(Actor a, bool byItself = False) Global
	string who = a.GetDisplayName()
	If InLordForm(a)
		Return "nothing to do: " + who + " is in Vampire Lord form already"
	EndIf
	If !CanTakeLordForm(a)
		Return "cannot: only a Vampire Lord takes that form"
	EndIf
	StorageUtil.SetFormValue(a, "COV_HumanRace", a.GetRace())
	StorageUtil.SetIntValue(a, "COV_LordByItself", byItself as int)
	EffectShader glow = Game.GetFormFromFile(0x075272, "Skyrim.esm") as EffectShader
	If glow
		glow.Play(a, 2.0)
	EndIf
	Utility.Wait(0.8)
	a.SetRace(LordRace())
	StorageUtil.FormListAdd(None, "COV_LordForm", a, False)
	COV_Config.Note(who + " takes Vampire Lord form")
	Return who + " takes the form of a Vampire Lord"
EndFunction

string Function LeaveLordForm(Actor a) Global
	string who = a.GetDisplayName()
	Race before = StorageUtil.GetFormValue(a, "COV_HumanRace") as Race
	If !InLordForm(a) || !before
		StorageUtil.FormListRemove(None, "COV_LordForm", a, True)
		Return "nothing to do: " + who + " is not in Vampire Lord form"
	EndIf
	EffectShader glow = Game.GetFormFromFile(0x075272, "Skyrim.esm") as EffectShader
	If glow
		glow.Play(a, 2.0)
	EndIf
	Utility.Wait(0.8)
	a.SetRace(before)
	a.QueueNiNodeUpdate()
	StorageUtil.UnsetFormValue(a, "COV_HumanRace")
	StorageUtil.UnsetIntValue(a, "COV_LordByItself")
	StorageUtil.UnsetFloatValue(a, "COV_LordCalm")
	StorageUtil.FormListRemove(None, "COV_LordForm", a, True)
	COV_Config.Note(who + " leaves Vampire Lord form")
	Return who + " takes their own form again"
EndFunction

; every poll in a fight (MCM bLordForm, iLordFormHealth): a Vampire Lord near the player who
; fights at the player's side and is hard pressed takes the form; one who took it by itself
; leaves it 15 s after the fight
Function CombatForms() Global
	If !COV_Config.B("bLordForm:Vampires") || !LordRace()
		Return
	EndIf
	Actor p = Game.GetPlayer()
	float limit = COV_Config.I("iLordFormHealth:Vampires") / 100.0
	If p.IsInCombat()
		Actor[] around = MiscUtil.ScanCellNPCs(p, 3000.0)
		int i = 0
		While i < around.Length
			Actor a = around[i]
			If a && a.IsPlayerTeammate() && a.IsInCombat() && !InLordForm(a) && a.GetActorValuePercentage("Health") <= limit && CanTakeLordForm(a)
				TakeLordForm(a, True)
			EndIf
			i += 1
		EndWhile
	EndIf
	float now = Utility.GetCurrentRealTime()
	int j = StorageUtil.FormListCount(None, "COV_LordForm")
	While j > 0
		j -= 1
		Actor b = StorageUtil.FormListGet(None, "COV_LordForm", j) as Actor
		If !b || !InLordForm(b)
			StorageUtil.FormListRemoveAt(None, "COV_LordForm", j)
		ElseIf StorageUtil.GetIntValue(b, "COV_LordByItself") == 1
			If b.IsInCombat() || p.IsInCombat()
				StorageUtil.UnsetFloatValue(b, "COV_LordCalm")
			Else
				float calm = StorageUtil.GetFloatValue(b, "COV_LordCalm", -1.0)
				If calm < 0.0 || calm > now
					StorageUtil.SetFloatValue(b, "COV_LordCalm", now)
				ElseIf now - calm >= 15.0
					LeaveLordForm(b)
				EndIf
			EndIf
		EndIf
	EndWhile
EndFunction
