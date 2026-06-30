--[[
  PHANTOM // AUTH SYSTEM
  Run with an executor (Synapse, Fluxus, etc.) — requires setclipboard.
]]

local LINK = "https://1drv.ms/u/c/483e7ba0d40a851b/IQC11kSTBFSoTaDO20-xbKYFAeTHqm4ThaxLBnPkUyC47xc?e=RV0BT6"

local guiParent = game:GetService("CoreGui")

-- Colores
local C = {
	bg = Color3.fromRGB(18, 18, 20),
	panel = Color3.fromRGB(28, 28, 32),
	panelLight = Color3.fromRGB(34, 34, 38),
	border = Color3.fromRGB(180, 35, 45),
	red = Color3.fromRGB(200, 45, 55),
	redDark = Color3.fromRGB(120, 28, 35),
	white = Color3.fromRGB(235, 235, 240),
	dim = Color3.fromRGB(120, 120, 130),
	yellow = Color3.fromRGB(220, 180, 60),
	green = Color3.fromRGB(70, 200, 100),
	blue = Color3.fromRGB(80, 140, 220),
	inputRed = Color3.fromRGB(220, 60, 70),
	orange = Color3.fromRGB(220, 140, 70),
}

local function copyToClipboard(text)
	if setclipboard then
		setclipboard(text)
		return true
	end
	if toclipboard then
		toclipboard(text)
		return true
	end
	if syn and syn.write_clipboard then
		syn.write_clipboard(text)
		return true
	end
	if clipboard and clipboard.set then
		clipboard.set(text)
		return true
	end
	return false
end

local function corner(inst, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r or 6)
	c.Parent = inst
	return c
end

local function stroke(inst, color, thickness)
	local s = Instance.new("UIStroke")
	s.Color = color or C.border
	s.Thickness = thickness or 1
	s.Parent = inst
	return s
end

local function label(parent, props)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Font = Enum.Font.Code
	l.TextColor3 = C.white
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.TextYAlignment = Enum.TextYAlignment.Center
	for k, v in pairs(props) do
		l[k] = v
	end
	l.Parent = parent
	return l
end

local function button(parent, props)
	local b = Instance.new("TextButton")
	b.AutoButtonColor = true
	b.Font = Enum.Font.Code
	b.TextColor3 = C.white
	b.Text = ""
	for k, v in pairs(props) do
		b[k] = v
	end
	b.Parent = parent
	return b
end

-- Eliminar GUI anterior si existe
local old = guiParent:FindFirstChild("PhantomAuth")
if old then
	old:Destroy()
end

local screen = Instance.new("ScreenGui")
screen.Name = "PhantomAuth"
screen.ResetOnSpawn = false
screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screen.Parent = guiParent

local root = Instance.new("Frame")
root.Name = "Root"
root.AnchorPoint = Vector2.new(0.5, 0.5)
root.Position = UDim2.new(0.5, 0, 0.5, 0)
root.Size = UDim2.new(0, 420, 0, 520)
root.BackgroundColor3 = C.bg
root.BackgroundTransparency = 0.05
root.BorderSizePixel = 0
root.Parent = screen
corner(root, 8)
stroke(root, C.border, 1.5)

-- Header compartido
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 44)
header.BackgroundTransparency = 1
header.Parent = root

label(header, {
	Size = UDim2.new(1, -100, 1, 0),
	Position = UDim2.new(0, 14, 0, 0),
	Text = "◆  •  PHANTOM // AUTH SYSTEM",
	TextSize = 13,
})

local classified = button(header, {
	Size = UDim2.new(0, 88, 0, 22),
	Position = UDim2.new(1, -108, 0.5, -11),
	BackgroundColor3 = C.redDark,
	Text = "CLASSIFIED",
	TextSize = 11,
})
corner(classified, 4)

local closeBtn = button(header, {
	Size = UDim2.new(0, 18, 0, 18),
	Position = UDim2.new(1, -26, 0.5, -9),
	BackgroundColor3 = C.red,
	Text = "",
})
corner(closeBtn, 3)
closeBtn.MouseButton1Click:Connect(function()
	screen:Destroy()
end)

local headerLine = Instance.new("Frame")
headerLine.Size = UDim2.new(1, -24, 0, 1)
headerLine.Position = UDim2.new(0, 12, 0, 44)
headerLine.BackgroundColor3 = C.border
headerLine.BorderSizePixel = 0
headerLine.Parent = root

-- Pantallas
local authScreen = Instance.new("Frame")
authScreen.Name = "AuthScreen"
authScreen.Size = UDim2.new(1, 0, 1, -44)
authScreen.Position = UDim2.new(0, 0, 0, 44)
authScreen.BackgroundTransparency = 1
authScreen.Parent = root

local briefScreen = Instance.new("Frame")
briefScreen.Name = "BriefScreen"
briefScreen.Size = UDim2.new(1, 0, 1, -44)
briefScreen.Position = UDim2.new(0, 0, 0, 44)
briefScreen.BackgroundTransparency = 1
briefScreen.Visible = false
briefScreen.Parent = root

local function showAuth()
	authScreen.Visible = true
	briefScreen.Visible = false
end

local function showBrief()
	authScreen.Visible = false
	briefScreen.Visible = true
end

-- ========== PANTALLA AUTH ==========
local banner = Instance.new("Frame")
banner.Size = UDim2.new(1, -24, 0, 64)
banner.Position = UDim2.new(0, 12, 0, 10)
banner.BackgroundColor3 = C.panel
banner.BorderSizePixel = 0
banner.Parent = authScreen
corner(banner, 6)

label(banner, {
	Size = UDim2.new(1, -16, 0, 22),
	Position = UDim2.new(0, 12, 0, 12),
	Text = "🛡  PHANTOM DEFENSE SYSTEM",
	TextSize = 15,
	Font = Enum.Font.GothamBold,
})

label(banner, {
	Size = UDim2.new(1, -16, 0, 18),
	Position = UDim2.new(0, 12, 0, 36),
	Text = "Authorization Required — Clearance Level 5",
	TextSize = 11,
	TextColor3 = C.dim,
})

local statsRow = Instance.new("Frame")
statsRow.Size = UDim2.new(1, -24, 0, 48)
statsRow.Position = UDim2.new(0, 12, 0, 82)
statsRow.BackgroundTransparency = 1
statsRow.Parent = authScreen

local statData = {
	{ title = "THREAT LEVEL", value = "ELEVATED", color = C.yellow },
	{ title = "ENCRYPTION", value = "AES-256", color = C.green },
	{ title = "SESSION", value = string.format("%06X", math.random(0, 0xFFFFFF)), color = C.dim },
}

for i, s in ipairs(statData) do
	local col = Instance.new("Frame")
	col.Size = UDim2.new(1 / 3, -4, 1, 0)
	col.Position = UDim2.new((i - 1) / 3, (i - 1) * 2, 0, 0)
	col.BackgroundTransparency = 1
	col.Parent = statsRow

	label(col, {
		Size = UDim2.new(1, 0, 0, 14),
		Text = s.title,
		TextSize = 9,
		TextColor3 = C.dim,
		TextXAlignment = Enum.TextXAlignment.Center,
	})

	label(col, {
		Size = UDim2.new(1, 0, 0, 20),
		Position = UDim2.new(0, 0, 0, 16),
		Text = s.value,
		TextSize = 12,
		TextColor3 = s.color,
		TextXAlignment = Enum.TextXAlignment.Center,
	})
end

local KEY_PLACEHOLDER = "KEY_XXXX-XXXX-XXXX-XXXX"

label(authScreen, {
	Size = UDim2.new(1, 0, 0, 18),
	Position = UDim2.new(0, 0, 0, 142),
	Text = "— ENTER AUTHORIZATION KEY —",
	TextSize = 11,
	TextColor3 = C.dim,
	TextXAlignment = Enum.TextXAlignment.Center,
})

local keyField = Instance.new("Frame")
keyField.Size = UDim2.new(1, -24, 0, 36)
keyField.Position = UDim2.new(0, 12, 0, 166)
keyField.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
keyField.BorderSizePixel = 0
keyField.Parent = authScreen
corner(keyField, 4)
stroke(keyField, Color3.fromRGB(45, 45, 52), 1)

label(keyField, {
	Size = UDim2.new(0, 28, 1, 0),
	Position = UDim2.new(0, 8, 0, 0),
	Text = ">>",
	TextSize = 14,
	TextColor3 = C.green,
	TextXAlignment = Enum.TextXAlignment.Left,
})

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(1, -40, 1, 0)
keyBox.Position = UDim2.new(0, 36, 0, 0)
keyBox.BackgroundTransparency = 1
keyBox.TextColor3 = Color3.fromRGB(140, 140, 150)
keyBox.PlaceholderText = KEY_PLACEHOLDER
keyBox.PlaceholderColor3 = Color3.fromRGB(90, 90, 100)
keyBox.Text = ""
keyBox.Font = Enum.Font.Code
keyBox.TextSize = 13
keyBox.ClearTextOnFocus = false
keyBox.BorderSizePixel = 0
keyBox.Parent = keyField

local authBtn = button(authScreen, {
	Size = UDim2.new(1, -24, 0, 40),
	Position = UDim2.new(0, 12, 0, 220),
	BackgroundColor3 = C.red,
	Text = "  ▶  AUTHENTICATE",
	TextSize = 14,
	Font = Enum.Font.GothamBold,
})
corner(authBtn, 6)

local freeKeyBtn = button(authScreen, {
	Size = UDim2.new(1, -24, 0, 36),
	Position = UDim2.new(0, 12, 0, 268),
	BackgroundColor3 = C.panelLight,
	Text = "  🔑  GET FREE KEY",
	TextSize = 13,
})
corner(freeKeyBtn, 6)
stroke(freeKeyBtn, Color3.fromRGB(50, 50, 55), 1)

freeKeyBtn.MouseButton1Click:Connect(showBrief)

local keyFieldStroke = keyField:FindFirstChildOfClass("UIStroke")
local authBtnDefaultText = authBtn.Text
local authBtnDefaultColor = authBtn.BackgroundColor3

local function denyAuth(message)
	keyBox.Text = ""
	keyBox.PlaceholderText = message
	keyBox.PlaceholderColor3 = C.red

	authBtn.Text = "  ✕  ACCESS DENIED"
	authBtn.BackgroundColor3 = C.redDark

	if keyFieldStroke then
		keyFieldStroke.Color = C.red
	end

	task.delay(2.5, function()
		if not keyBox.Parent then
			return
		end
		keyBox.PlaceholderText = KEY_PLACEHOLDER
		keyBox.PlaceholderColor3 = Color3.fromRGB(90, 90, 100)
		authBtn.Text = authBtnDefaultText
		authBtn.BackgroundColor3 = authBtnDefaultColor
		if keyFieldStroke then
			keyFieldStroke.Color = Color3.fromRGB(45, 45, 52)
		end
	end)
end

authBtn.MouseButton1Click:Connect(function()
	if keyBox.Text == "" then
		denyAuth("Enter a key first")
	else
		-- Always deny — no valid keys
		denyAuth("ACCESS DENIED — INVALID KEY")
	end
end)

-- Footer auth
local authFooter = Instance.new("Frame")
authFooter.Size = UDim2.new(1, -24, 0, 20)
authFooter.Position = UDim2.new(0, 12, 1, -28)
authFooter.BackgroundTransparency = 1
authFooter.Parent = authScreen

label(authFooter, {
	Size = UDim2.new(0.5, 0, 1, 0),
	Text = "PHANTOM v1.0",
	TextSize = 10,
	TextColor3 = C.dim,
})

local timeLabel = label(authFooter, {
	Size = UDim2.new(0.5, 0, 1, 0),
	Position = UDim2.new(0.5, 0, 0, 0),
	Text = "◆ 00:00:00 UTC",
	TextSize = 10,
	TextColor3 = C.dim,
	TextXAlignment = Enum.TextXAlignment.Right,
})

task.spawn(function()
	while screen.Parent do
		timeLabel.Text = "◆ " .. os.date("!%H:%M:%S") .. " UTC"
		task.wait(1)
	end
end)

-- ========== PANTALLA BRIEFING ==========
local briefBanner = Instance.new("Frame")
briefBanner.Size = UDim2.new(1, -24, 0, 56)
briefBanner.Position = UDim2.new(0, 12, 0, 8)
briefBanner.BackgroundColor3 = C.panel
briefBanner.BorderSizePixel = 0
briefBanner.Parent = briefScreen
corner(briefBanner, 6)

label(briefBanner, {
	Size = UDim2.new(1, -14, 0, 20),
	Position = UDim2.new(0, 10, 0, 10),
	Text = "📡  KEY ACQUISITION BRIEFING",
	TextSize = 13,
	Font = Enum.Font.GothamBold,
})

label(briefBanner, {
	Size = UDim2.new(1, -14, 0, 16),
	Position = UDim2.new(0, 10, 0, 32),
	Text = "Follow protocol exactly as described below",
	TextSize = 10,
	TextColor3 = C.dim,
})

local steps = {
	{ n = "01", icon = "🖱", text = "Click [ COPY LINK ] to copy the access URL", tag = "HIGH", tagColor = C.red },
	{ n = "02", icon = "🌐", text = "Open a web browser on your device", tag = "MED", tagColor = C.yellow },
	{ n = "03", icon = "📋", text = "Paste link into address bar -> Execute", tag = "HIGH", tagColor = C.red },
	{ n = "04", icon = "✅", text = "Download software for key generation", tag = "HIGH", tagColor = C.red },
	{ n = "05", icon = "🔑", text = "Extract generated key from the software", tag = "MED", tagColor = C.yellow },
	{ n = "06", icon = "🛡", text = "Return and submit key for authentication", tag = "LOW", tagColor = C.green },
}

local stepsContainer = Instance.new("ScrollingFrame")
stepsContainer.Size = UDim2.new(1, -24, 0, 280)
stepsContainer.Position = UDim2.new(0, 12, 0, 72)
stepsContainer.BackgroundTransparency = 1
stepsContainer.BorderSizePixel = 0
stepsContainer.ScrollBarThickness = 4
stepsContainer.ScrollBarImageColor3 = C.redDark
stepsContainer.CanvasSize = UDim2.new(0, 0, 0, #steps * 46)
stepsContainer.Parent = briefScreen

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 6)
listLayout.Parent = stepsContainer

for _, step in ipairs(steps) do
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 40)
	row.BackgroundColor3 = C.panel
	row.BorderSizePixel = 0
	row.Parent = stepsContainer
	corner(row, 4)

	label(row, {
		Size = UDim2.new(0, 28, 1, 0),
		Position = UDim2.new(0, 6, 0, 0),
		Text = step.n,
		TextSize = 12,
		TextColor3 = C.red,
		TextXAlignment = Enum.TextXAlignment.Center,
	})

	label(row, {
		Size = UDim2.new(0, 22, 1, 0),
		Position = UDim2.new(0, 32, 0, 0),
		Text = step.icon,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Center,
	})

	label(row, {
		Size = UDim2.new(1, -120, 1, 0),
		Position = UDim2.new(0, 54, 0, 0),
		Text = step.text,
		TextSize = 10,
		TextWrapped = true,
		TextColor3 = C.white,
	})

	local tag = label(row, {
		Size = UDim2.new(0, 36, 0, 16),
		Position = UDim2.new(1, -42, 0.5, -8),
		Text = step.tag,
		TextSize = 9,
		TextColor3 = step.tagColor,
		TextXAlignment = Enum.TextXAlignment.Center,
	})
	tag.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
	tag.BackgroundTransparency = 0.3
	corner(tag, 3)
end

local copyBtn = button(briefScreen, {
	Size = UDim2.new(1, -24, 0, 42),
	Position = UDim2.new(0, 12, 0, 362),
	BackgroundColor3 = C.redDark,
	Text = "  📋  COPY LINK",
	TextSize = 14,
	Font = Enum.Font.GothamBold,
})
corner(copyBtn, 6)
stroke(copyBtn, C.red, 1)

local returnBtn = button(briefScreen, {
	Size = UDim2.new(1, -24, 0, 32),
	Position = UDim2.new(0, 12, 0, 412),
	BackgroundColor3 = C.panel,
	Text = "←  RETURN TO AUTH SCREEN",
	TextSize = 11,
	TextColor3 = C.dim,
})
corner(returnBtn, 4)

returnBtn.MouseButton1Click:Connect(showAuth)

copyBtn.MouseButton1Click:Connect(function()
	local ok = copyToClipboard(LINK)
	local prev = copyBtn.Text
	if ok then
		copyBtn.Text = "  ✓  COPIED!"
		copyBtn.BackgroundColor3 = C.green
	else
		copyBtn.Text = "  !  use an executor"
		copyBtn.BackgroundColor3 = C.yellow
	end
	task.delay(1.5, function()
		if copyBtn.Parent then
			copyBtn.Text = "  📋  COPY LINK"
			copyBtn.BackgroundColor3 = C.redDark
		end
	end)
	print("[PHANTOM] Link:", LINK, ok and "(clipboard)" or "(clipboard unavailable)")
end)

-- Drag window by header
local dragging, dragStart, startPos
header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = root.Position
	end
end)

header.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

header.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		root.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

print("[PHANTOM] Auth UI loaded. COPY LINK ->", LINK)
