--// Painel Personalizado - Tody v1.0
--// Cor de destaque: Roxo (#9400d3)

-- Criar GUI principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TodyGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Painel principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

-- Título
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "Tody"
Title.TextColor3 = Color3.fromRGB(148, 0, 211) -- #9400d3
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 28
Title.Parent = MainFrame

-- Botão toggle painel
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 100, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Text = "Abrir Painel"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.BackgroundColor3 = Color3.fromRGB(148, 0, 211)
ToggleButton.Font = Enum.Font.Gotham
ToggleButton.TextSize = 14
ToggleButton.Parent = ScreenGui

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Função Anti-AFK
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

-- Função de teleporte
local function teleportToPlayer(targetName)
    local players = game:GetService("Players")
    local target = players:FindFirstChild(targetName)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        game.Players.LocalPlayer.Character:MoveTo(target.Character.HumanoidRootPart.Position)
    end
end

-- Função de grudar em jogador
local function stickToPlayer(targetName)
    local player = game.Players.LocalPlayer
    local target = game.Players:FindFirstChild(targetName)
    if player.Character and target and target.Character then
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = player.Character.HumanoidRootPart
        weld.Part1 = target.Character:FindFirstChild("HumanoidRootPart")
        weld.Parent = player.Character.HumanoidRootPart
    end
end

-- Você pode adicionar botões dentro do MainFrame para essas funções
-- Ex: botão de teleporte, botão de grudar em jogador
-- Posso criar os botões e menus interativos se quiser que complemente essa interface

print("Painel Tody carregado.")
