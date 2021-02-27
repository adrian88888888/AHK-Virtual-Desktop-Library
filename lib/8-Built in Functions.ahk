GetActiveHwnd(){
	WinGet, activeHwnd, ID, A
	return activeHwnd
}

GetActiveExe(){
	activeHwnd := GetActiveHwnd()
	WinGet, winExe, ProcessName, ahk_id %activeHwnd%
	return winExe
}

CopyActiveHwnd(){
	activeHwnd := GetActiveHwnd()
	SetClipboardHTML("",, activeHwnd)
}

CopyActiveExe(){
	activeExe := GetActiveExe()
	SetClipboardHTML("",, activeExe)
}
