; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname Spell extends Form Hidden
Function Cast(ObjectReference akSource, ObjectReference akTarget=NONE) Native
Function RemoteCast(ObjectReference akSource, Actor akBlameActor, ObjectReference akTarget=NONE) Native
bool Function IsHostile() Native
Function Preload() Native
Function Unload() Native
float Function GetCastTime() Native
Perk Function GetPerk() Native
int Function GetNumEffects() Native
float Function GetNthEffectMagnitude(int index) Native
int Function GetNthEffectArea(int index) Native
int Function GetNthEffectDuration(int index) Native
MagicEffect Function GetNthEffectMagicEffect(int index) Native
int Function GetCostliestEffectIndex() Native
int Function GetMagickaCost() Native
int Function GetEffectiveMagickaCost(Actor caster) Native
Function SetNthEffectMagnitude(int index, float value) Native
Function SetNthEffectArea(int index, int value) Native
Function SetNthEffectDuration(int index, int value) Native
EquipSlot Function GetEquipType() Native
Function SetEquipType(EquipSlot type) Native
float[] Function GetEffectMagnitudes() Native
int[] Function GetEffectAreas() Native
int[] Function GetEffectDurations() Native
MagicEffect[] Function GetMagicEffects() Native
