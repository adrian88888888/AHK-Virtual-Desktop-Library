GetAltTabList(){
	static WS_EX_TOPMOST :=            0x8 ; sets the Always On Top flag
	static WS_EX_APPWINDOW :=      0x40000 ; provides a taskbar button
	static WS_EX_TOOLWINDOW :=        0x80 ; removes the window from the alt-tab list
	static GW_OWNER := 4

	AltTabList := {}
	windowList := ""
	DetectHiddenWindows, Off ; makes DllCall("IsWindowVisible") unnecessary
	WinGet, windowList, List ; gather a list of running programs
	Loop, %windowList%
	{
		ownerID := windowID := windowList%A_Index%
		Loop
		{ ;If the window we found is opened by another application or "child", let's get the hWnd of the parent
			ownerID := Format("0x{:x}",  DllCall("GetWindow", "UInt", ownerID, "UInt", GW_OWNER))
		} Until !Format("0x{:x}",  DllCall("GetWindow", "UInt", ownerID, "UInt", GW_OWNER))
		ownerID := ownerID ? ownerID : windowID

	; only windows that are not removed from the Alt+Tab list, AND have a taskbar button, will be appended to our list.
		If (Format("0x{:x}", DllCall("GetLastActivePopup", "UInt", ownerID)) = windowID)
		{
			WinGet, es, ExStyle, ahk_id %windowID%
			If (!((es & WS_EX_TOOLWINDOW) && !(es & WS_EX_APPWINDOW)) && !IsInvisibleWin10BackgroundAppWindow(windowID))
			{
				AltTabList.Push(windowID)
			}
		}
	}
	; UNCOMMENT THIS FOR TESTING
	; WinGetClass, class1, % "ahk_id" AltTabList[1]
	; WinGetClass, class2, % "ahk_id" AltTabList[2]
	; WinGetClass, classF, % "ahk_id" AltTabList.pop()
	; msgbox % "Number of Windows: " AltTabList.length() "`nFirst windowID: " class1 "`nSecond windowID: " class2 "`nFinal windowID: " classF
	return AltTabList
}

IsInvisibleWin10BackgroundAppWindow(hWindow){
	result := 0
	VarSetCapacity(cloakedVal, A_PtrSize) ; DWMWA_CLOAKED := 14
	hr := DllCall("DwmApi\DwmGetWindowAttribute", "Ptr", hWindow, "UInt", 14, "Ptr", &cloakedVal, "UInt", A_PtrSize)
	if !hr ; returns S_OK (which is zero) on success. Otherwise, it returns an HRESULT error code
	{
		result := NumGet(cloakedVal) ; omitting the "&" performs better
	}
	return result ? true : false
}

/*
	DWMWA_CLOAKED: If the window is cloaked, the following values explain why:
	1  The window was cloaked by its owner application (DWM_CLOAKED_APP)
	2  The window was cloaked by the Shell (DWM_CLOAKED_SHELL)
	4  The cloak value was inherited from its owner window (DWM_CLOAKED_INHERITED)
*/

GetActiveHwnd(){
	WinGet, activeHwnd, ID, A
	return activeHwnd
}

GetActiveClass(){
	activeHwnd := GetActiveHwnd()
	WinGetClass, winClass, ahk_id %activeHwnd%
	return winClass
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

CopyActiveClass(){
	activeClass := GetActiveClass()
	SetClipboardHTML("",, activeClass)
}

CopyActiveExe(){
	activeExe := GetActiveExe()
	SetClipboardHTML("",, activeExe)
}
