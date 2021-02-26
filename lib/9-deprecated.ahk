GetActiveTitle(){
	activeHwnd := GetActiveHwnd()
	WinGetTitle, winTitle, ahk_id %activeHwnd%
	return winTitle
}

; funciones que intente exportar del .dll---------------

; global ViewGetFocusedProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "ViewGetFocused", "Ptr")
; global ViewSetFocusProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "ViewSetFocus", "Ptr")
; global ViewIsShownInSwitchersProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "ViewIsShownInSwitchers", "Ptr")
; global ViewGetByLastActivationOrderProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "ViewGetByLastActivationOrder", "Ptr")

;ViewGetFocused(){
	;return DllCall(ViewGetFocusedProc, UInt, hwnd)
;}
;ViewSetFocus(hwnd){
	;return DllCall(ViewSetFocusProc, UInt, hwnd)
;}
;ViewIsShownInSwitchers(hwnd){
	;return DllCall(ViewSetFocusProc, UInt, hwnd)
;}

;ViewGetByLastActivationOrder(){
	;return DllCall(ViewGetByLastActivationOrderProc, Int, what goes here?,UINT, what goes here?,BOOL, what is this for?,BOOL,1)
;}
