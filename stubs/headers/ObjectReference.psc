; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname ObjectReference extends Form Hidden
bool Function rampRumble(float power = 0.5, float duration = 0.25, float falloff = 1600.0)
EndFunction
bool Function IsNearPlayer()
EndFunction
bool Function IsInInterior()
EndFunction
bool Function MoveToIfUnloaded(ObjectReference akTarget, float afXOffset = 0.0, float afYOffset = 0.0, float afZOffset = 0.0)
EndFunction
Function MoveToWhenUnloaded(ObjectReference akTarget, float afXOffset = 0.0, float afYOffset = 0.0, float afZOffset = 0.0)
EndFunction
Function DeleteWhenAble()
EndFunction
Function AddKeyIfNeeded(ObjectReference ObjectWithNeededKey)
EndFunction
float Property X Auto
float Function get()
EndFunction
float Property Y Auto
float Function get()
EndFunction
float Property Z Auto
float Function get()
EndFunction
bool Function Activate(ObjectReference akActivator, bool abDefaultProcessingOnly = false) Native
bool Function AddDependentAnimatedObjectReference(ObjectReference akDependent) Native
Function AddInventoryEventFilter(Form akFilter) Native
Function AddItem(Form akItemToAdd, int aiCount = 1, bool abSilent = false) Native
Function AddToMap(bool abAllowFastTravel = false) Native
Function ApplyHavokImpulse(float afX, float afY, float afZ, float afMagnitude) Native
Function BlockActivation(bool abBlocked = true) Native
int Function CalculateEncounterLevel(int aiDifficulty = 4) Native
bool Function CanFastTravelToMarker() Native
Function ClearDestruction() Native
Function CreateDetectionEvent(Actor akOwner, int aiSoundLevel = 0) Native
Function DamageObject(float afDamage) Native
Function Delete() Native
Function Disable(bool abFadeOut = false) Native
Function DisableNoWait(bool abFadeOut = false) Native
ObjectReference Function DropObject(Form akObject, int aiCount = 1) Native
Function Enable(bool abFadeIn = false) Native
Function EnableFastTravel(bool abEnable = true) Native
Function EnableNoWait(bool abFadeIn = false) Native
Function ForceAddRagdollToWorld() Native
Function ForceRemoveRagdollFromWorld() Native
ActorBase Function GetActorOwner() Native
float Function GetAngleX() Native
float Function GetAngleY() Native
float Function GetAngleZ() Native
bool Function GetAnimationVariableBool(string arVariableName) Native
int Function GetAnimationVariableInt(string arVariableName) Native
float Function GetAnimationVariableFloat(string arVariableName) Native
Form Function GetBaseObject() Native
int Function GetCurrentDestructionStage() Native
Location Function GetCurrentLocation() Native
Scene Function GetCurrentScene() Native
float Function GetDistance(ObjectReference akOther) Native
Location Function GetEditorLocation() Native
Faction Function GetFactionOwner() Native
float Function GetHeadingAngle(ObjectReference akOther) Native
float Function GetHeight() Native
int Function GetItemCount(Form akItem) Native
float Function GetItemHealthPercent() Native
Key Function GetKey() Native
float Function GetLength() Native
ObjectReference Function GetLinkedRef(Keyword apKeyword = NONE) Native
int Function GetLockLevel() Native
int Function countLinkedRefChain(keyword apKeyword = None, int maxExpectedLinkedRefs = 100)
EndFunction
ObjectReference Function GetNthLinkedRef(int aiLinkedRef) Native
Function EnableLinkChain(Keyword apKeyword = None)
EndFunction
Function DisableLinkChain(Keyword apKeyword = None, bool abFadeOut = false)
EndFunction
float Function GetMass() Native
int Function GetOpenState() Native
Cell Function GetParentCell() Native
float Function GetPositionX() Native
float Function GetPositionY() Native
float Function GetPositionZ() Native
float Function GetScale() Native
int Function GetTriggerObjectCount() Native
VoiceType Function GetVoiceType() Native
float Function GetWidth() Native
WorldSpace Function GetWorldSpace() Native
actor Function GetSelfAsActor()
EndFunction
bool Function HasEffectKeyword(Keyword akKeyword) Native
bool Function HasNode(string asNodeName) Native
bool Function HasRefType(LocationRefType akRefType) Native
Function IgnoreFriendlyHits(bool abIgnore = true) Native
Function InterruptCast() Native
bool Function IsActivateChild(ObjectReference akChild) Native
bool Function IsActivationBlocked() Native
bool Function Is3DLoaded() Native
bool Function IsDeleted() Native
bool Function IsDisabled() Native
bool Function IsEnabled()
EndFunction
bool Function IsFurnitureInUse(bool abIgnoreReserved = false) Native
bool Function IsFurnitureMarkerInUse(int aiMarker, bool abIgnoreReserved = false) Native
bool Function IsIgnoringFriendlyHits() Native
bool Function IsInDialogueWithPlayer() Native
bool Function IsLockBroken() Native
bool Function IsLocked() Native
bool Function IsMapMarkerVisible() Native
Function KnockAreaEffect(float afMagnitude, float afRadius) Native
Function Lock(bool abLock = true, bool abAsOwner = false) Native
Function MoveTo(ObjectReference akTarget, float afXOffset = 0.0, float afYOffset = 0.0, float afZOffset = 0.0, bool abMatchRotation = true) Native
Function MoveToInteractionLocation(ObjectReference akTarget) Native
Function MoveToMyEditorLocation() Native
Function MoveToNode(ObjectReference akTarget, string asNodeName) Native
ObjectReference Function PlaceAtMe(Form akFormToPlace, int aiCount = 1, bool abForcePersist = false, bool abInitiallyDisabled = false) Native
Actor Function PlaceActorAtMe(ActorBase akActorToPlace, int aiLevelMod = 4, EncounterZone akZone = None) Native
bool Function PlayAnimation(string asAnimation) Native
bool Function PlayAnimationAndWait(string asAnimation, string asEventName) Native
bool Function PlayGamebryoAnimation(string asAnimation, bool abStartOver = false, float afEaseInTime = 0.0) Native
bool Function PlayImpactEffect(ImpactDataSet akImpactEffect, string asNodeName = "", float afPickDirX = 0.0, float afPickDirY = 0.0, float afPickDirZ = -1.0, float afPickLength = 512.0, bool abApplyNodeRotation = false, bool abUseNodeLocalRotation = false) Native
bool Function PlaySyncedAnimationSS(string asAnimation1, ObjectReference akObj2, string asAnimation2) Native
bool Function PlaySyncedAnimationAndWaitSS(string asAnimation1, string asEvent1, ObjectReference akObj2, string asAnimation2, string asEvent2) Native
Function PlayTerrainEffect(string asEffectModelName, string asAttachBoneName) Native
Function ProcessTrapHit(ObjectReference akTrap, float afDamage, float afPushback, float afXVel, float afYVel, float afZVel, float afXPos, float afYPos, float afZPos, int aeMaterial, float afStagger) Native
Function PushActorAway(Actor akActorToPush, float aiKnockbackForce) Native
Function RemoveAllInventoryEventFilters() Native
Function RemoveAllItems(ObjectReference akTransferTo = None, bool abKeepOwnership = false, bool abRemoveQuestItems = false) Native
Function RemoveInventoryEventFilter(Form akFilter) Native
Function RemoveItem(Form akItemToRemove, int aiCount = 1, bool abSilent = false, ObjectReference akOtherContainer = None) Native
bool Function RemoveDependentAnimatedObjectReference(ObjectReference akDependent) Native
Function Reset(ObjectReference akTarget = None) Native
Function Say(Topic akTopicToSay, Actor akActorToSpeakAs = None, bool abSpeakInPlayersHead = false) Native
Function SendStealAlarm(Actor akThief) Native
Function SetActorCause(Actor akActor) Native
Function SetActorOwner(ActorBase akActorBase) Native
Function SetAngle(float afXAngle, float afYAngle, float afZAngle) Native
Function SetAnimationVariableBool(string arVariableName, bool abNewValue) Native
Function SetAnimationVariableInt(string arVariableName, int aiNewValue) Native
Function SetAnimationVariableFloat(string arVariableName, float afNewValue) Native
Function SetDestroyed(bool abDestroyed = true) Native
Function SetFactionOwner(Faction akFaction) Native
Function SetLockLevel(int aiLockLevel) Native
Function SetMotionType(int aeMotionType, bool abAllowActivate = true) Native
Function SetNoFavorAllowed(bool abNoFavor = true) Native
Function SetOpen(bool abOpen = true) Native
Function SetPosition(float afX, float afY, float afZ) Native
Function SetScale(float afScale) Native
Function TranslateTo(float afX, float afY, float afZ, float afXAngle, float afYAngle, float afZAngle, float afSpeed, float afMaxRotationSpeed = 0.0) Native
Function SplineTranslateTo(float afX, float afY, float afZ, float afXAngle, float afYAngle, float afZAngle, float afTangentMagnitude, float afSpeed, float afMaxRotationSpeed = 0.0) Native
Function SplineTranslateToRefNode(ObjectReference arTarget, string arNodeName, float afTangentMagnitude, float afSpeed, float afMaxRotationSpeed = 0.0) Native
Function StopTranslation() Native
Function TranslateToRef(ObjectReference arTarget, float afSpeed, float afMaxRotationSpeed = 0.0)
EndFunction
Function SplineTranslateToRef(ObjectReference arTarget, float afTangentMagnitude, float afSpeed, float afMaxRotationSpeed = 0.0)
EndFunction
Function TetherToHorse(ObjectReference akHorse) Native
bool Function WaitForAnimationEvent(string asEventName) Native
bool Function IsInLocation(Location akLocation)
EndFunction
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
Event OnTrigger(ObjectReference akActionRef)
EndEvent
Event OnTriggerEnter(ObjectReference akActionRef)
EndEvent
Event OnTriggerLeave(ObjectReference akActionRef)
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
Event OnTranslationAlmostComplete()
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
Event OnUnequipped(Actor akActor)
EndEvent
Event OnUnload()
EndEvent
Event OnWardHit(ObjectReference akCaster, Spell akSpell, int aiStatus)
EndEvent
int Property Motion_Dynamic Auto
int Property Motion_SphereIntertia Auto
int Property Motion_BoxIntertia Auto
int Property Motion_Keyframed Auto
int Property Motion_Fixed Auto
int Property Motion_ThinBoxIntertia Auto
int Property Motion_Character Auto
Bool Function IsContainerEmpty() Native
Function RemoveAllStolenItems(ObjectReference akTransferTo) Native
Function SetContainerAllowStolenItems(Bool setAllowStolenItems) Native
Int Function GetAllItemsCount() Native
int Function GetNumItems() Native
Form Function GetNthForm(int index) Native
float Function GetTotalItemWeight() Native
float Function GetTotalArmorWeight() Native
bool Function IsHarvested() Native
Function SetHarvested(bool harvested) Native
Function SetItemHealthPercent(float health) Native
Function SetItemMaxCharge(float maxCharge) Native
float Function GetItemMaxCharge() Native
float Function GetItemCharge() Native
Function SetItemCharge(float charge) Native
Function ResetInventory() Native
bool Function IsOffLimits() Native
string Function GetDisplayName() Native
bool Function SetDisplayName(string name, bool force = false) Native
ObjectReference Function GetEnableParent() Native
Enchantment Function GetEnchantment() Native
Function SetEnchantment(Enchantment source, float maxCharge) Native
Function CreateEnchantment(float maxCharge, MagicEffect[] effects, float[] magnitudes, int[] areas, int[] durations) Native
int Function GetNumReferenceAliases() Native
ReferenceAlias Function GetNthReferenceAlias(int n) Native
Potion Function GetPoison() Native
Function GetAllForms(FormList toFill) Native
Form[] Function GetContainerForms() Native
ReferenceAlias[] Function GetReferenceAliases() Native
