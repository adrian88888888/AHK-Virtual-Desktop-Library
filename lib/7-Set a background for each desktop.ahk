CallBackgroundSetterOnDesktopSwitch(){
	DllCall(RegisterPostMessageHookProc, Int, hwnd, Int, 0x1400 + 30)
	OnMessage(0x1400 + 30, "BackgroundSetter")
}

BackgroundSetter(){
	currentDesktop := GetCurrentDesktop()
	imgPath := listOfBackgrounds[currentDesktop]
	if not imgPath
	{
		imgPath := defaultImg
	}
	ChangeBackground(imgPath)
}

SetBackgroundOnDesktop(num, imgPath){
	listOfBackgrounds.InsertAt(num, imgPath)
	if (num == GetCurrentDesktop())
	{
		ChangeBackground(imgPath)
	}
}

ChangeBackground(imgPath){
	DllCall("SystemParametersInfo", UInt, 0x14, UInt, 0, Str, imgPath, UInt, 1)
}

SetDefaultBackground(imgPath){
	defaultImg := imgPath
}
