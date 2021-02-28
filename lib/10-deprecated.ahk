GetActiveTitle(){
	activeHwnd := GetActiveHwnd()
	WinGetTitle, winTitle, ahk_id %activeHwnd%
	return winTitle
}

CopyActiveTitle(){
	activeTitle := GetActiveTitle()
	SetClipboardHTML("",, activeTitle)
}

FocusForemostHwndOnCurrentDesktop(){
	currentDesktop := GetCurrentDesktop()
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
