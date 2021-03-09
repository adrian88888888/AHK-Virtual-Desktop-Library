; overall explanation of these funtions:

; dont move current window if you are on desktop, because theres no
; current window then, thats why the "not OnDesktop()"

; dont move current window if taskbar is the current window,
; because theres no current window then

; also if you are tring to go or move a window to a desktop you
; are, then dont do it, thats why the "and not OnDesktopToGo(num)"

; ------------------------------------------
; im done working on this, sorry, theres only 2
; bugs im not going to fix unless theres a lot of
; people asking for it:
; 1- if you move the current window and the taskbar is focus,
; move the foremost maximized window instead, unless everything
; is minimized
; 2- if everithing is minimized exept one window it will focus
; the last minimized window, its a bug, but is an usefull one,
; thats why i didnt fix it

; this code is how the solution would look like:
; to fix both you need to know if the first alt tab window is
; minimized or maximized:

; IsFirstAltTabWindowForemost(){
; 	altTabList := GetAltTabList()
; 	firstAltTabWindow := altTabList[1]
; 	WinGet IsWindowMaximized, MinMax, firstAltTabWindow
; 	If IsWindowMaximized
; 	{
; 		return x
; 	}
; 	else
; 	{
; 		return x
; 	}
; }

; also:
; https://www.autohotkey.com/boards/viewtopic.php?t=59651

; and then act in accordance inside the function MoveCurrentWindowToDesktop()

; if you fix this do a push request!, thanks


MoveCurrentWindowToDesktop(num){
	if not OnDesktop() and not OnTaskBar() and not OnDesktopToGo(num)
	{
		hwndToMove := GetActiveHwnd()
		FocusLastWindow()
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
			FocusLastWindow()
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
