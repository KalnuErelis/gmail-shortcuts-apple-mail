# Gmail Keyboard Shortcuts for Apple Mail

Use Gmail-style keyboard shortcuts in Apple Mail on macOS.

## Quick Install

### 1. Install Karabiner-Elements

```bash
brew install --cask karabiner-elements
```

### 2. Copy the config

```bash
mkdir -p ~/.config/karabiner/assets/complex_modifications
curl -fsSL https://raw.githubusercontent.com/KalnuErelis/gmail-shortcuts-apple-mail/main/gmail-shortcuts-for-mail.json \
  -o ~/.config/karabiner/assets/complex_modifications/gmail-shortcuts-for-mail.json
```

### 3. Grant permissions

Open **System Settings → Privacy & Security → Input Monitoring** and enable:
- `karabiner_grabber`
- `karabiner_observer`

Restart your Mac if prompted.

### 4. Enable the shortcuts

1. Open Karabiner-Elements
2. Go to **Complex Modifications**
3. Click **Add predefined rule**
4. Enable "Gmail Shortcuts for Apple Mail" rules

---

## Optional: Auto-detect Text Fields (Recommended)

By default, you need to press `Escape` after clicking into a text field to re-enable shortcuts. To make this automatic, install Hammerspoon:

### 1. Install Hammerspoon

```bash
brew install --cask hammerspoon
```

### 2. Add the focus detector script

```bash
mkdir -p ~/.hammerspoon
curl -fsSL https://raw.githubusercontent.com/KalnuErelis/gmail-shortcuts-apple-mail/main/mail-focus-detector.lua \
  -o ~/.hammerspoon/init.lua
```

Or if you already have a Hammerspoon config, add this to your `init.lua`:

```lua
require("mail-focus-detector")
```

### 3. Grant Accessibility permissions

Open Hammerspoon and grant it Accessibility permissions when prompted (System Settings → Privacy & Security → Accessibility).

### 4. Reload config

Click the Hammerspoon menubar icon → **Reload Config**

Now the shortcuts will automatically disable when you click into any text field!

---

## How It Works (Vim-like Modes)

This config uses a **Vim-like modal system** to prevent shortcuts from interfering when typing:

### Normal Mode (default)
- Shortcuts are **active**
- Navigate, archive, reply, etc.

### Insert Mode
- Shortcuts are **disabled**
- Type normally in compose/search fields

### Mode Switching

| Action | Result |
|--------|--------|
| Press `r`, `a`, `f`, `c`, or `/` | → Insert Mode |
| Press `⌘R`, `⌘⇧R`, `⌘⇧F`, `⌘N`, `⌘⌥F` | → Insert Mode |
| Click into text field (with Hammerspoon) | → Insert Mode |
| Press `Escape` | → Normal Mode |
| Press `u` or `⌘W` (close window) | → Normal Mode |
| Click out of text field (with Hammerspoon) | → Normal Mode |

---

## Shortcuts

### Navigation
| Key | Action |
|-----|--------|
| `j` | Next message (down) |
| `k` | Previous message (up) |
| `o` | Open message |
| `u` | Close/Back to inbox |
| `g i` | Go to Inbox |

### Actions
| Key | Action |
|-----|--------|
| `e` | Archive |
| `#` | Delete |
| `s` | Flag/Star |
| `!` | Mark as Junk |
| `Shift+u` | Mark as unread |
| `Shift+i` | Mark as read |

### Compose
| Key | Action |
|-----|--------|
| `c` | Compose new message |
| `r` | Reply |
| `a` | Reply All |
| `f` | Forward |
| `/` | Search |

---

## Troubleshooting

**Shortcuts not working?**
- Open Karabiner → **Devices** → ensure your keyboard is enabled
- Check Input Monitoring permissions are granted
- Restart Mac after first-time permission grant
- Make sure you're in Normal Mode (press `Escape`)

**Archive (`e`) not working?**
- For Gmail accounts: uses `⌃⌘A`
- For iCloud accounts: change to `⌃⌘E` in the config

**Keys typing letters instead of triggering shortcuts?**
- You're in Insert Mode. Press `Escape` to return to Normal Mode.
- If using Hammerspoon: check it has Accessibility permissions

**Hammerspoon not detecting text fields?**
- Grant Accessibility permissions in System Settings
- Click Hammerspoon menubar → Reload Config
- Check Console.app for Hammerspoon errors

---

## How It Works Technically

1. **Karabiner-Elements** remaps single keys to Mail.app shortcuts (e.g., `e` → `⌃⌘A` for Archive)

2. **Vim-like modes** prevent conflicts:
   - A variable `mail_insert_mode` tracks the current mode
   - Shortcuts only fire when `mail_insert_mode ≠ 1`
   - Compose actions (`r`, `c`, etc.) set `mail_insert_mode = 1`
   - `Escape` sets `mail_insert_mode = 0`

3. **Hammerspoon** (optional) provides automatic detection:
   - Polls every 200ms to check the focused UI element
   - Uses macOS Accessibility API to detect text fields
   - Sets `mail_insert_mode` via `karabiner_cli --set-variables`

---

## License

MIT
