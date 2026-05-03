local lib = {}
lib.name = "Script Hub"

local tweens = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local http = game:GetService("HttpService")

local cfg = {
    bg = Color3.fromRGB(18,18,22),
    bg2 = Color3.fromRGB(25,25,30),
    accent = Color3.fromRGB(45,45,55),
    txt = Color3.fromRGB(240,240,245),
    border = Color3.fromRGB(35,35,42),
    gray = Color3.fromRGB(150,150,165)
}

local function checkExec()
    if not (writefile and getcustomasset and makefolder and isfolder) then
        local gui = Instance.new("ScreenGui")
        gui.Name = "Warning"
        gui.ResetOnSpawn = false
        pcall(function() gui.Parent = game:GetService("CoreGui") end)
        if not gui.Parent then gui.Parent = game.Players.LocalPlayer.PlayerGui end
        
        local bg = Instance.new("Frame", gui)
        bg.Size = UDim2.new(1,0,1,0)
        bg.BackgroundColor3 = Color3.fromRGB(10,10,15)
        bg.BackgroundTransparency = 0.1
        bg.BorderSizePixel = 0
        
        local box = Instance.new("Frame", gui)
        box.Size = UDim2.new(0,400,0,200)
        box.Position = UDim2.new(0.5,-200,0.5,-100)
        box.BackgroundColor3 = cfg.bg
        box.BorderSizePixel = 0
        Instance.new("UICorner", box).CornerRadius = UDim.new(0,10)
        
        local title = Instance.new("TextLabel", box)
        title.Size = UDim2.new(1,-20,0,30)
        title.Position = UDim2.new(0,10,0,10)
        title.BackgroundTransparency = 1
        title.Text = "Executor Not Supported"
        title.TextColor3 = Color3.fromRGB(255,80,80)
        title.TextSize = 16
        title.Font = Enum.Font.GothamBold
        
        local msg = Instance.new("TextLabel", box)
        msg.Size = UDim2.new(1,-20,0,80)
        msg.Position = UDim2.new(0,10,0,50)
        msg.BackgroundTransparency = 1
        msg.Text = "Your executor doesn't support required functions.\nTry a different executor."
        msg.TextColor3 = cfg.gray
        msg.TextSize = 13
        msg.Font = Enum.Font.Gotham
        msg.TextWrapped = true
        msg.TextYAlignment = Enum.TextYAlignment.Top
        
        local btn = Instance.new("TextButton", box)
        btn.Size = UDim2.new(0,120,0,35)
        btn.Position = UDim2.new(0.5,-60,1,-45)
        btn.BackgroundColor3 = cfg.accent
        btn.Text = "OK"
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.TextSize = 14
        btn.Font = Enum.Font.GothamBold
        btn.BorderSizePixel = 0
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
        
        btn.MouseButton1Click:Connect(function()
            gui:Destroy()
        end)
        
        return false
    end
    return true
end

local function loadIcon(url)
    if url:match("^rbxassetid://") then return url end
    if not (writefile and getcustomasset and makefolder and isfolder and isfile) then
        return "rbxassetid://3926305904"
    end
    
    local ok, res = pcall(function()
        local folder = "nexus_icons/" .. lib.name:gsub("[^%w]","")
        if not isfolder("nexus_icons") then makefolder("nexus_icons") end
        if not isfolder(folder) then makefolder(folder) end
        
        local hash = url:sub(-15):gsub("[^%w]","")
        local file = folder.."/"..hash..".png"
        
        if isfile(file) then return getcustomasset(file) end
        
        local data = game:HttpGet(url)
        writefile(file, data)
        return getcustomasset(file)
    end)
    
    return ok and res or "rbxassetid://3926305904"
end

function lib:SetScriptName(n)
    lib.name = n
end

function lib:SetMainColor(c)
    cfg.bg = c or cfg.bg
end

function lib:SetAccentColor(c)
    cfg.accent = c or cfg.accent
end

function lib:ShowLoadingScreen(callback)
    local gui = Instance.new("ScreenGui")
    gui.Name = "Loading"
    gui.ResetOnSpawn = false
    pcall(function() gui.Parent = game:GetService("CoreGui") end)
    if not gui.Parent then gui.Parent = game.Players.LocalPlayer.PlayerGui end
    
    local blur = Instance.new("BlurEffect", game.Lighting)
    blur.Size = 0
    tweens:Create(blur, TweenInfo.new(0.4), {Size=15}):Play()
    
    local bg = Instance.new("Frame", gui)
    bg.Size = UDim2.new(1,0,1,0)
    bg.Position = UDim2.new(0,0,0,0)
    bg.BackgroundColor3 = Color3.fromRGB(8,8,12)
    bg.BackgroundTransparency = 1
    bg.BorderSizePixel = 0
    
    tweens:Create(bg, TweenInfo.new(0.4), {BackgroundTransparency=0}):Play()
    
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0,320,0,100)
    frame.Position = UDim2.new(0.5,-160,0.5,-50)
    frame.BackgroundTransparency = 1
    
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0,30)
    title.Position = UDim2.new(0,0,0,0)
    title.BackgroundTransparency = 1
    title.Text = lib.name
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.TextSize = 20
    title.Font = Enum.Font.GothamBold
    title.TextTransparency = 1
    
    tweens:Create(title, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency=0}):Play()
    
    local status = Instance.new("TextLabel", frame)
    status.Size = UDim2.new(1,0,0,18)
    status.Position = UDim2.new(0,0,0,35)
    status.BackgroundTransparency = 1
    status.Text = "Loading..."
    status.TextColor3 = cfg.gray
    status.TextSize = 12
    status.Font = Enum.Font.Gotham
    status.TextTransparency = 1
    
    tweens:Create(status, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency=0}):Play()
    
    local bar = Instance.new("Frame", frame)
    bar.Size = UDim2.new(1,0,0,3)
    bar.Position = UDim2.new(0,0,0,65)
    bar.BackgroundColor3 = Color3.fromRGB(25,25,35)
    bar.BorderSizePixel = 0
    bar.BackgroundTransparency = 1
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1,0)
    
    tweens:Create(bar, TweenInfo.new(0.5), {BackgroundTransparency=0}):Play()
    
    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new(0,0,1,0)
    fill.BackgroundColor3 = cfg.accent
    fill.BorderSizePixel = 0
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)
    
    local watermark = Instance.new("TextLabel", gui)
    watermark.Size = UDim2.new(0,200,0,20)
    watermark.Position = UDim2.new(1,-210,1,-30)
    watermark.BackgroundTransparency = 1
    watermark.Text = "Powered By NexusLib"
    watermark.TextColor3 = Color3.fromRGB(100,100,120)
    watermark.TextSize = 11
    watermark.Font = Enum.Font.Gotham
    watermark.TextXAlignment = Enum.TextXAlignment.Right
    watermark.TextTransparency = 1
    
    tweens:Create(watermark, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency=0.5}):Play()
    
    task.spawn(function()
        wait(0.2)
        for i=0,100,4 do
            wait(0.015)
            tweens:Create(fill, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size=UDim2.new(i/100,0,1,0)}):Play()
            if i<30 then status.Text = "Initializing..."
            elseif i<60 then status.Text = "Loading components..."
            elseif i<90 then status.Text = "Building interface..."
            else status.Text = "Ready" end
        end
        wait(0.3)
        tweens:Create(bg, TweenInfo.new(0.4), {BackgroundTransparency=1}):Play()
        tweens:Create(title, TweenInfo.new(0.4), {TextTransparency=1}):Play()
        tweens:Create(status, TweenInfo.new(0.4), {TextTransparency=1}):Play()
        tweens:Create(bar, TweenInfo.new(0.4), {BackgroundTransparency=1}):Play()
        tweens:Create(fill, TweenInfo.new(0.4), {BackgroundTransparency=1}):Play()
        tweens:Create(watermark, TweenInfo.new(0.4), {TextTransparency=1}):Play()
        tweens:Create(blur, TweenInfo.new(0.4), {Size=0}):Play()
        wait(0.4)
        gui:Destroy()
        blur:Destroy()
        if callback then callback() end
    end)
end

function lib:CreateWindow(title)
    local win = {tabs={}, current=nil}
    
    win.gui = Instance.new("ScreenGui")
    win.gui.Name = "Hub"
    win.gui.ResetOnSpawn = false
    pcall(function() win.gui.Parent = game:GetService("CoreGui") end)
    if not win.gui.Parent then win.gui.Parent = game.Players.LocalPlayer.PlayerGui end
    
    win.main = Instance.new("Frame", win.gui)
    win.main.Size = UDim2.new(0,600,0,400)
    win.main.Position = UDim2.new(0.5,-300,0.5,-200)
    win.main.BackgroundColor3 = cfg.bg
    win.main.BorderSizePixel = 0
    win.main.Active = true
    win.main.ClipsDescendants = true
    Instance.new("UICorner", win.main).CornerRadius = UDim.new(0,10)
    
    local stroke = Instance.new("UIStroke", win.main)
    stroke.Color = cfg.border
    stroke.Thickness = 1
    stroke.Transparency = 0.7
    
    win.topbar = Instance.new("Frame", win.main)
    win.topbar.Size = UDim2.new(1,0,0,50)
    win.topbar.BackgroundColor3 = cfg.bg2
    win.topbar.BorderSizePixel = 0
    win.topbar.ClipsDescendants = true
    Instance.new("UICorner", win.topbar).CornerRadius = UDim.new(0,10)
    
    local topfix = Instance.new("Frame", win.topbar)
    topfix.Size = UDim2.new(1,0,0,10)
    topfix.Position = UDim2.new(0,0,1,-10)
    topfix.BackgroundColor3 = cfg.bg2
    topfix.BorderSizePixel = 0
    
    win.bannerBg = Instance.new("Frame", win.topbar)
    win.bannerBg.Name = "BannerBg"
    win.bannerBg.Size = UDim2.new(1,0,1,0)
    win.bannerBg.BackgroundColor3 = cfg.bg2
    win.bannerBg.BackgroundTransparency = 0
    win.bannerBg.BorderSizePixel = 0
    win.bannerBg.ZIndex = 0
    
    win.bannerImg = Instance.new("ImageLabel", win.topbar)
    win.bannerImg.Name = "BannerImage"
    win.bannerImg.Size = UDim2.new(1,0,1,0)
    win.bannerImg.BackgroundTransparency = 1
    win.bannerImg.ScaleType = Enum.ScaleType.Crop
    win.bannerImg.Visible = false
    win.bannerImg.ZIndex = 0
    
    win.bannerGrad = Instance.new("UIGradient", win.bannerBg)
    win.bannerGrad.Name = "BannerGradient"
    win.bannerGrad.Enabled = false
    
    local titleLbl = Instance.new("TextLabel", win.topbar)
    titleLbl.Size = UDim2.new(1,-100,1,0)
    titleLbl.Position = UDim2.new(0,15,0,0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = title
    titleLbl.TextColor3 = cfg.txt
    titleLbl.TextSize = 16
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 2
    
    local close = Instance.new("TextButton", win.topbar)
    close.Size = UDim2.new(0,40,0,40)
    close.Position = UDim2.new(1,-45,0,5)
    close.BackgroundTransparency = 1
    close.Text = ""
    close.ZIndex = 2
    
    local closeIcon = Instance.new("ImageLabel", close)
    closeIcon.Size = UDim2.new(0,16,0,16)
    closeIcon.Position = UDim2.new(0.5,-8,0.5,-8)
    closeIcon.BackgroundTransparency = 1
    closeIcon.Image = "rbxassetid://6031094678"
    closeIcon.ImageColor3 = Color3.fromRGB(255,80,80)
    
    close.MouseButton1Click:Connect(function()
        win.gui:Destroy()
    end)
    
    win.tabList = Instance.new("ScrollingFrame", win.main)
    win.tabList.Size = UDim2.new(0,85,1,-60)
    win.tabList.Position = UDim2.new(0,8,0,55)
    win.tabList.BackgroundTransparency = 1
    win.tabList.BorderSizePixel = 0
    win.tabList.ScrollBarThickness = 4
    win.tabList.ScrollBarImageColor3 = cfg.accent
    win.tabList.CanvasSize = UDim2.new(0,0,0,0)
    win.tabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    local tabLayout = Instance.new("UIListLayout", win.tabList)
    tabLayout.Padding = UDim.new(0,5)
    
    win.content = Instance.new("Frame", win.main)
    win.content.Size = UDim2.new(1,-108,1,-65)
    win.content.Position = UDim2.new(0,100,0,55)
    win.content.BackgroundTransparency = 1
    
    function win:SetBanner(type, ...)
        local args = {...}
        if type == "color" then
            win.bannerBg.BackgroundColor3 = args[1] or cfg.accent
            win.bannerGrad.Enabled = false
            win.bannerImg.Visible = false
        elseif type == "gradient" then
            win.bannerBg.BackgroundColor3 = Color3.fromRGB(255,255,255)
            win.bannerGrad.Enabled = true
            win.bannerGrad.Color = args[1] or ColorSequence.new(cfg.accent, cfg.bg2)
            win.bannerGrad.Rotation = args[2] or 0
            win.bannerImg.Visible = false
        elseif type == "image" then
            win.bannerGrad.Enabled = false
            win.bannerImg.Visible = true
            if args[1] then
                task.spawn(function()
                    win.bannerImg.Image = loadIcon(args[1])
                end)
            end
        end
    end
    
    local drag, dragInput, dragStart, startPos
    win.topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = true
            dragStart = input.Position
            startPos = win.main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    drag = false
                end
            end)
        end
    end)
    
    win.topbar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    uis.InputChanged:Connect(function(input)
        if input == dragInput and drag then
            local delta = input.Position - dragStart
            win.main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+delta.X, startPos.Y.Scale, startPos.Y.Offset+delta.Y)
        end
    end)
    
    function win:CreateTab(name, icon)
        local tab = {name=name}
        
        tab.btn = Instance.new("TextButton", win.tabList)
        tab.btn.Size = UDim2.new(1,-10,0,48)
        tab.btn.BackgroundColor3 = cfg.bg
        tab.btn.Text = ""
        tab.btn.BorderSizePixel = 0
        tab.btn.AutoButtonColor = false
        Instance.new("UICorner", tab.btn).CornerRadius = UDim.new(0,6)
        
        if icon and icon ~= "" then
            local ico = Instance.new("ImageLabel", tab.btn)
            ico.Size = UDim2.new(0,22,0,22)
            ico.Position = UDim2.new(0.5,-11,0,6)
            ico.BackgroundTransparency = 1
            ico.ImageColor3 = Color3.fromRGB(255,255,255)
            ico.Image = "rbxassetid://3926305904"
            task.spawn(function()
                ico.Image = loadIcon(icon)
            end)
        end
        
        local lbl = Instance.new("TextLabel", tab.btn)
        lbl.Size = UDim2.new(1,-10,0,14)
        lbl.Position = UDim2.new(0,5,1,-17)
        lbl.BackgroundTransparency = 1
        lbl.Text = name
        lbl.TextColor3 = cfg.txt
        lbl.TextSize = 10
        lbl.Font = Enum.Font.Gotham
        
        tab.page = Instance.new("ScrollingFrame", win.content)
        tab.page.Size = UDim2.new(1,0,1,0)
        tab.page.BackgroundTransparency = 1
        tab.page.BorderSizePixel = 0
        tab.page.ScrollBarThickness = 4
        tab.page.ScrollBarImageColor3 = cfg.accent
        tab.page.Visible = false
        
        local layout = Instance.new("UIListLayout", tab.page)
        layout.Padding = UDim.new(0,8)
        Instance.new("UIPadding", tab.page).PaddingTop = UDim.new(0,5)
        
        tab.btn.MouseButton1Click:Connect(function()
            for _,t in pairs(win.tabs) do
                t.page.Visible = false
                t.btn.BackgroundColor3 = cfg.bg
            end
            tab.page.Visible = true
            tab.btn.BackgroundColor3 = cfg.border
            win.current = tab
        end)
        
        table.insert(win.tabs, tab)
        if #win.tabs == 1 then
            tab.btn.BackgroundColor3 = cfg.border
            tab.page.Visible = true
            win.current = tab
        end
        
        function tab:AddButton(txt, cb)
            local btn = Instance.new("TextButton", tab.page)
            btn.Size = UDim2.new(1,-10,0,32)
            btn.BackgroundColor3 = cfg.bg2
            btn.Text = txt
            btn.TextColor3 = cfg.txt
            btn.TextSize = 13
            btn.Font = Enum.Font.Gotham
            btn.BorderSizePixel = 0
            btn.AutoButtonColor = false
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
            
            btn.MouseEnter:Connect(function()
                tweens:Create(btn, TweenInfo.new(0.15), {BackgroundColor3=cfg.border}):Play()
            end)
            btn.MouseLeave:Connect(function()
                tweens:Create(btn, TweenInfo.new(0.15), {BackgroundColor3=cfg.bg2}):Play()
            end)
            btn.MouseButton1Click:Connect(function()
                pcall(cb)
            end)
            return btn
        end
        
        function tab:AddToggle(txt, def, cb)
            local tog = {state=def or false}
            
            local frame = Instance.new("Frame", tab.page)
            frame.Size = UDim2.new(1,-10,0,32)
            frame.BackgroundColor3 = cfg.bg2
            frame.BorderSizePixel = 0
            Instance.new("UICorner", frame).CornerRadius = UDim.new(0,6)
            
            local lbl = Instance.new("TextLabel", frame)
            lbl.Size = UDim2.new(1,-55,1,0)
            lbl.Position = UDim2.new(0,12,0,0)
            lbl.BackgroundTransparency = 1
            lbl.Text = txt
            lbl.TextColor3 = cfg.txt
            lbl.TextSize = 13
            lbl.Font = Enum.Font.Gotham
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            
            local btn = Instance.new("TextButton", frame)
            btn.Size = UDim2.new(0,38,0,18)
            btn.Position = UDim2.new(1,-45,0.5,-9)
            btn.BackgroundColor3 = tog.state and cfg.accent or cfg.border
            btn.Text = ""
            btn.BorderSizePixel = 0
            btn.AutoButtonColor = false
            Instance.new("UICorner", btn).CornerRadius = UDim.new(1,0)
            
            local circle = Instance.new("Frame", btn)
            circle.Size = UDim2.new(0,14,0,14)
            circle.Position = tog.state and UDim2.new(1,-16,0.5,-7) or UDim2.new(0,2,0.5,-7)
            circle.BackgroundColor3 = Color3.fromRGB(255,255,255)
            circle.BorderSizePixel = 0
            Instance.new("UICorner", circle).CornerRadius = UDim.new(1,0)
            
            btn.MouseButton1Click:Connect(function()
                tog.state = not tog.state
                tweens:Create(btn, TweenInfo.new(0.15), {BackgroundColor3=tog.state and cfg.accent or cfg.border}):Play()
                tweens:Create(circle, TweenInfo.new(0.15), {Position=tog.state and UDim2.new(1,-16,0.5,-7) or UDim2.new(0,2,0.5,-7)}):Play()
                pcall(cb, tog.state)
            end)
            
            function tog:Set(val)
                tog.state = val
                btn.BackgroundColor3 = val and cfg.accent or cfg.border
                circle.Position = val and UDim2.new(1,-16,0.5,-7) or UDim2.new(0,2,0.5,-7)
            end
            return tog
        end
        
        function tab:AddSlider(txt, min, max, def, cb)
            local sld = {val=def or min}
            
            local frame = Instance.new("Frame", tab.page)
            frame.Size = UDim2.new(1,-10,0,45)
            frame.BackgroundColor3 = cfg.bg2
            frame.BorderSizePixel = 0
            Instance.new("UICorner", frame).CornerRadius = UDim.new(0,6)
            
            local lbl = Instance.new("TextLabel", frame)
            lbl.Size = UDim2.new(1,-20,0,18)
            lbl.Position = UDim2.new(0,12,0,4)
            lbl.BackgroundTransparency = 1
            lbl.Text = txt
            lbl.TextColor3 = cfg.txt
            lbl.TextSize = 13
            lbl.Font = Enum.Font.Gotham
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            
            local valLbl = Instance.new("TextLabel", frame)
            valLbl.Size = UDim2.new(0,50,0,18)
            valLbl.Position = UDim2.new(1,-60,0,4)
            valLbl.BackgroundTransparency = 1
            valLbl.Text = tostring(sld.val)
            valLbl.TextColor3 = cfg.accent
            valLbl.TextSize = 13
            valLbl.Font = Enum.Font.GothamBold
            valLbl.TextXAlignment = Enum.TextXAlignment.Right
            
            local bar = Instance.new("Frame", frame)
            bar.Size = UDim2.new(1,-24,0,4)
            bar.Position = UDim2.new(0,12,1,-12)
            bar.BackgroundColor3 = cfg.border
            bar.BorderSizePixel = 0
            Instance.new("UICorner", bar).CornerRadius = UDim.new(1,0)
            
            local fill = Instance.new("Frame", bar)
            fill.Size = UDim2.new((def-min)/(max-min),0,1,0)
            fill.BackgroundColor3 = cfg.accent
            fill.BorderSizePixel = 0
            Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)
            
            local dragging = false
            bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                end
            end)
            uis.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            uis.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                    sld.val = math.floor(min + (max-min)*pos)
                    fill.Size = UDim2.new(pos,0,1,0)
                    valLbl.Text = tostring(sld.val)
                    pcall(cb, sld.val)
                end
            end)
            
            function sld:Set(v)
                sld.val = math.clamp(v, min, max)
                local pos = (sld.val-min)/(max-min)
                fill.Size = UDim2.new(pos,0,1,0)
                valLbl.Text = tostring(sld.val)
            end
            return sld
        end
        
        function tab:AddLabel(txt)
            local lbl = Instance.new("TextLabel", tab.page)
            lbl.Size = UDim2.new(1,-10,0,22)
            lbl.BackgroundTransparency = 1
            lbl.Text = txt
            lbl.TextColor3 = cfg.gray
            lbl.TextSize = 13
            lbl.Font = Enum.Font.Gotham
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            return lbl
        end
        
        function tab:AddTextBox(placeholder, cb)
            local frame = Instance.new("Frame", tab.page)
            frame.Size = UDim2.new(1,-10,0,32)
            frame.BackgroundColor3 = cfg.bg2
            frame.BorderSizePixel = 0
            Instance.new("UICorner", frame).CornerRadius = UDim.new(0,6)
            
            local box = Instance.new("TextBox", frame)
            box.Size = UDim2.new(1,-24,1,0)
            box.Position = UDim2.new(0,12,0,0)
            box.BackgroundTransparency = 1
            box.PlaceholderText = placeholder
            box.Text = ""
            box.TextColor3 = cfg.txt
            box.PlaceholderColor3 = cfg.gray
            box.TextSize = 13
            box.Font = Enum.Font.Gotham
            box.TextXAlignment = Enum.TextXAlignment.Left
            box.ClearTextOnFocus = false
            
            box.FocusLost:Connect(function(enter)
                if enter then pcall(cb, box.Text) end
            end)
            return box
        end
        
        function tab:AddDropdown(txt, options, def, cb)
            local drop = {selected=def or options[1], open=false}
            
            local frame = Instance.new("Frame", tab.page)
            frame.Size = UDim2.new(1,-10,0,32)
            frame.BackgroundColor3 = cfg.bg2
            frame.BorderSizePixel = 0
            Instance.new("UICorner", frame).CornerRadius = UDim.new(0,6)
            
            local lbl = Instance.new("TextLabel", frame)
            lbl.Size = UDim2.new(1,-90,1,0)
            lbl.Position = UDim2.new(0,12,0,0)
            lbl.BackgroundTransparency = 1
            lbl.Text = txt
            lbl.TextColor3 = cfg.txt
            lbl.TextSize = 13
            lbl.Font = Enum.Font.Gotham
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            
            local btn = Instance.new("TextButton", frame)
            btn.Size = UDim2.new(0,70,0,22)
            btn.Position = UDim2.new(1,-78,0.5,-11)
            btn.BackgroundColor3 = cfg.border
            btn.Text = drop.selected
            btn.TextColor3 = cfg.txt
            btn.TextSize = 11
            btn.Font = Enum.Font.Gotham
            btn.BorderSizePixel = 0
            btn.AutoButtonColor = false
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0,4)
            
            local arrow = Instance.new("TextLabel", btn)
            arrow.Size = UDim2.new(0,12,1,0)
            arrow.Position = UDim2.new(1,-14,0,0)
            arrow.BackgroundTransparency = 1
            arrow.Text = "▼"
            arrow.TextColor3 = cfg.gray
            arrow.TextSize = 8
            arrow.Font = Enum.Font.Gotham
            
            local list = Instance.new("Frame", frame)
            list.Size = UDim2.new(0,70,0,0)
            list.Position = UDim2.new(1,-78,1,5)
            list.BackgroundColor3 = cfg.bg
            list.BorderSizePixel = 0
            list.ClipsDescendants = true
            list.ZIndex = 10
            Instance.new("UICorner", list).CornerRadius = UDim.new(0,4)
            
            local listLayout = Instance.new("UIListLayout", list)
            listLayout.Padding = UDim.new(0,2)
            
            for _,opt in pairs(options) do
                local optBtn = Instance.new("TextButton", list)
                optBtn.Size = UDim2.new(1,-4,0,20)
                optBtn.Position = UDim2.new(0,2,0,0)
                optBtn.BackgroundColor3 = cfg.bg2
                optBtn.Text = opt
                optBtn.TextColor3 = cfg.txt
                optBtn.TextSize = 11
                optBtn.Font = Enum.Font.Gotham
                optBtn.BorderSizePixel = 0
                optBtn.AutoButtonColor = false
                Instance.new("UICorner", optBtn).CornerRadius = UDim.new(0,3)
                
                optBtn.MouseEnter:Connect(function()
                    tweens:Create(optBtn, TweenInfo.new(0.1), {BackgroundColor3=cfg.border}):Play()
                end)
                optBtn.MouseLeave:Connect(function()
                    tweens:Create(optBtn, TweenInfo.new(0.1), {BackgroundColor3=cfg.bg2}):Play()
                end)
                optBtn.MouseButton1Click:Connect(function()
                    drop.selected = opt
                    btn.Text = opt
                    drop.open = false
                    tweens:Create(list, TweenInfo.new(0.15), {Size=UDim2.new(0,70,0,0)}):Play()
                    tweens:Create(arrow, TweenInfo.new(0.15), {Rotation=0}):Play()
                    pcall(cb, opt)
                end)
            end
            
            btn.MouseButton1Click:Connect(function()
                drop.open = not drop.open
                if drop.open then
                    local h = #options*22 + (#options-1)*2 + 4
                    tweens:Create(list, TweenInfo.new(0.15), {Size=UDim2.new(0,70,0,h)}):Play()
                    tweens:Create(arrow, TweenInfo.new(0.15), {Rotation=180}):Play()
                else
                    tweens:Create(list, TweenInfo.new(0.15), {Size=UDim2.new(0,70,0,0)}):Play()
                    tweens:Create(arrow, TweenInfo.new(0.15), {Rotation=0}):Play()
                end
            end)
            
            function drop:Set(val)
                if table.find(options, val) then
                    drop.selected = val
                    btn.Text = val
                end
            end
            return drop
        end
        
        return tab
    end
    
    return win
end

return lib
