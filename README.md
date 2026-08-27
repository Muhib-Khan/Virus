# InputBlocker 🔒

Blocks your **mouse and keyboard** the moment you run it — **no Administrator needed, no popups.**

> ⚠️ **READ THIS FIRST:** This script LOCKS your mouse and keyboard as soon as it starts.
> To get out at any time, press `Ctrl+Alt+Esc`. If even that fails, press `Ctrl+Alt+Del`.

---

## Step 1 — Install AutoHotkey (one time, super easy)

### Way 1 — One command in CMD

Open **Start** → type `cmd` → click **Command Prompt** (no admin needed), then paste:

```cmd
winget install AutoHotkey.AutoHotkey
```

### Way 2 — Download manually

1. Go to: https://www.autohotkey.com/download/
2. Download **AutoHotkey v1.1**, double-click, **Install**.
3. Leave defaults. Done ✅

### Check it worked

```cmd
WHERE autohotkey
```

If you see a path, you're good.

---

## Step 2 — Get the script

Download `src\InputBlocker.ahk` from this page. Right side → **Code** → **Download ZIP** → unzip → go into the `src` folder.

---

## Step 3 — Run it (locks your PC)

### Way 1 — Double-click
Double-click `InputBlocker.ahk`. No popup, no admin. Mouse + keyboard freeze. 🔒

### Way 2 — One command in CMD
```cmd
cd /d path\to\the\folder
"C:\Program Files\AutoHotkey\AutoHotkey.exe" InputBlocker.ahk
```

---

## HOW TO UNLOCK 🔓

| Hotkey                    | What it does                          |
|---------------------------|---------------------------------------|
| `Ctrl+Alt+M`              | Unlock the **mouse** only             |
| `Ctrl+Alt+K`              | Unlock the **keyboard** only          |
| `Ctrl+Alt+Shift+B`        | Unlock **both** and stop the script   |
| `Ctrl+Alt+Esc`            | EMERGENCY — unlock both + stop script |

These hotkeys work even while frozen (low-level keyboard hook sits above the lock).

---

## "Work forever" — auto-start every login

1. Press `Win + R`, type `shell:startup`, press **Enter**.
2. Copy `InputBlocker.ahk` into the Startup folder.
3. Every Windows boot = PC locked automatically. 🔒

> ⚠️ Delete it from Startup to stop this. Remember `Ctrl+Alt+Esc` to unlock!

---

## Honest note about "no admin"

`BlockInput` blocking works best as **Administrator**. Without admin, Windows 10/11
limits it, so mouse blocking may be partial on some systems. The unlock hotkeys always
work, and `Ctrl+Alt+Del` is never blocked as a last resort.
