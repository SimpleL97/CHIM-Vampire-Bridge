Scriptname MCM Hidden
; compile-time stub of MCM Helper's global API; the game uses MCM Helper's real MCM.pex
int Function GetModSettingInt(string ModName, string ModSetting) global native
bool Function GetModSettingBool(string ModName, string ModSetting) global native
float Function GetModSettingFloat(string ModName, string ModSetting) global native
string Function GetModSettingString(string ModName, string ModSetting) global native
Function SetModSettingString(string ModName, string ModSetting, string value) global native
