# InputBlocker 🔒

Blocks your **mouse and keyboard** the moment you run it... **forever** (until you press a hotkey to stop it).

> ⚠️ **READ THIS FIRST:** This script LOCKS your mouse and keyboard as soon as it starts.
> You **MUST run it as Administrator**, otherwise it won't work.
> To get out at any time, press `Ctrl+Alt+Esc`. If even that fails, press `Ctrl+Alt+Del` (Windows always pays attention to this).

---

## Step 1 — Install AutoHotkey (one time, super easy)

AutoHotkey is the free app that runs `.ahk` files. This PC probably doesn't have it yet, so install it first:

### Way 1 — One command in CMD (easiest)

Open **Start** → type `cmd` → right-click **Command Prompt** → **Run as administrator**, then copy-paste this:

```cmd
winget install AutoHotkey.AutoHotkey
```

Wait for it to finish, and close the window. Done ✅

### Way 2 — Download manually

1. Go to: https://www.autohotkey.com/download/
2. Download **AutoHotkey v1.1** installer.
3. Double-click it and click **Install**.
4. Leave default options. Done ✅

### Check it worked

Open a new CMD (as admin) and type:

```cmd
WHERE autohotkey
```

If you see a path (like `C:\Program Files\AutoHotkey\AutoHotkey.exe`), you're good to go.

---

## Step 2 — Get the script file

Download `src\InputBlocker.ahk` from this GitHub page, and put it anywhere, e.g. on your Desktop.

**Tip:** because the folder is named `src`, right side of this page → click **Code** → **Download ZIP** → unzip → go into the `src` folder → you'll see `InputBlocker.ahk`.

---

## Step 3 — Run it (locks your PC forever)

### Way 1 — Double-click
Double-click `InputBlocker.ahk`. When the blue UAC popup appears, click **Yes**.
Your mouse and keyboard are now **FROZEN**. 🔒

### Way 2 — One command in CMD (admin)
Open CMD **as administrator**, go to the folder with the file, and run:

```cmd
cd /d C:\Users\Admin\Desktop
"C:\Program Files\AutoHotkey\AutoHotkey.exe" InputBlocker.ahk
```

(Change the `cd` path to wherever you put the file.)

---

## How to UNLOCK 🔓

While it's running, press one of these:

| Hotkey                    | What it does                          |
|---------------------------|---------------------------------------|
| `Ctrl+Alt+M`              | Unlock the **mouse** only             |
| `Ctrl+Alt+K`              | Unlock the **keyboard** only          |
| `Ctrl+Alt+Shift+B`        | Unlock **both** and stop the script   |
| `Ctrl+Alt+Esc`            | EMERGENCY — unlock both + stop script |

> These hotkeys work even while everything is frozen, because they use the special
> low-level keyboard hook that sits above the lock.

---

## "Work Forever" — start it on every Windows login

To make it lock your PC **every time you turn on the computer** (works forever, no need to click):

1. Press `Win + R`, type `shell:startup`, press **Enter**.
2. Copy `InputBlocker.ahk` into the **Startup** folder that opens.
3. Done — every time Windows starts, it will lock your mouse and keyboard automatically. 🔒

> ⚠️ WARNING: If you auto-start it, it will lock your PC on EVERY boot.
> Make sure you remember the unlock hotkey (`Ctrl+Alt+Esc`), otherwise it'll lock you out!
> Just delete the file from the Startup folder to stop it from auto-starting.

---

## Tiny technical notes (for the curious)

- The lock (`BlockInput`) **needs Admin rights** — that's why you run it as admin.
- Hotkeys stay alive during the lock via the low-level keyboard hook.
- To compile into a standalone `.exe` (no AutoHotkey needed): use **Ahk2Exe** on the `.ahk` file.
- The script keeps running (in the system tray) until you press an unlock hotkey.
