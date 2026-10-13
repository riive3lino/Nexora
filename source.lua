-- Nexora UI
-- Código baseado na Luna UI.
-- Créditos originais: Nebula Softworks (2024).
-- Licença: consulte o arquivo LICENSE (Luna UI).


local Nexora = {}

Nexora.Name = "Nexora UI"
Nexora.Version = "0.1.0"

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

function Nexora:CreateWindow(options)
    options = options or {}

    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    local old = playerGui:FindFirstChild("NexoraUI")
    if old then
        old:Destroy()
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "NexoraUI"
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 50
    gui.Parent = playerGui

    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.fromOffset(650, 420)
    main.Position = UDim2.new(0.5, -325, 0.5, -210)
    main.BackgroundColor3 = Color3.fromRGB(17, 17, 23)
    main.BorderSizePixel = 0
    main.ClipsDescendants = true
    main.Parent = gui

    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

    local outline = Instance.new("UIStroke", main)
    outline.Color = Color3.fromRGB(90, 65, 180)
    outline.Thickness = 1.2
    outline.Transparency = 0.15

    -- Barra superior
    local topbar = Instance.new("Frame")
    topbar.Name = "Topbar"
    topbar.Size = UDim2.new(1, 0, 0, 54)
    topbar.BackgroundColor3 = Color3.fromRGB(23, 22, 32)
    topbar.BorderSizePixel = 0
    topbar.Active = true
    topbar.Parent = main

    local title = Instance.new("TextLabel")
    title.Position = UDim2.fromOffset(18, 0)
    title.Size = UDim2.new(1, -100, 1, 0)
    title.BackgroundTransparency = 1
    title.Text = options.Name or "Nexora UI"
    title.TextColor3 = Color3.fromRGB(240, 238, 255)
    title.TextSize = 19
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = topbar

    local version = Instance.new("TextLabel")
    version.AnchorPoint = Vector2.new(1, 0.5)
    version.Position = UDim2.new(1, -55, 0.5, 0)
    version.Size = UDim2.fromOffset(60, 22)
    version.BackgroundTransparency = 1
    version.Text = "v" .. Nexora.Version
    version.TextColor3 = Color3.fromRGB(155, 145, 190)
    version.TextSize = 10
    version.Font = Enum.Font.Gotham
    version.Parent = topbar

    local close = Instance.new("TextButton")
    close.AnchorPoint = Vector2.new(1, 0.5)
    close.Position = UDim2.new(1, -12, 0.5, 0)
    close.Size = UDim2.fromOffset(28, 28)
    close.BackgroundColor3 = Color3.fromRGB(55, 37, 55)
    close.Text = "×"
    close.TextColor3 = Color3.fromRGB(255, 125, 145)
    close.TextSize = 22
    close.Font = Enum.Font.Gotham
    close.AutoButtonColor = true
    close.Parent = topbar
    Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)

    close.Activated:Connect(function()
        gui:Destroy()
    end)

    -- Arrastar a janela pelo topo
    local dragging = True
    local dragStart
    local startPosition

    topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            dragStart = input.Position
            startPosition = main.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (
            input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch
        ) then
            local delta = input.Position - dragStart

            main.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
        end
    end)

    -- Barra lateral
    local sidebar = Instance.new("Frame")
    sidebar.Position = UDim2.fromOffset(12, 66)
    sidebar.Size = UDim2.new(0, 155, 1, -78)
    sidebar.BackgroundColor3 = Color3.fromRGB(23, 22, 31)
    sidebar.BorderSizePixel = 0
    sidebar.Parent = main
    Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 9)

    local sidePadding = Instance.new("UIPadding")
    sidePadding.PaddingTop = UDim.new(0, 12)
    sidePadding.PaddingLeft = UDim.new(0, 8)
    sidePadding.PaddingRight = UDim.new(0, 8)
    sidePadding.Parent = sidebar

    local sideLayout = Instance.new("UIListLayout")
    sideLayout.Padding = UDim.new(0, 7)
    sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sideLayout.Parent = sidebar

    -- Área das abas
    local content = Instance.new("Frame")
    content.Position = UDim2.fromOffset(179, 66)
    content.Size = UDim2.new(1, -191, 1, -78)
    content.BackgroundColor3 = Color3.fromRGB(23, 22, 31)
    content.BorderSizePixel = 0
    content.ClipsDescendants = true
    content.Parent = main
    Instance.new("UICorner", content).CornerRadius = UDim.new(0, 9)

    local Window = {
        Gui = gui,
        Main = main,
        Content = content,
        Tabs = {}
    }

    function Window:CreateTab(tabOptions)
        tabOptions = tabOptions or {}

        local tabName = tabOptions.Name or "Principal"
        local firstTab = #self.Tabs == 0

        local page = Instance.new("ScrollingFrame")
        page.Name = tabName
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.BorderSizePixel = 0
        page.ScrollBarThickness = 3
        page.ScrollBarImageColor3 = Color3.fromRGB(125, 95, 220)
        page.CanvasSize = UDim2.new(0, 0, 0, 0)
        page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        page.Visible = firstTab
        page.Parent = content

        local pagePadding = Instance.new("UIPadding")
        pagePadding.PaddingTop = UDim.new(0, 14)
        pagePadding.PaddingLeft = UDim.new(0, 14)
        pagePadding.PaddingRight = UDim.new(0, 14)
        pagePadding.PaddingBottom = UDim.new(0, 14)
        pagePadding.Parent = page

        local pageLayout = Instance.new("UIListLayout")
        pageLayout.Padding = UDim.new(0, 10)
        pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        pageLayout.Parent = page

        local button = Instance.new("TextButton")
        button.Name = tabName .. "Button"
        button.Size = UDim2.new(1, 0, 0, 37)
        button.BackgroundColor3 = firstTab
            and Color3.fromRGB(93, 67, 175)
            or Color3.fromRGB(34, 32, 44)
        button.Text = "   " .. tabName
        button.TextColor3 = firstTab
            and Color3.fromRGB(255, 255, 255)
            or Color3.fromRGB(170, 166, 190)
        button.TextSize = 12
        button.TextXAlignment = Enum.TextXAlignment.Left
        button.Font = Enum.Font.GothamMedium
        button.AutoButtonColor = true
        button.Parent = sidebar
        Instance.new("UICorner", button).CornerRadius = UDim.new(0, 7)

        local tab = {
            Name = tabName,
            Page = page,
            Button = button
        }

        button.Activated:Connect(function()
            for _, other in ipairs(self.Tabs) do
                other.Page.Visible = false
                other.Button.BackgroundColor3 =
                    Color3.fromRGB(34, 32, 44)
                other.Button.TextColor3 =
                    Color3.fromRGB(170, 166, 190)
            end

            page.Visible = true
            button.BackgroundColor3 = Color3.fromRGB(93, 67, 175)
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)

        table.insert(self.Tabs, tab)
        return tab
    end

    return Window
end

return Nexora
