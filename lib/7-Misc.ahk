AltTabOnSwitch(bool){
	if (bool = true)
	{
		DllCall(RegisterPostMessageHookProc, Int, hwnd, Int, 0x1400 + 30)
		OnMessage(0x1400 + 30, "AltTab")
	}
	if (bool = false)
	{
		DllCall(UnregisterPostMessageHookProc, Int, hwnd, Int, 0x1400 + 30)
		OnMessage(0x1400 + 30, "AltTab")
	}
}

AltTab(){ ; mejorar el nombre de esta funcion
	if OnDesktop()
	{
		FocusLastMinimized()
	}
	else
	{
		FocusLastWindow()
	}
}

OnDesktop(){
	activeClass := GetActiveClass()
	desktopClass := "WorkerW"
	if (activeClass == desktopClass)
	{
		return True
	}
	else
	{
		return False
	}
}

FocusLastMinimized(){
	altTabList := GetAltTabList()
	lastWindow := altTabList[1]
	WinActivate, ahk_id %lastWindow%
	;WinGetTitle, x, ahk_id %lastWindow%
	;MsgBox, %x%
}

FocusLastWindow(){
	altTabList := GetAltTabList()
	lastWindow := altTabList[2]
	WinActivate, ahk_id %lastWindow%
	;WinGetTitle, x, ahk_id %lastWindow%
	;MsgBox, %x%
}
;en construccion-----------

; global listOfBackgrounds := []
;
; BackgroundSetter(){
; 	currentDesktop := GetCurrentDesktopNumber()
; 	if (currentDesktop == 1)
; 	{
; 		ChangeBackground(1png)
; 	}
; 	if (currentDesktop == 2)
; 	{
; 		ChangeBackground(2png)
; 	}
; }
;
; SetBackgroundOnDesktop(num, imgPath){
; 	listOfBackgrounds.push(num)
; }
;
; SetBackgroundOnDesktop(1, imgPath)
;
; ChangeBackground(imgPath){
; 	DllCall("SystemParametersInfo", UInt, 0x14, UInt, 0, Str, imgPath, UInt, 1)
; }
;--------------------------


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
