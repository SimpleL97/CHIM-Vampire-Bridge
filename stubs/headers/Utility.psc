; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname Utility Hidden
string Function GameTimeToString(float afGameTime) Global Native
float Function GetCurrentGameTime() Global Native
float Function GetCurrentRealTime() Global Native
bool Function IsInMenuMode() Global Native
int Function RandomInt(int aiMin = 0, int aiMax = 100) Global Native
float Function RandomFloat(float afMin = 0.0, float afMax = 1.0) Global Native
Function SetINIFloat(string ini, float value) Global Native
Function SetINIInt(string ini, int value) Global Native
Function SetINIBool(string ini, bool value) Global Native
Function SetINIString(string ini, string value) Global Native
Function Wait(float afSeconds) Global Native
Function WaitGameTime(float afHours) Global Native
Function WaitMenuMode(float afSeconds) Global Native
string Function CaptureFrameRate(int numFrames) Global Native
Function StartFrameRateCapture() Global Native
Function EndFrameRateCapture() Global Native
float Function GetAverageFrameRate() Global Native
float Function GetMinFrameRate() Global Native
float Function GetMaxFrameRate() Global Native
int Function GetCurrentMemory() Global Native
int Function GetBudgetCount() Global Native
int Function GetCurrentBudget(int aiBudgetNumber) Global Native
bool Function OverBudget(int aiBudgetNumber) Global Native
string Function GetBudgetName(int aiBudgetNumber) Global Native
float Function GetINIFloat(string ini) Global Native
int Function GetINIInt(string ini) Global Native
bool Function GetINIBool(string ini) Global Native
string Function GetINIString(string ini) Global Native
float[] Function CreateFloatArray(int size, float fill = 0.0) Global Native
int[] Function CreateIntArray(int size, int fill = 0) Global Native
bool[] Function CreateBoolArray(int size, bool fill = false) Global Native
string[] Function CreateStringArray(int size, string fill = "") Global Native
Form[] Function CreateFormArray(int size, Form fill = None) Global Native
Alias[] Function CreateAliasArray(int size, Alias fill = None) Global Native
float[] Function ResizeFloatArray(float[] source, int size, float fill = 0.0) Global Native
int[] Function ResizeIntArray(int[] source, int size, int fill = 0) Global Native
bool[] Function ResizeBoolArray(bool[] source, int size, bool fill = false) Global Native
string[] Function ResizeStringArray(string[] source, int size, string fill = "") Global Native
Form[] Function ResizeFormArray(Form[] source, int size, Form fill = None) Global Native
Alias[] Function ResizeAliasArray(Alias[] source, int size, Alias fill = None) Global Native
