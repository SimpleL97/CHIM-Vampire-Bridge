; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
ScriptName OThread
int Function QuickStart(Actor[] Actors, string StartingAnimation = "", ObjectReference FurnitureRef = None) Global Native
bool Function IsRunning(int ThreadID) Global Native
Function Stop(int ThreadID) Global Native
int Function GetThreadCount() Global Native
int[] Function GetAllThreadIDs() Global Native
string Function GetScene(int ThreadID) Global Native
Function NavigateTo(int ThreadID, string SceneID) Global Native
Function QueueNavigation(int ThreadID, string SceneID, float Duration) Global Native
Function WarpTo(int ThreadID, string SceneID, bool UseFades = False) Global Native
Function QueueWarp(int ThreadID, string SceneID, float Duration) Global Native
bool Function AutoTransition(int ThreadID, string Type) Global Native
bool Function AutoTransitionForActor(int ThreadID, int Index, string Type) Global Native
int Function GetSpeed(int ThreadID) Global Native
Function SetSpeed(int ThreadID, int Speed) Global Native
Function PlaySequence(int ThreadID, string Sequence, bool NavigateTo = false, bool UseFades = false) Global Native
Actor[] Function GetActors(int ThreadID) Global Native
Actor Function GetActor(int ThreadID, int Index) Global Native
int Function GetActorPosition(int ThreadID, Actor Act) Global Native
Function StallClimax(int ThreadID) Global Native
Function PermitClimax(int ThreadID, bool PermitActors = false) Global Native
bool Function IsClimaxStalled(int ThreadID) Global Native
ObjectReference Function GetFurniture(int ThreadID) Global Native
string Function GetFurnitureType(int ThreadID) Global Native
Function ChangeFurniture(int ThreadID, ObjectReference FurnitureRef, string SceneID = "") Global Native
bool Function IsInAutoMode(int ThreadID) Global Native
Function StartAutoMode(int ThreadID) Global Native
Function StopAutoMode(int ThreadID) Global Native
bool Function HasMetadata(int ThreadID, string Metadata) Global Native
Function AddMetadata(int ThreadID, string Metadata) Global Native
string[] Function GetMetadata(int ThreadID) Global Native
bool Function HasMetaFloat(int ThreadID, string MetaID) Global Native
float Function GetMetaFloat(int ThreadID, string MetaID) Global Native
Function SetMetaFloat(int ThreadID, string MetaID, float Value) Global Native
bool Function HasMetaString(int ThreadID, string MetaID) Global Native
string Function GetMetaString(int ThreadID, string MetaID) Global Native
Function SetMetaString(int ThreadID, string MetaID, string Value) Global Native
Function CallEvent(int ThreadID, string EventName, int Actor, int Target = -1, int Performer = -1) Global Native
