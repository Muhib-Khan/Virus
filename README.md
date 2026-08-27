# InputBlocker

> **Warning:** This script uses `BlockInput` to lock the mouse and keyboard on the host
> machine. It **must be run as Administrator** (the script self-elevates via UAC).
> It will freeze all input until you press a hotkey below.

An AutoHotkey v1 utility that blocks both mouse and keyboard input at startup, with
hotkeys to selectively re-enable them or perform an emergency unblock.

## Requirements

- Windows 10/11
- [AutoHotkey v1.1](https://www.autohotkey.com/download/) (or compile to `.exe` with Ahk2Exe)

## Usage

Run `src\InputBlocker.ahk` (double-click). UAC will prompt — accept it, because
`BlockInput` silently fails without Administrator rights.

On start, both mouse and keyboard are **blocked**.

## Hotkeys

| Hotkey            | Action                          |
|-------------------|---------------------------------|
| `Ctrl+Alt+M`      | Re-enable mouse only            |
| `Ctrl+Alt+K`      | Re-enable keyboard only         |
| `Ctrl+Alt+Shift+B`| Re-enable both, then exit       |
| `Ctrl+Alt+Esc`    | Emergency unblock both + exit   |

> These hotkeys still fire while input is blocked because they are handled by the
> low-level keyboard hook, which runs above `BlockInput` filtering.

## Notes

- Notifications use `TrayTip` only — no dialogs that could hang while input is blocked.
- If you ever get locked out, the system-level escape is `Ctrl+Alt+Del` (never blocked).
