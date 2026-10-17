Scriptname COV Hidden
{CHIM Vampire Bridge by SaurOff - CHIM's direct entry point for the bridge's actions.
 For a command "ExtCmd<Name>_<Action>" CHIM first calls <Name>.DispatchExternalCommand,
 the way it hands commands to other CHIM plugins; without such a script it falls back to
 the "CHIM_CommandReceived" mod event, a path on which CHIM's command queue broke after the
 first action of a session. This only forwards the command to COV_Bridge through the
 bridge's own mod event, so CHIM's queue is never held up while a bite is played.}

bool Function DispatchExternalCommand(string asNpcName, string asCommand, string asParameter) Global
	int handle = ModEvent.Create("COV_Command")
	If !handle
		Return False
	EndIf
	ModEvent.PushString(handle, asNpcName)
	ModEvent.PushString(handle, asCommand)
	ModEvent.PushString(handle, asParameter)
	ModEvent.Send(handle)
	Return True
EndFunction
