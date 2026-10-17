; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname Location extends Form Hidden
float Function GetKeywordData(Keyword akKeyword) Native
int Function GetRefTypeAliveCount(LocationRefType akRefType) Native
int Function GetRefTypeDeadCount(LocationRefType akRefType) Native
bool Function HasCommonParent(Location akOther, Keyword akFilter = None) Native
bool Function HasRefType(LocationRefType akRefType) Native
bool Function IsCleared() Native
bool Function IsChild(Location akOther) Native
bool Function IsLoaded() Native
bool Function IsSameLocation(Location akOtherLocation, Keyword akKeyword = None)
EndFunction
Function SetKeywordData(Keyword akKeyword, float afData) Native
Function SetCleared(bool abCleared = true) Native
Location Function GetParent() Native
