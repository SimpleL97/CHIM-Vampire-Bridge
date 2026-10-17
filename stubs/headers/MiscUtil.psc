; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
scriptname MiscUtil Hidden
ObjectReference[] Function ScanCellObjects(int formType, ObjectReference CenterOn, float radius = 0.0, Keyword HasKeyword = none) Global Native
Actor[] Function ScanCellNPCs(ObjectReference CenterOn, float radius = 0.0, Keyword HasKeyword = none, bool IgnoreDead = true) Global Native
Actor[] Function ScanCellNPCsByFaction(Faction FindFaction, ObjectReference CenterOn, float radius = 0.0, int minRank = 0, int maxRank = 127, bool IgnoreDead = true) Global Native
Function ToggleFreeCamera(bool stopTime = false) Global Native
Function SetFreeCameraSpeed(float speed) Global Native
Function SetFreeCameraState(bool enable, float speed = 10.0) Global Native
string[] Function FilesInFolder(string directory, string extension="*") Global Native
string[] Function FoldersInFolder(string directory) Global Native
bool Function FileExists(string fileName) Global Native
string Function ReadFromFile(string fileName) Global Native
bool Function WriteToFile(string fileName, string text, bool append = true, bool timestamp = false) Global Native
Function PrintConsole(string text) Global Native
string Function GetRaceEditorID(Race raceForm) Global Native
string Function GetActorRaceEditorID(Actor actorRef) Global Native
Function SetMenus(bool enabled) Global Native
float Function GetNodeRotation(ObjectReference obj, string nodeName, bool firstPerson, int rotationIndex) Global
EndFunction
Function ExecuteBat(string fileName) Global
EndFunction
Actor[] Function ScanCellActors(ObjectReference CenterOn, float radius = 5000.0, Keyword HasKeyword = none) Global
EndFunction
