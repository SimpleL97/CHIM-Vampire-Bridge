; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname Race extends Form Hidden
int Function GetSpellCount() Native
Spell Function GetNthSpell(int n) Native
bool Function IsRaceFlagSet(int n) Native
Function SetRaceFlag(int n) Native
Function ClearRaceFlag(int n) Native
VoiceType Function GetDefaultVoiceType(bool female) Native
Function SetDefaultVoiceType(bool female, VoiceType voice) Native
Armor Function GetSkin() Native
Function SetSkin(Armor skin) Native
int Function GetNumPlayableRaces() Global Native
Race Function GetNthPlayableRace(int n) Global Native
Race Function GetRace(string editorId) Global Native
int Property kRace_Playable Auto
int Property kRace_FaceGenHead Auto
int Property kRace_Child Auto
int Property kRace_TiltFrontBack Auto
int Property kRace_TiltLeftRight Auto
int Property kRace_NoShadow Auto
int Property kRace_Swims Auto
int Property kRace_Flies Auto
int Property kRace_Walks Auto
int Property kRace_Immobile Auto
int Property kRace_NotPushable Auto
int Property kRace_NoCombatInWater Auto
int Property kRace_NoRotatingToHeadTrack Auto
int Property kRace_UseHeadTrackAnim Auto
int Property kRace_SpellsAlignWithMagicNode Auto
int Property kRace_UseWorldRaycasts Auto
int Property kRace_AllowRagdollCollision Auto
int Property kRace_CantOpenDoors Auto
int Property kRace_AllowPCDialogue Auto
int Property kRace_NoKnockdowns Auto
int Property kRace_AllowPickpocket Auto
int Property kRace_AlwaysUseProxyController Auto
int Property kRace_AllowMultipleMembraneShaders Auto
int Property kRace_AvoidsRoads Auto
bool Function IsPlayable()
EndFunction
Function MakePlayable()
EndFunction
Function MakeUnplayable()
EndFunction
bool Function IsChildRace()
EndFunction
Function MakeChildRace()
EndFunction
Function MakeNonChildRace()
EndFunction
bool Function CanFly()
EndFunction
Function MakeCanFly()
EndFunction
Function MakeNonFlying()
EndFunction
bool Function CanSwim()
EndFunction
Function MakeCanSwim()
EndFunction
Function MakeNonSwimming()
EndFunction
bool Function CanWalk()
EndFunction
Function MakeCanWalk()
EndFunction
Function MakeNonWalking()
EndFunction
bool Function IsImmobile()
EndFunction
Function MakeImmobile()
EndFunction
Function MakeMobile()
EndFunction
bool Function IsNotPushable()
EndFunction
Function MakeNotPushable()
EndFunction
Function MakePushable()
EndFunction
bool Function NoKnockdowns()
EndFunction
Function MakeNoKnockdowns()
EndFunction
Function ClearNoKNockdowns()
EndFunction
bool Function NoCombatInWater()
EndFunction
Function SetNoCombatInWater()
EndFunction
Function ClearNoCombatInWater()
EndFunction
bool Function AvoidsRoads()
EndFunction
Function SetAvoidsRoads()
EndFunction
Function ClearAvoidsRoads()
EndFunction
bool Function AllowPickpocket()
EndFunction
Function SetAllowPickpocket()
EndFunction
Function ClearAllowPickpocket()
EndFunction
bool Function AllowPCDialogue()
EndFunction
Function SetAllowPCDialogue()
EndFunction
Function ClearAllowPCDialogue()
EndFunction
bool Function CantOpenDoors()
EndFunction
Function SetCantOpenDoors()
EndFunction
Function ClearCantOpenDoors()
EndFunction
bool Function NoShadow()
EndFunction
Function SetNoShadow()
EndFunction
Function ClearNoShadow()
EndFunction
