; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname Quest extends Form Hidden
bool Function ModObjectiveGlobal(float afModValue, GlobalVariable aModGlobal, int aiObjectiveID = -1, float afTargetValue = -1.0, bool abCountingUp = true, bool abCompleteObjective = true, bool abRedisplayObjective = true)
EndFunction
Function CompleteAllObjectives() Native
Function CompleteQuest() Native
Function FailAllObjectives() Native
Alias Function GetAlias(int aiAliasID) Native
int Function GetCurrentStageID() Native
int Function GetStage()
EndFunction
bool Function GetStageDone(int aiStage)
EndFunction
bool Function IsActive() Native
bool Function IsCompleted() Native
bool Function IsObjectiveCompleted(int aiObjective) Native
bool Function IsObjectiveDisplayed(int aiObjective) Native
bool Function IsObjectiveFailed(int aiObjective) Native
bool Function IsRunning() Native
bool Function IsStageDone(int aiStage) Native
bool Function IsStarting() Native
bool Function IsStopping() Native
bool Function IsStopped() Native
Function Reset() Native
Function SetActive(bool abActive = true) Native
bool Function SetCurrentStageID(int aiStageID) Native
Function SetObjectiveCompleted(int aiObjective, bool abCompleted = true) Native
Function SetObjectiveDisplayed(int aiObjective, bool abDisplayed = true, bool abForce = false) Native
Function SetObjectiveFailed(int aiObjective, bool abFailed = true) Native
bool Function SetStage(int aiStage)
EndFunction
bool Function Start() Native
Function Stop() Native
bool Function UpdateCurrentInstanceGlobal(GlobalVariable aUpdateGlobal) Native
Event OnStoryAddToPlayer(ObjectReference akOwner, ObjectReference akContainer,  	Location akLocation, Form akItemBase, int aiAcquireType)
EndEvent
Event OnStoryArrest(ObjectReference akArrestingGuard, ObjectReference akCriminal,  	Location akLocation, int aiCrime)
EndEvent
Event OnStoryAssaultActor(ObjectReference akVictim, ObjectReference akAttacker,  	Location akLocation, int aiCrime)
EndEvent
Event OnStoryBribeNPC(ObjectReference akActor)
EndEvent
Event OnStoryCastMagic(ObjectReference akCastingActor, ObjectReference akSpellTarget,  	Location akLocation, Form akSpell)
EndEvent
Event OnStoryChangeLocation(ObjectReference akActor, Location akOldLocation,  	Location akNewLocation)
EndEvent
Event OnStoryCrimeGold(ObjectReference akVictim, ObjectReference akCriminal,  	Form akFaction, int aiGoldAmount, int aiCrime)
EndEvent
Event OnStoryCure(Form akInfection)
EndEvent
Event OnStoryDialogue(Location akLocation, ObjectReference akActor1, ObjectReference akActor2)
EndEvent
Event OnStoryDiscoverDeadBody(ObjectReference akActor, ObjectReference akDeadActor,  	Location akLocation)
EndEvent
Event OnStoryEscapeJail(Location akLocation, Form akCrimeGroup)
EndEvent
Event OnStoryActivateActor(Location akLocation, ObjectReference akActor)
EndEvent
Event OnStoryFlatterNPC(ObjectReference akActor)
EndEvent
Event OnStoryHello(Location akLocation, ObjectReference akActor1, ObjectReference akActor2)
EndEvent
Event OnStoryIncreaseLevel(int aiNewLevel)
EndEvent
Event OnStoryIncreaseSkill(string asSkill)
EndEvent
Event OnStoryInfection(ObjectReference akTransmittingActor, Form akInfection)
EndEvent
Event OnStoryIntimidateNPC(ObjectReference akActor)
EndEvent
Event OnStoryJail(ObjectReference akGuard, Form akCrimeGroup, Location akLocation,  	int aiCrimeGold)
EndEvent
Event OnStoryKillActor(ObjectReference akVictim, ObjectReference akKiller,  	Location akLocation, int aiCrimeStatus, int aiRelationshipRank)
EndEvent
Event OnStoryCraftItem(ObjectReference akBench, Location akLocation, Form akCreatedItem)
EndEvent
Event OnStoryNewVoicePower(ObjectReference akActor, Form akVoicePower)
EndEvent
Event OnStoryPickLock(ObjectReference akActor, ObjectReference akLock)
EndEvent
Event OnStoryPayFine(ObjectReference akCriminal, ObjectReference akGuard,  	Form akCrimeGroup, int aiCrimeGold)
EndEvent
Event OnStoryPlayerGetsFavor(ObjectReference akActor)
EndEvent
Event OnStoryRelationshipChange(ObjectReference akActor1, ObjectReference akActor2,  	int aiOldRelationship, int aiNewRelationship)
EndEvent
Event OnStoryRemoveFromPlayer(ObjectReference akOwner, ObjectReference akItem,  	Location akLocation, Form akItemBase, int aiRemoveType)
EndEvent
Event OnStoryScript(Keyword akKeyword, Location akLocation, ObjectReference akRef1,  	ObjectReference akRef2, int aiValue1, int aiValue2)
EndEvent
Event OnStoryServedTime(Location akLocation, Form akCrimeGroup, int aiCrimeGold,  	int aiDaysJail)
EndEvent
Event OnStoryTrespass(ObjectReference akVictim, ObjectReference akTrespasser,  	Location akLocation, int aiCrime)
EndEvent
Quest Function GetQuest(string editorId) Global Native
string Function GetID() Native
int Function GetPriority() Native
int Function GetNumAliases() Native
Alias Function GetNthAlias(int index) Native
Alias Function GetAliasByName(string name) Native
Alias Function GetAliasById(int aliasId) Native
Alias[] Function GetAliases() Native
