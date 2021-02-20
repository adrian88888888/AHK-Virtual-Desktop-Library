#Include AHK_Vitrual_Desktop_Library/WinHook.ahk
#Include AHK_Vitrual_Desktop_Library/SetClipboardHTML.ahk

DetectHiddenWindows, On
hwnd:=WinExist("ahk_pid " . DllCall("GetCurrentProcessId","Uint"))
hwnd+=0x1000<<32

hVirtualDesktopAccessor := DllCall("LoadLibrary", Str, "VirtualDesktopAccessor.dll", "Ptr") 

global GoToDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "GoToDesktopNumber", "Ptr")
global GetCurrentDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "GetCurrentDesktopNumber", "Ptr")
global GetDesktopCountProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "GetDesktopCount", "Ptr")
global IsWindowOnCurrentVirtualDesktopProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "IsWindowOnCurrentVirtualDesktop", "Ptr")
global MoveWindowToDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "MoveWindowToDesktopNumber", "Ptr")
global RegisterPostMessageHookProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "RegisterPostMessageHook", "Ptr")
global UnregisterPostMessageHookProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "UnregisterPostMessageHook", "Ptr")
global RestartVirtualDesktopAccessorProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "RestartVirtualDesktopAccessor", "Ptr")
global GetWindowDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "GetWindowDesktopNumber", "Ptr")
global ViewIsShownInSwitchersProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "ViewIsShownInSwitchers", "Ptr")
global ViewIsVisibleProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "ViewIsShownInSwitchers", "Ptr")
global IsWindowOnDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "IsWindowOnDesktopNumber", "Ptr")
global ViewGetThumbnailHwndProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "ViewGetThumbnailHwnd", "Ptr")
global ViewGetFocusedProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "ViewGetFocused", "Ptr")
global IsPinnedWindowProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "IsPinnedWindow", "Ptr")
global PinWindowProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "PinWindow", "Ptr")
global UnPinWindowProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "UnPinWindow", "Ptr")
global IsPinnedAppProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "IsPinnedApp", "Ptr")
global PinAppProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "PinApp", "Ptr")
global UnPinAppProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "UnPinApp", "Ptr")


RestartVirtualDesktopAccessorWhenNeeded()


RestartVirtualDesktopAccessorWhenNeeded(){ ; its needed when Explorer.exe crashes or restarts(e.g. when coming from fullscreen game)
	explorerRestartMsg := DllCall("user32\RegisterWindowMessage", "Str", "TaskbarCreated")
	OnMessage(explorerRestartMsg, "RestartVirtualDesktopAccessor")
}

RestartVirtualDesktopAccessor(){
	DllCall(RestartVirtualDesktopAccessorProc, UInt, result)
}

; Do basic Stuff------------------------------------------

GoToDesktopNumber(num){
	BugFix()
	DllCall(GoToDesktopNumberProc, Int, num - 1)
	return
}

GoToNextDesktop(){
	BugFix()
	currentDesktop := GetCurrentDesktopNumber()
	nextDesktop := currentDesktop + 1
	GoToDesktopNumber(nextDesktop)
}

GoToPrevDesktop(){
	BugFix()
	currentDesktop := GetCurrentDesktopNumber()
	prevDesktop := currentDesktop - 1
	GoToDesktopNumber(prevDesktop)
}

BugFix(){
	;the next line fixes a bug, you can see the solution reading those:
	;-https://github.com/Ciantic/VirtualDesktopAccessor/issues/4
	;-https://pypi.org/project/pyvda/   (read the end part)
	DllCall("user32\AllowSetForegroundWindow", Int, - 1)
}

; Return information---------------------------------------

GetCurrentDesktopNumber(){
	return DllCall(GetCurrentDesktopNumberProc) + 1
}

GetNumberOfDesktops(){
	return DllCall(GetDesktopCountProc)
}

GetInWichDesktopTheWindowIs(hwnd){
	return DllCall(GetWindowDesktopNumberProc, int, hwnd) + 1
}

IsWindowOnCurrentDesktop(hwnd){
	return DllCall(IsWindowOnCurrentVirtualDesktopProc, UInt, hwnd) ;esta funcion no parece funcionar correctamente
}

IsWindowOnDesktopNumber(num, hwnd){
	return DllCall(IsWindowOnDesktopNumberProc, int, hwnd, int, num - 1)
}

; Move windows between desktops----------------------------

MoveCurrentWindowToDesktop(num) {
	activeHwnd := GetActiveHwnd()
	DllCall(MoveWindowToDesktopNumberProc, UInt, activeHwnd, UInt, num-1)
	FocusForemostHwndOnCurrentDesktop()
}

MoveWindowToDesktop(num, hwndToMove){
	activeHwnd := GetActiveHwnd()
	if (activeHwnd == hwndToMove)
	{
		MoveCurrentWindowToDesktop(num)
	}
	else
	{
		DllCall(MoveWindowToDesktopNumberProc, UInt, hwndToMove, UInt, num-1)
	}
}

FocusForemostHwndOnCurrentDesktop(){
	currentDesktop := GetCurrentDesktopNumber()
	foremostHwnd := GetForemostHwndOnDesktopNumber(currentDesktop)
	WinActivate, ahk_id %foremostHwnd%
}

GetForemostHwndOnDesktopNumber(num) {
	WinGet hwndsList, list ; hwndsList contains a list of windows hwnd´s (ordered from the foremost to the one in the back) for each desktop
	Loop % hwndsList {
		hwnd := % hwndsList%A_Index%
		windowIsOnDesktop := IsWindowOnDesktopNumber(num, hwnd)
		WinGetTitle, windowTitle, % "ahk_id " hwndsList%A_Index%
		if (windowIsOnDesktop == 1) ; return the first that founds, that one is the foremost window because of the order of the hwndsList
		{
			return hwnd
		}
	}
}


; Open specified program on desired desktop every time-----

AlwaysOpenOnDesktopNumber(num, winClass:="", winExe:=""){
	DetectHiddenWindows On ; FuncOrMethod will be called with DetectHiddenWindows On
	WinHook.Shell.Add(Func("MoveWindowToDesktop").Bind(num),,winClass,winExe,1) ; https://www.autohotkey.com/boards/viewtopic.php?f=76&t=86967
}

;AlwaysOpenOnDesktopNumberAndGo(num, winClass:="", winTitle:="", winExe:=""){
	;WinHook.Shell.Add(Func("MoveWindowToDesktop").Bind(num),,winClass,,1) ; https://www.autohotkey.com/boards/viewtopic.php?f=76&t=86967
	;GoToDesktopNumber(num)
;}

; Pin/UnPin------------------------------------------------


PinWindow(hwnd){
	return DllCall(PinWindowProc, UInt, hwnd)
}

UnpinWindow(hwnd){
	return DllCall(UnpinWindowProc, UInt, hwnd)
}

IsWindowPinned(hwnd){
	return DllCall(IsPinnedWindowProc, UInt, hwnd)
}

PinApp(hwnd){
	return DllCall(PinAppProc, UInt, hwnd)
}

UnpinApp(hwnd){
	return DllCall(UnpinAppProc, UInt, hwnd)
}

IsAppPinned(hwnd){
	return DllCall(IsPinnedAppProc, UInt, hwnd)
}

; Misc-----------------------------------------------------

CallFunctionOnDesktopSwitch(bool){
	if (bool = true)
	{
		DllCall(RegisterPostMessageHookProc, Int, hwnd, Int, 0x1400 + 30)
		OnMessage(0x1400 + 30, "OnDesktopSwitch")
	}
	if (bool = false)
	{
		DllCall(UnregisterPostMessageHookProc, Int, hwnd, Int, 0x1400 + 30)
		OnMessage(0x1400 + 30, "OnDesktopSwitch")
	}
}

FocusLastIfOnDesktop(){
	desktopIsActive := IsDesktopActive()
	if desktopIsActive
		;FocusForemostHwndOnCurrentDesktop()
		Send !{Tab}
}

IsDesktopActive(){
	activeClass := GetActiveClass()
	desktopClass := "WorkerW"
	if (activeClass == desktopClass)
	{
		return True
	}
	else
	{
		return False
	}
}

OpenDesktopManager(){
	Send #{Tab}
}

; Built in functions---------------------------------------

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

; ---------------------------------------------------------