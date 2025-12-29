# Gmail Keyboard Shortcuts for Apple Mail

Use Gmail-style keyboard shortcuts in Apple Mail on macOS.

## Quick Install

### 1. Install Karabiner-Elements

```bash
brew install --cask karabiner-elements
```

### 2. Copy the config

```bash
cp gmail-shortcuts-for-mail.json ~/.config/karabiner/assets/complex_modifications/
```

Or one-liner:

```bash
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

## Shortcuts

| Key | Action |
|-----|--------|
| `e` | Archive |
| `#` | Delete |
| `r` | Reply |
| `a` | Reply All |
| `f` | Forward |
| `c` | Compose |
| `j` | Next message (down) |
| `k` | Previous message (up) |
| `o` | Open message |
| `u` | Close/Back to inbox |
| `s` | Flag/Star |
| `!` | Mark as Junk |
| `Shift+u` | Mark as unread |
| `Shift+i` | Mark as read |
| `/` | Search |

## How it works

[Karabiner-Elements](https://karabiner-elements.pqrs.org/) intercepts keyboard input at a low level. The config remaps Gmail shortcuts to Mail.app's native shortcuts, but only when Mail is the active app.

For example:
- `e` → `⌃⌘A` (Archive)
- `j` → `↓` (Down arrow)
- `r` → `⌘R` (Reply)

## Troubleshooting

**Shortcuts not working?**
- Open Karabiner → **Devices** → ensure your keyboard is enabled
- Check Input Monitoring permissions are granted
- Restart Mac after first-time permission grant

**Archive (`e`) not working?**
- For Gmail accounts: uses `⌃⌘A`
- For iCloud accounts: change to `⌃⌘E` in the config

## License

MIT
