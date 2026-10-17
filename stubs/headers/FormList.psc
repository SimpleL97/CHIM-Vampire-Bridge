; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod
Scriptname FormList extends Form
Function AddForm(Form apForm) Native
int Function Find(Form apForm) Native
int Function GetSize() Native
Form Function GetAt(int aiIndex) Native
bool Function HasForm(Form akForm) Native
Function RemoveAddedForm(Form apForm) Native
Function Revert() Native
Form[] Function ToArray() Native
Function AddForms(Form[] forms) Native
