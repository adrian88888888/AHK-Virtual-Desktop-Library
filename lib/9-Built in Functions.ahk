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
