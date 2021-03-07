DetectHiddenWindows, On
hwnd:=WinExist("ahk_pid " . DllCall("GetCurrentProcessId","Uint"))
hwnd+=0x1000<<32

hVirtualDesktopAccessor := DllCall("LoadLibrary", Str, "lib\AHK-Virtual-Desktop-Library\3rd party\VirtualDesktopAccessor.dll", "Ptr")
global GoToDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "GoToDesktopNumber", "Ptr")
global GetCurrentDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "GetCurrentDesktopNumber", "Ptr")
global GetDesktopCountProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "GetDesktopCount", "Ptr")
global IsWindowOnCurrentVirtualDesktopProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "IsWindowOnCurrentVirtualDesktop", "Ptr")
global MoveWindowToDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "MoveWindowToDesktopNumber", "Ptr")
global RegisterPostMessageHookProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "RegisterPostMessageHook", "Ptr")
global UnregisterPostMessageHookProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "UnregisterPostMessageHook", "Ptr")
global RestartVirtualDesktopAccessorProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "RestartVirtualDesktopAccessor", "Ptr")
global GetWindowDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "GetWindowDesktopNumber", "Ptr")
global IsWindowOnDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "IsWindowOnDesktopNumber", "Ptr")
global IsPinnedWindowProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "IsPinnedWindow", "Ptr")
global PinWindowProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "PinWindow", "Ptr")
global UnPinWindowProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "UnPinWindow", "Ptr")
global IsPinnedAppProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "IsPinnedApp", "Ptr")
global PinAppProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "PinApp", "Ptr")
global UnPinAppProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "UnPinApp", "Ptr")



; variables related with SetBackgroundOnDesktop(), SetDefaultBackground():
global listOfBackgrounds := []
global defaultBackground :=
global aBackgroundWasSetInADesktop :=

; 3rd paty
#Include lib\AHK-Virtual-Desktop-Library\3rd party\SetClipboardHTML.ahk
#Include lib\AHK-Virtual-Desktop-Library\3rd party\WinHook.ahk
; -------------

#Include lib\AHK-Virtual-Desktop-Library\1-Navigate between desktops.ahk
#Include lib\AHK-Virtual-Desktop-Library\2-Return information.ahk
#Include lib\AHK-Virtual-Desktop-Library\3-Move windows between desktops.ahk
#Include lib\AHK-Virtual-Desktop-Library\4-Open specified program on desired desktop every time.ahk
#Include lib\AHK-Virtual-Desktop-Library\5-Open-Close Desktop.ahk
#Include lib\AHK-Virtual-Desktop-Library\6-Pin-UnPin Windows.ahk
#Include lib\AHK-Virtual-Desktop-Library\7-Set a background for each desktop.ahk
#Include lib\AHK-Virtual-Desktop-Library\8-Misc.ahk
#Include lib\AHK-Virtual-Desktop-Library\9-Built in Functions.ahk



RestartVirtualDesktopAccessorOnDemand()
ChangeBackgroundOnDesktopSwitch()

RestartVirtualDesktopAccessorOnDemand(){ ; its needed when Explorer.exe crashes or restarts(e.g. when coming from fullscreen game)
	explorerRestartMsg := DllCall("user32\RegisterWindowMessage", "Str", "TaskbarCreated")
	OnMessage(explorerRestartMsg, "RestartVirtualDesktopAccessor")
}

RestartVirtualDesktopAccessor(){
	DllCall(RestartVirtualDesktopAccessorProc, UInt, result)
}
