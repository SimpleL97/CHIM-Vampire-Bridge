; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname ActorBase extends Form Hidden
Class Function GetClass() Native
int Function GetDeadCount() Native
FormList Function GetGiftFilter() Native
Race Function GetRace() Native
int Function GetSex() Native
bool Function IsEssential() Native
bool Function IsInvulnerable() Native
bool Function IsProtected() Native
bool Function IsUnique() Native
Function SetEssential(bool abEssential = true) Native
Function SetInvulnerable(bool abInvulnerable = true) Native
Function SetProtected(bool abProtected = true) Native
Function SetOutfit(Outfit akOutfit, bool abSleepOutfit = false) Native
CombatStyle Function GetCombatStyle() Native
Function SetCombatStyle(CombatStyle cs) Native
Outfit Function GetOutfit(bool bSleepOutfit = false) Native
Function SetClass(Class c) Native
float Function GetHeight() Native
Function SetHeight(float height) Native
float Function GetWeight() Native
Function SetWeight(float weight) Native
int Function GetNumHeadParts() Native
HeadPart Function GetNthHeadPart(int slotPart) Native
Function SetNthHeadPart(HeadPart headPart, int slotPart) Native
int Function GetIndexOfHeadPartByType(int type) Native
int Function GetNumOverlayHeadParts() Native
HeadPart Function GetNthOverlayHeadPart(int slotPart) Native
int Function GetIndexOfOverlayHeadPartByType(int type) Native
float Function GetFaceMorph(int index) Native
Function SetFaceMorph(float value, int index) Native
int Function GetFacePreset(int index) Native
Function SetFacePreset(int value, int index) Native
ColorForm Function GetHairColor() Native
Function SetHairColor(ColorForm color) Native
int Function GetSpellCount() Native
Spell Function GetNthSpell(int n) Native
TextureSet Function GetFaceTextureSet() Native
Function SetFaceTextureSet(TextureSet textures) Native
VoiceType Function GetVoiceType() Native
Function SetVoiceType(VoiceType nVoice) Native
Armor Function GetSkin() Native
Function SetSkin(Armor skin) Native
Armor Function GetSkinFar() Native
Function SetSkinFar(Armor skin) Native
ActorBase Function GetTemplate() Native
