; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname Enchantment extends Form Hidden
bool Function IsHostile() Native
int Function GetNumEffects() Native
float Function GetNthEffectMagnitude(int index) Native
int Function GetNthEffectArea(int index) Native
int Function GetNthEffectDuration(int index) Native
MagicEffect Function GetNthEffectMagicEffect(int index) Native
int Function GetCostliestEffectIndex() Native
Function SetNthEffectMagnitude(int index, float value) Native
Function SetNthEffectArea(int index, int value) Native
Function SetNthEffectDuration(int index, int value) Native
Enchantment Function GetBaseEnchantment() Native
FormList Function GetKeywordRestrictions() Native
Function SetKeywordRestrictions(FormList newKeywordList) Native
