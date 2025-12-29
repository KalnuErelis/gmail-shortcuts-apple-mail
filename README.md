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

This config uses a **Vim-like modal system** to prevent shortcuts from interfering when typing:

### Normal Mode (default)
- Shortcuts are **active**
- Navigate, archive, reply, etc.

### Insert Mode
- Shortcuts are **disabled**
- Type normally in compose/search fields

### Automatic Mode Switching

| Action | Result |
|--------|--------|
| Press `r`, `a`, `f`, `c`, or `/` | → Insert Mode |
| Press `⌘R`, `⌘⇧R`, `⌘⇧F`, `⌘N`, `⌘⌥F` | → Insert Mode |
| Press `Escape` | → Normal Mode |
| Press `u` or `⌘W` (close window) | → Normal Mode |

**Workflow example:**
1. Press `j`/`k` to navigate (Normal Mode)
2. Press `r` to reply → Insert Mode (type your reply)
3. Press `⌘↩` to send
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

## Known Limitations

**Clicking into text fields with mouse**: If you click directly into a search field or click the Reply button (instead of using keyboard shortcuts), you'll be in a text field but still in Normal Mode. Press `Escape` once to sync up, then type normally.

This is a Karabiner limitation - it can't detect mouse clicks or UI focus changes.

## Troubleshooting

**Shortcuts not working?**
- Open Karabiner → **Devices** → ensure your keyboard is enabled
- Check Input Monitoring permissions are granted
- Restart Mac after first-time permission grant
- Make sure you're in Normal Mode (press `Escape`)

**Archive (`e`) not working?**
- For Gmail accounts: uses `⌃⌘A`
- For iCloud accounts: change to `⌃⌘E` in the config

**Keys typing instead of triggering shortcuts?**
- You're in Insert Mode. Press `Escape` to return to Normal Mode.

## License

MIT
