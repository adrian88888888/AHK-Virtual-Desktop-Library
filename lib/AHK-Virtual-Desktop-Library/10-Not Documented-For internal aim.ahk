ConvertListToString(list){
  for k,v in list
  	listInString .= v ","
  listInString := RTrim(listInString, ",")
  return listInString
}

OnDesktop(){
	activeClass := GetActiveClass()
	desktopClass := "WorkerW"
	if (activeClass == desktopClass)
		return True
	else
		return False
}

OnTaskBar(){
	activeClass := GetActiveClass()
	taskBarClass := "Shell_TrayWnd"
	if (activeClass == taskBarClass)
		return True
	else
		return False
}

; yes, the following funtions are the same, i do it so in the actual code that uses it reads better

OnDesktopToGo(num){ ; why this funtion: if you are tring to go or move a window to a desktop you are, then dont do it!, how? put "if not OnDesktopToGo()"
	currentDesktop := GetCurrentDesktop()
	if (currentDesktop == num)
		return True
	else
		return False
}

OnDesktopToMoveWindowTo(num){ ; why this funtion: if you are tring to go or move a window to a desktop you are, then dont do it!, how? put "if not OnDesktopToGo()"
	currentDesktop := GetCurrentDesktop()
	if (currentDesktop == num)
		return True
	else
		return False
}
