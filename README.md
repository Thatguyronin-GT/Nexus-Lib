# NexusLib

A simple UI library for Roblox script's

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
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Thatguyronin-GT/Nexus-Lib/refs/heads/main/NexusLib.Luau"))()

Library:ShowLoadingScreen(function()
    local Window = Library:CreateWindow("My Hub")
    local Tab = Window:CreateTab("Main", "https://i.imgur.com/icon.png")
    
    Tab:AddButton("Click Me", function()
        print("clicked")
    end)
end)
```

## Basic Usage

### Load the library

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Thatguyronin-GT/Nexus-Lib/refs/heads/main/NexusLib.Luau"))()

```

### Set script name (optional)

This affects the icon cache folder name.

```lua
Library:SetScriptName("My Script")
```

### Customize colors (optional)

```lua
Library:SetMainColor(Color3.fromRGB(18, 18, 22))
Library:SetAccentColor(Color3.fromRGB(45, 45, 55))
```

### Create window

```lua
Library:ShowLoadingScreen(function()
    local Window = Library:CreateWindow("Window Title")
end)
```

## Window Functions

### Set banner

```lua
-- Solid color
Window:SetBanner("color", Color3.fromRGB(45, 45, 55))

-- Gradient
Window:SetBanner("gradient", ColorSequence.new(Color3.fromRGB(45, 45, 55), Color3.fromRGB(30, 30, 38)), 90)

-- Image
Window:SetBanner("image", "https://i.imgur.com/banner.png")
```

### Create tab

```lua
local Tab = Window:CreateTab("Tab Name", "https://i.imgur.com/icon.png")
```

## Tab Components

### Button

```lua
Tab:AddButton("Button Text", function()
    print("clicked")
end)
```

### Toggle

```lua
local Toggle = Tab:AddToggle("Toggle Text", false, function(state)
    print("toggled:", state)
end)

-- Set toggle state
Toggle:Set(true)
```

### Slider

```lua
local Slider = Tab:AddSlider("Slider Text", 0, 100, 50, function(value)
    print("value:", value)
end)

-- Set slider value
Slider:Set(75)
```

### Label

```lua
Tab:AddLabel("Label Text")
```

### TextBox

```lua
Tab:AddTextBox("Placeholder", function(text)
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
- `HttpGet`
- `makefolder`
- `isfolder`
- `isfile`
- `identifyexecutor`

If any are missing, you'll see a warning dialog. You can choose to continue or exit.

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
