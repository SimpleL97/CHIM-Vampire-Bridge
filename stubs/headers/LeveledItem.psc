; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname LeveledItem extends Form Hidden
Function AddForm(Form apForm, int aiLevel, int aiCount) Native
Function Revert() Native
int Function GetChanceNone() Native
Function SetChanceNone(int chance) Native
GlobalVariable Function GetChanceGlobal() Native
Function SetChanceGlobal(GlobalVariable glob) Native
int Function GetNumForms() Native
Form Function GetNthForm(int n) Native
int Function GetNthLevel(int n) Native
Function SetNthLevel(int n, int level) Native
int Function GetNthCount(int n) Native
Function SetNthCount(int n, int count) Native
