; note: the variable "path" is called "thePath" because path looks like a built
; in variable, even if is not in the documentation of the built in varialbes

SetDefaultBackground(thePath){
	StoreDefaultBackgroundInVariable(thePath)
	ChangeBackground()
}

SetBackgroundOnDesktop(num, thePath){
	aBackgroundWasSetInADesktop := true
	StoreBackgroundInList(num, thePath) ; is a list that has the background for each desktop, for example in the position 6 will be the path to the background for the desktop 6
	ChangeBackground()
}

StoreDefaultBackgroundInVariable(thePath){
	FileGetAttrib, pathIs, %thePath%
	If (pathIs == "D") ; D = directory
	{
		dir := thePath
		defaultBackground := GetRandomBackgroundFromDir(dir)
	}
	If (pathIs == "A") ; A = archive
	{
		defaultBackground := thePath
	}
}

StoreBackgroundInList(num, thePath){
	FileGetAttrib, pathIs, %thePath%
	If (pathIs == "D") ; D = directory
	{
		dir := thePath
		randomBackground := GetRandomBackgroundFromDir(dir)
		listOfBackgrounds.InsertAt(num, randomBackground)
	}
	If (pathIs == "A") ; A = archive
	{
		listOfBackgrounds.InsertAt(num, thePath)
	}
}

ChangeBackground(){
	background := GetRightBackgroundFromList()
	If background
	{
		DllCall("SystemParametersInfo", UInt, 0x14, UInt, 0, Str, background, UInt, 1)
	}
}

GetRightBackgroundFromList(){
	; this is my best try to make this function readable
	If aBackgroundWasSetInADesktop ; If the user set a background on a particular desktop
	{
		currentDesktop := GetCurrentDesktop()
		thePath := listOfBackgrounds[currentDesktop]
		If thePath ; If the user has set a background for this particular desktop, Return that path
			Return thePath
		If not thePath
		{
			If defaultBackground
				Return defaultBackground
			If not defaultBackground ; If the user has not set a background for this particular desktop, return "No defaultBackground, so orange" so the user notices it
				Return "No defaultBackground, so orange"
		}
	}
	If not aBackgroundWasSetInADesktop and defaultBackground ; If the user has ONLY set a default background, Return it
		Return defaultBackground
	If not aBackgroundWasSetInADesktop and not defaultBackground ; If the user has not set a default background or a background on a particular desktop, Return false
		Return false
}

GetRandomBackgroundFromDir(dir){
	numberOfFiles := GetNumberOfFiles(dir)
	randomFile := SelectARandomFile(dir, numberOfFiles)
	Return randomFile
}

GetNumberOfFiles(dir){
	Loop Files, %dir%*.*
	{
		numberOfFiles := A_Index
	}
	Return numberOfFiles
}

SelectARandomFile(dir, numberOfFiles){
	Random, randomFile, 1, numberOfFiles ; 1 is included
	Loop Files, %dir%*.*
	{
		If (A_Index == randomFile)
			Return, A_LoopFileFullPath
	}
}

ChangeBackgroundOnDesktopSwitch(){
	DllCall(RegisterPostMessageHookProc, Int, hwnd, Int, 0x1400 + 30)
	OnMessage(0x1400 + 30, "ChangeBackground")
}
