; autohotkey script to enable middle mouse button scrolling in VS Code
; with the cursor in a text area, hold down the middle mouse button to scroll
; outside of text areas, middle mouse is unaffected

#IfWinActive ahk_exe Code.exe ; script is only active in VS Code
	MButton:: ; on middle mouse button click, do the following
		; check if the cursor is in a text area
		; if no, send a regular middle click
		; if yes, scroll
		if (A_Cursor != "IBeam") {
			send {MButton}
		} else {
			scroll := true ; activate scroll
			noScrollZone := 10 ; no scrolling until the mouse moves at least this far
			MouseGetPos, xinit , yinit ; initial position of cursor when middle mouse button is clicked
			while scroll { ; loop until middle mouse button is released
				ToolTip, SCROLLING ; visual indication that scroll is active
				MouseGetPos, x , y ; current position of cursor
				; check the four cases
				if (y < yinit - noScrollZone) ; up
					send, {WheelUp 1}
				if (y > yinit + noScrollZone) ; down
					send, {WheelDown 1}
				if (x < xinit - noScrollZone) ; left
					send, {WheelLeft 1}
				if (x > xinit + noScrollZone) ; right
					send, {WheelRight 1}
				; make speed of scroll react to cursor position
				dist := Round( Sqrt( ( x - xinit )**2 + ( y - yinit )**2 ) ) ; cursor's distance from initial position
				sleepTime := Max( 300 - dist, 0 ) ; a lower sleeptime gives a faster scroll
				; sleepTime:= 100 ; uncomment this line to get a constant scroll speed
				sleep sleepTime ; loop pauses for this length of time
			}
		}
	return
#IfWinActive

#IfWinActive ahk_exe Code.exe ; script is only active in VS Code
	MButton Up:: ; on middle mouse button release, do the following
		scroll := false ; cancel scroll
		ToolTip ; cancel tooltip
	return
#IfWinActive
