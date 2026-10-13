
local Nexora = {}

Nexora.Name = "Nexora UI"
Nexora.Version = "0.1.0"

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

function Nexora:CreateWindow(options)
    options = options or {}

    local player = Players.LocalPlayer
    local parent = CoreGui

    pcall(function()
        parent = game:GetService("StarterGui")
        parent = player:WaitForChild("PlayerGui")
    end)

    local gui = Instance.new("ScreenGui")
    gui.Name = "NexoraUI"
    gui.ResetOnSpawn = false

    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.fromOffset(600, 400)
    main.Position = UDim2.new(0.5, -300, 0.5, -200)
    main.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    main.BorderSizePixel = 0
    main.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = main

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -50, 0, 45)
    title.Position = UDim2.fromOffset(15, 0)
    title.BackgroundTransparency = 1
    title.Text = options.Name or "Nexora UI"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 20
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = main

    local close = Instance.new("TextButton")
    close.Size = UDim2.fromOffset(35, 35)
    close.Position = UDim2.new(1, -42, 0, 5)
    close.Text = "X"
    close.TextColor3 = Color3.new(1, 1, 1)
    close.BackgroundColor3 = Color3.fromRGB(170, 55, 65)
    close.Font = Enum.Font.GothamBold
    close.TextSize = 14
    close.Parent = main

    close.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    local sidebar = Instance.new("Frame")
    sidebar.Position = UDim2.fromOffset(10, 55)
    sidebar.Size = UDim2.new(0, 145, 1, -65)
    sidebar.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
    sidebar.BorderSizePixel = 0
    sidebar.Parent = main

    local sideLayout = Instance.new("UIListLayout")
    sideLayout.Padding = UDim.new(0, 6)
    sideLayout.Parent = sidebar

    local content = Instance.new("Frame")
    content.Position = UDim2.fromOffset(165, 55)
    content.Size = UDim2.new(1, -175, 1, -65)
    content.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
    content.BorderSizePixel = 0
    content.Parent = main

    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 8)
    contentCorner.Parent = content

    local Window = {
        Gui = gui,
        Main = main,
        Content = content,
        Tabs = {}
    }

    function Window:CreateTab(tabOptions)
        tabOptions = tabOptions or {}

        local tabName = tabOptions.Name or "Tab"

        local page = Instance.new("Frame")
        page.Name = tabName
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.Visible = #self.Tabs == 0
        page.Parent = content

        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -8, 0, 35)
        button.Position = UDim2.fromOffset(4, 0)
        button.BackgroundColor3 = Color3.fromRGB(48, 48, 60)
        button.Text = tabName
        button.TextColor3 = Color3.new(1, 1, 1)
        button.TextSize = 13
        button.Font = Enum.Font.Gotham
        button.Parent = sidebar

        local tab = {
            Name = tabName,
            Page = page,
            Button = button
        }

        button.MouseButton1Click:Connect(function()
            for _, other in ipairs(self.Tabs) do
                other.Page.Visible = false
            end
            page.Visible = true
        end)

        table.insert(self.Tabs, tab)
        return tab
    end

    gui.Parent = player:WaitForChild("PlayerGui")

    return Window
end

return Nexora
