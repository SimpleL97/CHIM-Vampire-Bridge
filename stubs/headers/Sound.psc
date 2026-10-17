; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname Sound extends Form Hidden
int Function Play(ObjectReference akSource) Native
bool Function PlayAndWait(ObjectReference akSource) Native
Function StopInstance(int aiPlaybackInstance) Global Native
Function SetInstanceVolume(int aiPlaybackInstance, float afVolume) Global Native
SoundDescriptor Function GetDescriptor() Native
