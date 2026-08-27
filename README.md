# InputBlocker 🔒

Blocks your **mouse and keyboard** the moment you run it — **no Administrator needed, no popups.**
Comes with a bonus prank script too.

> ⚠️ **READ THIS FIRST:** The main script LOCKS your mouse and keyboard as soon as it starts.
> To get out at any time, press `Ctrl+Alt+Esc`. If even that fails, press `Ctrl+Alt+Del` (Windows never ignores it).

---

## 📑 Table of Contents

1. [What this is](#1-what-this-is)
2. [Requirements](#2-requirements)
3. [Step 1 — Install AutoHotkey](#-step-1--install-autohotkey-one-time)
4. [Step 2 — Get the scripts](#-step-2--get-the-scripts)
5. [Step 3 — Run, lock & unlock](#-step-3--run-lock--unlock)
6. [Auto-start on boot (Lock forever)](#-work-forever--auto-start-every-login)
7. [🎭 Bonus: the Pranks guide](#-bonus-pranksahk--the-prank-guide)
8. [Troubleshooting & FAQs](#8-troubleshooting--faqs)

---

## 1. What this is

| File | What it does |
|------|--------------|
| `src\InputBlocker.ahk` | **Locks the mouse and keyboard** on the PC when run. Unlock with a hotkey. |
| `src\Pranks.ahk` | **Harmless reversible pranks** — visual changes + folder tidy-ups (never deletes anything). |

Both are **100% upgradeable, reversible, and non-destructive.** Nothing ever deletes, encrypts, or destroys your data.

---

## 2. Requirements

- Windows 10 / 11 (works on older Windows 10 too, as best it can)
- [AutoHotkey v1.1](https://www.autohotkey.com/download/) — a free app that runs `.ahk` files

---

## 🔧 Step 1 — Install AutoHotkey (one time, super easy)

### Way 1 — One command in CMD (easiest)

Open **Start** → type `cmd` → click **Command Prompt** (no admin needed), then paste:

```cmd
winget install AutoHotkey.AutoHotkey
```

Wait for it to finish, then close the window.

### Way 2 — Download manually

1. Go to: https://www.autohotkey.com/download/
2. Download **AutoHotkey v1.1** installer.
3. Double-click it → click **Install** (leave defaults).

### ✅ Check it worked

Open a new CMD and type:

```cmd
WHERE autohotkey
```

If you see a path like `C:\Program Files\AutoHotkey\AutoHotkey.exe`, you're good to go.

---

## 📥 Step 2 — Get the scripts

1. On this GitHub page, click the green **Code** button (top-right).
2. Click **Download ZIP**.
3. Unzip the file.
4. Open the `src` folder — you'll see `InputBlocker.ahk` and `Pranks.ahk`.
5. Copy both `.ahk` files somewhere easy, e.g. your **Desktop**.

---

## 🚀 Step 3 — Run, lock & unlock

### Run it (locks your PC)

**Way 1 — Double-click**

Double-click `InputBlocker.ahk`. No popup, no admin. **Mouse + keyboard freeze.** 🔒

**Way 2 — One command in CMD**

```cmd
cd /d "C:\Users\YourName\Desktop"
"C:\Program Files\AutoHotkey\AutoHotkey.exe" InputBlocker.ahk
```

*(Change `YourName` to the real path where the file is.)*

### 🔓 HOW TO UNLOCK

| Hotkey            | What it does                          |
|-------------------|---------------------------------------|
| `Ctrl+Alt+M`      | Unlock the **mouse** only             |
| `Ctrl+Alt+K`      | Unlock the **keyboard** only          |
| `Ctrl+Alt+Shift+B`| Unlock **both** and stop the script   |
| `Ctrl+Alt+Esc`    | EMERGENCY — unlock both + stop script |

> These hotkeys work **even while everything is frozen**, because they use a special
> low-level keyboard hook that sits above the lock. `Ctrl+Alt+Del` is always a last resort.

---

## ⏰ "Work Forever" — auto-start every login

To lock your PC **every time Windows starts** (no need to click anything):

1. Press `Win + R`, type `shell:startup`, press **Enter**.
2. Copy `InputBlocker.ahk` into the **Startup** folder that opens.
3. Done — every boot locks the mouse + keyboard automatically.

> ⚠️ **WARNING:** This locks your PC on **every** boot. Seriously remember `Ctrl+Alt+Esc`.
> To stop it, just delete `InputBlocker.ahk` from the Startup folder.

---

## 🎭 Bonus: `Pranks.ahk` — the prank guide

A separate script that does **only reversible** visual changes + folder tidy-ups.
**It never deletes, encrypts, or destroys any data** — files are just *moved* into
new `PRANK-<date>` subfolders you can move back, and every visual change is undone
by **one** hotkey.

### Run it

Double-click `Pranks.ahk`, or in CMD:

```cmd
cd /d "C:\Users\YourName\Desktop"
"C:\Program Files\AutoHotkey\AutoHotkey.exe" Pranks.ahk
```

### What it does

| Effect | How to undo |
|--------|-------------|
| Turns wallpaper into a random garish solid color | `Ctrl+Alt+Shift+U` |
| Swaps left/right mouse buttons | `Ctrl+Alt+Shift+U` |
| Sets a fast/silly mouse speed | `Ctrl+Alt+Shift+U` |
| Slows keyboard repeat to a crawl | `Ctrl+Alt+Shift+U` |
| Hides the Taskbar | `Ctrl+Alt+Shift+U` |
| Hides all Desktop icons | `Ctrl+Alt+Shift+U` |
| Moves Desktop + Documents files into `PRANK-<date>` subfolders (grouped by type) | move files back manually |

### Hotkeys

| Hotkey            | Action                                  |
|-------------------|-----------------------------------------|
| `Ctrl+Alt+R`      | Run all pranks (MEGA)                   |
| `Ctrl+Alt+Shift+U`| Undo all visual pranks                  |
| `Ctrl+Alt+Esc`    | Emergency exit                          |

> ⚠️ The folder part **only moves files** — nothing is deleted. To fully restore,
> open the `PRANK-<date>` folders and drag the files back to Desktop/Documents.

---

## 8. Troubleshooting & FAQs

**Q: The mouse/keyboard don't lock.**
A: `BlockInput` works best as **Administrator**. Without admin, Windows 10/11 limits it,
so blocking may be partial on some systems. There's no way around this without admin —
it's a Microsoft security restriction.

**Q: I ran it and now I can't do anything!**
A: Press `Ctrl+Alt+Esc` to unlock and exit. If that fails, press `Ctrl+Alt+Del` — Windows
never blocks that.

**Q: Do I need to install AutoHotkey?**
A: Yes, to run the `.ahk` files. Or compile them to `.exe` with **Ahk2Exe** (then no install needed).

**Q: Will this damage my computer?**
A: No. Both scripts are designed to be reversible and never delete data. The worst that
happens is files get moved into folders and you drag them back.
