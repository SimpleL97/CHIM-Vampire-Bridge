; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname Game Hidden
Function AddAchievement(int aiAchievementID) Global Native
Function AddPerkPoints(int aiPerkPoints) Global Native
Function AdvanceSkill(string asSkillName, float afMagnitude) Global Native
bool Function AddHavokBallAndSocketConstraint(ObjectReference arRefA, string arRefANode, ObjectReference arRefB, string arRefBNode, float afRefALocalOffsetX = 0.0, float afRefALocalOffsetY = 0.0, float afRefALocalOffsetZ = 0.0, float afRefBLocalOffsetX = 0.0, float afRefBLocalOffsetY = 0.0, float afRefBLocalOffsetZ = 0.0) Global Native
bool Function RemoveHavokConstraints(ObjectReference arFirstRef, string arFirstRefNodeName, ObjectReference arSecondRef, string arSecondRefNodeName) Global Native
int Function CalculateFavorCost(int aiFavorPrice) Global Native
Function ClearPrison() Global Native
Function ClearTempEffects() Global Native
Function DisablePlayerControls(bool abMovement = true, bool abFighting = true, bool abCamSwitch = false, bool abLooking = false,    bool abSneaking = false, bool abMenu = true, bool abActivate = true, bool abJournalTabs = false, int aiDisablePOVType = 0) Global Native
Function EnablePlayerControls(bool abMovement = true, bool abFighting = true, bool abCamSwitch = true, bool abLooking = true,    bool abSneaking = true, bool abMenu = true, bool abActivate = true, bool abJournalTabs = true, int aiDisablePOVType = 0) Global Native
Function EnableFastTravel(bool abEnable = true) Global Native
Function FadeOutGame(bool abFadingOut, bool abBlackFade, float afSecsBeforeFade, float afFadeDuration) Global Native
Function FastTravel(ObjectReference akDestination) Global Native
ObjectReference Function FindClosestReferenceOfType(Form arBaseObject, float afX, float afY, float afZ, float afRadius) Global Native
ObjectReference Function FindRandomReferenceOfType(Form arBaseObject, float afX, float afY, float afZ, float afRadius) Global Native
ObjectReference Function FindClosestReferenceOfAnyTypeInList(FormList arBaseObjects, float afX, float afY, float afZ, float afRadius) Global Native
ObjectReference Function FindRandomReferenceOfAnyTypeInList(FormList arBaseObjects, float afX, float afY, float afZ, float afRadius) Global Native
ObjectReference Function FindClosestReferenceOfTypeFromRef(Form arBaseObject, ObjectReference arCenter, float afRadius) Global
EndFunction
ObjectReference Function FindRandomReferenceOfTypeFromRef(Form arBaseObject, ObjectReference arCenter, float afRadius) Global
EndFunction
ObjectReference Function FindClosestReferenceOfAnyTypeInListFromRef(FormList arBaseObjects, ObjectReference arCenter, float afRadius) Global
EndFunction
ObjectReference Function FindRandomReferenceOfAnyTypeInListFromRef(FormList arBaseObjects, ObjectReference arCenter, float afRadius) Global
EndFunction
Actor Function FindClosestActor(float afX, float afY, float afZ, float afRadius) Global Native
Actor Function FindRandomActor(float afX, float afY, float afZ, float afRadius) Global Native
Actor Function FindClosestActorFromRef(ObjectReference arCenter, float afRadius) Global
EndFunction
Actor Function FindRandomActorFromRef(ObjectReference arCenter, float afRadius) Global
EndFunction
Function ForceThirdPerson() Global Native
Function ForceFirstPerson() Global Native
Function ShowFirstPersonGeometry(bool abShow = true) Global Native
Form Function GetForm(int aiFormID) Global Native
Form Function GetFormFromFile(int aiFormID, string asFilename) Global Native
float Function GetGameSettingFloat(string asGameSetting) Global Native
int Function GetGameSettingInt(string asGameSetting) Global Native
string Function GetGameSettingString(string asGameSetting) Global Native
Actor Function GetPlayer() Global Native
ObjectReference Function GetPlayerGrabbedRef() Global Native
Actor Function GetPlayersLastRiddenHorse() Global Native
float Function GetSunPositionX() Global Native
float Function GetSunPositionY() Global Native
float Function GetSunPositionZ() Global Native
float Function GetRealHoursPassed() Global Native
Function IncrementSkill(string asSkillName) Global Native
Function IncrementSkillBy(string asSkillName, int aiCount) Global Native
Function IncrementStat(string asStatName, int aiModAmount = 1) Global Native
bool Function IsActivateControlsEnabled() Global Native
bool Function IsCamSwitchControlsEnabled() Global Native
bool Function IsFastTravelControlsEnabled() Global Native
bool Function IsFastTravelEnabled() Global Native
bool Function IsFightingControlsEnabled() Global Native
bool Function IsJournalControlsEnabled() Global Native
bool Function IsLookingControlsEnabled() Global Native
bool Function IsMenuControlsEnabled() Global Native
bool Function IsMovementControlsEnabled() Global Native
bool Function IsPlayerSungazing() Global Native
bool Function IsSneakingControlsEnabled() Global Native
bool Function IsWordUnlocked(WordOfPower akWord) Global Native
Function PlayBink(string asFileName, bool abInterruptible = false, bool abMuteAudio = true, bool abMuteMusic = true,    bool abLetterbox = true) Global Native
Function PrecacheCharGen() Global Native
Function PrecacheCharGenClear() Global Native
int Function QueryStat(string asStat) Global Native
Function QuitToMainMenu() Global Native
Function RequestAutoSave() Global Native
Function RequestModel(string asModelName) Global Native
Function RequestSave() Global Native
Function ServeTime() Global Native
Function SendWereWolfTransformation() Global Native
Function SetBeastForm(bool abEntering) Global Native
Function SetCameraTarget(Actor arTarget) Global Native
Function SetHudCartMode(bool abSetCartMode = true) Global Native
Function SetInChargen(bool abDisableSaving, bool abDisableWaiting, bool abShowControlsDisabledMessage) Global Native
Function SetPlayerAIDriven(bool abAIDriven = true) Global Native
Function SetPlayerReportCrime(bool abReportCrime = true) Global Native
Function SetSittingRotation(float afValue) Global Native
Function ShakeCamera(ObjectReference akSource = None, float afStrength = 0.5, float afDuration = 0.0) Global Native
Function ShakeController(float afSmallMotorStrength, float afBigMotorStreangth, float afDuration) Global Native
Function ShowRaceMenu() Global Native
Function ShowLimitedRaceMenu() Global Native
Function ShowTitleSequenceMenu() Global Native
Function HideTitleSequenceMenu() Global Native
Function StartTitleSequence(string asSequenceName) Global Native
Function SetAllowFlyingMountLandingRequests(bool abAllow) Global Native
Function SetSunGazeImageSpaceModifier(ImageSpaceModifier apImod = NONE) Global Native
Function ShowTrainingMenu(Actor aTrainer) Global Native
Function TeachWord(WordOfPower akWord) Global Native
Function TriggerScreenBlood(int aiValue) Global Native
Function UnlockWord(WordOfPower akWord) Global Native
bool Function UsingGamepad() Global Native
int Function GetPerkPoints() Global Native
Function SetPerkPoints(int perkPoints) Global Native
Function ModPerkPoints(int perkPoints) Global Native
int Function GetModCount() Global Native
int Function GetModByName(string name) Global Native
string Function GetModName(int modIndex) Global Native
string Function GetModAuthor(int modIndex) Global Native
string Function GetModDescription(int modIndex) Global Native
int Function GetModDependencyCount(int modIndex) Global Native
bool Function IsPluginInstalled(string name) Global Native
int Function GetLightModCount() Global Native
int Function GetLightModByName(string name) Global Native
string Function GetLightModName(int idx) Global Native
string Function GetLightModAuthor(int idx) Global Native
string Function GetLightModDescription(int idx) Global Native
int Function GetLightModDependencyCount(int idx) Global Native
int Function GetNthLightModDependency(int modIdx, int idx) Global Native
Function SetGameSettingFloat(string setting, float value) Global Native
Function SetGameSettingInt(string setting, int value) Global Native
Function SetGameSettingBool(string setting, bool value) Global Native
Function SetGameSettingString(string setting, string value) Global Native
Function SaveGame(string name) Global Native
Function LoadGame(string name) Global Native
int Function GetNumTintMasks() Global Native
int Function GetNthTintMaskColor(int n) Global Native
int Function GetNthTintMaskType(int n) Global Native
Function SetNthTintMaskColor(int n, int color) Global Native
string Function GetNthTintMaskTexturePath(int n) Global Native
Function SetNthTintMaskTexturePath(string path, int n) Global Native
int Function GetNumTintsByType(int type) Global Native
int Function GetTintMaskColor(int type, int index) Global Native
Function SetTintMaskColor(int color, int type, int index) Global Native
string Function GetTintMaskTexturePath(int type, int index) Global Native
Function SetTintMaskTexturePath(string path, int type, int index) Global Native
Function UpdateTintMaskColors() Global Native
Function UpdateHairColor() Global Native
int Function GetCameraState() Global
EndFunction
Function SetMiscStat(string name, int value) Global Native
Function SetPlayersLastRiddenHorse(Actor horse) Global Native
int Function GetSkillLegendaryLevel(string actorValue) Global
EndFunction
Function SetSkillLegendaryLevel(string actorValue, int level) Global
EndFunction
float Function GetPlayerExperience() Global Native
Function SetPlayerExperience(float exp) Global Native
float Function GetExperienceForLevel(int currentLevel) Global Native
bool Function GetPlayerMovementMode() Global Native
Function UpdateThirdPerson() Global
EndFunction
Function UnbindObjectHotkey(int hotkey) Global Native
Form Function GetHotkeyBoundObject(int hotkey) Global Native
bool Function IsObjectFavorited(Form form) Global Native
Form Function GetFormEx(int formId) Global Native
ObjectReference Function GetDialogueTarget() Global Native
ObjectReference Function GetCurrentCrosshairRef() Global Native
ObjectReference Function GetCurrentConsoleRef() Global Native
Function SetPlayerLevel(int level) Global Native
