# vs-code-mbutton-scroll-ahk

VS Code has an unexpected middle mouse button behavior, as discussed [here](https://github.com/Microsoft/vscode/issues/6302).

Windows users can use this [autohotkey](https://www.autohotkey.com/) script to restore middle click to the expected auto-scroll.

```
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
```
