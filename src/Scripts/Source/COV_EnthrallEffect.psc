Scriptname COV_EnthrallEffect extends ActiveMagicEffect
{CHIM Vampire Bridge by SaurOff - the player's lesser power "Vampire's Thrall" (on the
 shout key, Z by default): raises the dead body the player is looking at as their thrall
 (COV_Thralls.RaiseByPower). The living are not touched by it.}

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Actor player = Game.GetPlayer()
	If akCaster != player
		Return
	EndIf
	Actor target = Game.GetCurrentCrosshairRef() as Actor
	If !target
		Debug.Notification("Look at the dead body you want to raise")
		Return
	EndIf
	If target.GetDistance(player) > 400.0
		Debug.Notification(target.GetDisplayName() + " is too far away")
		Return
	EndIf
	string result = COV_Thralls.RaiseByPower(player, target)
	COV_Config.Log("Vampire's Thrall on " + target.GetDisplayName() + ": " + result)
	If StringUtil.Find(result, "cannot") == 0 || StringUtil.Find(result, "refuses") == 0 || StringUtil.Find(result, "nothing to do") == 0
		Debug.Notification(StringUtil.Substring(result, StringUtil.Find(result, ":") + 2))
	Else
		Debug.Notification(result)
	EndIf
EndEvent
