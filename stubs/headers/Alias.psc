; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname Alias Hidden
Quest Function GetOwningQuest() Native
bool Function RegisterForAnimationEvent(ObjectReference akSender, string asEventName) Native
Function RegisterForLOS(Actor akViewer, ObjectReference akTarget) Native
Function RegisterForSingleLOSGain(Actor akViewer, ObjectReference akTarget) Native
Function RegisterForSingleLOSLost(Actor akViewer, ObjectReference akTarget) Native
Function RegisterForSingleUpdate(float afInterval) Native
Function RegisterForUpdate(float afInterval) Native
Function RegisterForUpdateGameTime(float afInterval) Native
Function RegisterForSingleUpdateGameTime(float afInterval) Native
Function RegisterForSleep() Native
Function RegisterForTrackedStatsEvent() Native
Function StartObjectProfiling() Native
Function StopObjectProfiling() Native
Function UnregisterForLOS(Actor akViewer, ObjectReference akTarget) Native
Function UnregisterForAnimationEvent(ObjectReference akSender, string asEventName) Native
Function UnregisterForSleep() Native
Function UnregisterForTrackedStatsEvent() Native
Function UnregisterForUpdate() Native
Function UnregisterForUpdateGameTime() Native
Event OnAnimationEvent(ObjectReference akSource, string asEventName)
EndEvent
Event OnAnimationEventUnregistered(ObjectReference akSource, string asEventName)
EndEvent
Event OnGainLOS(Actor akViewer, ObjectReference akTarget)
EndEvent
Event OnLostLOS(Actor akViewer, ObjectReference akTarget)
EndEvent
Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
EndEvent
Event OnSleepStop(bool abInterrupted)
EndEvent
Event OnTrackedStatsEvent(string arStatName, int aiStatValue)
EndEvent
Event OnUpdate()
EndEvent
Event OnUpdateGameTime()
EndEvent
string Function GetName() Native
int Function GetID() Native
Function RegisterForKey(int keyCode) Native
Function UnregisterForKey(int keyCode) Native
Function UnregisterForAllKeys() Native
Event OnKeyDown(int keyCode)
EndEvent
Event OnKeyUp(int keyCode, float holdTime)
EndEvent
Function RegisterForControl(string control) Native
Function UnregisterForControl(string control) Native
Function UnregisterForAllControls() Native
Event OnControlDown(string control)
EndEvent
Event OnControlUp(string control, float holdTime)
EndEvent
Function RegisterForMenu(string menuName) Native
Function UnregisterForMenu(string menuName) Native
Function UnregisterForAllMenus() Native
Event OnMenuOpen(string menuName)
EndEvent
Event OnMenuClose(string menuName)
EndEvent
Function RegisterForModEvent(string eventName, string callbackName) Native
Function UnregisterForModEvent(string eventName) Native
Function UnregisterForAllModEvents() Native
Function SendModEvent(string eventName, string strArg = "", float numArg = 0.0) Native
Function RegisterForCameraState() Native
Function UnregisterForCameraState() Native
Event OnPlayerCameraState(int oldState, int newState)
EndEvent
Function RegisterForCrosshairRef() Native
Function UnregisterForCrosshairRef() Native
Event OnCrosshairRefChange(ObjectReference ref)
EndEvent
Function RegisterForActorAction(int actionType) Native
Function UnregisterForActorAction(int actionType) Native
Event OnActorAction(int actionType, Actor akActor, Form source, int slot)
EndEvent
Function RegisterForNiNodeUpdate() Native
Function UnregisterForNiNodeUpdate() Native
Event OnNiNodeUpdate(ObjectReference akActor)
EndEvent
