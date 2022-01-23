; autohotkey script to enable middle mouse button scrolling in VS Code
; with the cursor in a text area, hold down the middle mouse button to scroll
; outside of text areas, middle mouse is unaffected

#IfWinActive ahk_exe Code.exe ; script is only active in VS Code
	MButton:: ; on middle mouse button click, do the following
		; check if the cursor is in a text area
		; if no, send a regular middle click
		; if yes, scroll
		global hasScrollingStarted := false ; used to allow click then scroll without holding
		noScrollZone := 10 ; no scrolling until the mouse moves at least this far
		smooth := 80 ; higher smooth value makes scroll less smooth
		acceleration := 1.09 ; higher acceleration value makes scroll start accelerating sooner
		slow := 10 ; lower slow value increases scroll speed
		symbol := Chr(10021) ; html character code for four direction arrow symbol
		verticalScroll(y, yinit, noScrollZone) {
			if (y < yinit - noScrollZone) {
				send, {WheelUp 1}
				hasScrollingStarted := true
			} ; up
			if (y > yinit + noScrollZone) {
				send, {WheelDown 1}
				hasScrollingStarted := true
			} ; down
		}
		horizontalScroll(x, xinit, noScrollZone) {
			if (x < xinit - noScrollZone) {
				send, {WheelLeft 1}
				hasScrollingStarted := true
			} ; left
			if (x > xinit + noScrollZone) {
				send, {WheelRight 1}
				hasScrollingStarted := true
			} ; right
		}
		if (A_Cursor != "IBeam") {
			send {MButton}
		} else {
			scroll := true ; activate scroll
			MouseGetPos, xinit , yinit ; initial position of cursor when middle mouse button is clicked
			; the tooltip is locked to its initial position
			ToolTip, %symbol%, xinit, yinit ; visual indication that scroll is active
			while scroll { ; loop until middle mouse button is released
				MouseGetPos, x , y ; current position of cursor
				; check the four cases
				if (GetKeyState("Ctrl")) { ; hold ctrl while scrolling for vertical and horizontal scroll
					verticalScroll(y, yinit, noScrollZone)
					horizontalScroll(x, xinit, noScrollZone)
				} else if (GetKeyState("Shift")) { ; hold shift for horizontal scroll
					horizontalScroll(x, xinit, noScrollZone)
				} else { ; default is vertical scroll
					verticalScroll(y, yinit, noScrollZone)
				}
				; make speed of scroll react to cursor position
				dist := Round( Sqrt( ( x - xinit )**2 + ( y - yinit )**2 ) ) ; cursor's distance from initial position
				sleepTime := Max( smooth - ( dist / slow ) ** acceleration, 0 ) ; a lower sleeptime gives a faster scroll
				; sleepTime:= 100 ; uncomment this line to get a constant scroll speed
				sleep sleepTime ; loop pauses for this length of time
			}
		}
	return

	MButton Up:: ; on middle mouse button release, do the following
		if (hasScrollingStarted) { ; if the user has scrolled, scrolling without holding is off
			scroll := false ; cancel scroll
			ToolTip ; cancel tooltip
			hasScrollingStarted := false
		} else { ; if the user clicked and released without scrolling, scrolling without holding is on
			hasScrollingStarted := true
		}
	return
#IfWinActive
