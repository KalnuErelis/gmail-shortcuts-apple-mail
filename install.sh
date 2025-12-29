#!/bin/bash
#
# Gmail Shortcuts for Apple Mail - Installer
# https://github.com/KalnuErelis/gmail-shortcuts-apple-mail
#

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

echo ""
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}  Gmail Shortcuts for Apple Mail - Installer${NC}"
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Check for Homebrew
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}Homebrew not found. Installing...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Karabiner-Elements
echo -e "${BLUE}[1/4]${NC} Checking Karabiner-Elements..."
if ! brew list --cask karabiner-elements &> /dev/null 2>&1; then
    echo -e "      ${YELLOW}Installing Karabiner-Elements...${NC}"
    brew install --cask karabiner-elements
else
    echo -e "      ${GREEN}✓ Already installed${NC}"
fi

# Install Hammerspoon
echo -e "${BLUE}[2/4]${NC} Checking Hammerspoon..."
if ! brew list --cask hammerspoon &> /dev/null 2>&1; then
    echo -e "      ${YELLOW}Installing Hammerspoon...${NC}"
    brew install --cask hammerspoon
else
    echo -e "      ${GREEN}✓ Already installed${NC}"
fi

# Download Karabiner config
echo -e "${BLUE}[3/4]${NC} Installing Karabiner config..."
mkdir -p ~/.config/karabiner/assets/complex_modifications
curl -fsSL https://raw.githubusercontent.com/KalnuErelis/gmail-shortcuts-apple-mail/main/gmail-shortcuts-for-mail.json \
    -o ~/.config/karabiner/assets/complex_modifications/gmail-shortcuts-for-mail.json
echo -e "      ${GREEN}✓ Config installed${NC}"

# Setup Hammerspoon
echo -e "${BLUE}[4/4]${NC} Setting up Hammerspoon..."
mkdir -p ~/.hammerspoon

HAMMERSPOON_MODULE=~/.hammerspoon/mail-focus-detector.lua
curl -fsSL https://raw.githubusercontent.com/KalnuErelis/gmail-shortcuts-apple-mail/main/mail-focus-detector.lua \
    -o "$HAMMERSPOON_MODULE"

if [ -f ~/.hammerspoon/init.lua ]; then
    if ! grep -q "mail-focus-detector" ~/.hammerspoon/init.lua 2>/dev/null; then
        echo 'require("mail-focus-detector")' >> ~/.hammerspoon/init.lua
        echo -e "      ${GREEN}✓ Added to existing config${NC}"
    else
        echo -e "      ${GREEN}✓ Already configured${NC}"
    fi
else
    echo 'require("mail-focus-detector")' > ~/.hammerspoon/init.lua
    echo -e "      ${GREEN}✓ Config created${NC}"
fi

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Files installed! Now complete these steps:${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Step 1: Karabiner permissions
echo -e "${BOLD}STEP 1: Grant Karabiner permissions${NC}"
echo "   Opening Input Monitoring settings..."
echo -e "   ${YELLOW}→ Enable: karabiner_grabber${NC}"
echo -e "   ${YELLOW}→ Enable: karabiner_observer${NC}"
echo ""
open "x-apple.systempreferences:com.apple.preference.security?Privacy_ListenEvent"
read -p "   Press Enter when done..."
echo ""

# Step 2: Enable Karabiner rules
echo -e "${BOLD}STEP 2: Enable the shortcut rules${NC}"
echo "   Opening Karabiner-Elements..."
echo -e "   ${YELLOW}→ Go to 'Complex Modifications' tab${NC}"
echo -e "   ${YELLOW}→ Click 'Add predefined rule'${NC}"
echo -e "   ${YELLOW}→ Enable ALL 'Gmail:' rules${NC}"
echo ""
open -a "Karabiner-Elements"
read -p "   Press Enter when done..."
echo ""

# Step 3: Hammerspoon permissions
echo -e "${BOLD}STEP 3: Grant Hammerspoon permissions${NC}"
echo "   Opening Accessibility settings..."
echo -e "   ${YELLOW}→ Enable: Hammerspoon${NC}"
echo ""
open "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility"
read -p "   Press Enter when done..."
echo ""

# Step 4: Start Hammerspoon
echo -e "${BOLD}STEP 4: Start Hammerspoon${NC}"
open -a "Hammerspoon"
echo -e "   ${GREEN}✓ Hammerspoon started${NC}"
echo "   You should see 'Gmail shortcuts loaded' alert."
echo ""

# Done!
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  ✓ Installation complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "  Shortcuts (in Normal Mode):"
echo "    e       Archive"
echo "    j/k     Navigate down/up"
echo "    r       Reply"
echo "    a       Reply All"
echo "    c       Compose"
echo "    f       Forward"
echo "    s       Star/Flag"
echo "    /       Search"
echo ""
echo "  Mode switching:"
echo "    Escape  → Enable shortcuts (Normal Mode)"
echo "    r/c/a/f → Disable shortcuts (Insert Mode)"
echo ""
echo "  Tip: Shortcuts auto-disable when you click into text fields!"
echo ""
