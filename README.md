# AHK_Virtual_Desktop_Library

# Introduction:
In Windows you can use virtual desktops, this library gives you functions to manipulate them<br/>
For example:
- `GoToDesktopNumber(desktop_number)`
- `GetNumberOfDesktops()`
- `MoveCurrentWindowToDesktop(desktop_number)`
- `NewDesktop(desktop_number)`
- you can open a program always on a specifed desktop
- `GetAltTabList()`
- and more!

## Index:
- [Usefull ideas to use this library(by the community)](https://github.com/adrian88888888/AHK_Virtual_Desktop_Library/blob/main/README.md#usefull-ideas-to-use-this-libraryby-the-community "Usefull ideas to use this library(by the community)")
- [Working AHK Example](https://github.com/adrian88888888/AHK_Vitrual_Desktop_Library/blob/main/README.md#working-ahk-example "Working ahk example")
- [Documentation](https://github.com/adrian88888888/AHK_Vitrual_Desktop_Library/blob/main/README.md#documentation "Documentation")
- [Credits](https://github.com/adrian88888888/AHK_Vitrual_Desktop_Library/blob/main/README.md#credits "Credits")
- [Installation](https://github.com/adrian88888888/AHK_Vitrual_Desktop_Library/blob/main/README.md#installation "Installation")

------------------

# Documentation:

Note: a lot of functions takes the parameter hwnd, you can use the [Built in Function](https://github.com/adrian88888888/AHK_Vitrual_Desktop_Library/blob/main/README.md#usefull-built-in-functions "Built in Functions") `GetActiveHwnd()` to get the active hwnd<br/>
To the newbies: hwnd = ahk_id = it's an id that every window has

## Navigate between desktops:
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
|`MoveCurrentWindowToDesktop(desktop_number)`|Moves current window to the desired desktop|
|`MoveWindowToDesktop(desktop_number, hwnd)`|Moves window to the desired desktop /not done|
|`MoveAndGoToDesktop(desktop_number, hwnd)`|Moves current window to the desired desktop and goes to that one /add hwnd parameter to the code|

## Open specified program on desired desktop every time:
| Functions  |  Description |
| :------------ | :------------ |
|`AlwaysOpenOnDesktopNumber(desktop_number, winClass, winExe)`|You can use this to have your favourite programs in the desktops you want.<br/>Every time you open the a specified program(does not matter how) it will open in the desired desktop.<br/>Only recives 2 parameters: the desktop_number and winClass OR the winExe.<br/>In this part you can use the [Built in Functions](https://github.com/adrian88888888/AHK_Vitrual_Desktop_Library/blob/main/README.md#usefull-built-in-functions "Built in Functions") to make it easier.<br/>If everything starts to open in that desktop and not the program you want, that means that the parameters are wrong|
|`AlwaysOpenOnDesktopNumberAndGo(desktop_number, winClass, winExe)`|Same as above, but also goes to that desktop|

## Pin/UnPin:
When you pin a Window or an App, it means that it will stay in all desktops, Windows remember pins even if the script closes, so remember to unpin if you want to
| Functions  |  Description |
| :------------ | :------------ |
|`PinWindow(hwnd)`|Pins the specified window(making it stay in all desktops)|
|`UnPinWindow(hwnd)`|UnPins the specified window|
|`IsPinnedWindow(hwnd)`|Returns 1 if pinned, 0 if not pinned, -1 if not valid|
|`PinApp(hwnd)`|Pins the specified app(making it stay in all desktops)|
|`UnPinApp(hwnd)`|UnPins the specified app|
|`IsPinnedApp(hwnd)`|Returns 1 if pinned, 0 if not pinned, -1 if not valid|

## Misc:
| Functions  |  Description |
| :------------ | :------------ |
|`AltTabOnSwitch(bool)`|If true when you go to another desktop and everything is minimized it will automaticaly alt+tab(it does not send the keystrokes Alt+Tab because I tryed and looks bad and has bugs, the script imitates alt tab, does not use it)|
|`CallFunctionOnDesktopSwitch(bool)`|If true calls a funcion named `OnDesktopSwitch()` each time the desktop changes, if true then YOU need to create that funcion`OnDesktopSwitch()` and add to it what you want to happen every time the desktop changes<br/>If false stops calling that function|
|`OpenDesktopManager()`|If you call it again it closes it|

## Usefull Built in Functions:
Meant to make it easier<br/>
| Functions  |  Description |
| :------------ | :------------ |
|`GetAltTabList()`|Returns a list of hwnd of the alt tab, the order of the list: from foremost to the one in the back|
|`GetActiveHwnd()`|Returns the hwnd of the active window|
|`GetActiveClass()`|Returns the class of the active window|
|`GetActiveExe()`|Returns the exe of the active window|
|`CopyActiveHwnd()`|Copies into the clipboard the hwnd of the active window|
|`CopyActiveClass()`|Copies into the clipboard the class of the active window|
|`CopyActiveExe()`|Copies into the clipboard the exe of the active window|

# Working AHK Example:
I put a bunch of hotkeys together so you can test it for yourself, with escape you exit
```autohotkey
#Include, AHK_Virtual_Desktop_Library.ahk

GoToDesktopNumber(2) ; tip: if you call this at the beginning and if you start the scritp with windows, you will start always on the desktop you want

q::GoToNextDesktop()
w::GoToPrevDesktop()
e::OpenDesktopManager() ; press again to close

1::GoToDesktopNumber(1)
2::GoToDesktopNumber(2)
3::GoToDesktopNumber(3)

z::
currentDesktop := GetCurrentDesktopNumber()
MsgBox, You are on desktop number %currentDesktop%
return

x::MoveCurrentWindowToDesktop(3)

a::CallFunctionOnDesktopSwitch(true) ; If true calls a funcion named OnDesktopSwitch(), is not obligatory to use

OnDesktopSwitch(){
	MsgBox, I run every time the desktop changes, I stop with the key "s"
	; one of the things you can put here is FocusLastIfOnDesktop(): if you go to another desktop 
	; and everything is minimized it will press alt tab
}

s::CallFunctionOnDesktopSwitch(false) ; stops calling OnDesktopSwitch()

; You can use this to have your favourite programs in the desktops you want:
; opens paint always on desktop 3 using his winClass:
AlwaysOpenOnDesktopNumber(3,"MSPaintApp")
; opens notepad always on desktop 1 using his winExe:
AlwaysOpenOnDesktopNumber(1,,"Notepad.exe")

; to get the hwnd, class and exe easier:
r::CopyActiveHwnd() ; thats it, just paste it wherever you want
t::CopyActiveClass()
y::CopyActiveExe()

;Pin current window(remember to unpin)
f::
activeHwnd := GetActiveHwnd() ; you can use the built in function GetActiveHwnd() to get the active hwnd
PinWindow(activeHwnd)
return

;UpPin current window
g::
activeHwnd := GetActiveHwnd() ; you can use the built in function GetActiveHwnd() to get the active hwnd
UnPinWindow(activeHwnd)
return

Escape::ExitApp
```
# Usefull ideas to use this library(by the community):
If you have any usefull way you use this library and is not in this list, please open an isue and tell me so i add it to this list, that way i hope between everyone we get a good list
I also put only original ideas, pressing 1,2,3 to go to desktop 1,2,3 its not going to be here
- Go to the next/prev desktop when mouse touches the left/right side of the screen(idea from adrian88888888)
- Move a window to the next/prev desktop when dragged to the left/right side of the screen(idea from Ciantic)
- When you go to another desktop and everything is minimized it will automaticaly focus the last minimized(idea from adrian88888888)
- Have your favourite programs open always in the desktops you want(no matter how you open them)(idea from adrian88888888)
- Set a backgound for every desktop(idea from lschwahn)

# Installation:
Note: This DLL and library works only on 64 bit Windows 10 and it was tested with 1809 build 17663<br/>
1. You probably need [VS 2017 runtimes vc_redist.x64.exe and/or vc_redist.x86.exe](https://support.microsoft.com/en-us/help/2977003/the-latest-supported-visual-c-downloads "VS 2017 runtimes vc_redist.x64.exe and/or vc_redist.x86.exe") if they are not installed already
2. Download the file AHK_Vitrual_Desktop_Library.ahk and the folder lib
3. Put them in the same folder as your script
4. You should end up with your script, the AHK_Vitrual_Desktop_Library.ahk and the lib folder, all in the same folder
6. Then include it in your script:
```autohotkey
#Include, AHK_Virtual_Desktop_Library.ahk
```
5. I really recomend deactivating the animation of changing desktops, try it for a while, to do so search it on google or:<br/>
Win+r > sysdm.cpl > enter > advanced options > performance > configuration > UnTic the Animate windows when minimizing and maximizing > apply > ok

# Credits:
I want to thank Ciantic(Jari Pennanen) because he did the .dll that connects to Windows, thats black magic for me, so thanks<br/>
Ciantic: https://github.com/Ciantic/VirtualDesktopAccessor<br/>

Thanks to lschwahn because he did a complex program and I took ideas from his code<br/>
lschwahn: https://github.com/lschwahn/win-10-virtual-desktop-enhancer<br/>

As a newbie I couldn't find something easy to use, something ready to go, something with documentation, so here it is, that´s the only part where I take credit

Credits to Fanatic Guru for the [[Class] WinHook](https://www.autohotkey.com/boards/viewtopic.php?t=59149 "[Class] WinHook")

Thanks SKAN for the [function that copies to the clipboard](https://www.autohotkey.com/boards/viewtopic.php?f=6&t=80706&hilit=SetClipboardHTML")

Also thanks to tom-bowles for a "bug fix" [here](https://github.com/Ciantic/VirtualDesktopAccessor/issues/4 "here"), it was really usefull
