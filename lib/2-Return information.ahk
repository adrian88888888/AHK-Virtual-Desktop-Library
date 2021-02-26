GetCurrentDesktopNumber(){
	return DllCall(GetCurrentDesktopNumberProc) + 1
}

GetNumberOfDesktops(){
	return DllCall(GetDesktopCountProc)
}

GetInWichDesktopTheWindowIs(hwnd){
	return DllCall(GetWindowDesktopNumberProc, int, hwnd) + 1
}

IsWindowOnCurrentDesktop(hwnd){
	return DllCall(IsWindowOnCurrentVirtualDesktopProc, UInt, hwnd) ;esta funcion no parece funcionar correctamente
}

IsWindowOnDesktopNumber(num, hwnd){
	return DllCall(IsWindowOnDesktopNumberProc, int, hwnd, int, num - 1)
}

IsFullScreenMode(ExesToIgnore:=0){
	if ExesToIgnore
	{
		ExesToIgnore := ConvertListToString(ExesToIgnore) ; why this?: https://www.autohotkey.com/boards/viewtopic.php?f=76&t=87404&p=384395#p384395
		activeExe := GetActiveExe()
		If activeExe in %ExesToIgnore%
		{
			return False
		}
	}
	If OnDesktop() ; desktop is in full screen, so make an exeption
	{
		return False
	}
	; the folowing code was taken from https://autohotkey.com/board/topic/38882-detect-fullscreen-application/
	; probably does not have multimonitor support(i dont have 2 monitors so i cant test)
	; but, you can change the following code with this one probably? i dont knwow:
	; https://github.com/dufferzafar/Autohotkey-Scripts/blob/master/lib/IsFullScreen.ahk
	; if you fix it for multimonitor and it works, please give me your function to add it to the main repo
	; so everyone can have multimonitor support, thanksssss!
	activeHwnd := GetActiveHwnd()
	WinGet style, Style, ahk_id %activeHwnd%
	WinGetPos, , , winW, winH, ahk_id %activeHwnd%
	; 0x800000 is WS_BORDER.
	; 0x20000000 is WS_MINIMIZE.

	; if no border and not minimized return true or false
	Return ((style & 0x20800000) or winH < A_ScreenHeight or winW < A_ScreenWidth) ? false : true
}

ConvertListToString(list){
  for k,v in list
  	listInString .= v ","
  listInString := RTrim(listInString, ",")
  return listInString
}
