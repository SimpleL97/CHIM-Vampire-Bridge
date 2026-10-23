;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PRKF_COV_SleepThrallPerk Extends Perk Hidden
{CHIM Vampire Bridge by SaurOff - the perk COV_SleepThrallPerk (0x805): a Vampire Lord
 player who activates a sleeping person gets the choice to make them a thrall, next to
 Feed, the way Skyrim's own VampireFeed perk adds its choice.}

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
string result = COV_Thralls.BindSleeping(akActor, akTargetRef as Actor)
COV_Config.Log("sleeping thrall " + akTargetRef.GetDisplayName() + ": " + result)
If StringUtil.Find(result, "cannot") == 0 || StringUtil.Find(result, "nothing to do") == 0
	Debug.Notification(StringUtil.Substring(result, StringUtil.Find(result, ":") + 2))
Else
	Debug.Notification(result)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
