; overall explanation of these funtions:
; dont move current window if you are on desktop, because theres no
; current window then, thats why the "not OnDesktop()"

; dont move current window if taskbar is the current window,
; because theres no current window then
; move the foremost maximized window instead, unless everything
; is minimized, esta parte tengo que hacerla aun

; also if you are tring to go or move a window to a desktop you
; are, then dont do it, thats why the "and not OnDesktopToGo(num)"

MoveCurrentWindowToDesktop(num){ ; happy bug: when everything is minimized exept one window: if you move that window it will focus the last minimized window, you could say its a bug, i call it a feature
	if not OnDesktop() and not OnTaskBar() and not OnDesktopToGo(num)
	{
		hwndToMove := GetActiveHwnd()
		FocusLast()
		DllCall(MoveWindowToDesktopNumberProc, UInt, hwndToMove, UInt, num - 1)
	}
}

MoveCurrentWindowToDesktopAndGo(num){
	if not OnDesktop() and not OnTaskBar() and not OnDesktopToGo(num)
	{
		hwndToMove := GetActiveHwnd()
		DllCall(MoveWindowToDesktopNumberProc, UInt, hwndToMove, UInt, num - 1)
		GoToDesktop(num)
	}
}

MoveWindowToDesktop(num, hwndToMove){
	if not OnDesktopToMoveWindowTo(num)
	{
		if IsHwndActive(hwndToMove)
		{
			FocusLast()
		}
		DllCall(MoveWindowToDesktopNumberProc, UInt, hwndToMove, UInt, num - 1)
	}
}

MoveWindowToDesktopAndGo(num, hwndToMove){
	if not OnDesktopToMoveWindowTo(num)
	{
		DllCall(MoveWindowToDesktopNumberProc, UInt, hwndToMove, UInt, num - 1)
		GoToDesktop(num)
	}
}
