-- Gmail Shortcuts for Mail.app - Hammerspoon Focus Detector
-- Automatically detects text field focus and syncs with Karabiner
--
-- Installation:
-- 1. Install Hammerspoon: brew install --cask hammerspoon
-- 2. Copy this file to ~/.hammerspoon/init.lua (or require it from init.lua)
-- 3. Grant Hammerspoon accessibility permissions when prompted
-- 4. Reload Hammerspoon config (click menubar icon → Reload Config)

local karabinerCli = '/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli'
local currentInsertMode = nil  -- Track state to avoid redundant calls

local function setInsertMode(enabled)
    -- Only update if state changed
    if currentInsertMode == enabled then return end
    currentInsertMode = enabled

    local value = enabled and 1 or 0
    local cmd = string.format("'%s' --set-variables '{\"mail_insert_mode\":%d}'", karabinerCli, value)
    hs.execute(cmd)
end

local function isTextInputRole(role)
    if not role then return nil end  -- nil = unknown, don't change mode
    return role == "AXTextArea"
        or role == "AXTextField"
        or role == "AXSearchField"
        or role == "AXComboBox"
        or role == "AXTextView"
        or role == "AXWebArea"
end

local function checkFocusedElement()
    local app = hs.application.frontmostApplication()

    -- Only care about Mail.app
    if not app or app:bundleID() ~= "com.apple.mail" then
        return
    end

    -- Get the currently focused UI element
    local systemWide = hs.axuielement.systemWideElement()
    if not systemWide then
        return  -- Can't access, don't change anything
    end

    local focused = systemWide:attributeValue("AXFocusedUIElement")
    if not focused then
        return  -- Can't determine focus, don't change anything (let Karabiner handle it)
    end

    local role = focused:attributeValue("AXRole")
    local isTextInput = isTextInputRole(role)

    -- Only change mode if we're CERTAIN about the state
    if isTextInput ~= nil then
        setInsertMode(isTextInput)
    end
end

-- Watch for app activation/deactivation
local appWatcher = hs.application.watcher.new(function(appName, eventType, app)
    if eventType == hs.application.watcher.activated then
        if app and app:bundleID() == "com.apple.mail" then
            -- Small delay to let focus settle
            hs.timer.doAfter(0.1, checkFocusedElement)
        else
            -- Left Mail.app - reset tracking for next time
            currentInsertMode = nil
        end
    end
end)
appWatcher:start()

-- Poll for focus changes within Mail.app
-- This catches mouse clicks into text fields
local focusTimer = hs.timer.doEvery(0.3, function()
    local app = hs.application.frontmostApplication()
    if app and app:bundleID() == "com.apple.mail" then
        checkFocusedElement()
    end
end)

-- Initial check on script load
hs.timer.doAfter(1, checkFocusedElement)

hs.alert.show("Gmail shortcuts loaded", 1)
print("Gmail shortcuts focus detector loaded for Mail.app")
