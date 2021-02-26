MoveCurrentWindowToDesktop(num){
	activeHwnd := GetActiveHwnd()
	DllCall(MoveWindowToDesktopNumberProc, UInt, activeHwnd, UInt, num - 1)
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
		DllCall(MoveWindowToDesktopNumberProc, UInt, hwndToMove, UInt, num - 1)
	}
}

FocusForemostHwndOnCurrentDesktop(){
	currentDesktop := GetCurrentDesktopNumber()
	foremostHwnd := GetForemostHwndOnDesktopNumber(currentDesktop)
	WinActivate, ahk_id %foremostHwnd%
}

GetForemostHwndOnDesktopNumber(num){
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
