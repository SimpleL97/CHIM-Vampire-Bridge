; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname AIAgentFunctions
int Function getChimInteractionState() Global Native
bool Function setChimInteractionEnabled(bool enabled) Global Native
int Function sendMessage(String a_msg,String a_type) Global Native
int Function sendMessageToActor(String a_msg,String a_type,Actor targetActor) Global Native
int Function commandEnded(String command) Global Native
int Function commandEndedForActor(String command,string npc) Global Native
int Function recordSoundEx(int bindedKey) Global Native
int Function stopRecording(int bindedKey) Global Native
int Function stopAllDialogue() Global Native
bool Function isGameFocused() Global Native
int Function startOpenMicMonitoring() Global Native
int Function stopOpenMicMonitoring() Global Native
int Function setOpenMicMuted(bool muted) Global Native
String Function getCurrentRecordingDeviceName() Global Native
int Function beginChimMcmSnapshot() Global Native
int Function publishChimMcmEntry(String page, String section, String key, String label, String description, String controlType, String value, String options) Global Native
int Function commitChimMcmSnapshot(int revision) Global Native
int Function beginChimMcmAgents() Global Native
int Function publishChimMcmAgent(String bucket, int formId, String actorName) Global Native
int Function commitChimMcmAgents() Global Native
int Function publishChimMcmCommandResult(String request, bool succeeded, String message) Global Native
int Function setNewActionMode(int mode) Global Native
int Function logMessage(String a_msg,String type) Global Native
int Function logMessageForActor(String a_msg,String type,String npc) Global Native
int Function requestMessage(String a_msg,String type) Global Native
int Function requestMessageForActor(String a_msg,String type,String npc) Global Native
int Function requestMessageForEligibleActor(String a_msg,String type,String npc) Global Native
int Function setAnimationBusy(int busy,String npc) Global Native
int Function setLocked(int locked,String npc) Global Native
int Function isActorTalking(String npc) Global Native
int Function getPlayerBountyForGuard(String guardName) Global Native
int Function requestMoveInventoryItemConfirmation(Actor source, Actor target, Form itemForm, int amount, String realName) Global Native
int Function requestArrestConfirmation(Actor player, Actor guard, Faction crimeFaction) Global Native
int Function sendRequest() Global Native
int Function hardResetExpression() Global Native
int Function shotAndUpload(String hints,int mode) Global Native
int Function startSoulgazeCapture(String hints, int captureType, int renderMode, Actor target = None) Global Native
int Function isGameVR() Global Native
int Function sendLocationFast(Location curr,string tags,Cell referenceCell=None) Global Native
int Function sendFactionFast(Faction factions,string name) Global Native
int Function sendNPCFast(Actor akActor) Global Native
int Function setConf(String code,float float_value,int int_value,String string_value) Global Native
int Function get_conf_i(String code) Global Native
int Function setAIKeyWord(Actor targetActor) Global Native
int Function setDrivenByAI() Global Native
int Function setDrivenByAIA(Actor forcedActor,bool salutation) Global Native
int Function addBasicProfile(Actor forcedActor) Global Native
int Function removeAgentByName(String name) Global Native
Actor Function getClosestAgent() Global Native
Actor Function getAgentByName(String npcName) Global Native
Actor[] Function findAllNearbyAgents() Global Native
Actor[] Function findAllAgents() Global Native
Actor[] Function findAllNearbyNonAgents() Global Native
Actor[] Function findAllNearbyActors(bool onlyBgl) Global Native
int[] Function findAllAgentsFormId() Global Native
ObjectReference Function getLocationMarkerFor(Location loc) Global Native
ObjectReference Function getWorldLocationMarkerFor(Location loc) Global Native
ObjectReference Function getLocationCenterMarker(Location loc,int mode) Global Native
ObjectReference Function getNearestDoor() Global Native
ObjectReference Function findLocationsToSafeSpawn(float minDistance,bool restriction=true) Global Native
int Function scanActorsAroundOffline(Actor akActor) Global Native
int Function updateRemoteInventory(Actor akActor) Global Native
string Function GetLocationSpecialRefsString(int locationFormId) Global Native
ObjectReference Function loadReference(int refFormId) Global Native
int Function PostGameData(string jsonData) Global Native
int Function isUsingFurniture(Actor akActor) Global Native
int Function isInContainer(ObjectReference item) Global Native
int Function SayTo(Actor source,Actor dest,Form topicToSay) Global Native
int Function toggleHistoryPanel() Global Native
int Function showHistoryPanel() Global Native
int Function hideHistoryPanel() Global Native
int Function focusHistoryPanel(bool pauseGame = false) Global Native
int Function unfocusHistoryPanel() Global Native
int Function toggleHistoryPanelFocus(bool pauseGame = false) Global Native
int Function toggleOverlayPanel() Global Native
int Function cycleOverlayStatusPanels() Global Native
int Function cycleHistoryDiariesPanels() Global Native
int Function showOverlayPanel() Global Native
int Function hideOverlayPanel() Global Native
int Function toggleDiariesPanel() Global Native
int Function showDiariesPanel() Global Native
int Function hideDiariesPanel() Global Native
int Function toggleBrowserPanel() Global Native
int Function showBrowserPanel() Global Native
int Function hideBrowserPanel() Global Native
int Function toggleAIViewPanel() Global Native
int Function showAIViewPanel() Global Native
int Function hideAIViewPanel() Global Native
int Function toggleDebuggerPanel() Global Native
int Function showDebuggerPanel() Global Native
int Function hideDebuggerPanel() Global Native
int Function toggleStatusHUDPanel() Global Native
int Function showStatusHUDPanel() Global Native
int Function hideStatusHUDPanel() Global Native
int Function toggleChatboxPanel() Global Native
int Function showChatboxPanel() Global Native
int Function hideChatboxPanel() Global Native
int Function focusChatboxPanel() Global Native
int Function unfocusChatboxPanel() Global Native
int Function isChatboxPanelVisible() Global Native
int Function isChatboxPanelFocused() Global Native
int Function isAnyPrismaHotkeyPanelFocused() Global Native
int Function toggleSettingsMenu() Global Native
String Function getSettingsMenuPendingAction() Global Native
int Function clearSettingsMenuPendingAction() Global Native
int Function toggleMasterMenu() Global Native
int Function startPlayerMenuDialogueTTS(String fallbackText) Global Native
int Function sendAllVoices() Global Native
int Function testAddAllNPCAround() Global Native
int Function testRemoveAll() Global Native
int Function getHerikaFormId() Global Native
int Function jsonGetInt(string keyName,string jsonString) Global Native
int Function jsonGetFormId(string keyName,string jsonString) Global Native
string Function jsonGetString(string keyName,string jsonString) Global Native
float Function jsonGetFloat(string keyName,string jsonString) Global Native
Actor Function jsonGetActor(string keyName,string jsonString) Global Native
ObjectReference Function jsonGetReference(string keyName,string jsonString) Global Native
FormList Function jsonGetFormList(string keyName,string jsonString) Global Native
EffectShader Function jsonGetEffectShader(string keyName,string jsonString) Global Native
string Function GetDoorActivationText(ObjectReference akRef) Global Native
int Function startMusicScene(string songName,string singer) Global Native
int Function stopMusicScene(string singer) Global Native
int Function removeFromRenamedNPCList(Actor akTarget) Global Native
