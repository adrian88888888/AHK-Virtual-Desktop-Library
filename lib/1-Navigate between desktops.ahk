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
