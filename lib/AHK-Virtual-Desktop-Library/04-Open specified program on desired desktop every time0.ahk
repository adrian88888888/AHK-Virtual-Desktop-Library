; https://www.autohotkey.com/boards/viewtopic.php?f=76&t=86967

AlwaysOpenOnDesktopNumber(num, exe:=""){
	if (exe == "Explorer.EXE")
    WinHook.Shell.Add(Func("MoveAndFocus").Bind(num),,CabinetWClass,,1)
	else
	{
		DetectHiddenWindows On ; FuncOrMethod will be called with DetectHiddenWindows On.....tbh i got no idea why this, see the documentation of WinHook class
		WinHook.Shell.Add(Func("MoveAndFocus").Bind(num),,,exe,1)
	}
}

MoveAndFocus(num, hwndToMove){
	currentDesktop := GetCurrentDesktop()
	if (currentDesktop != num) ; if the window is opening in the desktop that is suposed to because you are already on that one: then do nothing
	{
		DllCall(MoveWindowToDesktopNumberProc, UInt, hwndToMove, UInt, num - 1)
		altTabList := GetAltTabList()
		lastWindow := altTabList[1]
		WinActivate, ahk_id %lastWindow%
	}
}

AlwaysOpenOnDesktopNumberAndGo(num, exe:=""){
  if (exe == "Explorer.EXE")
    WinHook.Shell.Add(Func("GoMoveAndFocus").Bind(num),,CabinetWClass,,1)
  else
    WinHook.Shell.Add(Func("GoMoveAndFocus").Bind(num),,class,exe,1)
}

GoMoveAndFocus(num, hwndToMove){
	currentDesktop := GetCurrentDesktop()
	if (currentDesktop != num) ; if the window is opening in the desktop that is suposed to because you are already on that one: then do nothing
	{
		GoToDesktop(num)
		DllCall(MoveWindowToDesktopNumberProc, UInt, hwndToMove, UInt, num - 1)
		WinActivate, ahk_id %hwndToMove%
	}
}
