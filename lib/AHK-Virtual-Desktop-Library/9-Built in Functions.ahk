GetActiveHwnd(){
	WinGet, activeHwnd, ID, A
	return activeHwnd
}

CopyActiveHwnd(){
	activeHwnd := GetActiveHwnd()
	SetClipboardHTML("",, activeHwnd)
}

IsHwndActive(hwnd){
	activeHwnd := GetActiveHwnd()
	if (activeHwnd == hwnd)
		return True
	else
		return False
}

GetActiveExe(){
	activeHwnd := GetActiveHwnd()
	WinGet, winExe, ProcessName, ahk_id %activeHwnd%
	return winExe
}

CopyActiveExe(){
	activeExe := GetActiveExe()
	SetClipboardHTML("",, activeExe)
}

IsExeActive(exe){
	activeExe := GetActiveExe()
	if (activeExe == exe)
		return True
	else
		return False
}

CopyActiveClass(){
	activeClass := GetActiveClass()
	SetClipboardHTML("",, activeClass)
}

GetActiveClass(){
	activeHwnd := GetActiveHwnd()
	WinGetClass, winClass, ahk_id %activeHwnd%
	return winClass
}

IsClassActive(Class){
	activeClass := GetActiveClass()
	if (activeClass == Class)
		return True
	else
		return False
}

CopyActiveTitle(){
	activeTitle := GetActiveTitle()
	SetClipboardHTML("",, activeTitle)
}

GetActiveTitle(){
	activeHwnd := GetActiveHwnd()
	WinGetTitle, winTitle, ahk_id %activeHwnd%
	return winTitle
}

IsTitleActive(Title){
	activeTitle := GetActiveTitle()
	if (activeTitle == Title)
		return True
	else
		return False
}
