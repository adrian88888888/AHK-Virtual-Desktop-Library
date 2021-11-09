GoToDesktop(num){
	WindowsBugFix()
	DllCall(GoToDesktopNumberProc, Int, num - 1)
	; the following 3 lines are because Windows still have bugs:
	; sometimes when going to one desktop to another the focus still
	; in the previous window of the previous desktop(dont ask me why...
	; cos windows)
	; SO I have to get the alt tab list of windows and focus the topmost
	; window EVERY time you go to another desktop
	; also, because the following lines auto alt tab when going to an empty
	; desktop  AltTabOnSwitch() its redundant and deprecated!, I didnt deleted it
	; because im lazy(at least I document everything)
	altTabList := GetAltTabList()
	lastWindow := altTabList[1]
	WinActivate, ahk_id %lastWindow%
}

GoToNextDesktop(){
	WindowsBugFix()
	currentDesktop := GetCurrentDesktop()
	nextDesktop := currentDesktop + 1
	GoToDesktop(nextDesktop)
}

GoToPrevDesktop(){
	WindowsBugFix()
	currentDesktop := GetCurrentDesktop()
	prevDesktop := currentDesktop - 1
	GoToDesktop(prevDesktop)
}

WindowsBugFix(){
	;the next line fixes a bug, you can see the solution reading those:
	;-https://github.com/Ciantic/VirtualDesktopAccessor/issues/4
	;-https://pypi.org/project/pyvda/   (read the end part)
	DllCall("user32\AllowSetForegroundWindow", Int, - 1)
}
