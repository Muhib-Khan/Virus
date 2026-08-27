#NoEnv
#SingleInstance Force
#Requires AutoHotkey v1.1
#MaxThreadsPerHotkey 2

; ============================================
; SELF-ELEVATE TO ADMINISTRATOR (REQUIRED)
; --------------------------------------------
; BlockInput silently fails on Windows 10+ unless
; the script runs with Administrator privileges.
; If we are not elevated, relaunch ourselves with
; UAC elevation, then exit this instance.
; ============================================
if not A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

; ============================================
; BLOCK MOUSE + KEYBOARD
; ============================================

; Block both at startup
BlockInput, Mouse
BlockInput, Keyboard

; Tray tip to show it's running
TrayTip, Input Blocker, Mouse and Keyboard are blocked., 3

return

; ============================================
; HOTKEYS TO RE-ENABLE
; ============================================

; Ctrl+Alt+M -> Re-enable mouse only
^!m::
    BlockInput, MouseOff
    TrayTip, Input Blocker, Mouse re-enabled!, 2
return

; Ctrl+Alt+K -> Re-enable keyboard only
^!k::
    BlockInput, KeyboardOff
    TrayTip, Input Blocker, Keyboard re-enabled!, 2
return

; Ctrl+Alt+Shift+B -> Re-enable both and exit
^!+b::
    BlockInput, MouseOff
    BlockInput, KeyboardOff
    TrayTip, Input Blocker, Both re-enabled - exiting!, 2
    Sleep, 500
    ExitApp
return

; Ctrl+Alt+Esc -> Emergency exit (re-enable both and exit)
^!Esc::
    BlockInput, MouseOff
    BlockInput, KeyboardOff
    TrayTip, Input Blocker, Emergency exit!, 2
    Sleep, 500
    ExitApp
return
