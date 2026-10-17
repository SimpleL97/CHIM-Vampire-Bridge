; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname Cell extends Form Hidden
ActorBase Function GetActorOwner() Native
Faction Function GetFactionOwner() Native
bool Function IsAttached() Native
bool Function IsInterior() Native
Function Reset() Native
Function SetActorOwner(ActorBase akActor) Native
Function SetFactionOwner(Faction akFaction) Native
Function SetFogColor(int aiNearRed, int aiNearGreen, int aiNearBlue,  	int aiFarRed, int aiFarGreen, int aiFarBlue) Native
Function SetFogPlanes(float afNear, float afFar) Native
Function SetFogPower(float afPower) Native
Function SetPublic(bool abPublic = true) Native
int Function GetNumRefs(int formTypeFilter = 0) Native
ObjectReference Function GetNthRef(int n, int formTypeFilter = 0) Native
float Function GetWaterLevel() Native
float Function GetActualWaterLevel() Native
