AltTabOnSwitch(){
	DllCall(RegisterPostMessageHookProc, Int, hwnd, Int, 0x1400 + 30)
	OnMessage(0x1400 + 30, "AltTabOnDesktop")
}

AltTabOnDesktop(){
	if OnDesktop()
		FocusLastMinimized()
}

FocusLastWindow(){
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

CallFunctionOnDesktopSwitch(){
	DllCall(RegisterPostMessageHookProc, Int, hwnd, Int, 0x1400 + 30)
	OnMessage(0x1400 + 30, "OnDesktopSwitch")
}
; If you ant to stop calling OnDesktopSwitch() in the middle of your script
; use:
; DllCall(UnregisterPostMessageHookProc, Int, hwnd, Int, 0x1400 + 30)
; OnMessage(0x1400 + 30, "OnDesktopSwitch")
; to be honest I have a hard time trying to understand this, so go to the
; creator of the dll and if you study that enough you will undestand
; the creator is in the credits

DesktopManager(){
	Send, #{Tab}
}

HoldAltTab(){
	Send, ^!{Tab}
}

ShowHideDesktop(){
	Send, #d
}
