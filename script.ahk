#IfWinActive ahk_exe Code.exe
	MButton::
		scroll := true
		MouseGetPos, , yinit
		while scroll {
			MouseGetPos, , y
			if (y < yinit)
				send, {WheelUp 1}
			else
				send, {WheelDown 1}
			sleep 100
		}
	return
#IfWinActive

#IfWinActive ahk_exe Code.exe
	MButton Up::
		scroll := false
	return
#IfWinActive
