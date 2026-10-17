Scriptname COV_MCM extends MCM_ConfigBase
{CHIM Vampire Bridge by SaurOff - the MCM (MCM Helper reads MCM/Config/CHIMVampireBridge/config.json).
 Any change is pushed to the CHIM server on the next COV_Events poll.}

Event OnConfigInit()
	Push()
EndEvent

Event OnSettingChange(string a_ID)
	Push()
EndEvent

Event OnGameReload()
	parent.OnGameReload()
	Push()
EndEvent

Function Push()
	COV_Events ev = Game.GetFormFromFile(0x000801, "CHIMVampireBridge.esp") as COV_Events
	If ev
		ev.ConfigChanged()
	EndIf
EndFunction
