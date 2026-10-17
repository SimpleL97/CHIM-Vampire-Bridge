Scriptname COV_Events extends Quest
{CHIM Vampire Bridge by SaurOff - what the CHIM server and the AI agents hear about.
 Comment-worthy events (LLM):
   cov_thrall          someone was bound as a thrall, or released (sent by COV_Thralls)
   cov_vampire_turned  a bitten NPC was not cured in time and became a vampire
 Silent bookkeeping (cov_state, never reaches the LLM):
   config|<json>        the MCM settings the server needs
   vampires|A,B         real game vampires near the player (blood thirst by default)
   lords|A,B            Vampire Lords near the player
   court|A,B            Volkihar nobles near the player (they can enthrall)
   thralls|A=M,B=M      every thrall and their master ("-" for none)
   released|A=M         a thrall set free (remembered for good)
   fed|A                A just drank blood
 Also brings over what CHIM OStim Bridge 1.x kept in a save before the vampire features
 moved here (bitten, turned and thrall NPCs), once.}

bool ready = False
bool configSent = False
int polls = 0
float lastRealTime = 0.0
string lastVampires = ""
string lastLords = ""
string lastCourt = ""

float Property PollSeconds = 3.0 AutoReadOnly Hidden

; ---------------------------------------------------------------- startup

Event OnInit()
	Setup()
	RegisterForSingleUpdate(PollSeconds)
EndEvent

Function Setup()
	ready = True
	Hook()
EndFunction

Function Hook()
	COV_Bridge bridge = Game.GetFormFromFile(0x000800, "CHIMVampireBridge.esp") as COV_Bridge
	If bridge
		bridge.Hook()
	EndIf
EndFunction

; called by COV_MCM when a setting changes, the menu is first built, or a save loads
Function ConfigChanged()
	configSent = False
	lastVampires = ""
	lastLords = ""
	lastCourt = ""
	Hook() ; every game load: mod event registrations added by an update reach existing saves
	; real time restarts with the game: a smaller value than last time means a new game
	; launch, which gets a fresh log file (loading saves within one launch keeps it)
	float now = Utility.GetCurrentRealTime()
	If now < lastRealTime || lastRealTime == 0.0
		COV_Config.NewLog()
	EndIf
	lastRealTime = now
	COV_Config.Log("loaded; settings sent to CHIM on the next poll")
EndFunction

; ---------------------------------------------------------------- polling

Event OnUpdate()
	If !ready
		Setup()
	EndIf
	polls += 1
	If polls == 1 || polls % 100 == 0
		Hook() ; cheap, keeps the registrations alive whatever happens to the save
	EndIf
	lastRealTime = Utility.GetCurrentRealTime()
	If polls == 1
		Migrate()
	EndIf
	If COV_Config.B("bEnabled:General")
		If !configSent
			SendConfig()
			configSent = True
		EndIf
		If polls % 10 == 1
			SendVampires()
			CheckInfected()
		EndIf
	EndIf
	If polls % 10 == 1
		COV_Thralls.UpdatePlayerPower()
	EndIf
	RegisterForSingleUpdate(PollSeconds)
EndEvent

; Real game vampires near the player (Vampire keyword, or turned by an untreated bite),
; Vampire Lords and the Volkihar court. Vampires get blood thirst by default, Lords can
; give their gift, Lords and the court can enthrall; the MCM lists add anyone else.
; Sent only when it changes.
Function SendVampires()
	Keyword kVampire = Game.GetFormFromFile(0x0A82BB, "Skyrim.esm") as Keyword
	Actor p = Game.GetPlayer()
	Actor[] around = MiscUtil.ScanCellNPCs(p, 4000.0)
	string names = ""
	string lords = ""
	string court = ""
	int i = 0
	While i < around.Length
		Actor a = around[i]
		If a && a != p
			bool lord = COV_Config.IsVampireLord(a)
			If lord || (kVampire && a.HasKeyword(kVampire)) || StorageUtil.FormListFind(None, "COV_Turned", a) > -1
				names = Join(names, COV_Config.Name(a.GetDisplayName()))
			EndIf
			If lord
				lords = Join(lords, COV_Config.Name(a.GetDisplayName()))
			ElseIf COV_Config.B("bThrallCourt:Thralls") && COV_Thralls.IsCourt(a)
				court = Join(court, COV_Config.Name(a.GetDisplayName()))
			EndIf
		EndIf
		i += 1
	EndWhile
	If names != lastVampires
		lastVampires = names
		If names != ""
			SendState("vampires|" + names)
		EndIf
	EndIf
	If lords != lastLords
		lastLords = lords
		If lords != ""
			SendState("lords|" + lords)
		EndIf
	EndIf
	If court != lastCourt
		lastCourt = court
		If court != ""
			SendState("court|" + court)
		EndIf
	EndIf
EndFunction

string Function Join(string list, string name)
	If list == ""
		Return name
	EndIf
	Return list + "," + name
EndFunction

; NPCs bitten with the curse on (COV_Bridge.Infect). Cured in time (the disease spell is
; gone) they drop off the list; otherwise after iTurnDays game days they lose the disease
; and count as vampires from then on (COV_Turned): blood thirst and Feed_On_Blood.
; Waits while the MCM option is off.
Function CheckInfected()
	int n = StorageUtil.FormListCount(None, "COV_Infected")
	If n == 0 || !COV_Config.B("bBiteCurse:Vampires")
		Return
	EndIf
	Spell disease = COV_Config.SanguinareVampiris()
	If !disease
		Return
	EndIf
	float days = COV_Config.I("iTurnDays:Vampires") as float
	If days <= 0.0
		days = 3.0
	EndIf
	float now = Utility.GetCurrentGameTime()
	int i = n - 1
	While i >= 0
		Actor a = StorageUtil.FormListGet(None, "COV_Infected", i) as Actor
		If !a || a.IsDead() || !a.HasSpell(disease)
			StorageUtil.FormListRemoveAt(None, "COV_Infected", i)
			If a
				StorageUtil.UnsetFloatValue(a, "COV_InfectedAt")
				COV_Config.Log(a.GetDisplayName() + " is no longer infected")
			EndIf
		ElseIf now - StorageUtil.GetFloatValue(a, "COV_InfectedAt", now) >= days
			StorageUtil.FormListRemoveAt(None, "COV_Infected", i)
			StorageUtil.UnsetFloatValue(a, "COV_InfectedAt")
			a.RemoveSpell(disease)
			StorageUtil.FormListAdd(None, "COV_Turned", a, False)
			string who = COV_Config.Name(a.GetDisplayName())
			SendState("vampires|" + who)
			COV_Config.Note(who + " turned into a vampire")
			AIAgentFunctions.requestMessage("(" + who + " was not cured of Sanguinare Vampiris in time and has now turned into a vampire)", "cov_vampire_turned")
		EndIf
		i -= 1
	EndWhile
EndFunction

; ---------------------------------------------------------------- moving in from CHIM OStim Bridge 1.x

; Until 1.2 CHIM OStim Bridge had the vampire features and kept their NPCs under COB_* keys.
; Once per save they move to this mod's keys; afterwards the old keys are empty.
Function Migrate()
	If StorageUtil.GetIntValue(None, "COV_Migrated") == 1
		Return
	EndIf
	StorageUtil.SetIntValue(None, "COV_Migrated", 1)
	int moved = 0
	int i = StorageUtil.FormListCount(None, "COB_Infected") - 1
	While i >= 0
		Actor a = StorageUtil.FormListGet(None, "COB_Infected", i) as Actor
		If a
			StorageUtil.FormListAdd(None, "COV_Infected", a, False)
			StorageUtil.SetFloatValue(a, "COV_InfectedAt", StorageUtil.GetFloatValue(a, "COB_InfectedAt", Utility.GetCurrentGameTime()))
			StorageUtil.UnsetFloatValue(a, "COB_InfectedAt")
			moved += 1
		EndIf
		i -= 1
	EndWhile
	StorageUtil.FormListClear(None, "COB_Infected")
	i = StorageUtil.FormListCount(None, "COB_Turned") - 1
	While i >= 0
		Actor a = StorageUtil.FormListGet(None, "COB_Turned", i) as Actor
		If a
			StorageUtil.FormListAdd(None, "COV_Turned", a, False)
			moved += 1
		EndIf
		i -= 1
	EndWhile
	StorageUtil.FormListClear(None, "COB_Turned")
	i = StorageUtil.FormListCount(None, "COB_Thralls") - 1
	While i >= 0
		Actor a = StorageUtil.FormListGet(None, "COB_Thralls", i) as Actor
		If a
			StorageUtil.FormListAdd(None, "COV_Thralls", a, False)
			StorageUtil.SetStringValue(a, "COV_ThrallMaster", StorageUtil.GetStringValue(a, "COB_ThrallMaster"))
			StorageUtil.SetFloatValue(a, "COV_ThrallAggression", StorageUtil.GetFloatValue(a, "COB_ThrallAggression", a.GetBaseActorValue("Aggression")))
			StorageUtil.SetIntValue(a, "COV_ThrallTeammate", StorageUtil.GetIntValue(a, "COB_ThrallTeammate"))
			StorageUtil.SetIntValue(a, "COV_Protected", StorageUtil.GetIntValue(a, "COB_Protected"))
			StorageUtil.UnsetStringValue(a, "COB_ThrallMaster")
			StorageUtil.UnsetFloatValue(a, "COB_ThrallAggression")
			StorageUtil.UnsetIntValue(a, "COB_ThrallTeammate")
			StorageUtil.UnsetIntValue(a, "COB_Protected")
			moved += 1
		EndIf
		i -= 1
	EndWhile
	StorageUtil.FormListClear(None, "COB_Thralls")
	; the NPC name lists of the old MCM, when this one has none yet
	If COV_Config.S("sVampires:Vampires") == "" && MCM.GetModSettingString("CHIMOStimBridge", "sVampires:Needs") != ""
		MCM.SetModSettingString("CHIMVampireBridge", "sVampires:Vampires", MCM.GetModSettingString("CHIMOStimBridge", "sVampires:Needs"))
	EndIf
	If COV_Config.S("sVampireLords:Vampires") == "" && MCM.GetModSettingString("CHIMOStimBridge", "sVampireLords:Needs") != ""
		MCM.SetModSettingString("CHIMVampireBridge", "sVampireLords:Vampires", MCM.GetModSettingString("CHIMOStimBridge", "sVampireLords:Needs"))
	EndIf
	If moved > 0
		COV_Config.Note("brought over " + moved + " NPCs from CHIM OStim Bridge (bitten, turned, thralls)")
		COV_Thralls.SendThralls()
	EndIf
EndFunction

; ---------------------------------------------------------------- send

Function SendState(string s) Global
	COV_Config.Log("state " + s)
	AIAgentFunctions.requestMessage(s, "cov_state")
EndFunction

; the settings the server side needs, as JSON (names lose any double quotes)
Function SendConfig()
	string j = "{"
	j += "\"version\":\"" + COV_Config.Version() + "\""
	j += ",\"enabled\":" + COV_Config.Bit(COV_Config.B("bEnabled:General"))
	j += ",\"log\":" + COV_Config.Bit(COV_Config.B("bLog:Debug"))
	j += ",\"vampires\":\"" + COV_Config.Clean(COV_Config.S("sVampires:Vampires")) + "\""
	j += ",\"blood_hours\":" + COV_Config.I("iBloodHours:Vampires")
	j += ",\"vampire_lords\":\"" + COV_Config.Clean(COV_Config.S("sVampireLords:Vampires")) + "\""
	j += ",\"lord_gift\":" + COV_Config.Bit(COV_Config.B("bLordGift:Vampires"))
	j += ",\"thralls\":" + COV_Config.Bit(COV_Config.B("bThralls:Thralls"))
	j += ",\"thrall_court\":" + COV_Config.Bit(COV_Config.B("bThrallCourt:Thralls"))
	j += ",\"thrall_masters\":\"" + COV_Config.Clean(COV_Config.S("sThrallMasters:Thralls")) + "\""
	j += "}"
	SendState("config|" + j)
	COV_Thralls.SendThralls() ; the server learns the thralls of this save too
EndFunction
