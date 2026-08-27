#NoEnv
#SingleInstance Force
#Requires AutoHotkey v1.1
#Persistent

; ============================================================
; PRANKS.AHK - harmless visual + folder-rearrange pranks
; ------------------------------------------------------------
; REVERSIBLE. No data is deleted, encrypted, or destroyed.
; Files are MOVED into new subfolders (you can move them back).
; All visual changes are undone with the hotkeys below.
;
; UNDO EVERYTHING:  Ctrl+Alt+Shift+U
; EMERGENCY EXIT:   Ctrl+Alt+Esc
; ============================================================

; Remember the original wallpaper so we can restore it
global g_origWall := ""
RegRead, g_origWall, HKEY_CURRENT_USER\Control Panel\Desktop, WallPaper

; ---- Wallpaper (works WITHOUT admin, per-user setting) ----
SetWallpaper(path) {
    ; path may be empty to just refresh
    DllCall("SystemParametersInfo", "UInt", 0x0014, "UInt", 0, "Str", path, "UInt", 2)
}

BuildWall() {
    ; Try to draw a random solid-color BMP so we don't need any downloaded file
    w := 1920, h := 1080
    ; Use GDI to make an image without external libraries is heavy; simpler:
    ; pick one of the built-in Windows wallpapers / accent color instead.
    SetWallpaper("")
}

; ---- Swap mouse buttons (works without admin, reversible) ----
SwapMouse(enable) {
    if enable
        value := 1
    else
        value := 0
    RegWrite, REG_DWORD, HKEY_CURRENT_USER\Control Panel\Mouse, SwapMouseButtons, %value%
    ; Tell the system to apply it
    DllCall("SystemParametersInfo", "UInt", 0x0081, "UInt", 0, "Ptr", 0, "UInt", 0) ; SPI_SETMOUSEBUTTONSWAP
}

; ---- Set mouse double-click speed (troll, reversible) ----
MouseSpeed(speed) {
    ; SPI_SETMOUSESPEED (0x0071)
    DllCall("SystemParametersInfo", "UInt", 0x0071, "UInt", 0, "Ptr", speed, "UInt", 0)
}

; ---- Hide / show the Taskbar (works without admin, reversible) ----
Taskbar(v) { ; v=0 hide, v=1 show
    static ABM_SETSTATE := 0x0000000A
    VarSetCapacity(appbar, 36, 0)
    NumPut(36, appbar, 0, "UInt")                 ; cbSize
    hTaskbar := DllCall("FindWindow", "Str", "Shell_TrayWnd", "Ptr", 0, "Ptr")
    if !hTaskbar
        return
    ; Work area approach is simplest: show desktop / hide via AH_BOTTOM
    if v
        WinShow, ahk_id %hTaskbar%
    else
        WinHide, ahk_id %hTaskbar%
}

; ---- Re-organize files (REVERSIBLE - moved, never deleted) ----
Reorganize(dir) {
    if !FileExist(dir)
        return
    stamp := A_YYYY A_MM A_DD "-" A_Hour A_Min A_Sec
    dest := dir "\PRANK-" stamp
    FileCreateDir, %dest%
    Loop, Files, %dir%\*.*, F
        FileMove, %A_LoopFileFullPath%, %dest%\
    ; Group by extension into random-numbered subfolders
    extList := "jpg png gif txt doc docx pdf mp3 mp4 xlsx zip avi mov"
    Loop, Parse, extList, %A_Space%
    {
        ext := A_LoopField
        if FileExist(dest "\*." ext) {
            Random, n, 100, 999
            sub := dest "\" ext "-" n
            FileCreateDir, %sub%
            FileMove, %dest%\*.%ext%, %sub%\
        }
    }
}

; ============================================================
; RUN ALL PRANKS
; ============================================================
^!r::
    TrayTip, Pranks, Running pranks... Ctrl+Alt+Shift+U to undo., 2
    SwapMouse(true)          ; swap left/right buttons
    MouseSpeed(20)           ; fast/silly mouse
    Taskbar(0)               ; hide taskbar
    Reorganize(A_Desktop)    ; tidy Desktop
    Reorganize(A_MyDocuments); tidy Documents
    Sleep, 1500
    TrayTip, Pranks, Done! Undo with Ctrl+Alt+Shift+U., 3
return

; ============================================================
; UNDO VISUAL PRANKS (restore mouse + taskbar + wallpaper)
; ============================================================
^!+u::
    SwapMouse(false)         ; restore mouse buttons
    MouseSpeed(10)           ; normal speed
    Taskbar(1)               ; show taskbar
    SetWallpaper(g_origWall) ; restore wallpaper
    TrayTip, Pranks, Visuals restored. Files are in PRANK-<date> folders - move them back., 4
return

; ============================================================
; EMERGENCY EXIT
; ============================================================
^!Esc::
    ExitApp
return
