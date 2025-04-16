-- Painel Dominus Tody v3.5 - Com botão redondo estilizado local Players = game:GetService("Players") local LocalPlayer = Players.LocalPlayer local Mouse = LocalPlayer:GetMouse() local RunService = game:GetService("RunService") local UserInputService = game:GetService("UserInputService") local VirtualUser = game:GetService("VirtualUser")

-- GUI Principal local gui = Instance.new("ScreenGui", game.CoreGui) local frame = Instance.new("Frame", gui) frame.Size = UDim2.new(0, 400, 0, 500) frame.Position = UDim2.new(0.5, -200, 0.5, -250) frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) frame.Visible = false Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

-- Título com nome de exibição local title = Instance.new("TextLabel", frame) title.Size = UDim2.new(1, 0, 0, 50) title.Text = LocalPlayer.DisplayName or LocalPlayer.Name title.Font = Enum.Font.GothamBlack title.TextColor3 = Color3.fromRGB(148, 0, 211) title.TextScaled = true title.BackgroundTransparency = 1

-- Dropdown para selecionar jogador local dropdown = Instance.new("TextButton", frame) dropdown.Size = UDim2.new(0, 360, 0, 30) dropdown.Position = UDim2.new(0, 20, 0, 60) dropdown.Text = "Selecionar Jogador" dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50) dropdown.TextColor3 = Color3.new(1, 1, 1) dropdown.Font = Enum.Font.Gotham dropdown.TextScaled = true Instance.new("UICorner", dropdown).CornerRadius = UDim.new(0, 6)

local selectedPlayer = nil

dropdown.MouseButton1Click:Connect(function() local menu = Instance.new("Frame", frame) menu.Position = UDim2.new(0, 20, 0, 100) menu.Size = UDim2.new(0, 360, 0, 200) menu.BackgroundColor3 = Color3.fromRGB(40, 40, 40) Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 6)

for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer then
        local btn = Instance.new("TextButton", menu)
        btn.Size = UDim2.new(1, -10, 0, 30)
        btn.Position = UDim2.new(0, 5, 0, (#menu:GetChildren() - 1) * 35)
        btn.Text = plr.Name
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.Gotham
        btn.TextScaled = true
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        btn.MouseButton1Click:Connect(function()
            selectedPlayer = plr
            dropdown.Text = "Selecionado: " .. plr.Name
            menu:Destroy()
        end)
    end
end

end)

-- Criador de botões funcionais local function createButton(text, y, callback) local btn = Instance.new("TextButton", frame) btn.Size = UDim2.new(0, 360, 0, 30) btn.Position = UDim2.new(0, 20, 0, y) btn.Text = text btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70) btn.TextColor3 = Color3.new(1, 1, 1) btn.Font = Enum.Font.Gotham btn.TextScaled = true Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6) btn.MouseButton1Click:Connect(callback) end

-- Variáveis local weld = nil local espEnabled = false local flying = false local flySpeed = 2

-- Botões de ação createButton("Teleportar", 310, function() if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character:MoveTo(selectedPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0)) end end)

createButton("Grudar / Desgrudar", 350, function() if weld then weld:Destroy() weld = nil elseif selectedPlayer and selectedPlayer.Character then weld = Instance.new("WeldConstraint") weld.Part0 = LocalPlayer.Character:WaitForChild("HumanoidRootPart") weld.Part1 = selectedPlayer.Character:WaitForChild("HumanoidRootPart") weld.Parent = LocalPlayer.Character.HumanoidRootPart end end)

createButton("Ativar / Desativar Fly", 390, function() flying = not flying end)

RunService.RenderStepped:Connect(function() if flying and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then local vel = Vector3.new() if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + workspace.CurrentCamera.CFrame.LookVector end if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - workspace.CurrentCamera.CFrame.LookVector end if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel = vel - workspace.CurrentCamera.CFrame.RightVector end if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel = vel + workspace.CurrentCamera.CFrame.RightVector end if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel = vel + Vector3.new(0, 1, 0) end LocalPlayer.Character:TranslateBy(vel.Unit * flySpeed) end end)

createButton("ESP Players", 430, function() espEnabled = not espEnabled for _, plr in pairs(Players:GetPlayers()) do if plr ~= LocalPlayer and plr.Character then for _, part in pairs(plr.Character:GetDescendants()) do if part:IsA("BasePart") then if espEnabled then local box = Instance.new("BoxHandleAdornment") box.Size = part.Size + Vector3.new(0.2, 0.2, 0.2) box.Adornee = part box.AlwaysOnTop = true box.ZIndex = 5 box.Transparency = 0.5 box.Color3 = Color3.fromRGB(255, 0, 0) box.Name = "ESP" box.Parent = part else local esp = part:FindFirstChild("ESP") if esp then esp:Destroy() end end end end end end end)

-- Anti-AFK automático LocalPlayer.Idled:Connect(function() VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame) wait(1) VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame) end)

-- Botão redondo para abrir/fechar painel local openButton = Instance.new("TextButton", gui) openButton.Size = UDim2.new(0, 50, 0, 50) openButton.Position = UDim2.new(0, 10, 0.5, -25) openButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40) openButton.Text = "T" openButton.TextColor3 = Color3.fromRGB(148, 0, 211) openButton.Font = Enum.Font.GothamBold openButton.TextScaled = true Instance.new("UICorner", openButton).CornerRadius = UDim.new(1, 0)

openButton.MouseButton1Click:Connect(function() frame.Visible = not frame.Visible end)

