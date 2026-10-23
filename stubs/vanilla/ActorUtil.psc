Scriptname ActorUtil Hidden
{Declaration-only stand-in for PapyrusUtil's ActorUtil (package overrides), for the compiler.
 Only what this mod calls; in the game PapyrusUtil's own script runs.}

Function AddPackageOverride(Actor targetActor, Package targetPackage, int priority = 30, int flags = 0) global native
bool Function RemovePackageOverride(Actor targetActor, Package targetPackage) global native
