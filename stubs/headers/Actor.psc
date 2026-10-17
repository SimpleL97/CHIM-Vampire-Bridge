; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname Actor extends ObjectReference Hidden
Function ModFavorPoints(int iFavorPoints = 1)
EndFunction
Function ModFavorPointsWithGlobal(GlobalVariable FavorPointsGlobal)
EndFunction
Function MakePlayerFriend()
EndFunction
Function AddPerk(Perk akPerk) Native
bool Function AddShout(Shout akShout) Native
bool Function AddSpell(Spell akSpell, bool abVerbose=true) Native
Function AllowBleedoutDialogue(bool abCanTalk) Native
Function AllowPCDialogue(bool abTalk) Native
Function AttachAshPile(Form akAshPileBase = None) Native
bool Function CanFlyHere() Native
Function ClearArrested() Native
Function ClearExpressionOverride() Native
Function ClearExtraArrows() Native
Function ClearForcedLandingMarker()
EndFunction
Function ClearKeepOffsetFromActor() Native
Function ClearLookAt() Native
Function DamageActorValue(string asValueName, float afDamage) Native
Function DamageAV(string asValueName, float afDamage)
EndFunction
bool Function Dismount() Native
Function DispelAllSpells() Native
bool Function DispelSpell(Spell akSpell) Native
Function DoCombatSpellApply(Spell akSpell, ObjectReference akTarget) Native
Function EnableAI(bool abEnable = true) Native
Function EndDeferredKill() Native
Function EquipItem(Form akItem, bool abPreventRemoval = false, bool abSilent = false) Native
Function EquipShout(Shout akShout) Native
Function EquipSpell(Spell akSpell, int aiSource) Native
Function EvaluatePackage() Native
Function ForceActorValue(string asValueName, float afNewValue) Native
Function ForceAV(string asValueName, float afNewValue)
EndFunction
ActorBase Function GetActorBase()
EndFunction
float Function GetActorValue(string asValueName) Native
float Function GetActorValueMax(string asValueName) Native
float Function GetActorValuePercentage(string asValueName) Native
float Function GetAV(string asValueName)
EndFunction
float Function GetAVMax(string asValueName)
EndFunction
float Function GetAVPercentage(string asValueName)
EndFunction
float Function GetBaseActorValue(string asValueName) Native
float Function GetBaseAV(string asValueName)
EndFunction
int Function GetBribeAmount() Native
Faction Function GetCrimeFaction() Native
int Function GetCombatState() Native
Actor Function GetCombatTarget() Native
Package Function GetCurrentPackage() Native
Actor Function GetDialogueTarget() Native
Armor Function GetEquippedArmorInSlot(int aiSlot) Native
int Function GetEquippedItemType(int aiHand) Native
Shout Function GetEquippedShout() Native
Weapon Function GetEquippedWeapon(bool abLeftHand = false) Native
Armor Function GetEquippedShield() Native
Spell Function GetEquippedSpell(int aiSource) Native
int Function GetFactionRank(Faction akFaction) Native
int Function GetFactionReaction(Actor akOther) Native
int Function GetFlyingState() Native
ObjectReference Function GetForcedLandingMarker() Native
int Function GetGoldAmount() Native
int Function GetHighestRelationshipRank() Native
Actor Function GetKiller() Native
int Function GetLevel() Native
float Function GetLightLevel() Native
int Function GetLowestRelationshipRank() Native
ActorBase Function GetLeveledActorBase() Native
bool Function GetNoBleedoutRecovery() Native
bool Function GetPlayerControls() Native
Race Function GetRace() Native
int Function GetRelationshipRank(Actor akOther) Native
int Function GetSitState() Native
int Function GetSleepState() Native
float Function GetVoiceRecoveryTime() Native
float Function GetWarmthRating() Native
bool Function HasAssociation(AssociationType akAssociation, Actor akOther = None) Native
bool Function HasFamilyRelationship(Actor akOther = None) Native
bool Function HasLOS(ObjectReference akOther) Native
bool Function HasMagicEffect(MagicEffect akEffect) Native
bool Function HasMagicEffectWithKeyword(Keyword akKeyword) Native
bool Function HasParentRelationship(Actor akOther) Native
bool Function HasPerk(Perk akPerk) Native
bool Function HasSpell(Form akForm) Native
bool Function IsAlarmed() Native
bool Function IsAlerted() Native
bool Function IsAllowedToFly() Native
bool Function IsArrested() Native
bool Function IsArrestingTarget() Native
bool Function IsBeingRidden() Native
bool Function IsBleedingOut() Native
bool Function IsBribed() Native
bool Function IsChild() Native
bool Function IsCommandedActor() Native
bool Function IsDead() Native
bool Function IsDetectedBy(Actor akOther) Native
bool Function IsDoingFavor() Native
bool Function IsEquipped(Form akItem) Native
bool Function IsEssential() Native
bool Function IsFlying() Native
bool Function IsGuard() Native
bool Function IsGhost() Native
bool Function IsHostileToActor(Actor akActor) Native
bool Function IsInCombat() Native
bool Function IsInFaction(Faction akFaction) Native
bool Function IsInKillMove() Native
bool Function IsIntimidated() Native
bool Function IsOnMount() Native
bool Function IsOverEncumbered() Native
bool Function IsPlayersLastRiddenHorse() Native
bool Function IsPlayerTeammate() Native
bool Function IsRunning() Native
bool Function IsSneaking() Native
bool Function IsSprinting() Native
bool Function IsTrespassing() Native
bool Function IsUnconscious() Native
bool Function IsWeaponDrawn() Native
Function KeepOffsetFromActor(Actor arTarget, float afOffsetX, float afOffsetY, float afOffsetZ, float afOffsetAngleX = 0.0,  float afOffsetAngleY = 0.0,  float afOffsetAngleZ = 0.0, float afCatchUpRadius = 20.0, float afFollowRadius = 5.0) Native
Function Kill(Actor akKiller = None) Native
Function KillEssential(Actor akKiller = None)
EndFunction
Function KillSilent(Actor akKiller = None) Native
Function ModActorValue(string asValueName, float afAmount) Native
Function ModAV(string asValueName, float afAmount)
EndFunction
Function ModFactionRank(Faction akFaction, int aiMod) Native
Function MoveToPackageLocation() Native
Function OpenInventory(bool abForceOpen = false) Native
bool Function PathToReference(ObjectReference aTarget, float afWalkRunPercent) Native
bool Function PlayIdle(Idle akIdle) Native
bool Function PlayIdleWithTarget(Idle akIdle, ObjectReference akTarget) Native
Function PlaySubGraphAnimation(string asEventName) Native
Function RemoveFromFaction(Faction akFaction) Native
Function RemoveFromAllFactions() Native
Function RemovePerk(Perk akPerk) Native
bool Function RemoveShout(Shout akShout) Native
bool Function RemoveSpell(Spell akSpell) Native
Function ResetHealthAndLimbs() Native
Function RestoreActorValue(string asValueName, float afAmount) Native
Function Resurrect() Native
Function RestoreAV(string asValueName, float afAmount)
EndFunction
Function SendAssaultAlarm() Native
Function SendLycanthropyStateChanged(bool abIsWerewolf) Native
Function SendTrespassAlarm(Actor akCriminal) Native
Function SendVampirismStateChanged(bool abIsVampire) Native
Function SetActorValue(string asValueName, float afValue) Native
Function SetAlert(bool abAlerted = true) Native
Function SetAllowFlying(bool abAllowed = true) Native
Function SetAllowFlyingEx(bool abAllowed = true, bool abAllowCrash = true, bool abAllowSearch = false) Native
Function SetAlpha(float afTargetAlpha, bool abFade = false) Native
Function SetAttackActorOnSight(bool abAttackOnSight = true) Native
Function SetAV(string asValueName, float afValue)
EndFunction
Function SetBribed(bool abBribe = true) Native
Function SetCrimeFaction(Faction akFaction) Native
Function SetCriticalStage(int aiStage) Native
Function SetDoingFavor(bool abDoingFavor = true) Native
Function SetDontMove(bool abDontMove = true) Native
Function SetExpressionOverride(int aiMood, int aiStrength = 100) Native
Function SetEyeTexture(TextureSet akNewTexture) Native
Function SetFactionRank(Faction akFaction, int aiRank) Native
Function SetForcedLandingMarker(ObjectReference aMarker) Native
Function SetGhost(bool abIsGhost = true) Native
Function AddToFaction(Faction akFaction)
EndFunction
Function SetHeadTracking(bool abEnable = true) Native
Function SetIntimidated(bool abIntimidate = true) Native
Function SetLookAt(ObjectReference akTarget, bool abPathingLookAt = false) Native
Function SetNoBleedoutRecovery(bool abAllowed) Native
Function SetNotShowOnStealthMeter(bool abNotShow) Native
Function SetOutfit(Outfit akOutfit, bool abSleepOutfit = false) Native
Function SetPlayerControls(bool abControls) Native
Function SetPlayerResistingArrest() Native
Function SetPlayerTeammate(bool abTeammate = true, bool abCanDoFavor=true) Native
Function SetRace(Race akRace = None) Native
Function SetRelationshipRank(Actor akOther, int aiRank) Native
Function SetRestrained(bool abRestrained = true) Native
Function SetSubGraphFloatVariable(string asVariableName, float afValue) Native
Function SetUnconscious(bool abUnconscious = true) Native
Function SetVehicle(ObjectReference akVehicle) Native
Function SetVoiceRecoveryTime(float afTime) Native
Function ShowBarterMenu() Native
int Function ShowGiftMenu(bool abGivingGift, FormList apFilterList = None, bool abShowStolenItems = false, bool abUseFavorPoints = true) Native
Function StartCannibal(Actor akTarget) Native
Function StartCombat(Actor akTarget) Native
Function StartDeferredKill() Native
Function StartVampireFeed(Actor akTarget) Native
Function StopCombat() Native
Function StopCombatAlarm() Native
bool Function TrapSoul(Actor akTarget) Native
Function UnequipAll() Native
Function UnequipItem(Form akItem, bool abPreventEquip = false, bool abSilent = false) Native
Function UnequipItemSlot(int aiSlot) Native
Function UnequipShout(Shout akShout) Native
Function UnequipSpell(Spell akSpell, int aiSource) Native
Function UnLockOwnedDoorsInCell() Native
bool Function WillIntimidateSucceed() Native
bool Function WornHasKeyword(Keyword akKeyword) Native
Function StartSneaking() Native
Function DrawWeapon() Native
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
Event OnEnterBleedout()
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
Event OnRaceSwitchComplete()
EndEvent
Event OnPlayerBowShot(Weapon akWeapon, Ammo akAmmo, float afPower, bool abSunGazing)
EndEvent
Event OnPlayerLoadGame()
EndEvent
Event OnPlayerFastTravelEnd(float afTravelGameTimeHours)
EndEvent
Event OnVampireFeed(Actor akTarget)
EndEvent
Event OnVampirismStateChanged(bool abIsVampire)
EndEvent
int Property CritStage_None Auto
int Property CritStage_GooStart Auto
int Property CritStage_GooEnd Auto
int Property CritStage_DisintegrateStart Auto
int Property CritStage_DisintegrateEnd Auto
Function ForceMovementDirection(float afXAngle = 0.0, float afYAngle = 0.0, float afZAngle = 0.0) Native
Function ForceMovementSpeed(float afSpeedMult) Native
Function ForceMovementRotationSpeed(float afXMult = 0.0, float afYMult = 0.0, float afZMult = 0.0) Native
Function ForceMovementDirectionRamp(float afXAngle = 0.0, float afYAngle = 0.0, float afZAngle = 0.0, float afRampTime = 0.1) Native
Function ForceMovementSpeedRamp(float afSpeedMult, float afRampTime = 0.1) Native
Function ForceMovementRotationSpeedRamp(float afXMult = 0.0, float afYMult = 0.0, float afZMult = 0.0, float afRampTime = 0.1) Native
Function ForceTargetDirection(float afXAngle = 0.0, float afYAngle = 0.0, float afZAngle = 0.0) Native
Function ForceTargetSpeed(float afSpeed) Native
Function ForceTargetAngle(float afXAngle = 0.0, float afYAngle = 0.0, float afZAngle = 0.0) Native
Function ClearForcedMovement() Native
Form Function GetWornForm(int slotMask) Native
int Function GetWornItemId(int slotMask) Native
Form Function GetEquippedObject(int location) Native
int Function GetEquippedItemId(int location) Native
Int Function GetSpellCount() Native
Spell Function GetNthSpell(int n) Native
Function QueueNiNodeUpdate() Native
Function RegenerateHead() Native
int Property EquipSlot_Default Auto
int Property EquipSlot_RightHand Auto
int Property EquipSlot_LeftHand Auto
Function EquipItemEx(Form item, int equipSlot = 0, bool preventUnequip = false, bool equipSound = true) Native
Function EquipItemById(Form item, int itemId, int equipSlot = 0, bool preventUnequip = false, bool equipSound = true) Native
Function UnequipItemEx(Form item, int equipSlot = 0, bool preventEquip = false) Native
Function ChangeHeadPart(HeadPart hPart) Native
Function ReplaceHeadPart(HeadPart oPart, HeadPart newPart) Native
Function UpdateWeight(float neckDelta) Native
bool Function IsAIEnabled() Native
Function ResetAI() Native
bool Function IsSwimming() Native
Function SheatheWeapon() Native
ObjectReference Function GetFurnitureReference() Native
Function SetExpressionPhoneme(int index, float value) Native
Function SetExpressionModifier(int index, float value) Native
Function ResetExpressionOverrides() Native
Faction[] Function GetFactions(int minRank, int maxRank) Native
