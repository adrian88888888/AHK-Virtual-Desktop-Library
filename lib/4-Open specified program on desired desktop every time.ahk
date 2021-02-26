AlwaysOpenOnDesktopNumber(num, winExe:=""){
	DetectHiddenWindows On ; FuncOrMethod will be called with DetectHiddenWindows On
	WinHook.Shell.Add(Func("MoveWindowToDesktop").Bind(num),,,winExe,1) ; https://www.autohotkey.com/boards/viewtopic.php?f=76&t=86967
}

;AlwaysOpenOnDesktopNumberAndGo(num, winTitle:="", winExe:=""){
	;WinHook.Shell.Add(Func("MoveWindowToDesktop").Bind(num),,,winExe,1) ; https://www.autohotkey.com/boards/viewtopic.php?f=76&t=86967
	;GoToDesktopNumber(num)
;}
