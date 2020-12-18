#IfWinActive ahk_exe Code.exe
    MButton::
        if (A_Cursor != "IBeam") {
            send {MButton}
        } else {
            scroll := true
            noScrollZone := 15
            MouseGetPos, , yinit
            while scroll {
                MouseGetPos, , y
                if (y < yinit - noScrollZone)
                    send, {WheelUp 1}
                if (y > yinit + noScrollZone)
                    send, {WheelDown 1}
                sleep 100
            }
        }
    return
#IfWinActive

#IfWinActive ahk_exe Code.exe
    MButton Up::
        scroll := false
    return
#IfWinActive
