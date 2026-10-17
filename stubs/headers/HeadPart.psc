; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname HeadPart extends Form Hidden
int Property Type_Misc Auto
int Property Type_Face Auto
int Property Type_Eyes Auto
int Property Type_Hair Auto
int Property Type_FacialHair Auto
int Property Type_Scar Auto
int Property Type_Brows Auto
HeadPart Function GetHeadPart(string name) Global Native
int Function GetType() Native
int Function GetNumExtraParts() Native
HeadPart Function GetNthExtraPart(int n) Native
bool Function HasExtraPart(HeadPart p) Native
int Function GetIndexOfExtraPart(HeadPart p) Native
FormList Function GetValidRaces() Native
Function SetValidRaces(FormList vRaces) Native
bool Function IsExtraPart() Native
string Function GetPartName() Native
