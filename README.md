# NexusLib

A simple UI library for Roblox script hubs.

## Features

- Clean dark theme
- Tabs with custom icons
- Buttons, toggles, sliders, labels, textboxes
- Customizable banners (color/gradient/image)
- Loading screen with progress bar
- Executor compatibility warnings
- Icon caching system

## Quick Start

```lua
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Thatguyronin-GT/Nexus-Lib/refs/heads/main/NexusLib.luau"))()

lib:ShowLoadingScreen(function()
    local win = lib:CreateWindow("My Hub")
    local tab = win:CreateTab("Main", "https://i.imgur.com/icon.png")
    
    tab:AddButton("Click Me", function()
        print("clicked")
    end)
end)
```

## Basic Usage

### Load the library

```lua
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Thatguyronin-GT/Nexus-Lib/refs/heads/main/NexusLib.luau"))()
```

### Set script name (optional)

This affects the icon cache folder name.

```lua
lib:SetScriptName("My Script")
```

### Customize colors (optional)

```lua
lib:SetMainColor(Color3.fromRGB(18, 18, 22))
lib:SetAccentColor(Color3.fromRGB(45, 45, 55))
```

### Create window

```lua
lib:ShowLoadingScreen(function()
    local win = lib:CreateWindow("Window Title")
end)
```

## Window Functions

### Set banner

```lua
-- Solid color
win:SetBanner("color", Color3.fromRGB(45, 45, 55))

-- Gradient
win:SetBanner("gradient", ColorSequence.new(Color3.fromRGB(45, 45, 55), Color3.fromRGB(30, 30, 38)), 90)

-- Image
win:SetBanner("image", "https://i.imgur.com/banner.png")
```

### Create tab

```lua
local tab = win:CreateTab("Tab Name", "https://i.imgur.com/icon.png")
```

## Tab Components

### Button

```lua
tab:AddButton("Button Text", function()
    print("clicked")
end)
```

### Toggle

```lua
local toggle = tab:AddToggle("Toggle Text", false, function(state)
    print("toggled:", state)
end)

-- Set toggle state
toggle:Set(true)
```

### Slider

```lua
local slider = tab:AddSlider("Slider Text", 0, 100, 50, function(value)
    print("value:", value)
end)

-- Set slider value
slider:Set(75)
```

### Label

```lua
tab:AddLabel("Label Text")
```

### TextBox

```lua
tab:AddTextBox("Placeholder", function(text)
    print("input:", text)
end)
```

## Icons

Icons use external HTTPS URLs. The library caches them locally to avoid re-downloading.

Icons are stored in `nexus_icons/{ScriptName}/` folders.

All icons render as white to match the UI theme.

If your executor doesn't support `writefile`/`getcustomasset`, icons fall back to a default.

## Executor Compatibility

The library checks for these functions:
- `writefile`
- `getcustomasset`
- `makefolder`
- `isfolder`
- `isfile`

If any are missing, you'll see a warning dialog.

## Example

See `Example.luau` for a full working example.

## Notes

- Icons must be HTTPS URLs (not `rbxassetid://`)
- Icons are cached after first load
- Loading screen shows automatically
- UI is draggable by the title bar
- Close button destroys the GUI

## License

Free to use.
