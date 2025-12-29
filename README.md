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

## How It Works (Vim-like Modes)

This config uses a **Vim-like modal system** to handle the edge case of typing in compose/search fields:

### Normal Mode (default)
- Shortcuts are **active**
- Navigate, archive, reply, etc.

### Insert Mode
- Shortcuts are **disabled**
- Type normally in compose/search fields

### Mode Switching
| Action | Result |
|--------|--------|
| Press `r`, `a`, `f`, `c`, or `/` | Enters **Insert Mode** (you're now typing) |
| Press `Escape` | Returns to **Normal Mode** (shortcuts work again) |
| Press `u` (close window) | Returns to **Normal Mode** |

**Workflow example:**
1. Press `j`/`k` to navigate to an email (Normal Mode)
2. Press `r` to reply → automatically enters Insert Mode
3. Type your reply
4. Press `Escape` → back to Normal Mode
5. Press `e` to archive

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

## Troubleshooting

**Shortcuts not working?**
- Open Karabiner → **Devices** → ensure your keyboard is enabled
- Check Input Monitoring permissions are granted
- Restart Mac after first-time permission grant
- Make sure you're in Normal Mode (press `Escape`)

**Archive (`e`) not working?**
- For Gmail accounts: uses `⌃⌘A`
- For iCloud accounts: change to `⌃⌘E` in the config

**Can't type in compose window?**
- You're in Normal Mode. Press any compose shortcut (`r`, `c`, etc.) or click in the text field and the mode will switch automatically next time you use a compose action.
- If stuck, the shortcuts only block single keys - you can always type with modifier keys held.

## License

MIT
