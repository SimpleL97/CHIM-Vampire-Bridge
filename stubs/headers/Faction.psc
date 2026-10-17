; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname Faction extends Form Hidden
bool Function CanPayCrimeGold() Native
int Function GetCrimeGold() Native
int Function GetCrimeGoldNonViolent() Native
int Function GetCrimeGoldViolent() Native
int Function GetInfamy() Native
int Function GetInfamyNonViolent() Native
int Function GetInfamyViolent() Native
int Function GetReaction(Faction akOther) Native
int Function GetStolenItemValueCrime() Native
int Function GetStolenItemValueNoCrime() Native
bool Function IsFactionInCrimeGroup(Faction akOther) Native
bool Function IsPlayerExpelled() Native
Function ModCrimeGold(int aiAmount, bool abViolent = false) Native
Function ModReaction(Faction akOther, int aiAmount) Native
Function PlayerPayCrimeGold(bool abRemoveStolenItems = true, bool abGoToJail = true) Native
Function SendAssaultAlarm() Native
Function SendPlayerToJail(bool abRemoveInventory = true, bool abRealJail = true) Native
Function SetAlly(Faction akOther, bool abSelfIsFriendToOther = false, bool abOtherIsFriendToSelf = false) Native
Function SetCrimeGold(int aiGold) Native
Function SetCrimeGoldViolent(int aiGold) Native
Function SetEnemy(Faction akOther, bool abSelfIsNeutralToOther = false, bool abOtherIsNeutralToSelf = false) Native
Function SetPlayerEnemy(bool abIsEnemy = true) Native
Function SetPlayerExpelled(bool abIsExpelled = true) Native
Function SetReaction(Faction akOther, int aiNewValue) Native
int Property kFaction_HiddenFromNPC Auto
int Property kFaction_SpecialCombat Auto
int Property kFaction_TrackCrime Auto
int Property kFaction_IgnoreMurder Auto
int Property kFaction_IgnoreAssault Auto
int Property kFaction_IgnoreStealing Auto
int Property kFaction_IgnoreTrespass Auto
int Property kFaction_NoReportCrime Auto
int Property kFaction_CrimeGoldDefaults Auto
int Property kFaction_IgnorePickpocket Auto
int Property kFaction_Vendor Auto
int Property kFaction_CanBeOwner Auto
int Property kFaction_IgnoreWerewolf Auto
Function MakeVendor()
EndFunction
bool Function IsVendor()
EndFunction
Function ClearVendor()
EndFunction
bool Function IsFactionFlagSet(int flag) Native
Function SetFactionFlag(int flag) Native
Function ClearFactionFlag(int flag) Native
bool Function OnlyBuysStolenItems() Native
Function SetOnlyBuysStolenItems(bool onlyStolen) Native
int Function GetVendorStartHour() Native
Function SetVendorStartHour(int hour) Native
int Function GetVendorEndHour() Native
Function SetVendorEndHour(int hour) Native
int Function GetVendorRadius() Native
Function SetVendorRadius(int radius) Native
ObjectReference Function GetMerchantContainer() Native
Function SetMerchantContainer(ObjectReference akContainer) Native
bool Function IsNotSellBuy() Native
Function SetNotSellBuy(bool notSellBuy) Native
FormList Function GetBuySellList() Native
Function SetBuySellList(FormList akList) Native
