Scriptname GlobalVariable extends Form Hidden

float Property Value Hidden
	float Function Get()
		return GetValue()
	EndFunction
	Function Set(float afValue)
		SetValue(afValue)
	EndFunction
EndProperty

float Function GetValue() native
int Function GetValueInt() native
Function SetValue(float asNewValue) native
Function SetValueInt(int aiNewValue) native
Function Mod(float afHowMuch) native
