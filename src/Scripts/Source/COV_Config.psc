Scriptname COV_Config Hidden
{CHIM Vampire Bridge by SaurOff - reads the MCM Helper settings (MCM/Config/CHIMVampireBridge),
 and the shared helpers: who is a vampire or a Vampire Lord, notifications and the log file.}

string Function ModName() global
	Return "CHIMVampireBridge"
EndFunction

string Function Version() global
	Return "1.0.0"
EndFunction

bool Function B(string id) global
	Return MCM.GetModSettingBool("CHIMVampireBridge", id)
EndFunction

int Function I(string id) global
	Return MCM.GetModSettingInt("CHIMVampireBridge", id)
EndFunction

float Function F(string id) global
	Return MCM.GetModSettingFloat("CHIMVampireBridge", id)
EndFunction

string Function S(string id) global
	Return MCM.GetModSettingString("CHIMVampireBridge", id)
EndFunction

; is name one of the comma separated names in the setting (Papyrus == ignores case)
bool Function InList(string id, string name) global
	string[] names = StringUtil.Split(S(id), ",")
	int i = 0
	While i < names.Length
		If Trim(names[i]) == name
			Return True
		EndIf
		i += 1
	EndWhile
	Return False
EndFunction

; ---------------------------------------------------------------- who is what

; a real game vampire (Vampire keyword), anyone listed in the MCM, or an NPC this mod
; turned after an untreated bite (StorageUtil list "COV_Turned")
bool Function IsVampire(Actor a) global
	If !a
		Return False
	EndIf
	Keyword kVampire = Game.GetFormFromFile(0x0A82BB, "Skyrim.esm") as Keyword
	If kVampire && a.HasKeyword(kVampire)
		Return True
	EndIf
	If StorageUtil.FormListFind(None, "COV_Turned", a) > -1
		Return True
	EndIf
	Return InList("sVampires:Vampires", a.GetDisplayName()) || IsVampireLord(a)
EndFunction

; Dawnguard's Vampire Lords (the base records below, including the disguised Vampire Lords
; of the radiant quests), anyone in Vampire Lord form right now, and anyone listed in the MCM
bool Function IsVampireLord(Actor a) global
	If !a
		Return False
	EndIf
	If InList("sVampireLords:Vampires", a.GetDisplayName())
		Return True
	EndIf
	If a.GetRace() == Game.GetFormFromFile(0x00283A, "Dawnguard.esm") as Race ; DLC1VampireBeastRace
		Return True
	EndIf
	ActorBase b = a.GetLeveledActorBase()
	If !b
		Return False
	EndIf
	int[] lords = new int[8]
	lords[0] = 0x002B6C ; DLC1Serana
	lords[1] = 0x003BA7 ; DLC1Harkon
	lords[2] = 0x01A93D ; DLC1HarkonCombat
	lords[3] = 0x00EC1C ; DLC1HarkonCombatMelee
	lords[4] = 0x00EC8A ; DLC1HarkonCombatMagic
	lords[5] = 0x00D1BE ; DLC1dunHarkonFontActor
	lords[6] = 0x004208 ; DLC1RadiantDisguisedVampireLord
	lords[7] = 0x003B8B ; DLC1Valerica
	int i = 0
	While i < lords.Length
		If b == Game.GetFormFromFile(lords[i], "Dawnguard.esm")
			Return True
		EndIf
		i += 1
	EndWhile
	Return False
EndFunction

; the game's own vampirism disease
Spell Function SanguinareVampiris() global
	Return Game.GetFormFromFile(0x0B8780, "Skyrim.esm") as Spell ; DiseaseSanguinareVampiris
EndFunction

; Is the actor in an OStim scene? This mod does not need OStim Standalone: without it
; nobody is ever in a scene, and OStim's scripts are never called.
bool Function InScene(Actor a) global
	If !a || !Game.IsPluginInstalled("OStim.esp")
		Return False
	EndIf
	int[] ids = OThread.GetAllThreadIDs()
	int i = 0
	While i < ids.Length
		If OThread.GetActorPosition(ids[i], a) > -1
			Return True
		EndIf
		i += 1
	EndWhile
	Return False
EndFunction

; ---------------------------------------------------------------- text

; CHIM lists the people around as "Name [RefID: FE07FE69]" and the model often copies that
; into a target. NameOf gives the name part; RefActor the actor the RefID points to, which is
; exact even when several NPCs share the name (None without a RefID).
string Function NameOf(string s) global
	int i = StringUtil.Find(s, "[RefID")
	If i > -1
		s = StringUtil.Substring(s, 0, i)
	EndIf
	Return Trim(s)
EndFunction

; the name without any "[...]" after it: CHIM writes NPCs renamed by other mods (Real Names
; and the like) as "Josajeh Rajida [Bandit Defender]", the game name being "Josajeh Rajida"
string Function BareName(string s) global
	s = NameOf(s)
	int i = StringUtil.Find(s, " [")
	If i > 0
		s = StringUtil.Substring(s, 0, i)
	EndIf
	i = StringUtil.Find(s, " (") ; "Inguya (dead)"
	If i > 0
		s = StringUtil.Substring(s, 0, i)
	EndIf
	Return Trim(s)
EndFunction

; does the actor go by this name (either side may carry a "[...]" or a RefID)
bool Function NameIs(Actor a, string name) global
	string d = a.GetDisplayName()
	Return d == name || BareName(d) == BareName(name)
EndFunction

Actor Function RefActor(string s) global
	int i = StringUtil.Find(s, "RefID")
	If i < 0
		Return None
	EndIf
	i += 5
	int n = StringUtil.GetLength(s)
	int id = 0
	int digits = 0
	While i < n && digits < 8
		string c = StringUtil.GetNthChar(s, i)
		int d = StringUtil.Find("0123456789ABCDEFabcdef", c)
		If d > 15
			d -= 6
		EndIf
		If d > -1
			id = Math.LogicalOr(Math.LeftShift(id, 4), d)
			digits += 1
		ElseIf digits > 0
			i = n ; the end of the number
		EndIf
		i += 1
	EndWhile
	If digits == 0
		Return None
	EndIf
	Return Game.GetFormEx(id) as Actor
EndFunction

string Function Trim(string s) global
	While StringUtil.GetLength(s) > 0 && StringUtil.GetNthChar(s, 0) == " "
		s = StringUtil.Substring(s, 1)
	EndWhile
	While StringUtil.GetLength(s) > 0 && StringUtil.GetNthChar(s, StringUtil.GetLength(s) - 1) == " "
		s = StringUtil.Substring(s, 0, StringUtil.GetLength(s) - 1)
	EndWhile
	Return s
EndFunction

; text safe inside the JSON and the "|" / "~" separated lines sent to CHIM
string Function Clean(string s) global
	Return Strip(s, False)
EndFunction

; a name inside the comma separated lists sent to CHIM ("A,B", "A=Master"): also no , or =
string Function Name(string s) global
	Return Strip(s, True)
EndFunction

string Function Strip(string s, bool listItem) global
	string out = ""
	int i = 0
	int n = StringUtil.GetLength(s)
	While i < n
		string c = StringUtil.GetNthChar(s, i)
		If c != "\"" && c != "\\" && c != "|" && c != "~" && !(listItem && (c == "," || c == "="))
			out += c
		EndIf
		i += 1
	EndWhile
	Return out
EndFunction

string Function Bit(bool b) global
	If b
		Return "1"
	EndIf
	Return "0"
EndFunction

; percent chance roll, 0..100
bool Function Roll(int chance) global
	If chance >= 100
		Return True
	EndIf
	If chance <= 0
		Return False
	EndIf
	Return Utility.RandomInt(1, 100) <= chance
EndFunction

; ---------------------------------------------------------------- notifications and log

; something worth knowing: always in the log file (MCM), on screen when notifications are on
Function Note(string msg) global
	Log(msg)
	If B("bNotify:Debug")
		Debug.Notification("COV: " + msg)
	EndIf
EndFunction

; Data/SKSE/Plugins/CHIMVampireBridge.log - one game launch per file (COV_Events starts it)
Function Log(string msg) global
	If B("bLog:Debug")
		MiscUtil.WriteToFile("Data/SKSE/Plugins/CHIMVampireBridge.log", msg + "\n", True, True)
	EndIf
EndFunction

Function NewLog() global
	If B("bLog:Debug")
		MiscUtil.WriteToFile("Data/SKSE/Plugins/CHIMVampireBridge.log", "==== CHIM Vampire Bridge " + Version() + " - game started ====\n", False, True)
	EndIf
EndFunction
