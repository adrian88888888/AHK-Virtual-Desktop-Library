# AHK_Vitrual_Desktop_Library

# Introduction:
In windows 10 you can use virtual desktops, this library gives you functions to manipulate them, for example: `GoToDesktopNumber(desktop_number)`, `GetCurrentDesktopNumber()`,`GetNumberOfDesktops()`, `MoveCurrentWindowToDesktop(desktop_number)`

- [Installation](https://github.com/adrian88888888/AHK_Vitrual_Desktop_Library/blob/main/README.md#installation "Installation")
- [Working AHK Example](https://github.com/adrian88888888/AHK_Vitrual_Desktop_Library/blob/main/README.md#working-ahk-example "Working ahk example")

------------------

# Documentation:

## Do basic stuff:
| Functions  |  Description |
| :------------ | :------------ |
|`GoToDesktopNumber(desktop_number)` |  Goes to the desired desktop |
|`GoToNextDesktop()` |  Goes to the next desktop |
|`GoToPrevDesktop()`  |  Goes to the previous desktop |


## Return information:
| Functions  |  Description |
| :------------ | :------------ |
|`GetCurrentDesktopNumber()` | Returns the number of the current desktop  |
|`GetNumberOfDesktops()`  |  Returns the total number of virtual desktops |
|`GetInWichDesktopTheWindowIs(hwnd)` |  Return in which desktop a given hwnd is /le cambie el nombre a la funcion|
|`IsWindowOnCurrentDesktop(hwnd)` |  Return if the given hwnd is in the current desktop /le cambie el nombre|
|`IsWindowOnDesktopNumber(desktop_number, hwnd)`| Return if a hwnd is in a specified desktop  /le cambie el orden a los parametros|

## Move windows between desktops:
| Functions  |  Description |
| :------------ | :------------ |
|`MoveCurrentWindowToDesktop(desktop_number)` |  Moves current window to the desired desktop |
|`MoveWindowToDesktop(desktop_number, hwnd)` |  Moves window to the desired desktop /not done|
|`MoveAndGoToDesktop(desktop_number, hwnd)` | Moves current window to the desired desktop and goes to that one /add hwnd parameter to the code|

## Open specified program on desired desktop every time:
| Functions  |  Description |
| :------------ | :------------ |
|`AlwaysOpenOnDesktopNumber(desktop_number, winClass, winTitle, winExe)`|Every time you open the a specified program(does not matter how) it will open in the desired desktop|
|`AlwaysOpenOnDesktopNumberAndGo(desktop_number, winClass, winTitle, winExe)`|Every time you open the a specified program(does not matter how) it will open in the desired desktop and move to that one/add new parameters to the code|

## Misc:
| Functions  |  Description |
| :------------ | :------------ |
|`CallFunctionOnDesktopSwitch(bool)` |  If true calls a funcion named `OnDesktopSwitch()` each time the desktop changes, if true then YOU need to create that funcion`OnDesktopSwitch()` and add to it what you want to happen every time the desktop changes<br/>If false stops calling that function, is not obligatory to use|
|`Pin()`|When you pin a Window, it will stay in all desktops, note: Windows remember pins even if the script closes, so remember to unpin if you want that|
|`UnPin()`|implement|

# Working AHK Example:
```autohotkey
#Include AHK_Vitrual_Desktop_Library.ahk

q::GoToNextDesktop()
w::GoToPrevDesktop()

1::GoToDesktopNumber(1)
2::GoToDesktopNumber(2)
3::GoToDesktopNumber(3)

z::
currentDesktop := GetCurrentDesktopNumber()
MsgBox, You are on desktop number %currentDesktop%
return

x::MoveCurrentWindowToDesktop(3)

a::CallFunctionOnDesktopSwitch(true)

OnDesktopSwitch(){
	MsgBox, I run every time the desktop changes
}

s::CallFunctionOnDesktopSwitch(false)

AlwaysOpenOnDesktopNumber(3,"MSPaintApp") ;opens paint always on desktop 3

Escape::ExitApp
```

# Installation:
1. Download the ".ahk" file and the "VirtualDesktopAccessor.dll"
2. Does not matter where you put the folder but the 2 files have to be in the SAME folder
3. Then include in your script the ahk library like this:
```autohotkey
#Include ...the-dir-with-the-2-files...\AHK_Vitrual_Desktop_Library.ahk
```
4. This DLL and library works only on 64 bit Windows 10 and it was tested with 1809 build 17663<br/>
Also you probably need [VS 2017 runtimes vc_redist.x64.exe and/or vc_redist.x86.exe](https://support.microsoft.com/en-us/help/2977003/the-latest-supported-visual-c-downloads "VS 2017 runtimes vc_redist.x64.exe and/or vc_redist.x86.exe"), if they are not installed already

# Credits:
I want to thank Ciantic because he did the .dll that connects with Windows, thats black magic for me, so thanks<br/>
Ciantic: https://github.com/Ciantic/VirtualDesktopAccessor<br/>

I want to thank lschwahn because he did a complex program and i took ideas from his code<br/>
lschwahn: https://github.com/lschwahn/win-10-virtual-desktop-enhancer<br/>

As a newbie I couldn't find something easy to use, something ready to go, something with documentation, so here it is, that´s the only part where I take credit

Also thanks to tom-bowles for a "bug fix" [here](https://github.com/Ciantic/VirtualDesktopAccessor/issues/4 "here"), it was really usefull<br/>
tom-bowles: https://github.com/tom-bowles
