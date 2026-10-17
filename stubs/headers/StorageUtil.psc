; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
scriptname StorageUtil Hidden
int Function SetIntValue(Form ObjKey, string KeyName, int value) Global Native
float Function SetFloatValue(Form ObjKey, string KeyName, float value) Global Native
string Function SetStringValue(Form ObjKey, string KeyName, string value) Global Native
Form Function SetFormValue(Form ObjKey, string KeyName, Form value) Global Native
bool Function UnsetIntValue(Form ObjKey, string KeyName) Global Native
bool Function UnsetFloatValue(Form ObjKey, string KeyName) Global Native
bool Function UnsetStringValue(Form ObjKey, string KeyName) Global Native
bool Function UnsetFormValue(Form ObjKey, string KeyName) Global Native
bool Function HasIntValue(Form ObjKey, string KeyName) Global Native
bool Function HasFloatValue(Form ObjKey, string KeyName) Global Native
bool Function HasStringValue(Form ObjKey, string KeyName) Global Native
bool Function HasFormValue(Form ObjKey, string KeyName) Global Native
int Function GetIntValue(Form ObjKey, string KeyName, int missing = 0) Global Native
float Function GetFloatValue(Form ObjKey, string KeyName, float missing = 0.0) Global Native
string Function GetStringValue(Form ObjKey, string KeyName, string missing = "") Global Native
Form Function GetFormValue(Form ObjKey, string KeyName, Form missing = none) Global Native
int Function PluckIntValue(Form ObjKey, string KeyName, int missing = 0) Global Native
float Function PluckFloatValue(Form ObjKey, string KeyName, float missing = 0.0) Global Native
string Function PluckStringValue(Form ObjKey, string KeyName, string missing = "") Global Native
Form Function PluckFormValue(Form ObjKey, string KeyName, Form missing = none) Global Native
int Function AdjustIntValue(Form ObjKey, string KeyName, int amount) Global Native
float Function AdjustFloatValue(Form ObjKey, string KeyName, float amount) Global Native
int Function IntListAdd(Form ObjKey, string KeyName, int value, bool allowDuplicate = true) Global Native
int Function FloatListAdd(Form ObjKey, string KeyName, float value, bool allowDuplicate = true) Global Native
int Function StringListAdd(Form ObjKey, string KeyName, string value, bool allowDuplicate = true) Global Native
int Function FormListAdd(Form ObjKey, string KeyName, Form value, bool allowDuplicate = true) Global Native
int Function IntListGet(Form ObjKey, string KeyName, int index) Global Native
float Function FloatListGet(Form ObjKey, string KeyName, int index) Global Native
string Function StringListGet(Form ObjKey, string KeyName, int index) Global Native
Form Function FormListGet(Form ObjKey, string KeyName, int index) Global Native
int Function IntListSet(Form ObjKey, string KeyName, int index, int value) Global Native
float Function FloatListSet(Form ObjKey, string KeyName, int index, float value) Global Native
string Function StringListSet(Form ObjKey, string KeyName, int index, string value) Global Native
Form Function FormListSet(Form ObjKey, string KeyName, int index, Form value) Global Native
int Function IntListPluck(Form ObjKey, string KeyName, int index, int missing) Global Native
float Function FloatListPluck(Form ObjKey, string KeyName, int index, float missing) Global Native
string Function StringListPluck(Form ObjKey, string KeyName, int index, string missing) Global Native
Form Function FormListPluck(Form ObjKey, string KeyName, int index, Form missing) Global Native
int Function IntListShift(Form ObjKey, string KeyName) Global Native
float Function FloatListShift(Form ObjKey, string KeyName) Global Native
string Function StringListShift(Form ObjKey, string KeyName) Global Native
Form Function FormListShift(Form ObjKey, string KeyName) Global Native
int Function IntListPop(Form ObjKey, string KeyName) Global Native
float Function FloatListPop(Form ObjKey, string KeyName) Global Native
string Function StringListPop(Form ObjKey, string KeyName) Global Native
Form Function FormListPop(Form ObjKey, string KeyName) Global Native
int Function IntListAdjust(Form ObjKey, string KeyName, int index, int amount) Global Native
float Function FloatListAdjust(Form ObjKey, string KeyName, int index, float amount) Global Native
bool Function IntListInsert(Form ObjKey, string KeyName, int index, int value) Global Native
bool Function FloatListInsert(Form ObjKey, string KeyName, int index, float value) Global Native
bool Function StringListInsert(Form ObjKey, string KeyName, int index, string value) Global Native
bool Function FormListInsert(Form ObjKey, string KeyName, int index, Form value) Global Native
int Function IntListRemove(Form ObjKey, string KeyName, int value, bool allInstances = false) Global Native
int Function FloatListRemove(Form ObjKey, string KeyName, float value, bool allInstances = false) Global Native
int Function StringListRemove(Form ObjKey, string KeyName, string value, bool allInstances = false) Global Native
int Function FormListRemove(Form ObjKey, string KeyName, Form value, bool allInstances = false) Global Native
int Function IntListClear(Form ObjKey, string KeyName) Global Native
int Function FloatListClear(Form ObjKey, string KeyName) Global Native
int Function StringListClear(Form ObjKey, string KeyName) Global Native
int Function FormListClear(Form ObjKey, string KeyName) Global Native
bool Function IntListRemoveAt(Form ObjKey, string KeyName, int index) Global Native
bool Function FloatListRemoveAt(Form ObjKey, string KeyName, int index) Global Native
bool Function StringListRemoveAt(Form ObjKey, string KeyName, int index) Global Native
bool Function FormListRemoveAt(Form ObjKey, string KeyName, int index) Global Native
int Function IntListCount(Form ObjKey, string KeyName) Global Native
int Function FloatListCount(Form ObjKey, string KeyName) Global Native
int Function StringListCount(Form ObjKey, string KeyName) Global Native
int Function FormListCount(Form ObjKey, string KeyName) Global Native
int Function IntListCountValue(Form ObjKey, string KeyName, int value, bool exclude = false) Global Native
int Function FloatListCountValue(Form ObjKey, string KeyName, float value, bool exclude = false) Global Native
int Function StringListCountValue(Form ObjKey, string KeyName, string value, bool exclude = false) Global Native
int Function FormListCountValue(Form ObjKey, string KeyName, Form value, bool exclude = false) Global Native
int Function IntListFind(Form ObjKey, string KeyName, int value) Global Native
int Function FloatListFind(Form ObjKey, string KeyName, float value) Global Native
int Function StringListFind(Form ObjKey, string KeyName, string value) Global Native
int Function FormListFind(Form ObjKey, string KeyName, Form value) Global Native
bool Function IntListHas(Form ObjKey, string KeyName, int value) Global Native
bool Function FloatListHas(Form ObjKey, string KeyName, float value) Global Native
bool Function StringListHas(Form ObjKey, string KeyName, string value) Global Native
bool Function FormListHas(Form ObjKey, string KeyName, Form value) Global Native
Function IntListSort(Form ObjKey, string KeyName) Global Native
Function FloatListSort(Form ObjKey, string KeyName) Global Native
Function StringListSort(Form ObjKey, string KeyName) Global Native
Function FormListSort(Form ObjKey, string KeyName) Global Native
Function IntListSlice(Form ObjKey, string KeyName, int[] slice, int startIndex = 0) Global Native
Function FloatListSlice(Form ObjKey, string KeyName, float[] slice, int startIndex = 0) Global Native
Function StringListSlice(Form ObjKey, string KeyName, string[] slice, int startIndex = 0) Global Native
Function FormListSlice(Form ObjKey, string KeyName, Form[] slice, int startIndex = 0) Global Native
int Function IntListResize(Form ObjKey, string KeyName, int toLength, int filler = 0) Global Native
int Function FloatListResize(Form ObjKey, string KeyName, int toLength, float filler = 0.0) Global Native
int Function StringListResize(Form ObjKey, string KeyName, int toLength, string filler = "") Global Native
int Function FormListResize(Form ObjKey, string KeyName, int toLength, Form filler = none) Global Native
bool Function IntListCopy(Form ObjKey, string KeyName, int[] copy) Global Native
bool Function FloatListCopy(Form ObjKey, string KeyName, float[] copy) Global Native
bool Function StringListCopy(Form ObjKey, string KeyName, string[] copy) Global Native
bool Function FormListCopy(Form ObjKey, string KeyName, Form[] copy) Global Native
int[] Function IntListToArray(Form ObjKey, string KeyName) Global Native
float[] Function FloatListToArray(Form ObjKey, string KeyName) Global Native
string[] Function StringListToArray(Form ObjKey, string KeyName) Global Native
Form[] Function FormListToArray(Form ObjKey, string KeyName) Global Native
int Function IntListRandom(Form ObjKey, string KeyName) Global Native
float Function FloatListRandom(Form ObjKey, string KeyName) Global Native
string Function StringListRandom(Form ObjKey, string KeyName) Global Native
Form Function FormListRandom(Form ObjKey, string KeyName) Global Native
Form[] Function FormListFilterByTypes(Form ObjKey, string KeyName, int[] FormTypeIDs, bool ReturnMatching = true) Global Native
Form[] Function FormListFilterByType(Form ObjKey, string KeyName, int FormTypeID, bool ReturnMatching = true) Global
EndFunction
int Function CountIntValuePrefix(string PrefixKey) Global Native
int Function CountFloatValuePrefix(string PrefixKey) Global Native
int Function CountStringValuePrefix(string PrefixKey) Global Native
int Function CountFormValuePrefix(string PrefixKey) Global Native
int Function CountIntListPrefix(string PrefixKey) Global Native
int Function CountFloatListPrefix(string PrefixKey) Global Native
int Function CountStringListPrefix(string PrefixKey) Global Native
int Function CountFormListPrefix(string PrefixKey) Global Native
int Function CountAllPrefix(string PrefixKey) Global Native
int Function CountObjIntValuePrefix(Form ObjKey, string PrefixKey) Global Native
int Function CountObjFloatValuePrefix(Form ObjKey, string PrefixKey) Global Native
int Function CountObjStringValuePrefix(Form ObjKey, string PrefixKey) Global Native
int Function CountObjFormValuePrefix(Form ObjKey, string PrefixKey) Global Native
int Function CountObjIntListPrefix(Form ObjKey, string PrefixKey) Global Native
int Function CountObjFloatListPrefix(Form ObjKey, string PrefixKey) Global Native
int Function CountObjStringListPrefix(Form ObjKey, string PrefixKey) Global Native
int Function CountObjFormListPrefix(Form ObjKey, string PrefixKey) Global Native
int Function CountAllObjPrefix(Form ObjKey, string PrefixKey) Global Native
int Function ClearIntValuePrefix(string PrefixKey) Global Native
int Function ClearFloatValuePrefix(string PrefixKey) Global Native
int Function ClearStringValuePrefix(string PrefixKey) Global Native
int Function ClearFormValuePrefix(string PrefixKey) Global Native
int Function ClearIntListPrefix(string PrefixKey) Global Native
int Function ClearFloatListPrefix(string PrefixKey) Global Native
int Function ClearStringListPrefix(string PrefixKey) Global Native
int Function ClearFormListPrefix(string PrefixKey) Global Native
int Function ClearAllPrefix(string PrefixKey) Global Native
int Function ClearObjIntValuePrefix(Form ObjKey, string PrefixKey) Global Native
int Function ClearObjFloatValuePrefix(Form ObjKey, string PrefixKey) Global Native
int Function ClearObjStringValuePrefix(Form ObjKey, string PrefixKey) Global Native
int Function ClearObjFormValuePrefix(Form ObjKey, string PrefixKey) Global Native
int Function ClearObjIntListPrefix(Form ObjKey, string PrefixKey) Global Native
int Function ClearObjFloatListPrefix(Form ObjKey, string PrefixKey) Global Native
int Function ClearObjStringListPrefix(Form ObjKey, string PrefixKey) Global Native
int Function ClearObjFormListPrefix(Form ObjKey, string PrefixKey) Global Native
int Function ClearAllObjPrefix(Form ObjKey, string PrefixKey) Global Native
Function debug_DeleteValues(Form ObjKey) Global Native
Function debug_DeleteAllValues() Global Native
int Function debug_Cleanup() Global Native
Form[] Function debug_AllIntObjs() Global Native
Form[] Function debug_AllFloatObjs() Global Native
Form[] Function debug_AllStringObjs() Global Native
Form[] Function debug_AllFormObjs() Global Native
Form[] Function debug_AllIntListObjs() Global Native
Form[] Function debug_AllFloatListObjs() Global Native
Form[] Function debug_AllStringListObjs() Global Native
Form[] Function debug_AllFormListObjs() Global Native
string[] Function debug_AllObjIntKeys(Form ObjKey) Global Native
string[] Function debug_AllObjFloatKeys(Form ObjKey) Global Native
string[] Function debug_AllObjStringKeys(Form ObjKey) Global Native
string[] Function debug_AllObjFormKeys(Form ObjKey) Global Native
string[] Function debug_AllObjIntListKeys(Form ObjKey) Global Native
string[] Function debug_AllObjFloatListKeys(Form ObjKey) Global Native
string[] Function debug_AllObjStringListKeys(Form ObjKey) Global Native
string[] Function debug_AllObjFormListKeys(Form ObjKey) Global Native
int Function debug_GetIntObjectCount() Global Native
int Function debug_GetFloatObjectCount() Global Native
int Function debug_GetStringObjectCount() Global Native
int Function debug_GetFormObjectCount() Global Native
int Function debug_GetIntListObjectCount() Global Native
int Function debug_GetFloatListObjectCount() Global Native
int Function debug_GetStringListObjectCount() Global Native
int Function debug_GetFormListObjectCount() Global Native
Form Function debug_GetIntObject(int index) Global Native
Form Function debug_GetFloatObject(int index) Global Native
Form Function debug_GetStringObject(int index) Global Native
Form Function debug_GetFormObject(int index) Global Native
Form Function debug_GetIntListObject(int index) Global Native
Form Function debug_GetFloatListObject(int index) Global Native
Form Function debug_GetStringListObject(int index) Global Native
Form Function debug_GetFormListObject(int index) Global Native
int Function debug_GetIntKeysCount(Form ObjKey) Global Native
int Function debug_GetFloatKeysCount(Form ObjKey) Global Native
int Function debug_GetStringKeysCount(Form ObjKey) Global Native
int Function debug_GetFormKeysCount(Form ObjKey) Global Native
int Function debug_GetIntListKeysCount(Form ObjKey) Global Native
int Function debug_GetFloatListKeysCount(Form ObjKey) Global Native
int Function debug_GetStringListKeysCount(Form ObjKey) Global Native
int Function debug_GetFormListKeysCount(Form ObjKey) Global Native
string Function debug_GetIntKey(Form ObjKey, int index) Global Native
string Function debug_GetFloatKey(Form ObjKey, int index) Global Native
string Function debug_GetStringKey(Form ObjKey, int index) Global Native
string Function debug_GetFormKey(Form ObjKey, int index) Global Native
string Function debug_GetIntListKey(Form ObjKey, int index) Global Native
string Function debug_GetFloatListKey(Form ObjKey, int index) Global Native
string Function debug_GetStringListKey(Form ObjKey, int index) Global Native
string Function debug_GetFormListKey(Form ObjKey, int index) Global Native
int Function FileSetIntValue(string KeyName, int value) Global
EndFunction
float Function FileSetFloatValue(string KeyName, float value) Global
EndFunction
string Function FileSetStringValue(string KeyName, string value) Global
EndFunction
form Function FileSetFormValue(string KeyName, Form value) Global
EndFunction
int Function FileAdjustIntValue(string KeyName, int amount) Global
EndFunction
float Function FileAdjustFloatValue(string KeyName, float amount) Global
EndFunction
bool Function FileUnsetIntValue(string KeyName) Global
EndFunction
bool Function FileUnsetFloatValue(string KeyName) Global
EndFunction
bool Function FileUnsetStringValue(string KeyName) Global
EndFunction
bool Function FileUnsetFormValue(string KeyName) Global
EndFunction
bool Function FileHasIntValue(string KeyName) Global
EndFunction
bool Function FileHasFloatValue(string KeyName) Global
EndFunction
bool Function FileHasStringValue(string KeyName) Global
EndFunction
bool Function FileHasFormValue(string KeyName) Global
EndFunction
int Function FileGetIntValue(string KeyName, int missing = 0) Global
EndFunction
float Function FileGetFloatValue(string KeyName, float missing = 0.0) Global
EndFunction
string Function FileGetStringValue(string KeyName, string missing = "") Global
EndFunction
Form Function FileGetFormValue(string KeyName, Form missing = none) Global
EndFunction
int Function FileIntListAdd(string KeyName, int value, bool allowDuplicate = true) Global
EndFunction
int Function FileFloatListAdd(string KeyName, float value, bool allowDuplicate = true) Global
EndFunction
int Function FileStringListAdd(string KeyName, string value, bool allowDuplicate = true) Global
EndFunction
int Function FileFormListAdd(string KeyName, Form value, bool allowDuplicate = true) Global
EndFunction
int Function FileIntListAdjust(string KeyName, int index, int amount) Global
EndFunction
float Function FileFloatListAdjust(string KeyName, int index, float amount) Global
EndFunction
int Function FileIntListRemove(string KeyName, int value, bool allInstances = false) Global
EndFunction
int Function FileFloatListRemove(string KeyName, float value, bool allInstances = false) Global
EndFunction
int Function FileStringListRemove(string KeyName, string value, bool allInstances = false) Global
EndFunction
int Function FileFormListRemove(string KeyName, Form value, bool allInstances = false) Global
EndFunction
int Function FileIntListGet(string KeyName, int index) Global
EndFunction
float Function FileFloatListGet(string KeyName, int index) Global
EndFunction
string Function FileStringListGet(string KeyName, int index) Global
EndFunction
Form Function FileFormListGet(string KeyName, int index) Global
EndFunction
int Function FileIntListSet(string KeyName, int index, int value) Global
EndFunction
float Function FileFloatListSet(string KeyName, int index, float value) Global
EndFunction
string Function FileStringListSet(string KeyName, int index, string value) Global
EndFunction
Form Function FileFormListSet(string KeyName, int index, Form value) Global
EndFunction
int Function FileIntListClear(string KeyName) Global
EndFunction
int Function FileFloatListClear(string KeyName) Global
EndFunction
int Function FileStringListClear(string KeyName) Global
EndFunction
int Function FileFormListClear(string KeyName) Global
EndFunction
bool Function FileIntListRemoveAt(string KeyName, int index) Global
EndFunction
bool Function FileFloatListRemoveAt(string KeyName, int index) Global
EndFunction
bool Function FileStringListRemoveAt(string KeyName, int index) Global
EndFunction
bool Function FileFormListRemoveAt(string KeyName, int index) Global
EndFunction
bool Function FileIntListInsert(string KeyName, int index, int value) Global
EndFunction
bool Function FileFloatListInsert(string KeyName, int index, float value) Global
EndFunction
bool Function FileStringListInsert(string KeyName, int index, string value) Global
EndFunction
bool Function FileFormListInsert(string KeyName, int index, Form value) Global
EndFunction
int Function FileIntListCount(string KeyName) Global
EndFunction
int Function FileFloatListCount(string KeyName) Global
EndFunction
int Function FileStringListCount(string KeyName) Global
EndFunction
int Function FileFormListCount(string KeyName) Global
EndFunction
int Function FileIntListFind(string KeyName, int value) Global
EndFunction
int Function FileFloatListFind(string KeyName, float value) Global
EndFunction
int Function FileStringListFind(string KeyName, string value) Global
EndFunction
int Function FileFormListFind(string KeyName, Form value) Global
EndFunction
bool Function FileIntListHas(string KeyName, int value) Global
EndFunction
bool Function FileFloatListHas(string KeyName, float value) Global
EndFunction
bool Function FileStringListHas(string KeyName, string value) Global
EndFunction
bool Function FileFormListHas(string KeyName, Form value) Global
EndFunction
Function FileIntListSlice(string KeyName, int[] slice, int startIndex = 0) Global
EndFunction
Function FileFloatListSlice(string KeyName, float[] slice, int startIndex = 0) Global
EndFunction
Function FileStringListSlice(string KeyName, string[] slice, int startIndex = 0) Global
EndFunction
Function FileFormListSlice(string KeyName, Form[] slice, int startIndex = 0) Global
EndFunction
int Function FileIntListResize(string KeyName, int toLength, int filler = 0) Global
EndFunction
int Function FileFloatListResize(string KeyName, int toLength, float filler = 0.0) Global
EndFunction
int Function FileStringListResize(string KeyName, int toLength, string filler = "") Global
EndFunction
int Function FileFormListResize(string KeyName, int toLength, Form filler = none) Global
EndFunction
bool Function FileIntListCopy(string KeyName, int[] copy) Global
EndFunction
bool Function FileFloatListCopy(string KeyName, float[] copy) Global
EndFunction
bool Function FileStringListCopy(string KeyName, string[] copy) Global
EndFunction
bool Function FileFormListCopy(string KeyName, Form[] copy) Global
EndFunction
Function debug_SaveFile() Global
EndFunction
int Function debug_FileGetIntKeysCount() Global
EndFunction
int Function debug_FileGetFloatKeysCount() Global
EndFunction
int Function debug_FileGetStringKeysCount() Global
EndFunction
int Function debug_FileGetIntListKeysCount() Global
EndFunction
int Function debug_FileGetFloatListKeysCount() Global
EndFunction
int Function debug_FileGetStringListKeysCount() Global
EndFunction
string Function debug_FileGetIntKey(int index) Global
EndFunction
string Function debug_FileGetFloatKey(int index) Global
EndFunction
string Function debug_FileGetStringKey(int index) Global
EndFunction
string Function debug_FileGetIntListKey(int index) Global
EndFunction
string Function debug_FileGetFloatListKey(int index) Global
EndFunction
string Function debug_FileGetStringListKey(int index) Global
EndFunction
Function debug_FileDeleteAllValues() Global
EndFunction
Function debug_SetDebugMode(bool enabled) Global
EndFunction
bool Function ImportFile(string fileName, string restrictKey = "", int restrictType = -1, Form restrictForm = none, bool restrictGlobal = false, bool keyContains = false) Global
EndFunction
bool Function ExportFile(string fileName, string restrictKey = "", int restrictType = -1, Form restrictForm = none, bool restrictGlobal = false, bool keyContains = false, bool append = true) Global
EndFunction
