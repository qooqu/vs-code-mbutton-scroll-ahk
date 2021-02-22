#IfWinActive ahk_exe Code.exe
	; autohotkey script to enable middle mouse button scrolling in VS Code
	; with the cursor in a text area, hold down the middle mouse button to scroll
	; outside of text areas, middle mouse is unaffected
	MButton:: ; on middle mouse button click, do the following
		; check if the cursor is in a text area
		; if no, send a regular middle click
		; if yes, scroll
		if (A_Cursor != "IBeam") {
			send {MButton}
		} else {
			scroll := true ; activate scroll
			noScrollZone := 15 ; no scrolling until the mouse moves at least this far
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
				sleep 100 ; controls speed of scroll ... this could be improved
			}
		}
	return
#IfWinActive

#IfWinActive ahk_exe Code.exe
	MButton Up:: ; on middle mouse button release, do the following
		scroll := false ; cancel scroll
		ToolTip ; cancel tooltip
	return
#IfWinActive
