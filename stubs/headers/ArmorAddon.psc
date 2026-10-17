; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname ArmorAddon extends Form Hidden
string Function GetModelPath(bool firstPerson, bool female) Native
Function SetModelPath(string path, bool firstPerson, bool female) Native
int Function GetModelNumTextureSets(bool first, bool female) Native
TextureSet Function GetModelNthTextureSet(int n, bool first, bool female) Native
Function SetModelNthTextureSet(TextureSet texture, int n, bool first, bool female) Native
int Function GetNumAdditionalRaces() Native
Race Function GetNthAdditionalRace(int n) Native
int Function GetSlotMask() Native
Function SetSlotMask(int slotMask) Native
int Function AddSlotToMask(int slotMask) Native
int Function RemoveSlotFromMask(int slotMask) Native
int Function GetMaskForSlot(int slot) Global
EndFunction
