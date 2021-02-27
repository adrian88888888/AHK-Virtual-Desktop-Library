GoToDesktop(num){
	BugFix()
	DllCall(GoToDesktopNumberProc, Int, num - 1)
	return
}

GoToNextDesktop(){
	BugFix()
	currentDesktop := GetCurrentDesktop()
	nextDesktop := currentDesktop + 1
	GoToDesktop(nextDesktop)
}

GoToPrevDesktop(){
	BugFix()
	currentDesktop := GetCurrentDesktop()
	prevDesktop := currentDesktop - 1
	GoToDesktop(prevDesktop)
}

BugFix(){
	;the next line fixes a bug, you can see the solution reading those:
	;-https://github.com/Ciantic/VirtualDesktopAccessor/issues/4
	;-https://pypi.org/project/pyvda/   (read the end part)
	DllCall("user32\AllowSetForegroundWindow", Int, - 1)
}
