; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname Potion extends Form
bool Function IsHostile() Native
bool Function IsFood() Native
bool Function IsPoison() Native
int Function GetNumEffects() Native
float Function GetNthEffectMagnitude(int index) Native
int Function GetNthEffectArea(int index) Native
int Function GetNthEffectDuration(int index) Native
MagicEffect Function GetNthEffectMagicEffect(int index) Native
int Function GetCostliestEffectIndex() Native
Function SetNthEffectMagnitude(int index, float value) Native
Function SetNthEffectArea(int index, int value) Native
Function SetNthEffectDuration(int index, int value) Native
SoundDescriptor Function GetUseSound() Native
float[] Function GetEffectMagnitudes() Native
int[] Function GetEffectAreas() Native
int[] Function GetEffectDurations() Native
MagicEffect[] Function GetMagicEffects() Native
