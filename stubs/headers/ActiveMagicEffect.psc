; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname ActiveMagicEffect Hidden
Function AddInventoryEventFilter(Form akFilter) Native
Function Dispel() Native
MagicEffect Function GetBaseObject() Native
Actor Function GetCasterActor() Native
Actor Function GetTargetActor() Native
bool Function RegisterForAnimationEvent(ObjectReference akSender, string asEventName) Native
Function RegisterForLOS(Actor akViewer, ObjectReference akTarget) Native
Function RegisterForSingleLOSGain(Actor akViewer, ObjectReference akTarget) Native
Function RegisterForSingleLOSLost(Actor akViewer, ObjectReference akTarget) Native
Function RegisterForSingleUpdate(float afInterval) Native
Function RegisterForSleep() Native
Function RegisterForTrackedStatsEvent() Native
Function RegisterForUpdate(float afInterval) Native
Function RegisterForUpdateGameTime(float afInterval) Native
Function RegisterForSingleUpdateGameTime(float afInterval) Native
Function RemoveAllInventoryEventFilters() Native
Function RemoveInventoryEventFilter(Form akFilter) Native
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
Event OnEffectStart(Actor akTarget, Actor akCaster)
EndEvent
Event OnEffectFinish(Actor akTarget, Actor akCaster)
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
Event OnActivate(ObjectReference akActionRef)
EndEvent
Event OnAttachedToCell()
EndEvent
Event OnCellAttach()
EndEvent
Event OnCellDetach()
EndEvent
Event OnCellLoad()
EndEvent
Event OnClose(ObjectReference akActionRef)
EndEvent
Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
EndEvent
Event OnDestructionStageChanged(int aiOldStage, int aiCurrentStage)
EndEvent
Event OnDetachedFromCell()
EndEvent
Event OnEquipped(Actor akActor)
EndEvent
Event OnGrab()
EndEvent
Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
EndEvent
Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
EndEvent
Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
EndEvent
Event OnLoad()
EndEvent
Event OnLockStateChanged()
EndEvent
Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
EndEvent
Event OnOpen(ObjectReference akActionRef)
EndEvent
Event OnRaceSwitchComplete()
EndEvent
Event OnRead()
EndEvent
Event OnRelease()
EndEvent
Event OnReset()
EndEvent
Event OnSell(Actor akSeller)
EndEvent
Event OnSpellCast(Form akSpell)
EndEvent
Event OnTranslationComplete()
EndEvent
Event OnTranslationFailed()
EndEvent
Event OnTrapHit(ObjectReference akTarget, float afXVel, float afYVel, float afZVel, float afXPos, float afYPos, float afZPos,  	int aeMaterial, bool abInitialHit, int aeMotionType)
EndEvent
Event OnTrapHitStart(ObjectReference akTarget, float afXVel, float afYVel, float afZVel, float afXPos, float afYPos, float afZPos,  	int aeMaterial, bool abInitialHit, int aeMotionType)
EndEvent
Event OnTrapHitStop(ObjectReference akTarget)
EndEvent
Event OnTrigger(ObjectReference akActionRef)
EndEvent
Event OnTriggerEnter(ObjectReference akActionRef)
EndEvent
Event OnTriggerLeave(ObjectReference akActionRef)
EndEvent
Event OnUnequipped(Actor akActor)
EndEvent
Event OnUnload()
EndEvent
Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
EndEvent
Event OnSit(ObjectReference akFurniture)
EndEvent
Event OnGetUp(ObjectReference akFurniture)
EndEvent
Event OnDeath(Actor akKiller)
EndEvent
Event OnDying(Actor akKiller)
EndEvent
Event OnLocationChange(Location akOldLoc, Location akNewLoc)
EndEvent
Event OnLycanthropyStateChanged(bool abIsWerewolf)
EndEvent
Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
EndEvent
Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
EndEvent
Event OnPackageStart(Package akNewPackage)
EndEvent
Event OnPackageChange(Package akOldPackage)
EndEvent
Event OnPackageEnd(Package akOldPackage)
EndEvent
Event OnWardHit(ObjectReference akCaster, Spell akSpell, int aiStatus)
EndEvent
Event OnPlayerBowShot(Weapon akWeapon, Ammo akAmmo, float afPower, bool abSunGazing)
EndEvent
Event OnPlayerFastTravelEnd(float afTravelGameTimeHours)
EndEvent
Event OnPlayerLoadGame()
EndEvent
Event OnVampireFeed(Actor akTarget)
EndEvent
Event OnVampirismStateChanged(bool abIsVampire)
EndEvent
float Function GetDuration() Native
float Function GetTimeElapsed() Native
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
float Function GetMagnitude() Native
