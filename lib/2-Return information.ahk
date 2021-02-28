GetCurrentDesktop(){
	return DllCall(GetCurrentDesktopNumberProc) + 1
}

GetAmountOfDesktops(){
	return DllCall(GetDesktopCountProc)
}

InWichDesktopThisWindowIs(hwnd){
	return DllCall(GetWindowDesktopNumberProc, int, hwnd) + 1
}

IsWindowOnCurrentDesktop(hwnd){
	return DllCall(IsWindowOnCurrentVirtualDesktopProc, UInt, hwnd) ;esta funcion no parece funcionar correctamente
}

IsWindowOnDesktopNumber(num, hwnd){
	return DllCall(IsWindowOnDesktopNumberProc, int, hwnd, int, num - 1)
}

IsFullScreenMode(ExesToIgnore:=0){
	if ExesToIgnore
	{
		ExesToIgnore := ConvertListToString(ExesToIgnore) ; why this?: https://www.autohotkey.com/boards/viewtopic.php?f=76&t=87404&p=384395#p384395
		activeExe := GetActiveExe()
		If activeExe in %ExesToIgnore%
		{
			return False
		}
	}
	If OnDesktop() ; desktop is in full screen, so make an exeption
	{
		return False
	}
	; the folowing code was taken from https://autohotkey.com/board/topic/38882-detect-fullscreen-application/
	; probably does not have multimonitor support(i dont have 2 monitors so i cant test)
	; but, you can change the following code with this one probably? i dont knwow:
	; https://github.com/dufferzafar/Autohotkey-Scripts/blob/master/lib/IsFullScreen.ahk
	; if you fix it for multimonitor and it works, please give me your function to add it to the main repo
	; so everyone can have multimonitor support, thanksssss!
	activeHwnd := GetActiveHwnd()
	WinGet style, Style, ahk_id %activeHwnd%
	WinGetPos, , , winW, winH, ahk_id %activeHwnd%
	; 0x800000 is WS_BORDER.
	; 0x20000000 is WS_MINIMIZE.

	; if no border and not minimized return true or false
	Return ((style & 0x20800000) or winH < A_ScreenHeight or winW < A_ScreenWidth) ? false : true

	; trying to make it understandable:
	; if ((style & 0x20800000) or winH < A_ScreenHeight or winW < A_ScreenWidth)
	; 	Return false
	; else
	; 	Return true
}

ConvertListToString(list){
  for k,v in list
  	listInString .= v ","
  listInString := RTrim(listInString, ",")
  return listInString
}

GetAltTabList(){
	; took from https://www.autohotkey.com/boards/viewtopic.php?t=46069
	; if does not work you can try:
	; https://www.autohotkey.com/boards/viewtopic.php?f=76&t=87170&p=383201#p383201
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
	/*
		DWMWA_CLOAKED: If the window is cloaked, the following values explain why:
		1  The window was cloaked by its owner application (DWM_CLOAKED_APP)
		2  The window was cloaked by the Shell (DWM_CLOAKED_SHELL)
		4  The cloak value was inherited from its owner window (DWM_CLOAKED_INHERITED)
	*/
}

OnDesktop(){
	activeClass := GetActiveClass()
	desktopClass := "WorkerW"
	if (activeClass == desktopClass)
		return True
	else
		return False
}

OnTaskBar(){
	activeClass := GetActiveClass()
	taskBarClass := "Shell_TrayWnd"
	if (activeClass == taskBarClass)
		return True
	else
		return False
}

GetActiveClass(){
	activeHwnd := GetActiveHwnd()
	WinGetClass, winClass, ahk_id %activeHwnd%
	return winClass
}

CopyActiveClass(){
	activeClass := GetActiveClass()
	SetClipboardHTML("",, activeClass)
}

; yes, the following funtions are the same, i do it so in the actual code that uses it reads better

OnDesktopToGo(num){ ; why this funtion: if you are tring to go or move a window to a desktop you are, then dont do it!, how? put "if not OnDesktopToGo()"
	currentDesktop := GetCurrentDesktop()
	if (currentDesktop == num)
		return True
	else
		return False
}

OnDesktopToMoveWindowTo(num){ ; why this funtion: if you are tring to go or move a window to a desktop you are, then dont do it!, how? put "if not OnDesktopToGo()"
	currentDesktop := GetCurrentDesktop()
	if (currentDesktop == num)
		return True
	else
		return False
}
