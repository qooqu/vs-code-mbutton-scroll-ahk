# vs-code-mbutton-scroll-ahk

Middle mouse button doesn't scroll in VS Code, as discussed [here](https://github.com/Microsoft/vscode/issues/6302).

Windows users can use this [autohotkey](https://www.autohotkey.com/) script as a workaround.

Please see https://github.com/qooqu/vs-code-mbutton-scroll-ahk/blob/main/script.ahk for the code.

Note that the script only modifies the middle click if the cursor is inside the text area. If the cursor is outside of the text area (`if (A_Cursor != "IBeam")`), middle click is unaffected.
