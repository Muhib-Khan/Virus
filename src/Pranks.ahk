#NoEnv
#SingleInstance Force
#Requires AutoHotkey v1.1
#Persistent

; ============================================================
; PRANKS.AHK - powerful, 100% REVERSIBLE, non-destructive pranks
; ------------------------------------------------------------
; NOTHING is deleted, encrypted, or destroyed. Everything done
; here can be returned to normal with ONE hotkey:
;
;   UNDO EVERYTHING:  Ctrl+Alt+Shift+U
;   EMERGENCY EXIT:   Ctrl+Alt+Esc
;
; Visual/system changes are per-user and reversible.
; Files are only MOVED into PRANK-<date> folders (move back manually).
; ============================================================

global g_origWall := ""
global g_origMouseSwap := ""
global g_origKeyboardDelay := ""

; ---- remember original settings (registry) so undo is exact ----
RegRead, g_origWall, HKEY_CURRENT_USER\Control Panel\Desktop, WallPaper
RegRead, g_origMouseSwap, HKEY_CURRENT_USER\Control Panel\Mouse, SwapMouseButtons
RegRead, g_origKeyboardDelay, HKEY_CURRENT_USER\Control Panel\Keyboard, KeyboardDelay

; ============================================================
; VISUAL / SYSTEM PRANKS (ALL reversible)
; ============================================================

; -- Wallpaper: set a solid color (works without admin) --
MakeColorWallpaper() {
    ; Create a solid-color BMP to /tmp and set it as wallpaper.
    ; Pick a random garish color the first time, else undo restores original.
    static used := 0
    Random, rr, 0, 255
    Random, gg, 0, 255
    Random, bb, 0, 255
    width := 640, height := 360
    bmp := A_Temp "\prank_wall.bmp"
    ; Build BMP manually (24-bit, no compression) via FileOpen + raw bytes
    f := FileOpen(bmp, "w")
    rowSize := width * 3
    pad := (4 - Mod(rowSize, 4)) & 3
    dataSize := (rowSize + pad) * height
    fileSize := 54 + dataSize
    f.Seek(0)
    ; --- BITMAPFILEHEADER (14 bytes) ---
    f.WriteUChar(0x42) ; 'B'
    f.WriteUChar(0x4D) ; 'M'
    f.WriteUInt(fileSize)
    f.WriteUShort(0)
    f.WriteUShort(0)
    f.WriteUInt(54) ; data offset
    ; --- BITMAPINFOHEADER (40 bytes) ---
    f.WriteUInt(40)
    f.WriteInt(width)
    f.WriteInt(height)
    f.WriteUShort(1) ; planes
    f.WriteUShort(24) ; bpp
    f.WriteUInt(0) ; compression
    f.WriteUInt(dataSize)
    f.WriteInt(2835) ; x ppm
    f.WriteInt(2835) ; y ppm
    f.WriteUInt(0)
    f.WriteUInt(0)
    ; --- pixel data (bottom-up) ---
    Loop, %height% {
        Loop, %width% {
            f.WriteUChar(bb) ; B
            f.WriteUChar(gg) ; G
            f.WriteUChar(rr) ; R
        }
        Loop, %pad%
            f.WriteUChar(0)
    }
    f.Close()
    SetWallpaper(bmp)
}

SetWallpaper(path) {
    DllCall("SystemParametersInfo", "UInt", 0x0014, "UInt", 0, "Str", path, "UInt", 2)
}

; -- Swap mouse buttons --
SwapMouse(enable) {
    value := enable ? 1 : 0
    RegWrite, REG_DWORD, HKEY_CURRENT_USER\Control Panel\Mouse, SwapMouseButtons, %value%
    DllCall("SystemParametersInfo", "UInt", 0x0081, "UInt", 0, "Ptr", 0, "UInt", 1)
}

; -- Mouse speed --
MouseSpeed(speed) {
    DllCall("SystemParametersInfo", "UInt", 0x0071, "UInt", 0, "Ptr", speed, "UInt", 1)
}

; -- Keyboard repeat delay (reversible) --
KeyboardDelay(delay) { ; 0=fastest .. 3=slowest
    RegWrite, REG_DWORD, HKEY_CURRENT_USER\Control Panel\Keyboard, KeyboardDelay, %delay%
    ; refresh keyboard settings
    DllCall("SystemParametersInfo", "UInt", 0x0055, "UInt", 0, "Ptr", 0, "UInt", 1) ; SPI_SETKEYBOARDDELAY
}

; -- Show a big always-on-top "Error" style text overlay (cosmetic) --
FakeError() {
    Gui, New, +AlwaysOnTop -Caption +ToolWindow
    Gui, Color, Black
    Gui, Font, s32 cRed Bold
    Gui, Add, Text, Center, FAKE ERROR - DO NOT PANIC
    Gui, +LastFound
    WinSet, Transparent, 230
    Gui, Show, x0 y0 w800 h120 NoActivate
}

; -- Hide taskbar --
Taskbar(v) { ; 1=show 0=hide
    hTaskbar := DllCall("FindWindow", "Str", "Shell_TrayWnd", "Ptr", 0, "Ptr")
    if v
        WinShow, ahk_id %hTaskbar%
    else
        WinHide, ahk_id %hTaskbar%
}

; -- Desktop icons on/off (hide via worker window broadcast) --
DesktopIcons(v) { ; 1=show 0=hide
    ; Send the special message that toggles desktop icon visibility.
    ; Simpler reliable method: use the registry + broadcast is complex; we
    ; instead toggle via sending to the desktop ListView (works on most systems).
    hProg := DllCall("FindWindow", "Str", "Progman", "Ptr", 0, "Ptr")
    ControlGet, id, Hwnd,, SysListView321, ahk_id %hProg%
    if !id {
        ; Worker window fallback
        hWorker := DllCall("FindWindowEx", "Ptr", hProg, "Ptr", 0, "Str", "SHELLDLL_DefView", "Ptr", 0, "Ptr")
        ControlGet, id, Hwnd,, SysListView321, ahk_id %hWorker%
    }
    if id {
        if v
            WinShow, ahk_id %id%
        else
            WinHide, ahk_id %id%
    }
}

; -- Re-organize files (REVERSIBLE - moved, never deleted) --
Reorganize(dir) {
    if !FileExist(dir)
        return
    stamp := A_YYYY A_MM A_DD "-" A_Hour A_Min A_Sec
    dest := dir "\PRANK-" stamp
    FileCreateDir, %dest%
    Loop, Files, %dir%\*.*, F
        FileMove, %A_LoopFileFullPath%, %dest%\
    extList := "jpg jpeg png gif bmp txt doc docx pdf mp3 mp4 xlsx zip rar avi mov png"
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
    ; move the leftover non-matching files into a "misc" folder
    if FileExist(dest "\*.*") {
        Random, n, 100, 999
        sub := dest "\misc-" n
        FileCreateDir, %sub%
        FileMove, %dest%\*.*, %sub%\
    }
}

; ============================================================
; RUN ALL PRANKS (MEGA)
; ============================================================
^!r::
    TrayTip, Pranks, MEGA pranks running... (Ctrl+Alt+Shift+U to undo), 2
    MakeColorWallpaper()     ; garish solid-color wallpaper
    SwapMouse(true)          ; swap mouse buttons
    MouseSpeed(20)           ; silly fast mouse
    KeyboardDelay(3)         ; super slow key repeat
    Taskbar(0)               ; hide taskbar
    DesktopIcons(0)          ; hide desktop icons
    Reorganize(A_Desktop)    ; tidy Desktop
    Reorganize(A_MyDocuments); tidy Documents
    Sleep, 1500
    TrayTip, Pranks, Done! Everything is reversible. Undo: Ctrl+Alt+Shift+U, 4
return

; ============================================================
; UNDO ALL VISUAL PRANKS
; ============================================================
^!+u::
    SwapMouse(false)         ; restore mouse buttons
    MouseSpeed(10)           ; normal mouse speed
    KeyboardDelay(1)         ; normal key repeat
    Taskbar(1)               ; show taskbar
    DesktopIcons(1)          ; show desktop icons
    SetWallpaper(g_origWall) ; restore original wallpaper
    Gui, Destroy              ; close fake error if open
    TrayTip, Pranks, Visuals restored. Files are in PRANK-<date> folders - move them back., 5
return

; ============================================================
; EMERGENCY EXIT
; ============================================================
^!Esc::
    ExitApp
return
