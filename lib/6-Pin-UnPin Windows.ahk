PinWindow(hwnd){
	return DllCall(PinWindowProc, UInt, hwnd)
}

UnpinWindow(hwnd){
	return DllCall(UnpinWindowProc, UInt, hwnd)
}

IsWindowPinned(hwnd){
	return DllCall(IsPinnedWindowProc, UInt, hwnd)
}

PinApp(hwnd){
	return DllCall(PinAppProc, UInt, hwnd)
}

UnpinApp(hwnd){
	return DllCall(UnpinAppProc, UInt, hwnd)
}

IsAppPinned(hwnd){
	return DllCall(IsPinnedAppProc, UInt, hwnd)
}
