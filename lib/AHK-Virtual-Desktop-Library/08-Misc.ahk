AltTabOnSwitch(bool){
	if (bool = true)
	{
		DllCall(RegisterPostMessageHookProc, Int, hwnd, Int, 0x1400 + 30)
		OnMessage(0x1400 + 30, "AltTabOnDesktop")
	}
	if (bool = false)
	{
		DllCall(UnregisterPostMessageHookProc, Int, hwnd, Int, 0x1400 + 30)
		OnMessage(0x1400 + 30, "AltTabOnDesktop")
	}
}

AltTabOnDesktop(){
	if OnDesktop()
		FocusLastMinimized()
}

FocusLast(){
	if OnDesktop()
		FocusLastMinimized()
	else
		FocusSecondForemostWindow()
}

FocusLastMinimized(){
	altTabList := GetAltTabList()
	lastWindow := altTabList[1]
	WinActivate, ahk_id %lastWindow%
}

FocusSecondForemostWindow(){
	altTabList := GetAltTabList()
	lastWindow := altTabList[2]
	WinActivate, ahk_id %lastWindow%
}

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

OpenDesktopManager(){
	Send, #{Tab}
}

OpenAltTab(){
	Send, ^!{Tab}
}

ShowHideDesktop(){
	Send, #d
}
