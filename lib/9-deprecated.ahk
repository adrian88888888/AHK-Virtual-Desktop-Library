GetActiveTitle(){
	activeHwnd := GetActiveHwnd()
	WinGetTitle, winTitle, ahk_id %activeHwnd%
	return winTitle
}

GetActiveClass(){
	activeHwnd := GetActiveHwnd()
	WinGetClass, winClass, ahk_id %activeHwnd%
	return winClass
}

CopyActiveTitle(){
	activeTitle := GetActiveTitle()
	SetClipboardHTML("",, activeTitle)
}

CopyActiveClass(){
	activeClass := GetActiveClass()
	SetClipboardHTML("",, activeClass)
}
