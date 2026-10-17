Scriptname COV_EnthrallEffect extends ActiveMagicEffect
{CHIM Vampire Bridge by SaurOff - the player's lesser power "Vampire's Thrall" (on the
 shout key, Z by default): bites the person the player is looking at and binds their
 will (COV_Thralls). Used on one's own thrall it sets them free.}

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Actor player = Game.GetPlayer()
	If akCaster != player
		Return
	EndIf
	Actor target = Game.GetCurrentCrosshairRef() as Actor
	If !target
		Debug.Notification("Look at the one you want to bite")
		Return
	EndIf
	If target.GetDistance(player) > 250.0
		Debug.Notification(target.GetDisplayName() + " is too far away")
		Return
	EndIf
	string result = COV_Thralls.Bite(player, target)
	COV_Config.Log("Vampire's Thrall on " + target.GetDisplayName() + ": " + result)
	If StringUtil.Find(result, "cannot") == 0 || StringUtil.Find(result, "refuses") == 0 || StringUtil.Find(result, "nothing to do") == 0
		Debug.Notification(StringUtil.Substring(result, StringUtil.Find(result, ":") + 2))
	Else
		Debug.Notification(result)
	EndIf
EndEvent
