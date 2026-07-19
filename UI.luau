do --// UI Source
    if getgenv().Library and getgenv().Library.Exit then
        getgenv().Library:Exit()
    end

    -- Bad executor support (atleast by a bit)
    cloneref = cloneref or function(Object) return Object end

    --#region Services
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local HttpService = game:GetService("HttpService")
    local TweenService = game:GetService("TweenService")
    local GuiService = game:GetService("GuiService")
    local CoreGui = cloneref(game:GetService("CoreGui"))
    --#endregion

    gethui = gethui or function() return CoreGui end

    --#region Variables
    local LocalPlayer = Players.LocalPlayer
    local IsMobile = UserInputService.TouchEnabled or false
    local GuiInset = GuiService:GetGuiInset().Y
    local Mouse = cloneref(LocalPlayer:GetMouse())
    --#endregion

    Library = {
        Flags = { },
        MenuKeybind = tostring(Enum.KeyCode.X),

        Directory = "dreamybull.club",
        Folders = {
            Assets = "/Assets",
            Configs = "/Configs"
        },

        FontSize = 12,

        Animation = {
            Time = 0.3,
            Style = "Exponential",
            Direction = "Out"
        },

        ZIndexOrder = {
            ["OptionHolder"] = 4,
            ["KeybindWindow"] = 4, -- burp
            ["ColorpickerWindow"] = 6
        },

        Theme = nil,

        -- Ignore below
        Threads = { },
        Connections = { },
        SetFlags = { },

        ThemingStuff = { },
        ThemeMap = { },

        OpenFrames = { },

        Holder = nil,
        UnusedHolder = nil,

        Font = nil,
        BoldFont = nil,
    } do
        Library.__index = Library

        local Flags = Library.Flags
        local SetFlags = Library.SetFlags
        local ConfigsFolder = Library.Directory .. Library.Folders.Configs .. "/"
        local ConfigSelected
        local ConfigName

        local Keys = {
            ["Unknown"]           = "Unknown",
            ["Backspace"]         = "Back",
            ["Tab"]               = "Tab",
            ["Clear"]             = "Clear",
            ["Return"]            = "Return",
            ["Pause"]             = "Pause",
            ["Escape"]            = "Escape",
            ["Space"]             = "Space",
            ["QuotedDouble"]      = '"',
            ["Hash"]              = "#",
            ["Dollar"]            = "$",
            ["Percent"]           = "%",
            ["Ampersand"]         = "&",
            ["Quote"]             = "'",
            ["LeftParenthesis"]   = "(",
            ["RightParenthesis"]  = " )",
            ["Asterisk"]          = "*",
            ["Plus"]              = "+",
            ["Comma"]             = ",",
            ["Minus"]             = "-",
            ["Period"]            = ".",
            ["Slash"]             = "`",
            ["Three"]             = "3",
            ["Seven"]             = "7",
            ["Eight"]             = "8",
            ["Colon"]             = ":",
            ["Semicolon"]         = ";",
            ["LessThan"]          = "<",
            ["GreaterThan"]       = ">",
            ["Question"]          = "?",
            ["Equals"]            = "=",
            ["At"]                = "@",
            ["LeftBracket"]       = "LeftBracket",
            ["RightBracket"]      = "RightBracked",
            ["BackSlash"]         = "BackSlash",
            ["Caret"]             = "^",
            ["Underscore"]        = "_",
            ["Backquote"]         = "`",
            ["LeftCurly"]         = "{",
            ["Pipe"]              = "|",
            ["RightCurly"]        = "}",
            ["Tilde"]             = "~",
            ["Delete"]            = "Delete",
            ["End"]               = "End",
            ["KeypadZero"]        = "Keypad0",
            ["KeypadOne"]         = "Keypad1",
            ["KeypadTwo"]         = "Keypad2",
            ["KeypadThree"]       = "Keypad3",
            ["KeypadFour"]        = "Keypad4",
            ["KeypadFive"]        = "Keypad5",
            ["KeypadSix"]         = "Keypad6",
            ["KeypadSeven"]       = "Keypad7",
            ["KeypadEight"]       = "Keypad8",
            ["KeypadNine"]        = "Keypad9",
            ["KeypadPeriod"]      = "KeypadP",
            ["KeypadDivide"]      = "KeypadD",
            ["KeypadMultiply"]    = "KeypadM",
            ["KeypadMinus"]       = "KeypadM",
            ["KeypadPlus"]        = "KeypadP",
            ["KeypadEnter"]       = "KeypadE",
            ["KeypadEquals"]      = "KeypadE",
            ["Insert"]            = "Insert",
            ["Home"]              = "Home",
            ["PageUp"]            = "PageUp",
            ["PageDown"]          = "PageDown",
            ["RightShift"]        = "RightShift",
            ["LeftShift"]         = "LeftShift",
            ["RightControl"]      = "RightControl",
            ["LeftControl"]       = "LeftControl",
            ["LeftAlt"]           = "LeftAlt",
            ["RightAlt"]          = "RightAlt"
        }

        -- Folders
        if not isfolder(Library.Directory) then
            makefolder(Library.Directory)
        end

        for _, Folder in Library.Folders do
            if not isfolder(Library.Directory .. Folder) then
                makefolder(Library.Directory .. Folder)
            end
        end

        local Themes = {
            ["Preset"] = {
                ["Background"] = Color3.fromRGB(23, 23, 23),
                ["Inline"] = Color3.fromRGB(22, 22, 22),
                ["Content"] = Color3.fromRGB(21, 21, 21),
                ["Text"] = Color3.fromRGB(200, 200, 200),
                ["Outline 1"] = Color3.fromRGB(35, 35, 35),
                ["Outline 2"] = Color3.fromRGB(30, 30, 30),
                ["Outline 3"] = Color3.fromRGB(15, 15, 15),
                ["Outline 4"] = Color3.fromRGB(10, 10, 10),
                ["Inactive Text"] = Color3.fromRGB(135, 135, 135),
                ["Accent"] = Color3.fromRGB(126, 192, 255), -- 126, 192, 255
                ["Hovered Element"] = Color3.fromRGB(35, 35, 35),
            }
        }

        Library.Theme = Themes.Preset

        -- Custom Font
        local CustomFont = { } do
            function CustomFont:New(Name, Weight, Style, Data)
                if not isfile(Data.Id) then
                    writefile(Data.Id, game:HttpGet(Data.Url))
                end

                local Data = {
                    name = Name,
                    faces = {
                        {
                            name = Name,
                            weight = Weight,
                            style = Style,
                            assetId = getcustomasset(Data.Id)
                        }
                    }
                }

                local FontPath = Library.Directory .. Library.Folders.Assets .. "/" .. Name .. ".font"
                writefile(FontPath, HttpService:JSONEncode(Data))
                return Font.new(getcustomasset(FontPath))
            end

            Library.Font = CustomFont:New("WindowsXPTAHOMA", 400, "Regular", {
                Id = "WindowsXPTAHOMA",
                Url = "https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/windows-xp-tahoma.ttf"
            })

            Library.BoldFont = CustomFont:New("Tahoma8PTBOLD", 400, "Regular", {
                Id = "Tahoma8PTBOLD",
                Url = "https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/TAHOMA-8PT-BOLD-WINDOWS-XP.TTF"
            })
        end

        Library.Exit = function(Self)
            for _, Connection in Library.Connections do
                Connection:Disconnect()
            end

            for Thread in Library.Threads do -- [OPT] Threads 现在是字典
                coroutine.close(Thread)
            end

            if Self.Holder then
                Self.Holder.Instance:Destroy()
            end

            if Self.UnusedHolder then
                Self.UnusedHolder.Instance:Destroy()
            end

            task.spawn(function()
                HookManager:RestoreAll()
            end)

            task.spawn(function()
                TaskScheduler:Unload()
            end)

            task.spawn(function()
                ESP.Unload()
            end)

            task.spawn(function()
                Connection.Clear()
            end)

            Library = nil
            getgenv().Library = nil
        end

        Library.Create = function(Self, Class, Properties)
            local Data = {
                Class = Class,
                Properties = Properties,
                Instance = Instance.new(Class)
            }

            if Class == 'TextLabel' then
                Data.Instance.AutoLocalize = false
            end

            for Index, Property in Properties do
                if Property == "FontFace" then
                    Data.Instance[Property] = Library.Font
                elseif Property == "TextSize" then
                    Data.Instance[Property] = Library.FontSize
                elseif Property == "Name" then
                    Data.Instance[Property] = "\0"
                elseif Class == "TextButton" and Property == "AutoButtonColor" then
                    Data.Instance[Property] = false
                elseif Class == "TextButton" and Property == "Text" then
                    Data.Instance[Property] = ""
                else
                    Data.Instance[Index] = Property
                end
            end

            return setmetatable(Data, Library)
        end

        Library.Thread = function(Self, Function)
            -- [OPT] 原来每次创建两个协程且永不从 Threads 移除 (无限增长); 现在单协程 + 结束自清理
            local Threads = Library.Threads

            local NewThread = coroutine.create(function()
                Function()
                Threads[coroutine.running()] = nil
            end)

            Threads[NewThread] = true
            task.spawn(NewThread)

            return NewThread
        end

        Library.Connect = function(Self, Signal, Callback)
            local Connection

            if Self.Instance then
                if Self.Instance[Signal] then
                    if IsMobile and Signal == "MouseButton1Down" then
                        Connection = Self.Instance.InputBegan:Connect(function(Input)
                            if Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseButton1 then
                                Callback(Input)
                            end
                        end)

                        return
                    end

                    Connection = Self.Instance[Signal]:Connect(Callback)
                else
                    Connection = Signal:Connect(Callback)
                end
            else
                Connection = Signal:Connect(Callback)
            end

            table.insert(Library.Connections, Connection)
            return Connection
        end

        -- [OPT] TweenInfo.new 每次调用都会分配; 动画设置不变时复用同一个
        local CachedTweenInfo, CachedAnimTime, CachedAnimStyle, CachedAnimDirection
        local CachedQuartInfo, CachedQuartTime

        Library.GetAnimationInfo = function()
            local Animation = Library.Animation

            if not CachedTweenInfo or CachedAnimTime ~= Animation.Time or CachedAnimStyle ~= Animation.Style or CachedAnimDirection ~= Animation.Direction then
                CachedAnimTime = Animation.Time
                CachedAnimStyle = Animation.Style
                CachedAnimDirection = Animation.Direction
                CachedTweenInfo = TweenInfo.new(CachedAnimTime, Enum.EasingStyle[CachedAnimStyle], Enum.EasingDirection[CachedAnimDirection])
            end

            return CachedTweenInfo
        end

        Library.GetQuartInfo = function()
            local Time = Library.Animation.Time

            if not CachedQuartInfo or CachedQuartTime ~= Time then
                CachedQuartTime = Time
                CachedQuartInfo = TweenInfo.new(Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            end

            return CachedQuartInfo
        end

        Library.Tween = function(Self, Properties, Info, IsRawItem)
            local Object = Self.Instance or IsRawItem
            Info = Info or Library.GetAnimationInfo()

            if not Object then
                return
            end

            local NewTween = TweenService:Create(Object, Info, Properties)
            NewTween:Play()

            if Properties.TextTransparency and Object:IsA("TextLabel") then -- [OPT] 便宜的判断放前面
                local Stroke = Object:FindFirstChildOfClass("UIStroke")

                if Stroke then
                    TweenService:Create(Stroke, Info, {
                        Transparency = Properties.TextTransparency
                    }):Play()
                end
            end

            return NewTween
        end

        -- [OPT] 返回常量表; 原来每个 descendant 每次调用都分配一张新表
        local TweenPropsFrame = { "BackgroundTransparency" }
        local TweenPropsText = { "TextTransparency", "BackgroundTransparency" }
        local TweenPropsImage = { "BackgroundTransparency", "ImageTransparency" }
        local TweenPropsScroll = { "BackgroundTransparency", "ScrollBarImageTransparency" }
        local TweenPropsStroke = { "Transparency" }
        local TweenPropsNone = { }

        Library.GetTweenProperty = function(Self, IsRawItem)
            local Object = Self.Instance or IsRawItem

            if not Object then
                return TweenPropsNone
            end

            if Object:IsA("Frame") then
                return TweenPropsFrame
            elseif Object:IsA("TextLabel") or Object:IsA("TextButton") or Object:IsA("TextBox") then
                return TweenPropsText
            elseif Object:IsA("ImageLabel") or Object:IsA("ImageButton") then
                return TweenPropsImage
            elseif Object:IsA("ScrollingFrame") then
                return TweenPropsScroll
            elseif Object:IsA("UIStroke") then
                return TweenPropsStroke
            end
        end

        Library.Fade = function(Self, Property, Visibility, IsRawItem)
            local Object = Self.Instance or IsRawItem

            if not Object then
                return
            end

            local OldTransparency = Object[Property]
            Object[Property] = Visibility and 1 or OldTransparency

            local NewTween = Library:Tween({
                [Property] = Visibility and OldTransparency or 1
            }, nil, Object)

            NewTween.Completed:Once(function() -- [OPT+FIX] 自动断开; 原来塞进 Library.Connections 永不清理 (泄漏)
                if not Visibility then
                    task.wait()
                    Object[Property] = OldTransparency
                end
            end)

            return NewTween
        end

        Library.FadeDescendants = function(Self, Visibility, Callback)
            if Visibility then
                Self.Instance.Visible = true
            end

            local NewTween

            local Children = Self.Instance:GetDescendants()
            table.insert(Children, Self.Instance)

            for _, Child in Children do
                local TransparencyProperty = Library:GetTweenProperty(Child)

                if TransparencyProperty then
                    if type(TransparencyProperty) == "table" then
                        for _, Property in TransparencyProperty do
                            NewTween = Library:Fade(Property, Visibility, Child)
                        end
                    else
                        NewTween = Library:Fade(TransparencyProperty, Visibility, Child)
                    end
                end
            end

            if not NewTween then -- 没有可渐变的元素时原来会直接报错
                if Callback and type(Callback) == "function" then
                    Callback()
                end

                Self.Instance.Visible = Visibility
                return
            end

            NewTween.Completed:Once(function() -- [OPT+FIX] 自动断开; 原来每次翻页都往 Library.Connections 里塞几百个连接
                if Callback and type(Callback) == "function" then
                    Callback()
                end

                Self.Instance.Visible = Visibility
            end)
        end

        Library.MakeDraggable = function(Self)
            if not Self.Instance then
                return
            end

            local Gui = Self.Instance
            local Dragging = false
            local DragStart
            local StartPosition
            local GoalPosition -- [OPT] 原来每个鼠标移动事件创建一个 Tween 对象; 现在只记目标, 用一条 RenderStepped 平滑

            local Set = function(Input)
                local DragDelta = Input.Position - DragStart
                local NewX = StartPosition.X.Offset + DragDelta.X
                local NewY = StartPosition.Y.Offset + DragDelta.Y

                local ScreenSize = Gui.Parent.AbsoluteSize
                local GuiSize = Gui.AbsoluteSize

                NewX = math.clamp(NewX, 0, ScreenSize.X - GuiSize.X)
                NewY = math.clamp(NewY, 0, ScreenSize.Y - GuiSize.Y)

                GoalPosition = UDim2.new(0, NewX, 0, NewY)
            end

            local InputChanged

            Self:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = true
                    DragStart = Input.Position
                    StartPosition = Gui.Position

                    if InputChanged then
                        return
                    end

                    InputChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            Dragging = false
                            InputChanged:Disconnect()
                            InputChanged = nil
                        end
                    end)
                end
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if Dragging then
                        Set(Input)
                    end
                end
            end)

            Library:Connect(RunService.RenderStepped, function(DeltaTime)
                if not GoalPosition then -- 空闲时每帧只有这一次判断
                    return
                end

                local Current = Gui.Position
                local DiffX = GoalPosition.X.Offset - Current.X.Offset
                local DiffY = GoalPosition.Y.Offset - Current.Y.Offset

                if DiffX * DiffX + DiffY * DiffY < 0.25 then
                    Gui.Position = GoalPosition

                    if not Dragging then
                        GoalPosition = nil
                    end

                    return
                end

                Gui.Position = Current:Lerp(GoalPosition, math.min(1, DeltaTime * 20))
            end)

            return Dragging
        end

        Library.MakeResizeable = function(Self, Minimum)
            if not Self.Instance then
                return
            end

            local Gui = Self.Instance

            local Resizing = false
            local CurrentSide = nil

            local StartMouse = nil
            local StartPosition = nil
            local StartSize = nil

            local EdgeThickness = 2

            local MakeEdge = function(Name, Position, Size)
                local Button = Library:Create("TextButton", {
                    Name = "\0",
                    Size = Size,
                    Position = Position,
                    BackgroundColor3 = Color3.fromRGB(166, 147, 243),
                    BackgroundTransparency = 1,
                    Text = "",
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    Parent = Gui,
                    ZIndex = 99999,
                })  Button:AddToTheme({BackgroundColor3 = "Accent"})

                return Button
            end

            local Edges = {
                {Button = MakeEdge(
                    "Left",
                    UDim2.new(0, 0, 0, 0),
                    UDim2.new(0, EdgeThickness, 1, 0)),
                    Side = "L"
                },

                {Button = MakeEdge(
                    "Right",
                    UDim2.new(1, -EdgeThickness, 0, 0),
                    UDim2.new(0, EdgeThickness, 1, 0)),
                    Side = "R"
                },

                {Button = MakeEdge(
                    "Top", UDim2.new(0, 0, 0, 0),
                    UDim2.new(1, 0, 0, EdgeThickness)),
                    Side = "T"
                },

                {Button = MakeEdge(
                    "Bottom",
                    UDim2.new(0, 0, 1, -EdgeThickness),
                    UDim2.new(1, 0, 0, EdgeThickness)),
                    Side = "B"
                },
            }

            local BeginResizing = function(Side)
                Resizing = true
                CurrentSide = Side

                StartMouse = UserInputService:GetMouseLocation()

                StartPosition = Vector2.new(Gui.Position.X.Offset, Gui.Position.Y.Offset)
                StartSize = Vector2.new(Gui.Size.X.Offset, Gui.Size.Y.Offset)

                for Index, Value in Edges do
                    Value.Button.Instance.BackgroundTransparency = (Value.Side == Side) and 0 or 1
                end
            end

            local EndResizing = function()
                Resizing = false
                CurrentSide = nil

                for Index, Value in Edges do
                    Value.Button.Instance.BackgroundTransparency = 1
                end
            end

            for Index, Value in Edges do
                Value.Button:Connect("InputBegan", function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                        BeginResizing(Value.Side)
                    end
                end)
            end

            Library:Connect(UserInputService.InputEnded, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    if Resizing then
                        EndResizing()
                    end
                end
            end)

            Library:Connect(RunService.RenderStepped, function(DeltaTime)
                if not Resizing or not CurrentSide then
                    return
                end

                local MouseLocation = UserInputService:GetMouseLocation()
                local dx = MouseLocation.X - StartMouse.X
                local dy = MouseLocation.Y - StartMouse.Y

                local x, y = StartPosition.X, StartPosition.Y
                local w, h = StartSize.X, StartSize.Y

                if CurrentSide == "L" then
                    x = StartPosition.X + dx
                    w = StartSize.X - dx
                elseif CurrentSide == "R" then
                    w = StartSize.X + dx
                elseif CurrentSide == "T" then
                    y = StartPosition.Y + dy
                    h = StartSize.Y - dy
                elseif CurrentSide == "B" then
                    h = StartSize.Y + dy
                end

                if w < Minimum.X then
                    if CurrentSide == "L" then
                        x = x - (Minimum.X - w)
                    end
                    w = Minimum.X
                end
                if h < Minimum.Y then
                    if CurrentSide == "T" then
                        y = y - (Minimum.Y - h)
                    end
                    h = Minimum.Y
                end

                -- [OPT] 原来拖动边缘时每帧创建 2 个 Tween 对象互相打架; 直接平滑赋值
                local Alpha = math.min(1, DeltaTime * 20)
                Gui.Position = Gui.Position:Lerp(UDim2.fromOffset(x, y), Alpha)
                Gui.Size = Gui.Size:Lerp(UDim2.fromOffset(w, h), Alpha)
            end)
        end

        Library.IsMouseOverFrame = function(Self)
            if not Self.Instance then
                return
            end

            local Object = Self.Instance

            local MousePosition = Vector2.new(Mouse.X, Mouse.Y)

            return MousePosition.X >= Object.AbsolutePosition.X and MousePosition.X <= Object.AbsolutePosition.X + Object.AbsoluteSize.X
            and MousePosition.Y >= Object.AbsolutePosition.Y and MousePosition.Y <= Object.AbsolutePosition.Y + Object.AbsoluteSize.Y
        end

        Library.SafeCall = function(Self, Function, ...)
            local Success, Result = pcall(Function, ...) -- [OPT+FIX] 直接透传: 不分配表, 且中间为 nil 的参数不再被吞掉

            if not Success then
                warn(Result)
                return false
            end

            return Success, Result
        end

        Library.Round = function(Self, Number, Float)
            local Multiplier = 1 / (Float or 1)
            return math.floor(Number * Multiplier) / Multiplier
        end

        Library.GetConfig = function(Self)
            local Config = { }

            local Success, Result = Library:SafeCall(function()
                for Index, Value in Library.Flags do
                    if type(Value) == "table" and Value.Key then
                        Config[Index] = {Key = tostring(Value.Key), Mode = Value.Mode}
                    elseif type(Value) == "table" and Value.Color then
                        Config[Index] = {Color = "#" .. Value.HexValue, Alpha = Value.Alpha}
                    else
                        Config[Index] = Value
                    end
                end
            end)

            if not Success then
                warn("Failed to get config:\n"..Result)
                return
            end

            return HttpService:JSONEncode(Config)
        end

        Library.LoadConfig = function(Self, Config)
            local Decoded = HttpService:JSONDecode(Config)

            local Success, Result = Library:SafeCall(function()
                for Index, Value in Decoded do
                    local SetFunction = Library.SetFlags[Index]

                    if SetFunction then
                        if type(Value) == "table" and Value.Key then
                            SetFunction(Value)
                        elseif type(Value) == "table" and Value.Color then
                            SetFunction(Value.Color, Value.Alpha)
                        else
                            SetFunction(Value)
                        end
                    end
                end
            end)

            return Success, Result
        end

        Library.GetConfigsList = function(Self, Element)
            local List = { }
            local ReturnList = { }

            List = listfiles(Library.Directory .. Library.Folders.Configs)

            for Index = 1, #List do
                local File = List[Index]

                if File:sub(-5) == ".json" then
                    local Position = File:find(".json", 1, true)
                    local StartPosition = Position

                    local Character = File:sub(Position, Position)
                    while Character ~= "/" and Character ~= "\\" and Character ~= "" do
                        Position = Position - 1
                        Character = File:sub(Position, Position)
                    end

                    if Character == "/" or Character == "\\" then
                        table.insert(ReturnList, File:sub(Position + 1, StartPosition - 1))
                    end
                end
            end

            Element:Refresh(ReturnList)
        end

        Library.AddToTheme = function(Self, Properties)
            local Object = Self.Instance

            local ThemeData = {
                Item = Object,
                Properties = Properties,
            }

            for Property, Value in ThemeData.Properties do
                if type(Value) == "string" then
                    if not Library.Theme[Value] then
                        Object[Property] = Value
                    end

                    Object[Property] = Library.Theme[Value]
                else
                    Object[Property] = Value()
                end
            end

            table.insert(Library.ThemingStuff, ThemeData)
            Library.ThemeMap[Object] = ThemeData
            return Self
        end

        Library.ChangeItemTheme = function(Self, Properties)
            local Object = Self.Instance

            if not Library.ThemeMap[Object] then
                return
            end

            Library.ThemeMap[Object].Properties = Properties
            Library.ThemeMap[Object] = Library.ThemeMap[Object]
        end

        Library.ChangeTheme = function(Self, Theme, Color)
            Library.Theme[Theme] = Color

            for _, Item in Library.ThemingStuff do
                for Property, Value in Item.Properties do
                    if type(Value) == "string" and Value == Theme then
                        Item.Item[Property] = Color
                    elseif type(Value) == "function" then
                        Item.Item[Property] = Value()
                    end
                end
            end
        end

        Library.OnHover = function(Self, OnHoverEnter, OnHoverLeave)
            local Object = Self.Instance

            if not Object then
                return
            end

            Library:Connect(Object.MouseEnter, OnHoverEnter)
            Library:Connect(Object.MouseLeave, OnHoverLeave)
        end

        Library.Holder = Library:Create("ScreenGui", {
            Parent = gethui(),
            IgnoreGuiInset = true,
            Name = "\0",
            ZIndexBehavior = Enum.ZIndexBehavior.Global,
            ResetOnSpawn = false
        })

        Library.UnusedHolder = Library:Create("ScreenGui", {
            Parent = gethui(),
            Name = "\0",
            Enabled = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Global,
            ResetOnSpawn = false
        })

        Library.NotifHolder = Library:Create("Frame", {
            Name = "\0",
            Parent = Library.Holder.Instance,
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 0, 1, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X
        })

        Library:Create("UIListLayout", {
            Name = "\0",
            Parent = Library.NotifHolder.Instance,
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 6)
        })

        Library:Create("UIPadding", {
            Name = "\0",
            Parent = Library.NotifHolder.Instance,
            PaddingTop = UDim.new(0, 8),
            PaddingBottom = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8),
            PaddingLeft = UDim.new(0, 8)
        })

        do
            Library.CreateColorpicker = function(Self, Data)
                local Colorpicker = {
                    Hue = 0,
                    Saturation = 0,
                    Value = 0,

                    Alpha = 0,

                    Color = Color3.fromRGB(255, 255, 255),
                    HexValue = "#FFFFFF",

                    Flag = Data.Flag,
                    IsOpen = false,

                    Items = { }
                }

                local Items = { } do
                    Items["ColorpickerButton"] = Library:Create("TextButton", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Data.Parent.Instance,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        Size = UDim2.new(0, 20, 0, 8),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 143, 203)
                    })

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["ColorpickerButton"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["ColorpickerButton"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Items["ColorpickerWindow"] = Library:Create("TextButton", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Library.UnusedHolder.Instance,
                        Visible = false,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        Position = UDim2.new(0, 1011, 0, 100),
                        Size = UDim2.new(0, 204, 0, 178),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Background"]
                    }):AddToTheme({BackgroundColor3 = 'Background'})

                    Items["CurrentColor"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["ColorpickerWindow"].Instance,
                        AnchorPoint = Vector2.new(0, 1),
                        Position = UDim2.new(0, 8, 1, -8),
                        Size = UDim2.new(0, 14, 0, 14),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 143, 203)
                    })

                    Items["Checkers"] = Library:Create("ImageLabel", {
                        Name = "\0",
                        Parent = Items["CurrentColor"].Instance,
                        ScaleType = Enum.ScaleType.Tile,
                        ImageTransparency = 0.6000000238418579,
                        TileSize = UDim2.new(0, 6, 0, 6),
                        Image = "http://www.roblox.com/asset/?id=18274452449",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 1, 0),
                        ZIndex = 2,
                        BorderSizePixel = 0
                    })

                    Items["Hue"] = Library:Create("TextButton", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["ColorpickerWindow"].Instance,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        Position = UDim2.new(0, 8, 0, 8),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Size = UDim2.new(0, 14, 1, -38),
                        BorderSizePixel = 0
                    })

                    Library:Create("UIGradient", {
                        Name = "\0",
                        Parent = Items["Hue"].Instance,
                        Rotation = 90,
                        Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
                        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
                        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
                        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                    }
                    })

                    Items["HueDragger"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Hue"].Instance,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Size = UDim2.new(1, 0, 0, 1),
                        BorderSizePixel = 0
                    })

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["HueDragger"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Color3.fromRGB(6, 7, 7)
                    })

                    Items["Alpha"] = Library:Create("TextButton", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["ColorpickerWindow"].Instance,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        AnchorPoint = Vector2.new(1, 1),
                        Position = UDim2.new(1, -8, 1, -8),
                        Size = UDim2.new(1, -38, 0, 14),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 143, 203)
                    })

                    Items["CheckersAlpha"] = Library:Create("ImageLabel", {
                        Name = "\0",
                        Parent = Items["Alpha"].Instance,
                        ScaleType = Enum.ScaleType.Tile,
                        TileSize = UDim2.new(0, 6, 0, 6),
                        Image = "http://www.roblox.com/asset/?id=18274452449",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 1, 0),
                        ZIndex = 2,
                        BorderSizePixel = 0
                    })

                    Library:Create("UIGradient", {
                        Name = "\0",
                        Parent = Items["CheckersAlpha"].Instance,
                        Transparency = NumberSequence.new{
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(1, 0),
                        },
                    })

                    Items["AlphaDragger"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Alpha"].Instance,
                        Size = UDim2.new(0, 1, 1, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BorderSizePixel = 0
                    })

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["AlphaDragger"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Color3.fromRGB(6, 7, 7)
                    })

                    Items["Palette"] = Library:Create("TextButton", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["ColorpickerWindow"].Instance,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        Position = UDim2.new(0, 30, 0, 8),
                        Size = UDim2.new(1, -38, 1, -38),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 143, 203)
                    })

                    Items["Saturation"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Palette"].Instance,
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BorderSizePixel = 0
                    })

                    Library:Create("UIGradient", {
                        Name = "\0",
                        Parent = Items["Saturation"].Instance,
                        Transparency = NumberSequence.new{
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(1, 0)
                    }
                    })

                    Items["Value"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Palette"].Instance,
                        Size = UDim2.new(1, 0, 1, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    })

                    Library:Create("UIGradient", {
                        Name = "\0",
                        Parent = Items["Value"].Instance,
                        Rotation = 90,
                        Transparency = NumberSequence.new{
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(1, 0)
                    }
                    })

                    Items["PaletteDragger"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Palette"].Instance,
                        Size = UDim2.new(0, 1, 0, 1),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BorderSizePixel = 0
                    })

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["PaletteDragger"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Color3.fromRGB(6, 7, 7)
                    })

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["ColorpickerWindow"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["ColorpickerWindow"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Colorpicker.Items = Items
                end

                Colorpicker.Holder = Items["ColorpickerWindow"]

                function Colorpicker:SetVisibility(Bool)
                    Items["ColorpickerButton"].Instance.Visible = Bool
                end

                function Colorpicker:Update(IsFromAlpha)
                    local Hue, Saturation, Value = Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value
                    Colorpicker.Color = Color3.fromHSV(Hue, Saturation, Value)
                    Colorpicker.HexValue = Colorpicker.Color:ToHex()

                    Items["ColorpickerButton"]:Tween({BackgroundColor3 = Colorpicker.Color})
                    Items["Palette"]:Tween({BackgroundColor3 = Color3.fromHSV(Hue, 1, 1)})

                    Flags[Colorpicker.Flag] = {
                        Alpha = Colorpicker.Alpha,
                        Color = Colorpicker.Color,
                        HexValue = Colorpicker.HexValue,
                        Transparency = 1 - Colorpicker.Alpha
                    }

                    if not IsFromAlpha then
                        Items["Alpha"]:Tween({BackgroundColor3 = Colorpicker.Color})
                    end

                    Items["CurrentColor"]:Tween({BackgroundColor3 = Colorpicker.Color})
                    Items["Checkers"]:Tween({ImageTransparency = 1 - Colorpicker.Alpha})

                    if Data.Callback then
                        Library:SafeCall(Data.Callback, Colorpicker.Color, Colorpicker.Alpha)
                    end
                end

                local Debounce = false
                local ColorpickerWindow = Items["ColorpickerWindow"].Instance
                local ColorpickerButton = Items["ColorpickerButton"].Instance

                local IsSettings = Data.Section and Data.Section.IsSettings

                function Colorpicker:SetOpen(Bool)
                    if Debounce then
                        return
                    end

                    Colorpicker.IsOpen = Bool

                    Debounce = true

                    if Colorpicker.IsOpen then
                        ColorpickerWindow.Position = UDim2.new(0, ColorpickerButton.AbsolutePosition.X, 0, ColorpickerButton.AbsolutePosition.Y + ColorpickerButton.AbsoluteSize.Y + GuiInset)

                        ColorpickerWindow.Parent = Library.Holder.Instance
                        ColorpickerWindow.Visible = true
                        Items["ColorpickerWindow"]:Tween({Position = UDim2.new(0, ColorpickerButton.AbsolutePosition.X, 0, ColorpickerButton.AbsolutePosition.Y + ColorpickerButton.AbsoluteSize.Y + 10 + GuiInset)})

                        Items["ColorpickerWindow"]:FadeDescendants(true, function()
                            Debounce = false
                        end)

                        for Index, Value in Library.OpenFrames do
                            if Value ~= IsSettings then
                                Value:SetOpen(false)
                            end
                        end

                        Library.OpenFrames[Colorpicker] = Colorpicker
                    else
                        Items["ColorpickerWindow"]:Tween({Position = UDim2.new(0, ColorpickerButton.AbsolutePosition.X, 0, ColorpickerButton.AbsolutePosition.Y + ColorpickerButton.AbsoluteSize.Y - 10 + GuiInset)})
                        Items["ColorpickerWindow"]:FadeDescendants(false, function()
                            ColorpickerWindow.Parent = Library.UnusedHolder.Instance
                            Debounce = false
                        end)

                        if Library.OpenFrames[Colorpicker] then
                            Library.OpenFrames[Colorpicker] = nil
                        end
                    end

                    local Descendants = ColorpickerWindow:GetDescendants()
                    table.insert(Descendants, ColorpickerWindow)

                    for Index, Value in Descendants do
                        if not Value.ClassName:find("UI") then
                            if IsSettings then
                                Value.ZIndex = Colorpicker.IsOpen and Library.ZIndexOrder.ColorpickerWindow + 4 or 1
                            else
                                Value.ZIndex = Colorpicker.IsOpen and Library.ZIndexOrder.ColorpickerWindow or 1
                            end
                        end
                    end
                end

                local SlidingPalette = false
                local PaletteChanged

                function Colorpicker:SlidePalette(Input)
                    if not Input or not SlidingPalette then
                        return
                    end

                    local ValueX = math.clamp(1 - (Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 1)
                    local ValueY = math.clamp(1 - (Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 1)

                    if Colorpicker.Saturation == ValueX and Colorpicker.Value == ValueY then -- [OPT] 值没变就不刷 5 个 Tween + 回调
                        return
                    end

                    Colorpicker.Saturation = ValueX
                    Colorpicker.Value = ValueY

                    local SlideX = math.clamp((Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 0.99)
                    local SlideY = math.clamp((Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 0.99)

                    Items["PaletteDragger"]:Tween({Position = UDim2.new(SlideX, 0, SlideY, 0)}, Library.GetQuartInfo())
                    Colorpicker:Update()
                end

                local SlidingHue = false
                local HueChanged

                function Colorpicker:SlideHue(Input)
                    if not Input or not SlidingHue then
                        return
                    end

                    local ValueY = math.clamp((Input.Position.Y - Items["Hue"].Instance.AbsolutePosition.Y) / Items["Hue"].Instance.AbsoluteSize.Y, 0, 1)

                    if Colorpicker.Hue == ValueY then -- [OPT] 值没变就不刷
                        return
                    end

                    local SlideY = math.clamp((Input.Position.Y - Items["Hue"].Instance.AbsolutePosition.Y) / Items["Hue"].Instance.AbsoluteSize.Y, 0, 0.99)

                    Colorpicker.Hue = ValueY

                    Items["HueDragger"]:Tween({Position = UDim2.new(0, 0, SlideY, 0)}, Library.GetQuartInfo())
                    Colorpicker:Update()
                end

                local SlidingAlpha = false
                local AlphaChanged

                function Colorpicker:SlideAlpha(Input)
                    if not Input or not SlidingAlpha then
                        return
                    end

                    local ValueX = math.clamp((Input.Position.X - Items["Alpha"].Instance.AbsolutePosition.X) / Items["Alpha"].Instance.AbsoluteSize.X, 0, 1)

                    if Colorpicker.Alpha == ValueX then -- [OPT] 值没变就不刷
                        return
                    end

                    Colorpicker.Alpha = ValueX

                    local SlideX = math.clamp((Input.Position.X - Items["Alpha"].Instance.AbsolutePosition.X) / Items["Alpha"].Instance.AbsoluteSize.X, 0, 0.985)

                    Items["AlphaDragger"]:Tween({Position = UDim2.new(SlideX, 0, 0, 0)}, Library.GetQuartInfo())
                    Colorpicker:Update(true)
                end

                function Colorpicker:Set(Color, Alpha)
                    if type(Color) == "table" then
                        Color = Color3.fromRGB(Color[1], Color[2], Color[3])
                    elseif type(Color) == "string" then
                        Color = Color3.fromHex(Color)
                    else
                        Color = Color -- lul
                    end

                    Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value = Color:ToHSV()
                    Colorpicker.Alpha = Alpha or 0

                    local PaletteValueX = math.clamp(1 - Colorpicker.Saturation, 0, 0.99)
                    local PaletteValueY = math.clamp(1 - Colorpicker.Value, 0, 0.99)

                    local AlphaPositionX = math.clamp(Colorpicker.Alpha, 0, 0.99)

                    local HuePositionY = math.clamp(Colorpicker.Hue, 0, 0.99)

                    Items["PaletteDragger"]:Tween({Position = UDim2.new(PaletteValueX, 0, PaletteValueY, 0)}, Library.GetQuartInfo())
                    Items["HueDragger"]:Tween({Position = UDim2.new(0, 0, HuePositionY, 0)}, Library.GetQuartInfo())
                    Items["AlphaDragger"]:Tween({Position = UDim2.new(AlphaPositionX, 0, 0, 0)}, Library.GetQuartInfo())
                    Colorpicker:Update()
                end

                Items["ColorpickerButton"]:Connect("MouseButton1Down", function()
                    Colorpicker:SetOpen(not Colorpicker.IsOpen)
                end)

                Items["Palette"]:Connect("InputBegan", function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                        SlidingPalette = true

                        Colorpicker:SlidePalette(Input)

                        if PaletteChanged then
                            return
                        end

                        PaletteChanged = Input.Changed:Connect(function()
                            if Input.UserInputState == Enum.UserInputState.End then
                                SlidingPalette = false

                                PaletteChanged:Disconnect()
                                PaletteChanged = nil
                            end
                        end)
                    end
                end)

                Items["Hue"]:Connect("InputBegan", function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                        SlidingHue = true

                        Colorpicker:SlideHue(Input)

                        if HueChanged then
                            return
                        end

                        HueChanged = Input.Changed:Connect(function()
                            if Input.UserInputState == Enum.UserInputState.End then
                                SlidingHue = false

                                HueChanged:Disconnect()
                                HueChanged = nil
                            end
                        end)
                    end
                end)

                Items["Alpha"]:Connect("InputBegan", function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                        SlidingAlpha = true

                        Colorpicker:SlideAlpha(Input)

                        if AlphaChanged then
                            return
                        end

                        AlphaChanged = Input.Changed:Connect(function()
                            if Input.UserInputState == Enum.UserInputState.End then
                                SlidingAlpha = false

                                AlphaChanged:Disconnect()
                                AlphaChanged = nil
                            end
                        end)
                    end
                end)

                Library:Connect(UserInputService.InputChanged, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                        if SlidingPalette then
                            Colorpicker:SlidePalette(Input)
                        end

                        if SlidingHue then
                            Colorpicker:SlideHue(Input)
                        end

                        if SlidingAlpha then
                            Colorpicker:SlideAlpha(Input)
                        end
                    end
                end)

                Library:Connect(UserInputService.InputBegan, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                        if Colorpicker.IsOpen then
                            if Items["ColorpickerWindow"]:IsMouseOverFrame() then
                                return
                            end

                            Colorpicker:SetOpen(false)
                        end
                    end
                end)

                if Data.Default then
                    Colorpicker:Set(Data.Default, Data.Alpha)
                end

                SetFlags[Colorpicker.Flag] = function(Value, Alpha)
                    Colorpicker:Set(Value, Alpha)
                end

                return Colorpicker, Items
            end

            --[[
                UI.luau — Library.CreateKeybind 修复版

                用法:
                在 UI.luau 中找到  Library.CreateKeybind = function(Self, Data)
                把它到对应结尾 end 的【整个函数】删掉, 换成下面这一整段。
                (它就在 Library.CreateColorpicker 之后 / Library.Watermark 之前)

                修复内容:
                1. Always 模式初始化后状态为 true, 并且立刻出现在 keybind list 里
                2. 初始化时必定触发一次 Callback (且只触发一次, 值正确)
                3. 不再依赖 ModeDropdown 回调的执行顺序 (原来靠它初始化, 很脆弱)
                4. Keybind:Set / 读取 config 时, mode 下拉框 UI 会跟着同步
                5. Value == "None" 时也能正常关闭 keybind 窗口
            --]]

            Library.CreateKeybind = function(Self, Data)
                local Keybind = {
                    Flag = Data.Flag,
                    IsOpen = false,

                    Key = "",
                    Mode = Data.Mode or Data.mode or "Toggle",
                    Value = "None",

                    Toggled = false,
                    Picking = false,

                    -- [关键] 构造期间禁止把回调抛给用户, 全部构造完成后再统一触发一次
                    Initialized = false,

                    Items = { },
                }

                local Items = { } do
                    Items["KeyButton"] = Library:Create("TextButton", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Data.Parent.Instance,
                        TextColor3 = Library.Theme["Inactive Text"],
                        Text = "mb2",
                        AutoButtonColor = false,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 0, 0, 12),
                        TextXAlignment = Enum.TextXAlignment.Right,
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X
                    }):AddToTheme({TextColor3 = 'Inactive Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["KeyButton"].Instance
                    })

                    Library:Create("UIPadding", {
                        Parent = Items["KeyButton"].Instance,
                        PaddingRight = UDim.new(0, -1)
                    })

                    Items["KeybindWindow"] = Library:Create("TextButton", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Library.UnusedHolder.Instance,
                        Visible = false,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        Size = UDim2.new(0, 200, 0, 50),
                        Position = UDim2.new(0, 1030, 0, 197),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        BackgroundColor3 = Library.Theme["Background"]
                    }):AddToTheme({BackgroundColor3 = 'Background'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["KeybindWindow"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["KeybindWindow"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Library:Create("UIPadding", {
                        Name = "\0",
                        Parent = Items["KeybindWindow"].Instance,
                        PaddingTop = UDim.new(0, 6),
                        PaddingBottom = UDim.new(0, 6),
                        PaddingRight = UDim.new(0, 6),
                        PaddingLeft = UDim.new(0, 6)
                    })

                    Library:Create("UIListLayout", {
                        Name = "\0",
                        Parent = Items["KeybindWindow"].Instance,
                        Padding = UDim.new(0, 4),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })

                    Keybind.Items = Items
                end

                Keybind.Holder = Items["KeybindWindow"]

                local Debounce = false
                local KeybindWindow = Items["KeybindWindow"].Instance
                local KeyButton = Items["KeyButton"].Instance

                local IsSettings = Data.Section and Data.Section.IsSettings

                function Keybind:SetOpen(Bool)
                    if Debounce then
                        return
                    end

                    Keybind.IsOpen = Bool

                    Debounce = true

                    if Keybind.IsOpen then
                        KeybindWindow.Position = UDim2.new(0, KeyButton.AbsolutePosition.X, 0, KeyButton.AbsolutePosition.Y + KeyButton.AbsoluteSize.Y + GuiInset)

                        KeybindWindow.Parent = Library.Holder.Instance
                        Items["KeybindWindow"]:Tween({Position = UDim2.new(0, KeyButton.AbsolutePosition.X, 0, KeyButton.AbsolutePosition.Y + KeyButton.AbsoluteSize.Y + 10 + GuiInset)})

                        Items["KeybindWindow"]:FadeDescendants(true, function()
                            Debounce = false
                        end)

                        for Index, Value in Library.OpenFrames do
                            if Value ~= IsSettings then
                                Value:SetOpen(false)
                            end
                        end

                        Library.OpenFrames[Keybind] = Keybind
                    else
                        Items["KeybindWindow"]:Tween({Position = UDim2.new(0, KeyButton.AbsolutePosition.X, 0, KeyButton.AbsolutePosition.Y + KeyButton.AbsoluteSize.Y - 10 + GuiInset)})
                        Items["KeybindWindow"]:FadeDescendants(false, function()
                            Items["KeybindWindow"].Instance.Parent = Library.UnusedHolder.Instance
                            Debounce = false
                        end)

                        if Library.OpenFrames[Keybind] then
                            Library.OpenFrames[Keybind] = nil
                        end
                    end

                    local Descendants = KeybindWindow:GetDescendants()
                    table.insert(Descendants, KeybindWindow)

                    for Index, Value in Descendants do
                        if not Value.ClassName:find("UI") then
                            if IsSettings then
                                Value.ZIndex = Keybind.IsOpen and Library.ZIndexOrder.KeybindWindow or 1
                            else
                                Value.ZIndex = Keybind.IsOpen and Library.ZIndexOrder.KeybindWindow + 1 or 1
                            end
                        end
                    end
                end

                local KeybindObject

                if Library.KeyList then
                    KeybindObject = Library.KeyList:Add("", "")
                end

                local Update = function()
                    if not KeybindObject then
                        return
                    end

                    -- tostring 保护: Data.Name 为 nil 时原版会直接报错, 导致整个 CreateKeybind 中断
                    KeybindObject:Set(tostring(Data.Name or "keybind"), Keybind.Mode)

                    -- [修复] Always 无条件显示, 不再受 Toggled 影响
                    KeybindObject:SetStatus(Keybind.Toggled or Keybind.Mode == "Always")

                    if Keybind.Mode == "Hold" then
                        KeybindObject:SetMode(Keybind.Toggled and "holding" or "off")
                    elseif Keybind.Mode == "Always" then
                        KeybindObject:SetMode("always on")
                    else
                        KeybindObject:SetMode(Keybind.Toggled and "toggled" or "off")
                    end
                end

                -- [核心] 所有状态写入 / UI 刷新 / 用户回调 都只走这一个出口
                local Sync = function()
                    Flags[Keybind.Flag] = {
                        Mode = Keybind.Mode,
                        Key = Keybind.Key,
                        Toggled = Keybind.Toggled
                    }

                    Update()

                    if Keybind.Initialized and Data.Callback then
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end
                end

                function Keybind:SetMode(NewMode)
                    if type(NewMode) == "string" and NewMode ~= "" then
                        Keybind.Mode = NewMode
                    end

                    if Keybind.Mode == "Always" then
                        Keybind.Toggled = true       -- Always: 永远开
                    elseif Keybind.Mode == "Hold" then
                        Keybind.Toggled = false      -- Hold: 没按住就是关
                    end
                    -- Toggle: 保持当前状态

                    Sync()
                end

                function Keybind:Press(Bool)
                    if Keybind.Mode == "Toggle" then
                        Keybind.Toggled = not Keybind.Toggled
                    elseif Keybind.Mode == "Hold" then
                        Keybind.Toggled = Bool and true or false
                    elseif Keybind.Mode == "Always" then
                        Keybind.Toggled = true
                    end

                    Sync()
                end

                local ShowInKeybindsList = Library:Toggle({
                    Name = "show in keybinds list",
                    Flag = Data.Flag .. "ShowInKeybindsList",
                    Parent = Items["KeybindWindow"],
                    Default = Data.ShowInKeybindsList,
                    Callback = function(Value)
                        if KeybindObject then
                            KeybindObject:SetVis(Value)
                            Update()
                        end
                    end
                })

                if Data.Toggle then
                    Library:Toggle({
                        Name = "sync",
                        Flag = Data.Flag .. "Sync",
                        Parent = Items["KeybindWindow"],
                        Default = true,
                    })
                end

                local ModeDropdown = Library:Dropdown({
                    Name = "mode",
                    Flag = Keybind.Flag .. "ModeDropdown",
                    Parent = Items["KeybindWindow"],
                    Items = { "Toggle", "Hold", "Always" },
                    Default = Keybind.Mode,
                    Callback = function(Value)
                        Keybind:SetMode(Value)
                    end
                })

                local SetKeyText = function(Text)
                    Keybind.Value = Text
                    Items["KeyButton"].Instance.Text = Text
                end

                local ApplyMode = function(NewMode)
                    NewMode = NewMode or "Toggle"

                    -- 让下拉框 UI 一起同步; 它的回调最终会走到 Keybind:SetMode -> Sync
                    if ModeDropdown and ModeDropdown.Options[NewMode] and ModeDropdown.Value ~= NewMode then
                        ModeDropdown:Set(NewMode)
                    else
                        Keybind:SetMode(NewMode)
                    end
                end

                function Keybind:Set(Key)
                    if typeof(Key) == "EnumItem" then
                        -- 用户点按钮重新绑定按键
                        Keybind.Key = tostring(Key)

                        local Raw = (Key.Name == "Backspace") and "None" or Key.Name
                        local KeyString = Keys[Keybind.Key] or Raw or "None"
                        local Text = string.gsub(string.gsub(tostring(KeyString), "KeyCode%.", ""), "UserInputType%.", "")

                        SetKeyText(Text)
                        Sync()
                    elseif type(Key) == "table" then
                        -- 初始化 / 读取 config: {Key = ..., Mode = ...}
                        Keybind.Key = tostring(Key.Key)

                        local Raw = (Keybind.Key == "Backspace") and "None" or Keybind.Key
                        local KeyString = Keys[Keybind.Key] or Raw
                        local Text = string.gsub(tostring(KeyString), "Enum%.", "")
                        Text = string.gsub(string.gsub(Text, "KeyCode%.", ""), "UserInputType%.", "")

                        SetKeyText(Text)
                        ApplyMode(Key.Mode or Keybind.Mode)
                    elseif table.find({"Toggle", "Hold", "Always"}, Key) then
                        ApplyMode(Key)
                    end

                    Keybind.Picking = false
                end

                Items["KeyButton"]:Connect("MouseButton1Click", function()
                    Keybind.Picking = true

                    Items["KeyButton"].Instance.Text = ". . ."
                    Items["KeyButton"]:Tween({TextColor3 = Library.Theme.Text})

                    local InputBegan
                    InputBegan = UserInputService.InputBegan:Connect(function(Input)
                        if Input.UserInputType == Enum.UserInputType.Keyboard then
                            Keybind:Set(Input.KeyCode)
                        else
                            Keybind:Set(Input.UserInputType)
                        end

                        Items["KeyButton"]:Tween({TextColor3 = Library.Theme["Inactive Text"]})

                        InputBegan:Disconnect()
                        InputBegan = nil
                    end)
                end)

                Library:Connect(UserInputService.InputBegan, function(Input, GPE)
                    -- 关窗口的判断要放最前面, 否则 Key 为 None 的 keybind 窗口点外面关不掉
                    if Keybind.IsOpen and not Items["KeybindWindow"]:IsMouseOverFrame() and not ModeDropdown.Items.OptionHolder:IsMouseOverFrame() then
                        Keybind:SetOpen(false)
                    end

                    if GPE or Keybind.Picking then
                        return
                    end

                    if Keybind.Key == "" or Keybind.Value == "None" then
                        return
                    end

                    if Data.Toggle and not Data.Toggle.Value then
                        return
                    end

                    if tostring(Input.KeyCode) == Keybind.Key or tostring(Input.UserInputType) == Keybind.Key then
                        if Keybind.Mode == "Toggle" then
                            Keybind:Press()
                        elseif Keybind.Mode == "Hold" then
                            Keybind:Press(true)
                        end
                        -- Always 不需要按键驱动
                    end
                end)

                Library:Connect(UserInputService.InputEnded, function(Input, GPE)
                    if Keybind.Mode ~= "Hold" then
                        return
                    end

                    if Keybind.Key == "" or Keybind.Value == "None" then
                        return
                    end

                    if tostring(Input.KeyCode) == Keybind.Key or tostring(Input.UserInputType) == Keybind.Key then
                        Keybind:Press(false)
                    end
                end)

                Items["KeyButton"]:Connect("MouseButton2Down", function()
                    Keybind:SetOpen(not Keybind.IsOpen)
                end)

                SetFlags[Keybind.Flag] = function(Value)
                    Keybind:Set(Value)
                end

                --====================== 初始化 ======================--
                if Data.Default then
                    Keybind:Set({
                        Key = Data.Default,
                        Mode = Keybind.Mode,
                    })
                else
                    Keybind:SetMode(Keybind.Mode)
                end

                -- 到这里 UI / Flags / Mode / Toggled 全部就绪, 打开回调开关, 触发唯一一次初始化回调
                Keybind.Initialized = true
                Sync()

                --[[ 如果你的 Callback 里引用了 ":Keybind(...)" 这行【之后】才定义的变量,
                    把上面这行 Sync() 换成下面这行, 让初始化回调延迟到本帧脚本跑完再触发:

                    task.defer(Sync)
                --]]

                return Keybind, Items
            end


            Library.Watermark = function(Self, Params)
                Params = Params or { }

                local Watermark = {
                    Name = Params.Name or Params.name or "Watermark",
                    SubName = Params.SubName or Params.subname or "SubName",

                    Items = { }
                }

                local Items = { } do
                    Items["Watermark"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Library.Holder.Instance,
                        AnchorPoint = Vector2.new(0.5, 0),
                        Position = UDim2.new(0.5, 0, 0, 5 + GuiInset),
                        Size = UDim2.new(0, 0, 0, 20),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        BackgroundColor3 = Library.Theme["Background"]
                    }):AddToTheme({BackgroundColor3 = 'Background'})

                    Items["Watermark"]:MakeDraggable()

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Watermark"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Watermark"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Watermark"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 2"],
                        BorderOffset = UDim.new(0, 2)
                    }):AddToTheme({Color = 'Outline 2'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Watermark"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 4"],
                        BorderOffset = UDim.new(0, 3)
                    }):AddToTheme({Color = 'Outline 4'})

                    Items["Title"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Watermark"].Instance,
                        AnchorPoint = Vector2.new(0, 1),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, -10, 0, 0),
                        Size = UDim2.new(0, 0, 0, 21),
                        ZIndex = -1,
                        AutomaticSize = Enum.AutomaticSize.X,
                        BackgroundColor3 = Library.Theme["Inline"]
                    }):AddToTheme({BackgroundColor3 = 'Inline'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Title"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Title"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Items["_"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Title"].Instance,
                        AnchorPoint = Vector2.new(0, 1),
                        Position = UDim2.new(0, -8, 1, -2),
                        Size = UDim2.new(1, 16, 0, 2),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Inline"]
                    }):AddToTheme({BackgroundColor3 = 'Inline'})

                    Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["_"].Instance,
                        Position = UDim2.new(0, -1, 0, 0),
                        Size = UDim2.new(0, 1, 0, 1),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Outline 1"]
                    }):AddToTheme({BackgroundColor3 = 'Outline 1'})

                    Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["_"].Instance,
                        AnchorPoint = Vector2.new(1, 0),
                        Position = UDim2.new(1, 1, 0, 0),
                        Size = UDim2.new(0, 1, 0, 1),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Outline 1"]
                    }):AddToTheme({BackgroundColor3 = 'Outline 1'})

                    Library:Create("UIPadding", {
                        Name = "\0",
                        Parent = Items["Title"].Instance,
                        PaddingRight = UDim.new(0, 8),
                        PaddingLeft = UDim.new(0, 8)
                    })

                    Items["Text"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.BoldFont,
                        TextSize = Library.FontSize,
                        Parent = Items["Title"].Instance,
                        RichText = true,
                        TextColor3 = Library.Theme["Text"],
                        Text = Watermark.Name,
                        Size = UDim2.new(0, 0, 0, 15),
                        AnchorPoint = Vector2.new(0, 0.5),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0.5, -2),
                        AutomaticSize = Enum.AutomaticSize.X
                    }):AddToTheme({TextColor3 = 'Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Text"].Instance
                    })

                    Items["SubText"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["Watermark"].Instance,
                        RichText = true,
                        TextColor3 = Library.Theme["Text"],
                        Text = Watermark.SubName,
                        Size = UDim2.new(0, 0, 0, 15),
                        AnchorPoint = Vector2.new(0, 0.5),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0.5, 0),
                        AutomaticSize = Enum.AutomaticSize.X
                    }):AddToTheme({TextColor3 = 'Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["SubText"].Instance
                    })

                    Library:Create("UIPadding", {
                        Name = "\0",
                        Parent = Items["Watermark"].Instance,
                        PaddingRight = UDim.new(0, 8),
                        PaddingLeft = UDim.new(0, 8)
                    })

                    Watermark.Items = Items
                end

                function Watermark:Center()
                    local AbsPos = Items["Watermark"].Instance.AbsolutePosition
                    Items["Watermark"].Instance.AnchorPoint = Vector2.new(0, 0)
                    task.wait()
                    Items["Watermark"].Instance.Position = UDim2.new(0, AbsPos.X, 0, AbsPos.Y + GuiInset)
                end

                function Watermark:SetText(Text)
                    Items["Text"].Instance.Text = tostring(Text)
                end

                function Watermark:SetSubText(Text)
                    Items["SubText"].Instance.Text = tostring(Text)
                end

                function Watermark:SetVisibility(Bool)
                Items["Watermark"].Instance.Visible = Bool
                end

                Watermark:Center()

                return setmetatable(Watermark, Library)
            end

            Library.KeybindList = function(Self, Params)
                Params = Params or { }

                local KeybindList = {
                    Name = Params.Name or Params.name or 'hot<font color="rgb(126, 192, 255)">keys</font>',

                    Items = { },
                }

                Library.KeyList = KeybindList

                local Items = { } do
                    Items["KeybindList"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Library.Holder.Instance,
                        AnchorPoint = Vector2.new(0, 0.5),
                        Position = UDim2.new(0, 20, 0.5, 0),
                        Size = UDim2.new(0, 156, 0, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.XY,
                        BackgroundColor3 = Library.Theme["Background"]
                    }):AddToTheme({BackgroundColor3 = 'Background'})

                    Items["KeybindList"]:MakeDraggable()

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["KeybindList"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["KeybindList"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["KeybindList"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 2"],
                        BorderOffset = UDim.new(0, 2)
                    }):AddToTheme({Color = 'Outline 2'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["KeybindList"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 4"],
                        BorderOffset = UDim.new(0, 3)
                    }):AddToTheme({Color = 'Outline 4'})

                    Items["Title"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["KeybindList"].Instance,
                        AnchorPoint = Vector2.new(0, 1),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, -10, 0, 0),
                        Size = UDim2.new(0, 0, 0, 21),
                        ZIndex = -1,
                        AutomaticSize = Enum.AutomaticSize.X,
                        BackgroundColor3 = Library.Theme["Inline"]
                    }):AddToTheme({BackgroundColor3 = 'Inline'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Title"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Title"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Items["_"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Title"].Instance,
                        AnchorPoint = Vector2.new(0, 1),
                        Position = UDim2.new(0, -8, 1, -2),
                        Size = UDim2.new(1, 16, 0, 2),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Inline"]
                    }):AddToTheme({BackgroundColor3 = 'Inline'})

                    Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["_"].Instance,
                        Position = UDim2.new(0, -1, 0, 0),
                        Size = UDim2.new(0, 1, 0, 1),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Outline 1"]
                    }):AddToTheme({BackgroundColor3 = 'Outline 1'})

                    Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["_"].Instance,
                        AnchorPoint = Vector2.new(1, 0),
                        Position = UDim2.new(1, 1, 0, 0),
                        Size = UDim2.new(0, 1, 0, 1),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Outline 1"]
                    }):AddToTheme({BackgroundColor3 = 'Outline 1'})

                    Library:Create("UIPadding", {
                        Name = "\0",
                        Parent = Items["Title"].Instance,
                        PaddingRight = UDim.new(0, 8),
                        PaddingLeft = UDim.new(0, 8)
                    })

                    Items["Text"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.BoldFont,
                        TextSize = Library.FontSize,
                        Parent = Items["Title"].Instance,
                        RichText = true,
                        TextColor3 = Library.Theme["Text"],
                        Text = KeybindList.Name,
                        Size = UDim2.new(0, 0, 0, 15),
                        AnchorPoint = Vector2.new(0, 0.5),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0.5, -2),
                        AutomaticSize = Enum.AutomaticSize.X
                    }):AddToTheme({TextColor3 = 'Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Text"].Instance
                    })

                    Library:Create("UIPadding", {
                        Name = "\0",
                        Parent = Items["KeybindList"].Instance,
                        PaddingBottom = UDim.new(0, 7),
                        PaddingRight = UDim.new(0, 8),
                        PaddingLeft = UDim.new(0, 8)
                    })

                    Items["Content"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["KeybindList"].Instance,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0, 5),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.XY
                    })

                    Library:Create("UIListLayout", {
                        Name = "\0",
                        Parent = Items["Content"].Instance,
                        Padding = UDim.new(0, 5),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })

                    KeybindList.Items = Items
                end

                function KeybindList:Center()
                    local AbsPos = Items["KeybindList"].Instance.AbsolutePosition
                    Items["KeybindList"].Instance.AnchorPoint = Vector2.new(0, 0)
                    task.wait()
                    Items["KeybindList"].Instance.Position = UDim2.new(0, AbsPos.X, 0, AbsPos.Y + GuiInset)
                end

                function KeybindList:SetText(Text)
                    Items["Text"].Instance.Text = tostring(Text)
                end

                function KeybindList:SetVisibility(Bool)
                Items["KeybindList"].Instance.Visible = Bool
                end

                function KeybindList:Add(Name, Mode)
                    local NewItems = { } do
                        NewItems["NewKey"] = Library:Create("Frame", {
                            Name = "\0",
                            Parent = Items["Content"].Instance,
                            BackgroundTransparency = 1,
                            Size = UDim2.new(0, 180, 0, 15),
                            BorderSizePixel = 0
                        })

                        NewItems["Holder"] = Library:Create("Frame", {
                            Name = "\0",
                            Parent = NewItems["NewKey"].Instance,
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, 0, 1, 0),
                            BorderSizePixel = 0
                        })

                        NewItems["Text"] = Library:Create("TextLabel", {
                            Name = "\0",
                            FontFace = Library.Font,
                            TextSize = Library.FontSize,
                            Parent = NewItems["Holder"].Instance,
                            TextColor3 = Library.Theme["Text"],
                            Text = "pause touch",
                            AnchorPoint = Vector2.new(0, 0.5),
                            Size = UDim2.new(0, 0, 0, 15),
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 0, 0.5, 0),
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.X
                        }):AddToTheme({TextColor3 = 'Text'})

                        Library:Create("UIStroke", {
                            Name = "\0",
                            Parent = NewItems["Text"].Instance
                        })

                        NewItems["Mode"] = Library:Create("TextLabel", {
                            Name = "\0",
                            FontFace = Library.Font,
                            TextSize = Library.FontSize,
                            Parent = NewItems["Holder"].Instance,
                            TextColor3 = Library.Theme["Inactive Text"],
                            Text = "always",
                            AnchorPoint = Vector2.new(1, 0.5),
                            Size = UDim2.new(0, 0, 0, 15),
                            BackgroundTransparency = 1,
                            Position = UDim2.new(1, 0, 0.5, 0),
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.X
                        }):AddToTheme({TextColor3 = 'Inactive Text'})

                        Library:Create("UIStroke", {
                            Name = "\0",
                            Parent = NewItems["Mode"].Instance
                        })
                    end

                    task.wait()

                    local CanBeVisible = true

                    function NewItems:SetVis(Bool)
                        CanBeVisible = Bool
                    end

                    local StateId = 0

                    function NewItems:SetStatus(Bool)
                        StateId = StateId + 1
                        local Current = StateId

                        if not CanBeVisible then
                            NewItems["NewKey"].Instance.Visible = false
                            return
                        end

                        if Bool then
                            NewItems["NewKey"].Instance.Visible = true

                            NewItems["NewKey"]:Tween({Size = UDim2.new(0, 180, 0, 15), Position = UDim2.new(0, 0, 0, 0)})
                            NewItems["Text"]:Tween({TextTransparency = 0})
                            NewItems["Mode"]:Tween({TextTransparency = 0})
                        else
                            Library:Thread(function()
                                NewItems["NewKey"]:Tween({Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(-1, 0, 0, 0)})
                                local gayporn = NewItems["Text"]:Tween({TextTransparency = 1})
                                NewItems["Mode"]:Tween({TextTransparency = 1})
                                gayporn.Completed:Wait()

                                if Current ~= StateId then return end

                                NewItems["NewKey"].Instance.Visible = false
                            end)
                        end
                    end

                    function NewItems:Set(Name, Mode)
                        NewItems["Text"].Instance.Text = Name
                    end

                    function NewItems:SetMode(Mode)
                        NewItems["Mode"].Instance.Text = Mode
                    end

                    return NewItems
                end

                KeybindList:Center()

                return setmetatable(KeybindList, Library)
            end

            Library.StaffList = function(Self, Params)
                Params = Params or { }

                local StaffList = {
                    Name = Params.Name or Params.name or 'staff<font color="rgb(126, 192, 255)"> list</font>',

                    Items = { }
                }

                local Items = { } do
                    Items["StaffList"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Library.Holder.Instance,
                        AnchorPoint = Vector2.new(0, 0.5),
                        Position = UDim2.new(0, 20, 0.7, 0),
                        Size = UDim2.new(0, 156, 0, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.XY,
                        BackgroundColor3 = Library.Theme["Background"]
                    }):AddToTheme({BackgroundColor3 = 'Background'})

                    Items["StaffList"]:MakeDraggable()

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["StaffList"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["StaffList"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["StaffList"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 2"],
                        BorderOffset = UDim.new(0, 2)
                    }):AddToTheme({Color = 'Outline 2'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["StaffList"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 4"],
                        BorderOffset = UDim.new(0, 3)
                    }):AddToTheme({Color = 'Outline 4'})

                    Items["Title"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["StaffList"].Instance,
                        AnchorPoint = Vector2.new(0, 1),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, -10, 0, 0),
                        Size = UDim2.new(0, 0, 0, 21),
                        ZIndex = -1,
                        AutomaticSize = Enum.AutomaticSize.X,
                        BackgroundColor3 = Library.Theme["Inline"]
                    }):AddToTheme({BackgroundColor3 = 'Inline'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Title"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Title"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Items["_"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Title"].Instance,
                        AnchorPoint = Vector2.new(0, 1),
                        Position = UDim2.new(0, -8, 1, -2),
                        Size = UDim2.new(1, 16, 0, 2),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Inline"]
                    }):AddToTheme({BackgroundColor3 = 'Inline'})

                    Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["_"].Instance,
                        Position = UDim2.new(0, -1, 0, 0),
                        Size = UDim2.new(0, 1, 0, 1),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Outline 1"]
                    }):AddToTheme({BackgroundColor3 = 'Outline 1'})

                    Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["_"].Instance,
                        AnchorPoint = Vector2.new(1, 0),
                        Position = UDim2.new(1, 1, 0, 0),
                        Size = UDim2.new(0, 1, 0, 1),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Outline 1"]
                    }):AddToTheme({BackgroundColor3 = 'Outline 1'})

                    Library:Create("UIPadding", {
                        Name = "\0",
                        Parent = Items["Title"].Instance,
                        PaddingRight = UDim.new(0, 8),
                        PaddingLeft = UDim.new(0, 8)
                    })

                    Items["Text"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.BoldFont,
                        TextSize = Library.FontSize,
                        Parent = Items["Title"].Instance,
                        RichText = true,
                        TextColor3 = Library.Theme["Text"],
                        Text = StaffList.Name,
                        Size = UDim2.new(0, 0, 0, 15),
                        AnchorPoint = Vector2.new(0, 0.5),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0.5, -2),
                        AutomaticSize = Enum.AutomaticSize.X
                    }):AddToTheme({TextColor3 = 'Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Text"].Instance
                    })

                    Library:Create("UIPadding", {
                        Name = "\0",
                        Parent = Items["StaffList"].Instance,
                        PaddingBottom = UDim.new(0, 7),
                        PaddingRight = UDim.new(0, 8),
                        PaddingLeft = UDim.new(0, 8)
                    })

                    Items["Content"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["StaffList"].Instance,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0, 5),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.XY
                    })

                    Library:Create("UIListLayout", {
                        Name = "\0",
                        Parent = Items["Content"].Instance,
                        Padding = UDim.new(0, 5),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })

                    StaffList.Items = Items
                end

                function StaffList:Center()
                    local AbsPos = Items["StaffList"].Instance.AbsolutePosition
                    Items["StaffList"].Instance.AnchorPoint = Vector2.new(0, 0)
                    task.wait()
                    Items["StaffList"].Instance.Position = UDim2.new(0, AbsPos.X, 0, AbsPos.Y + GuiInset)
                end

                function StaffList:SetText(Text)
                    Items["Text"].Instance.Text = tostring(Text)
                end

                function StaffList:SetVisibility(Bool)
                Items["StaffList"].Instance.Visible = Bool
                end

                function StaffList:Add(Name, Rank)
                    local NewItems = { } do
                        NewItems["NewStaff"] = Library:Create("Frame", {
                            Name = "\0",
                            Parent = Items["Content"].Instance,
                            BackgroundTransparency = 1,
                            Size = UDim2.new(0, 180, 0, 15),
                            BorderSizePixel = 0
                        })

                        NewItems["Text"] = Library:Create("TextLabel", {
                            Name = "\0",
                            FontFace = Library.Font,
                            TextSize = Library.FontSize,
                            Parent = NewItems["NewStaff"].Instance,
                            TextColor3 = Library.Theme["Text"],
                            Text = Name,
                            AnchorPoint = Vector2.new(0, 0.5),
                            Size = UDim2.new(0, 0, 0, 15),
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 0, 0.5, 0),
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.X
                        }):AddToTheme({TextColor3 = 'Text'})

                        Library:Create("UIStroke", {
                            Name = "\0",
                            Parent = NewItems["Text"].Instance
                        })

                        NewItems["Rank"] = Library:Create("TextLabel", {
                            Name = "\0",
                            FontFace = Library.Font,
                            TextSize = Library.FontSize,
                            Parent = NewItems["NewStaff"].Instance,
                            TextColor3 = Library.Theme["Inactive Text"],
                            Text = Rank,
                            AnchorPoint = Vector2.new(1, 0.5),
                            Size = UDim2.new(0, 0, 0, 15),
                            BackgroundTransparency = 1,
                            Position = UDim2.new(1, 0, 0.5, 0),
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.X
                        }):AddToTheme({TextColor3 = 'Inactive Text'})

                        Library:Create("UIStroke", {
                            Name = "\0",
                            Parent = NewItems["Rank"].Instance
                        })
                    end

                    function NewItems:Set(Name)
                        NewItems["Text"].Instance.Text = Name
                    end

                    function NewItems:SetRank(Rank)
                        NewItems["Rank"].Instance.Text = Rank
                    end

                    return NewItems
                end

                StaffList:Center()

                return setmetatable(StaffList, Library)
            end

            Library.TargetIndicator = function(Self, Params)
                Params = Params or { }

                local Indicator = {
                    Name = Params.Name or Params.name or "Indicator",
                    CurrentTarget = nil,
                    Items = { }
                }

                local Items = { } do
                    Items["TargetIndicator"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Library.Holder.Instance,
                        AnchorPoint = Vector2.new(0, 0.5),
                        Position = UDim2.new(0.6829608678817749, 20, 0.6088272929191589, 0),
                        Size = UDim2.new(0, 156, 0, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.XY,
                        BackgroundColor3 = Library.Theme["Background"]
                    }):AddToTheme({BackgroundColor3 = 'Background'})

                    Items["TargetIndicator"]:MakeDraggable()

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["TargetIndicator"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["TargetIndicator"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["TargetIndicator"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 2"],
                        BorderOffset = UDim.new(0, 2)
                    }):AddToTheme({Color = 'Outline 2'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["TargetIndicator"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 4"],
                        BorderOffset = UDim.new(0, 3)
                    }):AddToTheme({Color = 'Outline 4'})

                    Items["Title"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["TargetIndicator"].Instance,
                        AnchorPoint = Vector2.new(0, 1),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, -10, 0, 0),
                        Size = UDim2.new(0, 0, 0, 21),
                        ZIndex = -1,
                        AutomaticSize = Enum.AutomaticSize.X,
                        BackgroundColor3 = Library.Theme["Inline"]
                    }):AddToTheme({BackgroundColor3 = 'Inline'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Title"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Title"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Items["_"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Title"].Instance,
                        AnchorPoint = Vector2.new(0, 1),
                        Position = UDim2.new(0, -8, 1, -2),
                        Size = UDim2.new(1, 16, 0, 2),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Inline"]
                    }):AddToTheme({BackgroundColor3 = 'Inline'})

                    Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["_"].Instance,
                        Position = UDim2.new(0, -1, 0, 0),
                        Size = UDim2.new(0, 1, 0, 1),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Outline 1"]
                    }):AddToTheme({BackgroundColor3 = 'Outline 1'})

                    Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["_"].Instance,
                        AnchorPoint = Vector2.new(1, 0),
                        Position = UDim2.new(1, 1, 0, 0),
                        Size = UDim2.new(0, 1, 0, 1),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Outline 1"]
                    }):AddToTheme({BackgroundColor3 = 'Outline 1'})

                    Library:Create("UIPadding", {
                        Name = "\0",
                        Parent = Items["Title"].Instance,
                        PaddingRight = UDim.new(0, 8),
                        PaddingLeft = UDim.new(0, 8)
                    })

                    Items["Text"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.BoldFont,
                        TextSize = Library.FontSize,
                        Parent = Items["Title"].Instance,
                        RichText = true,
                        TextColor3 = Library.Theme["Text"],
                        Text = Indicator.Name,
                        Size = UDim2.new(0, 0, 0, 15),
                        AnchorPoint = Vector2.new(0, 0.5),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0.5, -2),
                        AutomaticSize = Enum.AutomaticSize.X
                    }):AddToTheme({TextColor3 = 'Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Text"].Instance
                    })

                    Library:Create("UIPadding", {
                        Name = "\0",
                        Parent = Items["TargetIndicator"].Instance,
                        PaddingBottom = UDim.new(0, 7),
                        PaddingRight = UDim.new(0, 8),
                        PaddingLeft = UDim.new(0, 8)
                    })

                    Items["Content"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["TargetIndicator"].Instance,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0, 8),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.XY
                    })

                    Library:Create("UIListLayout", {
                        Name = "\0",
                        Parent = Items["Content"].Instance,
                        Padding = UDim.new(0, 5),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })

                    Items["Main"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Content"].Instance,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 235, 0, 60),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.Y
                    })

                    Items["Avatar"] = Library:Create("ImageLabel", {
                        Name = "\0",
                        Parent = Items["Main"].Instance,
                        Image = "rbxassetid://125055486069298",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 55, 0, 55),
                        BorderSizePixel = 0
                    })

                    Items["Other"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Main"].Instance,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 68, 0, 0),
                        Size = UDim2.new(1, -68, 1, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.Y
                    })

                    Library:Create("UIListLayout", {
                        Name = "\0",
                        Parent = Items["Other"].Instance,
                        Padding = UDim.new(0, 5),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })

                    Items["Status"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["Other"].Instance,
                        RichText = true,
                        TextColor3 = Library.Theme["Text"],
                        Text = "targeting",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 0, 0, 12),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X
                    }):AddToTheme({TextColor3 = 'Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Status"].Instance
                    })

                    Items["Name"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["Other"].Instance,
                        TextColor3 = Library.Theme["Text"],
                        Text = "username",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 0, 0, 12),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X
                    }):AddToTheme({TextColor3 = 'Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Name"].Instance
                    })

                    Items["Healthbar"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Other"].Instance,
                        Size = UDim2.new(1, 0, 0, 3),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Outline 4"]
                    }):AddToTheme({BackgroundColor3 = 'Outline 4'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Healthbar"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 4"]
                    }):AddToTheme({Color = 'Outline 4'})

                    Items["Fill"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Healthbar"].Instance,
                        Size = UDim2.new(1, 0, 1, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                    })

                    Items["HealthText"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["Other"].Instance,
                        TextColor3 = Library.Theme["Inactive Text"],
                        Text = "100/100",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 0, 0, 12),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X
                    }):AddToTheme({TextColor3 = 'Inactive Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["HealthText"].Instance
                    })

                    Items["Distance"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["Other"].Instance,
                        TextColor3 = Library.Theme["Inactive Text"],
                        Text = "664ft",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 0, 0, 12),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X
                    }):AddToTheme({TextColor3 = 'Inactive Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Distance"].Instance
                    })

                    Library:Create("UIPadding", {
                        Name = "\0",
                        Parent = Items["Distance"].Instance,
                        PaddingTop = UDim.new(0, 1)
                    })

                    Items["Backpack"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Content"].Instance,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 235, 0, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.Y
                    })

                    Library:Create("UIGridLayout", {
                        Name = "\0",
                        Parent = Items["Backpack"].Instance,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        CellSize = UDim2.new(0, 55, 0, 55)
                    })

                    Indicator.Items = Items
                end

                function Indicator:Center()
                    local AbsPos = Items["TargetIndicator"].Instance.AbsolutePosition
                    Items["TargetIndicator"].Instance.AnchorPoint = Vector2.new(0, 0)
                    task.wait()
                    Items["TargetIndicator"].Instance.Position = UDim2.new(0, AbsPos.X, 0, AbsPos.Y + GuiInset)
                end

                function Indicator:SetText(Text)
                    Items["Text"].Instance.Text = tostring(Text)
                end

                function Indicator:SetVisibility(Bool)
                    Items["TargetIndicator"].Instance.Visible = Bool
                end

                -- 渐变换目标: 用 TweenService 驱动 alpha, 换目标时直接 Cancel 掉上一个补间再起新的,
                -- 所以切目标是即时的, 不会再 "整段淡出 -> 换 -> 整段淡入" 造成拖影 / 延迟。
                --
                -- 仍然保留关键的防坑设计: 设计透明度只在创建时快照一次, 永远以快照为准, 绝不回读实时值。
                -- 之前指示器会 "永久消失" 的根因是 Library.Fade 把当前 (可能淡到一半的) 透明度当成原始值,
                -- 每被打断一次就劣化一点, 最后记成 1 (全透明)。这里用固定快照 + 单一补间, 不会再出现。
                --
                -- TweenService 对同一属性只保留最新补间, 我们只补间一个 NumberValue.Value,
                -- 不碰 Fill 的 Size 补间 (血条), 两者互不干扰。

                local FadeList = { } do
                    local Objects = Items["TargetIndicator"].Instance:GetDescendants()
                    table.insert(Objects, Items["TargetIndicator"].Instance)

                    for _, Object in Objects do
                        local Properties = Library:GetTweenProperty(Object)
                        if type(Properties) ~= "table" then continue end

                        for _, Property in Properties do
                            table.insert(FadeList, {
                                Object = Object,
                                Property = Property,
                                Design = Object[Property]
                            })
                        end
                    end
                end

                -- alpha: 1 = 完全显示(设计透明度), 0 = 完全透明
                local FadeAlpha = 0

                local ApplyFadeAlpha = function(Alpha)
                    local Inverse = 1 - Alpha
                    for _, Data in FadeList do
                        Data.Object[Data.Property] = Data.Design + (1 - Data.Design) * Inverse
                    end
                end

                -- 用一个 NumberValue 当补间载体, 它的值一变就把 alpha 刷到所有元素上
                local FadeDriver = Instance.new("NumberValue")
                FadeDriver.Value = FadeAlpha
                FadeDriver.Parent = Items["TargetIndicator"].Instance
                FadeDriver:GetPropertyChangedSignal("Value"):Connect(function()
                    FadeAlpha = FadeDriver.Value
                    ApplyFadeAlpha(FadeAlpha)
                end)

                local CurrentFadeTween = nil
                local FadeShown = false -- 当前是否有目标显示中

                local function StopFade()
                    if CurrentFadeTween then
                        CurrentFadeTween:Cancel() -- [核心] 换目标先取消上一个补间, 不排队
                        CurrentFadeTween = nil
                    end
                end

                -- 把 alpha 补间到 Goal; Duration<=0 或已经到位就瞬间设定。
                -- OnComplete 只在正常播完时触发 (被 Cancel 的补间 State 是 Cancelled, 不触发)。
                local function FadeTo(Goal, Duration, OnComplete)
                    StopFade()

                    if Duration and Duration > 0 and math.abs(FadeDriver.Value - Goal) > 0.001 then
                        local Info = TweenInfo.new(Duration, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                        local ThisTween = TweenService:Create(FadeDriver, Info, { Value = Goal })
                        CurrentFadeTween = ThisTween

                        if OnComplete then
                            ThisTween.Completed:Once(function(State)
                                if State == Enum.PlaybackState.Completed then
                                    OnComplete()
                                end
                            end)
                        end

                        ThisTween:Play()
                    else
                        FadeDriver.Value = Goal -- 触发上面的 changed -> ApplyFadeAlpha
                        if OnComplete then OnComplete() end
                    end
                end

                -- 供外部起始隐藏用: 让 alpha 与可见状态对齐
                function Indicator:ResetFade()
                    StopFade()
                    FadeShown = false
                    FadeDriver.Value = 0
                    ApplyFadeAlpha(0)
                    Items["TargetIndicator"].Instance.Visible = false
                end

                function Indicator:TransitionTo(Target)
                    local AnimTime = Library.Animation.Time

                    if not Target then
                        -- 目标丢失: 断开血量 / 距离连接后淡出隐藏
                        FadeShown = false
                        Indicator:SetTarget(nil) -- 清理连接, 避免泄漏 + 不再更新死目标
                        FadeTo(0, AnimTime, function()
                            if not FadeShown then
                                Items["TargetIndicator"].Instance.Visible = false
                            end
                        end)
                        return
                    end

                    -- 有目标: 立刻替换内容 (名字 / 头像 / 血量), 保持可见
                    Items["TargetIndicator"].Instance.Visible = true
                    Indicator:SetTarget(Target)

                    if FadeShown then
                        -- A -> B: 即时切换。取消进行中的补间, alpha 直接拉满, 不做整段淡入淡出。
                        -- 想让切换也带一点点过渡, 把下面两行换成一行: FadeTo(1, math.min(AnimTime, 0.08))
                        StopFade()
                        FadeDriver.Value = 1
                    else
                        -- 无 -> 有: 正常淡入
                        FadeShown = true
                        FadeTo(1, AnimTime)
                    end
                end

                function Indicator:SetStatus(Text, Color)
                    if typeof(Color) == "Color3" then
                        Items["Status"].Instance.Text = '<font color="rgb(' .. math.floor(Color.R * 255) .. ', ' .. math.floor(Color.G * 255) .. ', ' .. math.floor(Color.B * 255) .. ')">' .. tostring(Text) .. '</font>'
                    else
                        Items["Status"].Instance.Text = tostring(Text)
                    end
                end

                local HealthConnection = nil

                function Indicator:ResetConnection()
                    if HealthConnection then
                        HealthConnection:Disconnect()
                        HealthConnection = nil
                    end

                    getgenv().TaskScheduler:StopLoop('Indicator')
                end

                function Indicator:SetTarget(Target)
                    Indicator:ResetConnection()

                    if not Target then
                        Indicator.CurrentTarget = nil -- [FIX] 原来清空目标后 CurrentTarget 还留着旧值
                        return
                    end

                    Items["Name"].Instance.Text = Target.Name

                    local isPlayer = Target:IsA("Player")
                    local Character = isPlayer and Target.Character or Target

                    if isPlayer then
                        pcall(function()
                            Items["Avatar"].Instance.Image = Players:GetUserThumbnailAsync(Target.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
                        end)
                    else
                        Items["Avatar"].Instance.Image = "rbxassetid://106085233976811"
                    end

                    local function updateHealth(Humanoid)
                        if not Humanoid then return end
                        local MaxHealth = Humanoid.MaxHealth
                        local Health = math.max(Humanoid.Health, 0)
                        
                        Items["HealthText"].Instance.Text = math.floor(Health) .. "/" .. math.floor(MaxHealth)
                        local healthAlpha = math.clamp(Health / MaxHealth, 0, 1)
                        Items["Fill"]:Tween({Size = UDim2.new(healthAlpha, 0, 1, 0)})
                    end

                    if Character then
                        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                        if Humanoid then
                            updateHealth(Humanoid)
                            HealthConnection = Humanoid.HealthChanged:Connect(function()
                                updateHealth(Humanoid)
                            end)
                        end
                    end

                    DistanceConnection = getgenv().TaskScheduler:AddLoop('Indicator', 1/3, function(DeltaTime: number)
                        local currentChar = (isPlayer and Target.Character) or Target
                        if not currentChar then return end
                        
                        local targetRoot = currentChar:FindFirstChild("HumanoidRootPart")
                        local targetHuman = currentChar:FindFirstChildOfClass("Humanoid")
                        
                        if not targetRoot or not targetHuman or targetHuman.Health <= 0 then return end
                        
                        local localChar = LocalPlayer.Character
                        if not localChar then return end
                        
                        local localRoot = localChar:FindFirstChild("HumanoidRootPart")
                        if not localRoot then return end
                        
                        local Distance = math.floor((localRoot.Position - targetRoot.Position).Magnitude)
                        Items["Distance"].Instance.Text = Distance .. "st"
                    end)

                    Indicator.CurrentTarget = Target
                end

                function Indicator:ClearItems()
                    for Index, Value in Items["Backpack"].Instance:GetChildren() do
                        if Value:IsA("ImageLabel") then
                            Value:Destroy()
                        end
                    end
                end

                function Indicator:AddItem(Icon)
                    return Library:Create("ImageLabel", {
                        Name = "\0",
                        Parent = Items["Backpack"].Instance,
                        Image = Icon,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 100, 0, 100),
                        BorderSizePixel = 0
                    })
                end

                Indicator:Center()
                
                local Item = setmetatable(Indicator, Library)

                Library.TargetIndicatorItem = Item

                return Item
            end

            Library.Notification = function(Self, Params)
                local Items = { } do
                    Items["Notification"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Library.NotifHolder.Instance,
                        Size = UDim2.new(0, 0, 0, 22),
                        BorderSizePixel = 0,
                        ClipsDescendants = true,
                        AutomaticSize = Enum.AutomaticSize.X,
                        BackgroundColor3 = Library.Theme["Background"]
                    }):AddToTheme({BackgroundColor3 = 'Background'})

                    Items["Stroke1"] = Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Notification"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Items["Stroke2"] = Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Notification"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Library:Create("UIPadding", {
                        Name = "\0",
                        Parent = Items["Notification"].Instance,
                        PaddingRight = UDim.new(0, 8),
                        PaddingLeft = UDim.new(0, 8)
                    })

                    Items["Text"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["Notification"].Instance,
                        TextColor3 = Library.Theme["Text"],
                        Text = Params.Name,
                        AnchorPoint = Vector2.new(0, 0.5),
                        Size = UDim2.new(0, 0, 0, 12),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0.5, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X
                    }):AddToTheme({TextColor3 = 'Text'})

                    Items["TextStroke"] = Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Text"].Instance
                    })
                end

                for Index, Value in Items do
                    if Value.Instance:IsA("Frame") then
                        Value.Instance.BackgroundTransparency = 1
                    elseif Value.Instance:IsA("TextLabel") then
                        Value.Instance.TextTransparency = 1
                    elseif Value.Instance:IsA("UIStroke") then
                        Value.Instance.Transparency = 1
                    end
                end

                local GetSize = function()
                    local AbsSize = Items["Notification"].Instance.AbsoluteSize
                    Items["Notification"].Instance.AutomaticSize = Enum.AutomaticSize.None
                    task.wait()
                    Items["Notification"].Instance.Size = UDim2.new(0, AbsSize.X, 0, AbsSize.Y)
                    return AbsSize
                end

                local Size = GetSize()
                task.wait()
                Items["Notification"].Instance.Size = UDim2.new(0, 0, 0, Size.Y)

                local Info = TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0)

                Library:Thread(function()
                    for Index, Value in Items do
                        if Value.Instance:IsA("Frame") then
                            Value:Tween({BackgroundTransparency = 0}, Info)
                        elseif Value.Instance:IsA("TextLabel") then
                            Value:Tween({TextTransparency = 0}, Info)
                        elseif Value.Instance:IsA("UIStroke") then
                            Value:Tween({Transparency = 0}, Info)
                        end
                    end

                    Items["Notification"]:Tween({Size = UDim2.new(0, Size.X, 0, Size.Y)}, Info)

                    task.delay(Params.Time + 0.1, function()
                        for Index, Value in Items do
                            if Value.Instance:IsA("Frame") then
                                Value:Tween({BackgroundTransparency = 1})
                            elseif Value.Instance:IsA("TextLabel") then
                                Value:Tween({TextTransparency = 1})
                            elseif Value.Instance:IsA("UIStroke") then
                                Value:Tween({Transparency = 1})
                            end
                        end

                        Items["Notification"]:Tween({Size = UDim2.new(0, 0, 0, 0)}, Info)
                        task.wait(0.5)
                        Items["Notification"].Instance:Destroy()
                    end)
                end)
            end

            Library.Window = function(Self, Params)
                Params = Params or { }

                local Window = {
                    Name = Params.Name or Params.name or "Window",

                    IsOpen = true,
                    Pages = { },
                    Items = { }
                }

                local Items = { } do
                    if IsMobile then
                        Library:Create("UIScale", {
                            Parent = Items["MainFrame"],
                            Scale = 0.67 -- funyn
                        })
                    end

                    Items["MainFrame"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Library.Holder.Instance,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(0, 485, 0, 417),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Background"]
                    }):AddToTheme({BackgroundColor3 = 'Background'})

                    Items["MainFrame"]:MakeDraggable()
                    Items["MainFrame"]:MakeResizeable(Vector2.new(Items["MainFrame"].Instance.AbsoluteSize.X, Items["MainFrame"].Instance.AbsoluteSize.Y))

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["MainFrame"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["MainFrame"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["MainFrame"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 2"],
                        BorderOffset = UDim.new(0, 2)
                    }):AddToTheme({Color = 'Outline 2'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["MainFrame"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 4"],
                        BorderOffset = UDim.new(0, 3)
                    }):AddToTheme({Color = 'Outline 4'})

                    Items["Pages"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["MainFrame"].Instance,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 6, 0, 6),
                        Size = UDim2.new(1, -12, 0, 20),
                        BorderSizePixel = 0
                    })

                    Library:Create("UIListLayout", {
                        Name = "\0",
                        Parent = Items["Pages"].Instance,
                        FillDirection = Enum.FillDirection.Horizontal,
                        Padding = UDim.new(0, 3),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })

                    Items["Content"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["MainFrame"].Instance,
                        Position = UDim2.new(0, 8, 0, 32),
                        Size = UDim2.new(1, -16, 1, -40),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Content"]
                    }):AddToTheme({BackgroundColor3 = 'Content'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Content"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Content"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Content"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 2"],
                        BorderOffset = UDim.new(0, 2)
                    }):AddToTheme({Color = 'Outline 2'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Content"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 4"],
                        BorderOffset = UDim.new(0, 3)
                    }):AddToTheme({Color = 'Outline 4'})

                    Items["Title"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["MainFrame"].Instance,
                        AnchorPoint = Vector2.new(1, 1),
                        BorderSizePixel = 0,
                        Position = UDim2.new(1, 2, 0, 0),
                        Size = UDim2.new(0, 0, 0, 21),
                        ZIndex = -1,
                        AutomaticSize = Enum.AutomaticSize.X,
                        BackgroundColor3 = Library.Theme["Inline"]
                    }):AddToTheme({BackgroundColor3 = 'Inline'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Title"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Title"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Items["_"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Title"].Instance,
                        AnchorPoint = Vector2.new(0, 1),
                        Position = UDim2.new(0, -8, 1, -2),
                        Size = UDim2.new(1, 16, 0, 2),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Inline"]
                    }):AddToTheme({BackgroundColor3 = 'Inline'})

                    Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["_"].Instance,
                        Position = UDim2.new(0, -1, 0, 0),
                        Size = UDim2.new(0, 1, 0, 1),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Outline 1"]
                    }):AddToTheme({BackgroundColor3 = 'Outline 1'})

                    Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["_"].Instance,
                        AnchorPoint = Vector2.new(1, 0),
                        Position = UDim2.new(1, 1, 0, 0),
                        Size = UDim2.new(0, 1, 0, 1),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Outline 1"]
                    }):AddToTheme({BackgroundColor3 = 'Outline 1'})

                    Library:Create("UIPadding", {
                        Name = "\0",
                        Parent = Items["Title"].Instance,
                        PaddingRight = UDim.new(0, 8),
                        PaddingLeft = UDim.new(0, 8)
                    })

                    Items["ActualTitle"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.BoldFont,
                        TextSize = Library.FontSize,
                        Parent = Items["Title"].Instance,
                        RichText = true,
                        TextColor3 = Library.Theme["Text"],
                        Text = Window.Name,
                        Size = UDim2.new(0, 0, 0, 15),
                        AnchorPoint = Vector2.new(0, 0.5),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0.5, -3),
                        AutomaticSize = Enum.AutomaticSize.X
                    }):AddToTheme({TextColor3 = 'Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["ActualTitle"].Instance
                    })

                    Window.Items = Items
                end

                local Debounce = false

                function Window:SetOpen(Bool)
                    if Debounce then
                        return
                    end

                    Debounce = true

                    Window.IsOpen = Bool
                    Items["MainFrame"]:FadeDescendants(Bool, function()
                        Debounce = false
                    end)

                    for Index, Value in Library.OpenFrames do
                        Value:SetOpen(false)
                    end
                end

                function Window:Center()
                    local AbsPos = Items["MainFrame"].Instance.AbsolutePosition
                    Items["MainFrame"].Instance.AnchorPoint = Vector2.new(0, 0)
                    task.wait()
                    Items["MainFrame"].Instance.Position = UDim2.new(0, AbsPos.X, 0, AbsPos.Y + GuiInset)
                end

                Library:Connect(UserInputService.InputBegan, function(Input)
                    if tostring(Input.KeyCode) == Library.MenuKeybind or tostring(Input.UserInputType) == Library.MenuKeybind then
                        if UserInputService:GetFocusedTextBox() then
                            return
                        end

                        Window:SetOpen(not Window.IsOpen)
                    end
                end)

                Window:Center()

                local Item = setmetatable(Window, Library)

                Library.WindowItem = Item -- 和 TargetIndicatorItem 一样, 给外部脚本引用

                return Item
            end

            Library.Page = function(Self, Params)
                Params = Params or { }

                local Page = {
                    Name = Params.Name or Params.name or "Page",

                    Window = Self,
                    ColumnsData = { },
                    Items = { },
                    Active = false,
                    Debounce = false
                }

                local Items = { } do
                    Items["Inactive"] = Library:Create("TextButton", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Page.Window.Items["Pages"].Instance,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        AutomaticSize = Enum.AutomaticSize.X,
                        Size = UDim2.new(0, 0, 1, 1),
                        BorderSizePixel = 0,
                        ZIndex = 2,
                        BackgroundColor3 = Library.Theme["Inline"]
                    }):AddToTheme({BackgroundColor3 = 'Inline'})

                    Library:Create("UIPadding", {
                        Name = "\0",
                        Parent = Items["Inactive"].Instance,
                        PaddingRight = UDim.new(0, 7),
                        PaddingLeft = UDim.new(0, 7)
                    })

                    Items["Text"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.BoldFont,
                        TextSize = Library.FontSize,
                        Parent = Items["Inactive"].Instance,
                        TextColor3 = Library.Theme["Inactive Text"],
                        Text = Page.Name,
                        AutomaticSize = Enum.AutomaticSize.X,
                        AnchorPoint = Vector2.new(0, 0.5),
                        Size = UDim2.new(0, 0, 0, 15),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0.5, 0),
                        BorderSizePixel = 0,
                        ZIndex = 2
                    }):AddToTheme({TextColor3 = 'Inactive Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Text"].Instance
                    })

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Inactive"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Inactive"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Items["Hide"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Inactive"].Instance,
                        Visible = false,
                        AnchorPoint = Vector2.new(0, 1),
                        Position = UDim2.new(0, -7, 1, 4),
                        Size = UDim2.new(1, 14, 0, 4),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Inline"]
                    }):AddToTheme({BackgroundColor3 = 'Inline'})

                    Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Hide"].Instance,
                        Size = UDim2.new(0, 1, 0, 3),
                        Position = UDim2.new(1, 0, 0, 0),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Outline 1"]
                    }):AddToTheme({BackgroundColor3 = 'Outline 1'})

                    Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Hide"].Instance,
                        AnchorPoint = Vector2.new(1, 0),
                        Size = UDim2.new(0, 1, 0, 3),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Outline 1"]
                    }):AddToTheme({BackgroundColor3 = 'Outline 1'})

                    Items["Hide2"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Inactive"].Instance,
                        AnchorPoint = Vector2.new(0, 1),
                        Position = UDim2.new(0, -7, 1, 1),
                        Size = UDim2.new(1, 14, 0, 1),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Inline"]
                    }):AddToTheme({BackgroundColor3 = 'Inline'})

                    Items["Page"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Library.Holder.Instance,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 1, 0),
                        Visible = false,
                        BorderSizePixel = 0
                    })

                    Library:Create("UIListLayout", {
                        Name = "\0",
                        Parent = Items["Page"].Instance,
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalFlex = Enum.UIFlexAlignment.Fill,
                        Padding = UDim.new(0, 4),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })

                    Items["LeftColumn"] = Library:Create("ScrollingFrame", {
                        Name = "\0",
                        Parent = Items["Page"].Instance,
                        ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
                        Active = true,
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        ScrollBarThickness = 0,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 1, 0),
                        BorderSizePixel = 0,
                        CanvasSize = UDim2.new(0, 0, 0, 0)
                    })

                    Library:Create("UIPadding", {
                        Name = "\0",
                        Parent = Items["LeftColumn"].Instance,
                        PaddingTop = UDim.new(0, 6),
                        PaddingBottom = UDim.new(0, 6),
                        PaddingRight = UDim.new(0, 2),
                        PaddingLeft = UDim.new(0, 6)
                    })

                    Library:Create("UIListLayout", {
                        Name = "\0",
                        Parent = Items["LeftColumn"].Instance,
                        Padding = UDim.new(0, 8),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })

                    Items["RightColumn"] = Library:Create("ScrollingFrame", {
                        Name = "\0",
                        Parent = Items["Page"].Instance,
                        ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
                        Active = true,
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        ScrollBarThickness = 0,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 1, 0),
                        BorderSizePixel = 0,
                        CanvasSize = UDim2.new(0, 0, 0, 0)
                    })

                    Library:Create("UIPadding", {
                        Name = "\0",
                        Parent = Items["RightColumn"].Instance,
                        PaddingTop = UDim.new(0, 6),
                        PaddingBottom = UDim.new(0, 6),
                        PaddingRight = UDim.new(0, 6),
                        PaddingLeft = UDim.new(0, 2)
                    })

                    Library:Create("UIListLayout", {
                        Name = "\0",
                        Parent = Items["RightColumn"].Instance,
                        Padding = UDim.new(0, 8),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })

                    Page.ColumnsData[1] = Items["LeftColumn"]
                    Page.ColumnsData[2] = Items["RightColumn"]

                    Page.Items = Items
                end

                function Page:Turn()
                    local Old = Page.Window.Current

                    if Old == Page then
                        return
                    end

                    if Page.Debounce then
                        return
                    end

                    if Old and Old.Debounce then
                        return
                    end

                    Page.Debounce = true

                    if Old then
                        Old.Items["Text"]:ChangeItemTheme({TextColor3 = "Inactive Text"})
                        Old.Items["Text"]:Tween({TextColor3 = Library.Theme["Inactive Text"]})

                        Old.Items["Hide2"]:Tween({BackgroundTransparency = 0})
                        Old.Items["Hide"].Instance.Visible = false

                        Old.Items["Inactive"].Instance.Size = UDim2.new(0, 0, 0, 21)
                        Old.Items["Text"].Instance.Position = UDim2.new(0, 0, 0.5, 0)

                        Old.Items["Page"]:FadeDescendants(false, function()
                            Old.Items["Page"].Instance.Parent = Library.UnusedHolder.Instance
                        end)
                    end

                    Items["Page"].Instance.Parent = Page.Window.Items["Content"].Instance
                    Items["Page"].Instance.Visible = true
                    Items["Page"]:FadeDescendants(true, function()
                        Page.Debounce = false
                    end)

                    Items["Text"]:ChangeItemTheme({TextColor3 = "Text"})
                    Items["Text"]:Tween({TextColor3 = Library.Theme.Text})

                    Items["Hide2"]:Tween({BackgroundTransparency = 1})
                    Items["Hide"].Instance.Visible = true

                    Items["Inactive"].Instance.Size = UDim2.new(0, 0, 0, 20)
                    Items["Text"].Instance.Position = UDim2.new(0, 0, 0.5, 1)

                    Page.Window.Current = Page
                end

                Items["Inactive"]:Connect("MouseButton1Down", function()
                    Page:Turn()
                end)

                if #Page.Window.Pages == 0 then
                    Page:Turn()
                end

                table.insert(Page.Window.Pages, Page)
                return setmetatable(Page, Library)
            end

            Library.Section = function(Self, Params)
                Params = Params or { }

                local Section = {
                    Name = Params.Name or Params.name or "Section",
                    Side = Params.Side or Params.side or 1,

                    Window = Self.Window,
                    Page = Self,
                    Items = { },
                }

                local Items = { } do
                    Items["Section"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Section.Page.ColumnsData[Section.Side].Instance,
                        Size = UDim2.new(1, 0, 0, 35),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        BackgroundColor3 = Library.Theme["Inline"]
                    }):AddToTheme({BackgroundColor3 = 'Inline'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Section"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Section"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Items["Text"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.BoldFont,
                        TextSize = Library.FontSize,
                        Parent = Items["Section"].Instance,
                        TextColor3 = Library.Theme["Text"],
                        Text = Section.Name,
                        Size = UDim2.new(0, 0, 0, 12),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 5, 0, 6),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X
                    }):AddToTheme({TextColor3 = 'Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Text"].Instance
                    })

                    Items["Content"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Section"].Instance,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 4, 0, 26),
                        Size = UDim2.new(1, -8, 0, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.Y
                    })

                    Library:Create("UIListLayout", {
                        Name = "\0",
                        Parent = Items["Content"].Instance,
                        Padding = UDim.new(0, 4),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })

                    Library:Create("UIPadding", {
                        Name = "\0",
                        Parent = Items["Section"].Instance,
                        PaddingBottom = UDim.new(0, 6)
                    })

                    Section.Items = Items
                end

                return setmetatable(Section, Library)
            end

            Library.MultiSection = function(Self, Params)
                Params = Params or { }

                local MultiSection = {
                    Side = Params.Side or Params.side or 1,

                    Window = Self.Window,
                    Page = Self,
                    Items = { },
                    Current = nil,
                    Sections = { }
                }

                local Items = { } do
                    Items["MultiSection"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = MultiSection.Page.ColumnsData[MultiSection.Side].Instance,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.Y
                    })

                    Items["Sections"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["MultiSection"].Instance,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 20),
                        BorderSizePixel = 0
                    })

                    Library:Create("UIListLayout", {
                        Name = "\0",
                        Parent = Items["Sections"].Instance,
                        FillDirection = Enum.FillDirection.Horizontal,
                        Padding = UDim.new(0, 3),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })

                    Items["Inline"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["MultiSection"].Instance,
                        Size = UDim2.new(1, 0, 0, 35),
                        Position = UDim2.new(0, 0, 0, 23),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        BackgroundColor3 = Library.Theme["Inline"]
                    }):AddToTheme({BackgroundColor3 = 'Inline'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Inline"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Inline"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Items["Content"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Inline"].Instance,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 4, 0, 7),
                        Size = UDim2.new(1, -8, 0, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.Y
                    })

                    Library:Create("UIPadding", {
                        Name = "\0",
                        Parent = Items["Inline"].Instance,
                        PaddingBottom = UDim.new(0, 6)
                    })
                end

                function MultiSection:Add(Name)
                    local NewSection = {
                        Active = false,
                        Items = { },
                        Debounce = false
                    }

                    local NewItems = { } do
                        NewItems["Inactive"] = Library:Create("TextButton", {
                            Name = "\0",
                            FontFace = Library.Font,
                            TextSize = Library.FontSize,
                            Parent = Items["Sections"].Instance,
                            TextColor3 = Color3.fromRGB(0, 0, 0),
                            Text = "",
                            AutoButtonColor = false,
                            AutomaticSize = Enum.AutomaticSize.X,
                            Size = UDim2.new(0, 0, 1, 0),
                            BorderSizePixel = 0,
                            ZIndex = 2,
                            BackgroundColor3 = Library.Theme["Inline"]
                        }):AddToTheme({BackgroundColor3 = 'Inline'})

                        Library:Create("UIPadding", {
                            Name = "\0",
                            Parent = NewItems["Inactive"].Instance,
                            PaddingRight = UDim.new(0, 7),
                            PaddingLeft = UDim.new(0, 7)
                        })

                        NewItems["Text"] = Library:Create("TextLabel", {
                            Name = "\0",
                            FontFace = Library.BoldFont,
                            TextSize = Library.FontSize,
                            Parent = NewItems["Inactive"].Instance,
                            TextColor3 = Library.Theme["Inactive Text"],
                            Text = Name,
                            AutomaticSize = Enum.AutomaticSize.X,
                            AnchorPoint = Vector2.new(0, 0.5),
                            Size = UDim2.new(0, 0, 0, 15),
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 0, 0.5, 1),
                            BorderSizePixel = 0,
                            ZIndex = 2
                        }):AddToTheme({TextColor3 = 'Inactive Text'})

                        Library:Create("UIStroke", {
                            Name = "\0",
                            Parent = NewItems["Text"].Instance
                        })

                        Library:Create("UIStroke", {
                            Name = "\0",
                            Parent = NewItems["Inactive"].Instance,
                            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                            LineJoinMode = Enum.LineJoinMode.Miter,
                            Color = Library.Theme["Outline 1"]
                        }):AddToTheme({Color = 'Outline 1'})

                        Library:Create("UIStroke", {
                            Name = "\0",
                            Parent = NewItems["Inactive"].Instance,
                            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                            LineJoinMode = Enum.LineJoinMode.Miter,
                            Color = Library.Theme["Outline 3"],
                            BorderOffset = UDim.new(0, 1)
                        }):AddToTheme({Color = 'Outline 3'})

                        NewItems["Hide"] = Library:Create("Frame", {
                            Name = "\0",
                            Parent = NewItems["Inactive"].Instance,
                            Visible = false,
                            AnchorPoint = Vector2.new(0, 1),
                            Position = UDim2.new(0, -7, 1, 4),
                            Size = UDim2.new(1, 14, 0, 4),
                            ZIndex = 2,
                            BorderSizePixel = 0,
                            BackgroundColor3 = Library.Theme["Inline"]
                        }):AddToTheme({BackgroundColor3 = 'Inline'})

                        Library:Create("Frame", {
                            Name = "\0",
                            Parent = NewItems["Hide"].Instance,
                            Size = UDim2.new(0, 1, 0, 3),
                            Position = UDim2.new(1, 0, 0, 0),
                            ZIndex = 2,
                            BorderSizePixel = 0,
                            BackgroundColor3 = Library.Theme["Outline 1"]
                        }):AddToTheme({BackgroundColor3 = 'Outline 1'})

                        Library:Create("Frame", {
                            Name = "\0",
                            Parent = NewItems["Hide"].Instance,
                            AnchorPoint = Vector2.new(1, 0),
                            Size = UDim2.new(0, 1, 0, 3),
                            ZIndex = 2,
                            BorderSizePixel = 0,
                            BackgroundColor3 = Library.Theme["Outline 1"]
                        }):AddToTheme({BackgroundColor3 = 'Outline 1'})

                        NewItems["Hide2"] = Library:Create("Frame", {
                            Name = "\0",
                            Parent = NewItems["Inactive"].Instance,
                            AnchorPoint = Vector2.new(0, 1),
                            Position = UDim2.new(0, -7, 1, 1),
                            Size = UDim2.new(1, 14, 0, 1),
                            ZIndex = 4,
                            BorderSizePixel = 0,
                            BackgroundColor3 = Library.Theme["Inline"]
                        }):AddToTheme({BackgroundColor3 = 'Inline'})

                        NewItems["Content"] = Library:Create("Frame", {
                            Name = "\0",
                            Parent = Library.UnusedHolder.Instance,
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, 0, 1, 0),
                            BorderSizePixel = 0
                        })

                        Library:Create("UIListLayout", {
                            Name = "\0",
                            Parent = NewItems["Content"].Instance,
                            Padding = UDim.new(0, 4),
                            SortOrder = Enum.SortOrder.LayoutOrder
                        })

                        NewSection.Items = NewItems
                    end

                    function NewSection:Turn()
                        local Old = MultiSection.Current

                        if Old == NewSection then
                            return
                        end

                        if NewSection.Debounce then
                            return
                        end

                        if Old and Old.Debounce then
                            return
                        end

                        NewSection.Debounce = true

                        if Old then
                            Old.Items["Text"]:ChangeItemTheme({TextColor3 = "Inactive Text"})
                            Old.Items["Text"]:Tween({TextColor3 = Library.Theme["Inactive Text"]})

                            Old.Items["Hide2"]:Tween({BackgroundTransparency = 0})
                            Old.Items["Hide"].Instance.Visible = false

                            Old.Items["Inactive"].Instance.Size = UDim2.new(0, 0, 0, 21)
                            Old.Items["Text"].Instance.Position = UDim2.new(0, 0, 0.5, 0)

                            Old.Items["Content"]:FadeDescendants(false, function()
                                Old.Items["Content"].Instance.Parent = Library.UnusedHolder.Instance
                            end)
                        end

                        NewItems["Content"].Instance.Parent = Items["Content"].Instance
                        NewItems["Content"].Instance.Visible = true
                        NewItems["Content"]:FadeDescendants(true, function()
                            NewSection.Debounce = false
                        end)

                        NewItems["Text"]:ChangeItemTheme({TextColor3 = "Text"})
                        NewItems["Text"]:Tween({TextColor3 = Library.Theme.Text})

                        NewItems["Hide2"]:Tween({BackgroundTransparency = 1})
                        NewItems["Hide"].Instance.Visible = true

                        NewItems["Inactive"].Instance.Size = UDim2.new(0, 0, 0, 20)
                        NewItems["Text"].Instance.Position = UDim2.new(0, 0, 0.5, 1)

                        MultiSection.Current = NewSection
                    end

                    NewItems["Inactive"]:Connect("MouseButton1Down", function()
                        NewSection:Turn()
                    end)

                    if #MultiSection.Sections == 0 then
                        NewSection:Turn()
                    end

                    table.insert(MultiSection.Sections, NewSection)
                    return setmetatable(NewSection, Library)
                end

                return setmetatable(MultiSection, Library)
            end

            Library.Toggle = function(Self, Params)
                Params = Params or { }

                local Toggle = {
                    Name = Params.Name or Params.name or "Toggle",
                    Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
                    Default = Params.Default or Params.default or false,
                    Callback = Params.Callback or Params.callback or function() end,

                    Window = Self.Window,
                    Page = Self.Page,
                    Section = Self,

                    Value = false,
                    Items = { },
                    SettingsItem = nil,
                }

                local Parent

                if Params.Parent then
                    Parent = Params.Parent
                else
                    Parent = Toggle.Section.Items["Content"]
                end

                local Items = { } do
                    Items["Toggle"] = Library:Create("TextButton", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Parent.Instance,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 12),
                        BorderSizePixel = 0
                    })

                    Items["Indicator"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Toggle"].Instance,
                        Position = UDim2.new(0, 2, 0, 2),
                        Size = UDim2.new(0, 8, 0, 8),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Content"]
                    }):AddToTheme({BackgroundColor3 = 'Content'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Indicator"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Indicator"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Items["Inline"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Indicator"].Instance,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Accent"]
                    }):AddToTheme({BackgroundColor3 = 'Accent'})

                    Items["Text"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["Toggle"].Instance,
                        TextColor3 = Library.Theme["Inactive Text"],
                        Text = Toggle.Name,
                        Size = UDim2.new(0, 0, 0, 12),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 18, 0, -1),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X
                    }):AddToTheme({TextColor3 = 'Inactive Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Text"].Instance
                    })

                    -- 之前这里的 Size = UDim2.new(0, 0, 1, 0)
                    Items["SubElements"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Toggle"].Instance,
                        AnchorPoint = Vector2.new(1, 0),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, -1, 0, 0),
                        Size = UDim2.new(0, 0, 0, 12), -- [核心修复点]: 将高度死锁为基础高度 12 像素
                        BorderSizePixel = 0
                    })

                    Library:Create("UIListLayout", {
                        Name = "\0",
                        Parent = Items["SubElements"].Instance,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalAlignment = Enum.HorizontalAlignment.Right,
                        Padding = UDim.new(0, 6),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })

                    Items["Toggle"]:OnHover(function()
                        Items["Indicator"]:Tween({BackgroundColor3 = Library.Theme["Hovered Element"]})
                    end, function()
                        Items["Indicator"]:Tween({BackgroundColor3 = Library.Theme["Content"]})
                    end)

                    Toggle.Items = Items
                end

                function Toggle:Set(Bool)
                    Toggle.Value = Bool

                    if Bool then
                        Items["Inline"]:Tween({BackgroundTransparency = 0, Size = UDim2.new(1, 0, 1, 0)})
                        Items["Text"]:ChangeItemTheme({TextColor3 = "Text"})
                        Items["Text"]:Tween({TextColor3 = Library.Theme.Text})
                    else
                        Items["Inline"]:Tween({BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0)})
                        Items["Text"]:ChangeItemTheme({TextColor3 = "Inactive Text"})
                        Items["Text"]:Tween({TextColor3 = Library.Theme["Inactive Text"]})
                    end

                    if Toggle.SettingsItem then
                        Toggle.SettingsItem:SetOpen(Bool)
                    end

                    Flags[Toggle.Flag] = Bool
                    Library:SafeCall(Toggle.Callback, Bool)
                end

                function Toggle:SetVisibility(Bool)
                    Items["Toggle"].Instance.Visible = Bool
                end

                function Toggle:SetText(Text)
                    Items["Text"].Instance.Text = tostring(Text)
                end

                function Toggle:Colorpicker(Data)
                    Data = Data or { }

                    local Colorpicker = {
                        Flag = Data.Flag or Data.flag or (Data.Name or Data.name or Toggle.Name),
                        Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
                        Callback = Data.Callback or Data.callback or function() end,
                        Alpha = Data.Alpha or Data.alpha or 0,

                        Window = Toggle.Window,
                        Page = Toggle.Page,
                        Section = Toggle.Section,
                    }

                    local NewColorpicker, ColorpickerItems = Library:CreateColorpicker({
                        Parent = Items["SubElements"],
                        Page = Colorpicker.Page,
                        Section = Colorpicker.Section,
                        Flag = Colorpicker.Flag,
                        Default = Colorpicker.Default,
                        Callback = Colorpicker.Callback,
                        Alpha = Colorpicker.Alpha
                    })

                    return NewColorpicker
                end

                function Toggle:Keybind(Data)
                    Data = Data or { }

                    local Keybind = {
                        Name = Data.Name or Data.name or Toggle.Name,
                        Flag = Data.Flag or Data.flag or (Data.Name or Data.name or Toggle.Name),
                        Default = Data.Default or Data.default or Enum.KeyCode.E,
                        Callback = Data.Callback or Data.callback or function() end,
                        Mode = Data.Mode or Data.mode or "Toggle",
                        ShowInKeybindsList = Data.ShowInKeybindsList,

                        Window = Toggle.Window,
                        Page = Toggle.Page,
                        Section = Toggle.Section,
                    }

                    local NewKeybind, KeybindItems = Library:CreateKeybind({
                        Parent = Items["SubElements"],
                        Name = Keybind.Name,
                        Page = Keybind.Page,
                        Section = Keybind.Section,
                        Toggle = Toggle,
                        Flag = Keybind.Flag,
                        Default = Keybind.Default,
                        Mode = Keybind.Mode,
                        Callback = Keybind.Callback,
                        ShowInKeybindsList = Keybind.ShowInKeybindsList
                    })

                    return NewKeybind
                end

                function Toggle:Settings()
                    local Settings = {
                        IsOpen = false,
                        Items = { }
                    }

                    Items["Toggle"].Instance.AutomaticSize = Enum.AutomaticSize.Y

                    local SettingsItems = { } do
                        SettingsItems["Content"] = Library:Create("Frame", {
                            Name = "\0",
                            Parent = Items["Toggle"].Instance,
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 19, 0, 19),
                            Size = UDim2.new(1, -19, 0, 0),
                            Visible = false,
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.Y
                        })

                        Library:Create("UIListLayout", {
                            Name = "\0",
                            Parent = SettingsItems["Content"].Instance,
                            Padding = UDim.new(0, 4),
                            SortOrder = Enum.SortOrder.LayoutOrder
                        })

                        Library:Create("UIPadding", {
                            Name = "\0",
                            Parent = SettingsItems["Content"].Instance,
                            PaddingBottom = UDim.new(0, 6)
                        })

                        SettingsItems["Connect"] = Library:Create("Frame", {
                            Name = "\0",
                            Parent = Items["Toggle"].Instance,
                            Position = UDim2.new(0, 5, 0, 12),
                            Size = UDim2.new(0, 2, 0, 0),
                            BorderSizePixel = 0,
                            BackgroundColor3 = Library.Theme["Outline 2"]
                        }):AddToTheme({BackgroundColor3 = 'Outline 2'})

                        Settings.Items = SettingsItems
                    end

                    function Settings:SetOpen(Bool)
                        if Bool then
                            SettingsItems["Content"].Instance.Visible = true
                            SettingsItems["Connect"]:Tween({Size = UDim2.new(0, 2, 0, SettingsItems["Content"].Instance.AbsoluteSize.Y + 1)})
                        else
                            SettingsItems["Content"].Instance.Visible = false
                            SettingsItems["Connect"]:Tween({Size = UDim2.new(0, 2, 0, 0)})
                        end
                    end

                    Toggle.SettingsItem = Settings
                    return setmetatable(Settings, Library)
                end

                Items["Toggle"]:Connect("MouseButton1Down", function()
                    Toggle:Set(not Toggle.Value)
                end)

                Toggle:Set(Toggle.Default)

                SetFlags[Toggle.Flag] = function(Value)
                    Toggle:Set(Value)
                end

                return setmetatable(Toggle, Library)
            end

            Library.Button = function(Self, Params)
                Params = Params or { }

                local Button = {
                    Name = Params.Name or Params.name or "Button",
                    Callback = Params.Callback or Params.callback or function() end,

                    Window = Self.Window,
                    Page = Self.Page,
                    Section = Self,
                    Items = { }
                }

                local Parent

                if Params.Parent then
                    Parent = Params.Parent
                else
                    Parent = Button.Section.Items["Content"]
                end

                local Items = { } do
                    Items["Button"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Parent.Instance,
                        Size = UDim2.new(1, 0, 0, 18),
                        Active = true,
                        Selectable = true,
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Inline"]
                    }):AddToTheme({BackgroundColor3 = 'Inline'})

                    Items["RealButton"] = Library:Create("TextButton", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["Button"].Instance,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        AutoButtonColor = false,
                        Position = UDim2.new(0, 2, 0, 0),
                        Size = UDim2.new(1, -4, 0, 18),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Content"]
                    }):AddToTheme({BackgroundColor3 = 'Content'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["RealButton"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["RealButton"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Items["Text"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["RealButton"].Instance,
                        TextColor3 = Library.Theme["Text"],
                        Text = Button.Name,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Size = UDim2.new(0, 0, 0, 12),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0.5, 0, 0.5, -1),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X
                    }):AddToTheme({TextColor3 = 'Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Text"].Instance
                    })

                    Items["RealButton"]:OnHover(function()
                        Items["RealButton"]:Tween({BackgroundColor3 = Library.Theme["Hovered Element"]})
                    end, function()
                        Items["RealButton"]:Tween({BackgroundColor3 = Library.Theme["Content"]})
                    end)

                    Button.Items = Items
                end

                function Button:Press()
                    Items["RealButton"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
                    Items["RealButton"]:Tween({BackgroundColor3 = Library.Theme.Accent})
                    task.wait(0.1)
                    Items["RealButton"]:ChangeItemTheme({BackgroundColor3 = "Content"})
                    Items["RealButton"]:Tween({BackgroundColor3 = Library.Theme.Content})

                    Library:SafeCall(Button.Callback)
                end

                function Button:SetVisibility(Bool)
                    Items["Button"].Instance.Visible = Bool
                end

                function Button:SetText(Text)
                    Items["Text"].Instance.Text = tostring(Text)
                end

                Items["RealButton"]:Connect("MouseButton1Down", function()
                    Button:Press()
                end)

                return setmetatable(Button, Library)
            end

            Library.Slider = function(Self, Params)
                Params = Params or { }

                local Slider = {
                    Name = Params.Name or Params.name or "Slider",
                    Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
                    Default = Params.Default or Params.default or 0,
                    Min = Params.Min or Params.min or 0,
                    Max = Params.Max or Params.max or 100,
                    Callback = Params.Callback or Params.callback or function() end,
                    Decimals = Params.Decimals or Params.decimals or 0,
                    Suffix = Params.Suffix or Params.suffix or "",

                    Window = Self.Window,
                    Page = Self.Page,
                    Section = Self,

                    Value = 0,
                    Sliding = false,
                    Items = { }
                }

                local Parent

                if Params.Parent then
                    Parent = Params.Parent
                else
                    Parent = Slider.Section.Items["Content"]
                end

                local Items = { } do
                    Items["Slider"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Parent.Instance,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 20),
                        BorderSizePixel = 0
                    })

                    Items["RealSlider"] = Library:Create("TextButton", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["Slider"].Instance,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        AnchorPoint = Vector2.new(0, 1),
                        Position = UDim2.new(0, 2, 1, 1),
                        Size = UDim2.new(1, -4, 0, 5),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Content"]
                    }):AddToTheme({BackgroundColor3 = 'Content'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["RealSlider"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["RealSlider"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Items["Accent"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["RealSlider"].Instance,
                        Size = UDim2.new(0.5, 0, 1, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Accent"]
                    }):AddToTheme({BackgroundColor3 = 'Accent'})

                    Items["Value"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["Accent"].Instance,
                        TextColor3 = Library.Theme["Text"],
                        Text = "1871ft",
                        AnchorPoint = Vector2.new(1, 0.5),
                        Size = UDim2.new(0, 0, 0, 12),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, 10, 0.5, -1),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X
                    }):AddToTheme({TextColor3 = 'Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Value"].Instance
                    })

                    Items["Text"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["Slider"].Instance,
                        TextColor3 = Library.Theme["Text"],
                        Text = Slider.Name,
                        Size = UDim2.new(0, 0, 0, 12),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 1, 0, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X
                    }):AddToTheme({TextColor3 = 'Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Text"].Instance
                    })

                    Items["RealSlider"]:OnHover(function()
                        Items["RealSlider"]:Tween({BackgroundColor3 = Library.Theme["Hovered Element"]})
                    end, function()
                        Items["RealSlider"]:Tween({BackgroundColor3 = Library.Theme["Content"]})
                    end)

                    Slider.Items = Items
                end

                function Slider:Set(Value)
                    local NewValue = Library:Round(math.clamp(Value, Slider.Min, Slider.Max), Slider.Decimals)

                    if Slider.HasSet and Slider.Value == NewValue then -- [OPT] 鼠标滑动时值没变就跳过 Tween/Flag/回调
                        return
                    end

                    Slider.HasSet = true
                    Slider.Value = NewValue

                    Items["Accent"]:Tween({Size = UDim2.new((Slider.Value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1, 0)}, Library.GetQuartInfo())
                    Items["Value"].Instance.Text = string.format("%s%s", Slider.Value, Slider.Suffix)

                    Flags[Slider.Flag] = Slider.Value
                    Library:SafeCall(Slider.Callback, Slider.Value)
                end

                function Slider:SetVisibility(Bool)
                    Items["Slider"].Instance.Visible = Bool
                end

                function Slider:GetSize(Input)
                    local SizeX = (Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X
                    local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min

                    return Value
                end

                function Slider:SetText(Text)
                    Items["Text"].Instance.Text = tostring(Text)
                end

                local InputChanged

                Items["RealSlider"]:Connect("InputBegan", function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                        Slider.Sliding = true

                        local Value = Slider:GetSize(Input)

                        Slider:Set(Value)

                        if InputChanged then
                            return
                        end

                        InputChanged = Input.Changed:Connect(function()
                            if Input.UserInputState == Enum.UserInputState.End then
                                Slider.Sliding = false

                                InputChanged:Disconnect()
                                InputChanged = nil
                            end
                        end)
                    end
                end)

                Library:Connect(UserInputService.InputChanged, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                        if Slider.Sliding then
                            local Value = Slider:GetSize(Input)

                            Slider:Set(Value)
                        end
                    end
                end)

                Slider:Set(Slider.Default)

                SetFlags[Slider.Flag] = function(Value)
                    Slider:Set(Value)
                end

                return setmetatable(Slider, Library)
            end

            Library.Dropdown = function(Self, Params)
                Params = Params or { }

                local Dropdown = {
                    Name = Params.Name or Params.name or "Dropdown",
                    OptionItems = Params.Items or Params.items or { },
                    Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
                    Default = Params.Default or Params.default or "",
                    Callback = Params.Callback or Params.callback or function() end,
                    Multi = Params.Multi or Params.multi or false,

                    Window = Self.Window,
                    Page = Self.Page,
                    Section = Self,

                    Value = { },
                    Options = { },
                    IsOpen = false,
                    Items = { }
                }

                local Parent

                if Params.Parent then
                    Parent = Params.Parent
                else
                    Parent = Dropdown.Section.Items["Content"]
                end

                local Items = { } do
                    Items["Dropdown"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Parent.Instance,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 35),
                        BorderSizePixel = 0
                    })

                    Items["Text"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["Dropdown"].Instance,
                        TextColor3 = Library.Theme["Text"],
                        Text = Dropdown.Name,
                        Size = UDim2.new(0, 0, 0, 12),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 1, 0, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X
                    }):AddToTheme({TextColor3 = 'Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Text"].Instance
                    })

                    Items["RealDropdown"] = Library:Create("TextButton", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["Dropdown"].Instance,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        AnchorPoint = Vector2.new(0, 1),
                        Position = UDim2.new(0, 2, 1, 0),
                        Size = UDim2.new(1, -4, 0, 18),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Inline"]
                    }):AddToTheme({BackgroundColor3 = 'Inline'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["RealDropdown"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["RealDropdown"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Items["Value"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["RealDropdown"].Instance,
                        TextColor3 = Library.Theme["Inactive Text"],
                        Text = "...",
                        AnchorPoint = Vector2.new(0, 0.5),
                        Size = UDim2.new(0, 0, 0, 12),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 6, 0.5, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X
                    }):AddToTheme({TextColor3 = 'Inactive Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Value"].Instance
                    })

                    Items["OptionHolder"] = Library:Create("TextButton", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Library.UnusedHolder.Instance,
                        Visible = false,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        Size = UDim2.new(0, 246, 0, 0),
                        Position = UDim2.new(0, 979, 0, 167),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        BackgroundColor3 = Library.Theme["Background"]
                    }):AddToTheme({BackgroundColor3 = 'Background'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["OptionHolder"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["OptionHolder"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Library:Create("UIPadding", {
                        Name = "\0",
                        Parent = Items["OptionHolder"].Instance,
                        PaddingTop = UDim.new(0, 6),
                        PaddingBottom = UDim.new(0, 6),
                        PaddingRight = UDim.new(0, 6),
                        PaddingLeft = UDim.new(0, 6)
                    })

                    -- 选项放进一个可滚动容器: 选项 <=10 时它跟着内容自动长高 (和以前一样),
                    -- 选项 >10 时 UpdateScroll 会把它锁到 10 行高度并出现滚动条, 避免撑出屏幕。
                    Items["OptionScroll"] = Library:Create("ScrollingFrame", {
                        Name = "\0",
                        Parent = Items["OptionHolder"].Instance,
                        Active = true,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        CanvasSize = UDim2.new(0, 0, 0, 0),
                        ScrollBarThickness = 3,
                        ScrollBarImageColor3 = Library.Theme["Accent"],
                        ScrollingDirection = Enum.ScrollingDirection.Y
                    }):AddToTheme({ScrollBarImageColor3 = 'Accent'})

                    Library:Create("UIListLayout", {
                        Name = "\0",
                        Parent = Items["OptionScroll"].Instance,
                        Padding = UDim.new(0, 5),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })

                    Items["RealDropdown"]:OnHover(function()
                        Items["RealDropdown"]:Tween({BackgroundColor3 = Library.Theme["Hovered Element"]})
                    end, function()
                        Items["RealDropdown"]:Tween({BackgroundColor3 = Library.Theme["Content"]})
                    end)

                    Dropdown.Items = Items
                end

                Dropdown.Holder = Items["OptionHolder"]

                function Dropdown:Set(Value)
                    if Dropdown.Multi then
                        if type(Value) ~= "table" then
                            return
                        end

                        Dropdown.Value = Value

                        for Index, Value in Value do
                            local OptionData = Dropdown.Options[Value]

                            if OptionData then
                                OptionData.IsSelected = true
                                OptionData:ToggleState("Active")
                            end
                        end

                        Flags[Dropdown.Flag] = Value
                        Items["Value"].Instance.Text = table.concat(Value, ", ")
                    else
                        if not Dropdown.Options[Value] then
                            return
                        end

                        local OptionData = Dropdown.Options[Value]

                        Dropdown.Value = Value

                        for Index, Value in Dropdown.Options do
                            if Value ~= OptionData then
                                Value.IsSelected = false
                                Value:ToggleState("Inactive")
                            else
                                Value.IsSelected = true
                                Value:ToggleState("Active")
                            end
                        end

                        Flags[Dropdown.Flag] = Value
                        Items["Value"].Instance.Text = Value
                    end

                    Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                end

                function Dropdown:Add(Value)
                    local OptionButton = Library:Create("TextButton", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["OptionScroll"].Instance,
                        TextColor3 = Library.Theme["Inactive Text"],
                        Text = Value,
                        AutoButtonColor = false,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 12),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.None
                    }):AddToTheme({TextColor3 = 'Inactive Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = OptionButton.Instance
                    })

                    local OptionData = {
                        Button = OptionButton,
                        Text = OptionButton,
                        Name = Value,
                        IsSelected = false
                    }

                    OptionButton:OnHover(function()
                        if OptionData.IsSelected then return end
                        OptionButton:Tween({TextColor3 = Library.Theme.Text})
                    end, function()
                        if OptionData.IsSelected then return end
                        OptionButton:Tween({TextColor3 = Library.Theme["Inactive Text"]})
                    end)

                    function OptionData:ToggleState(Value)
                        if Value == "Active" then
                            OptionData.Text:ChangeItemTheme({TextColor3 = "Accent"})
                            OptionData.Text:Tween({TextColor3 = Library.Theme.Accent})
                        else
                            OptionData.Text:ChangeItemTheme({TextColor3 = "Inactive Text"})
                            OptionData.Text:Tween({TextColor3 = Library.Theme["Inactive Text"]})
                        end
                    end

                    function OptionData:Set()
                        OptionData.IsSelected = not OptionData.IsSelected

                        if Dropdown.Multi then
                            local Index = table.find(Dropdown.Value, OptionData.Name)

                            if Index then
                                table.remove(Dropdown.Value, Index)
                            else
                                table.insert(Dropdown.Value, OptionData.Name)
                            end

                            OptionData:ToggleState(Index and "Inactive" or "Active")

                            Flags[Dropdown.Flag] = Dropdown.Value

                            local TextFormat = #Dropdown.Value > 0 and table.concat(Dropdown.Value, ", ") or "..."
                            Items["Value"].Instance.Text = TextFormat
                        else
                            if OptionData.IsSelected then
                                Dropdown.Value = OptionData.Name
                                Flags[Dropdown.Flag] = OptionData.Name

                                OptionData.IsSelected = true
                                OptionData:ToggleState("Active")

                                for Index, Value in Dropdown.Options do
                                    if Value ~= OptionData then
                                        Value.IsSelected = false
                                        Value:ToggleState("Inactive")
                                    end
                                end

                                Items["Value"].Instance.Text = OptionData.Name
                            else
                                Dropdown.Value = nil
                                Flags[Dropdown.Flag] = nil

                                OptionData.IsSelected = false
                                OptionData:ToggleState("Inactive")

                                Items["Value"].Instance.Text = "..."
                            end
                        end

                        Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                    end

                    OptionData.Button:Connect("MouseButton1Down", function()
                        OptionData:Set()
                    end)

                    Dropdown.Options[OptionData.Name] = OptionData

                    Dropdown:UpdateScroll()
                    return OptionData
                end

                -- 选项超过 10 个就锁高度 + 出滚动条, 否则跟随内容自动长高
                function Dropdown:UpdateScroll()
                    local Scroll = Items["OptionScroll"]
                    if not Scroll then return end

                    local Count = 0
                    for _ in Dropdown.Options do Count += 1 end

                    local RowHeight = 12          -- 单个选项高度 (见 OptionButton Size)
                    local RowPadding = 5          -- UIListLayout Padding
                    local MaxRows = 10

                    local ScrollInstance = Scroll.Instance

                    if Count > MaxRows then
                        local Height = MaxRows * RowHeight + (MaxRows - 1) * RowPadding
                        ScrollInstance.AutomaticSize = Enum.AutomaticSize.None
                        ScrollInstance.Size = UDim2.new(1, 0, 0, Height)
                    else
                        ScrollInstance.AutomaticSize = Enum.AutomaticSize.Y
                        ScrollInstance.Size = UDim2.new(1, 0, 0, 0)
                    end
                end

                function Dropdown:Remove(Option)
                    if Dropdown.Options[Option] then
                        Dropdown.Options[Option].Button.Instance:Destroy()
                        Dropdown.Options[Option] = nil
                    end

                    Dropdown:UpdateScroll()
                end

                function Dropdown:Refresh(List)
                    for Index, Value in Dropdown.Options do
                        Dropdown:Remove(Value.Name)
                    end

                    for Index, Value in List do
                        Dropdown:Add(Value)
                    end

                    Dropdown:UpdateScroll()
                end

                function Dropdown:SetText(Text)
                    Items["Text"].Instance.Text = tostring(Text)
                end

                function Dropdown:SetVisibility(Bool)
                    Items["Dropdown"].Instance.Visible = Bool
                end

                local Debounce = false
                local OptionHolder = Items["OptionHolder"].Instance
                local RealDropdown = Items["RealDropdown"].Instance

                local IsSettings = Dropdown.Section and Dropdown.Section.IsSettings

                function Dropdown:SetOpen(Bool)
                    if Debounce then
                        return
                    end

                    Dropdown.IsOpen = Bool

                    Debounce = true

                    if Dropdown.IsOpen then
                        OptionHolder.Position = UDim2.new(0, RealDropdown.AbsolutePosition.X, 0, RealDropdown.AbsolutePosition.Y + RealDropdown.AbsoluteSize.Y + GuiInset)
                        OptionHolder.Size = UDim2.new(0, RealDropdown.AbsoluteSize.X, 0, Dropdown.MaxSize)

                        OptionHolder.Parent = Library.Holder.Instance
                        Items["OptionHolder"]:Tween({Position = UDim2.new(0, RealDropdown.AbsolutePosition.X, 0, RealDropdown.AbsolutePosition.Y + RealDropdown.AbsoluteSize.Y + 10 + GuiInset)})

                        Items["OptionHolder"]:FadeDescendants(true, function()
                            Debounce = false
                        end)

                        for Index, Value in Library.OpenFrames do
                            if Value ~= IsSettings and not Params.Parent then
                                Value:SetOpen(false)
                            end
                        end

                        Library.OpenFrames[Dropdown] = Dropdown
                    else
                        Items["OptionHolder"]:Tween({Position = UDim2.new(0, RealDropdown.AbsolutePosition.X, 0, RealDropdown.AbsolutePosition.Y + RealDropdown.AbsoluteSize.Y - 10 + GuiInset)})
                        Items["OptionHolder"]:FadeDescendants(false, function()
                            OptionHolder.Parent = Library.UnusedHolder.Instance
                            Debounce = false
                        end)

                        if Library.OpenFrames[Dropdown] then
                            Library.OpenFrames[Dropdown] = nil
                        end
                    end

                    local Descendants = OptionHolder:GetDescendants()
                    table.insert(Descendants, OptionHolder)

                    for Index, Value in Descendants do
                        if not Value.ClassName:find("UI") then
                            if not Params.Parent then
                                Value.ZIndex = Dropdown.IsOpen and Library.ZIndexOrder.OptionHolder or 1
                            else
                                Value.ZIndex = Dropdown.IsOpen and Library.ZIndexOrder.OptionHolder + 3 or 1
                            end
                        end
                    end
                end

                Items["RealDropdown"]:Connect("MouseButton1Down", function()
                    Dropdown:SetOpen(not Dropdown.IsOpen)
                end)

                Library:Connect(UserInputService.InputBegan, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if not Dropdown.IsOpen then
                            return
                        end

                        if Items["OptionHolder"]:IsMouseOverFrame() then
                            return
                        end

                        Dropdown:SetOpen(false)
                    end
                end)

                for Index, Value in Dropdown.OptionItems do
                    Dropdown:Add(Value)
                end

                Dropdown:Set(Dropdown.Default)

                SetFlags[Dropdown.Flag] = function(Value)
                    Dropdown:Set(Value)
                end

                return setmetatable(Dropdown, Library)
            end

            Library.Label = function(Self, Params)
                Params = Params or { }

                local Label = {
                    Name = Params.Name or Params.name or "Label",

                    Window = Self.Window,
                    Page = Self.Page,
                    Section = Self,

                    Items = { }
                }

                local Parent

                if Params.Parent then
                    Parent = Params.Parent
                else
                    Parent = Label.Section.Items["Content"]
                end

                local Items = { } do
                    Items["Label"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Parent.Instance,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 12),
                        BorderSizePixel = 0
                    })

                    Items["Text"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["Label"].Instance,
                        TextColor3 = Library.Theme["Text"],
                        Text = Label.Name,
                        Size = UDim2.new(0, 0, 0, 12),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 1, 0, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X
                    }):AddToTheme({TextColor3 = 'Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Text"].Instance
                    })

                    Items["SubElements"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Label"].Instance,
                        AnchorPoint = Vector2.new(1, 0),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, 0, 0, 0),
                        Size = UDim2.new(0, 0, 1, 0),
                        BorderSizePixel = 0
                    })

                    Library:Create("UIListLayout", {
                        Name = "\0",
                        Parent = Items["SubElements"].Instance,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalAlignment = Enum.HorizontalAlignment.Right,
                        Padding = UDim.new(0, 6),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })

                    Label.Items = Items
                end

                function Label:SetVisibility(Bool)
                    Items["Label"].Instance.Visible = Bool
                end

                function Label:SetText(Text)
                    Items["Text"].Instance.Text = tostring(Text)
                end

                function Label:Colorpicker(Data)
                    Data = Data or { }

                    local Colorpicker = {
                        Flag = Data.Flag or Data.flag or (Data.Name or Data.name or Label.Name),
                        Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
                        Callback = Data.Callback or Data.callback or function() end,
                        Alpha = Data.Alpha or Data.alpha or 0,

                        Window = Label.Window,
                        Page = Label.Page,
                        Section = Label.Section,
                    }

                    local NewColorpicker, ColorpickerItems = Library:CreateColorpicker({
                        Parent = Items["SubElements"],
                        Page = Colorpicker.Page,
                        Section = Colorpicker.Section,
                        Flag = Colorpicker.Flag,
                        Default = Colorpicker.Default,
                        Callback = Colorpicker.Callback,
                        Alpha = Colorpicker.Alpha
                    })

                    return NewColorpicker
                end

                function Label:Keybind(Data)
                    Data = Data or { }

                    local Keybind = {
                        Name = Data.Name or Data.name or Label.Name,
                        Flag = Data.Flag or Data.flag or (Data.Name or Data.name or Label.Name),
                        Default = Data.Default or Data.default or Enum.KeyCode.E,
                        Callback = Data.Callback or Data.callback or function() end,
                        Mode = Data.Mode or Data.mode or "Toggle",
                        ShowInKeybindsList = Data.ShowInKeybindsList,

                        Window = Label.Window,
                        Page = Label.Page,
                        Section = Label.Section,
                    }

                    local NewKeybind, KeybindItems = Library:CreateKeybind({
                        Parent = Items["SubElements"],
                        Name = Keybind.Name,
                        Page = Keybind.Page,
                        Section = Keybind.Section,
                        Flag = Keybind.Flag,
                        Default = Keybind.Default,
                        Mode = Keybind.Mode,
                        Callback = Keybind.Callback,
                        ShowInKeybindsList = Keybind.ShowInKeybindsList
                    })

                    return NewKeybind
                end

                Label:SetText(Label.Name)

                return setmetatable(Label, Library)
            end

            Library.Textbox = function(Self, Params)
                Params = Params or { }

                local Textbox = {
                    Name = Params.Name or Params.name or "Textbox",
                    Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
                    Default = Params.Default or Params.default or "",
                    Callback = Params.Callback or Params.callback or function() end,
                    Finished = Params.Finished or Params.finished or false,
                    Placeholder = Params.Placeholder or Params.placeholder or "",
                    Numeric = Params.Numeric or Params.numeric or false,

                    Window = Self.Window,
                    Page = Self.Page,
                    Section = Self,
                    Value = "",

                    Items = { },
                }

                local Parent

                if Params.Parent then
                    Parent = Params.Parent
                else
                    Parent = Textbox.Section.Items["Content"]
                end

                local Items = { } do
                    Items["Textbox"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Parent.Instance,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 20),
                        BorderSizePixel = 0
                    })

                    Items["Background"] = Library:Create("Frame", {
                        Name = "\0",
                        Parent = Items["Textbox"].Instance,
                        ClipsDescendants = true,
                        AnchorPoint = Vector2.new(0, 1),
                        Size = UDim2.new(1, -4, 0, 18),
                        Position = UDim2.new(0, 2, 1, 0),
                        Selectable = true,
                        Active = true,
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Inline"]
                    }):AddToTheme({BackgroundColor3 = 'Inline'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Background"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 1"]
                    }):AddToTheme({Color = 'Outline 1'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Background"].Instance,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Color = Library.Theme["Outline 3"],
                        BorderOffset = UDim.new(0, 1)
                    }):AddToTheme({Color = 'Outline 3'})

                    Items["Input"] = Library:Create("TextBox", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["Background"].Instance,
                        Active = false,
                        Selectable = false,
                        AnchorPoint = Vector2.new(0, 0.5),
                        PlaceholderColor3 = Library.Theme["Inactive Text"],
                        PlaceholderText = Textbox.Placeholder,
                        Size = UDim2.new(1, -12, 0, 12),
                        TextColor3 = Library.Theme["Text"],
                        Text = "",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 6, 0.5, 0),
                        CursorPosition = -1,
                        ClearTextOnFocus = false,
                        BorderSizePixel = 0
                    }):AddToTheme({TextColor3 = 'Text', PlaceholderColor3 = 'Inactive Text'})

                    Library:Create("UIStroke", {
                        Name = "\0",
                        Parent = Items["Input"].Instance
                    })

                    Textbox.Items = Items
                end

                function Textbox:SetVisibility(Bool)
                    Items["Textbox"].Instance.Visible = Bool
                end

                function Textbox:SetText(Text)
                    Items["Text"].Instance.Text = tostring(Text)
                end

                function Textbox:Set(Value)
                    if Textbox.Numeric then
                        if (not tonumber(Value)) and string.len(tostring(Value)) > 0 then
                            Value = Textbox.Value
                        end
                    end

                    Textbox.Value = Value
                    Items["Input"].Instance.Text = Value
                    Flags[Textbox.Flag] = Value

                    Library:SafeCall(Textbox.Callback, Value)
                end

                if Textbox.Finished then
                    Items["Input"]:Connect("FocusLost", function(PressedEnterQuestionMark)
                        if PressedEnterQuestionMark then
                            Textbox:Set(Items["Input"].Instance.Text)
                        end
                    end)
                else
                    Library:Connect(Items["Input"].Instance:GetPropertyChangedSignal("Text"), function()
                        Textbox:Set(Items["Input"].Instance.Text)
                    end)
                end

                Textbox:Set(Textbox.Default)

                SetFlags[Textbox.Flag] = function(Value)
                    Textbox:Set(Value)
                end

                return setmetatable(Textbox, Library)
            end

            Library.InitWindow = function(Self)
                local SettingsPage = Self:Page({Name = "settings"}) do
                    local ConfigsSection = SettingsPage:Section({Name = "configs", Side = 2}) do
                        local ConfigsDropdown = ConfigsSection:Dropdown({
                            Name = "configs",
                            Flag = "configs_dropdown",
                            Items = { },
                            Multi = false,
                            Callback = function(Value)
                                ConfigSelected = Value
                            end
                        })

                        ConfigsSection:Textbox({
                            Flag = "config_name",
                            Placeholder = "",
                            Callback = function(Value)
                                ConfigName = Value
                            end
                        })

                        ConfigsSection:Button({
                            Name = "create",
                            Callback = function()
                                if ConfigName then
                                    if ConfigName == "" then
                                        return
                                    end

                                    writefile(ConfigsFolder .. ConfigName .. ".json", Library:GetConfig())
                                    Library:GetConfigsList(ConfigsDropdown)

                                    Library:Notification{Name = "created config succesfully", Time = 3}
                                end
                            end
                        })

                        ConfigsSection:Button({
                            Name = "delete",
                            Callback = function()
                                if ConfigSelected then
                                    if isfile(ConfigsFolder .. ConfigSelected .. ".json") then
                                        delfile(ConfigsFolder .. ConfigSelected .. ".json")
                                        Library:GetConfigsList(ConfigsDropdown)

                                        Library:Notification{Name = "deleted config succesfully", Time = 3}
                                    end
                                end
                            end
                        })

                        ConfigsSection:Button({
                            Name = "load",
                            Callback = function()
                                if ConfigSelected then
                                    if isfile(ConfigsFolder.. ConfigSelected .. ".json") then
                                        local ConfigContent = readfile(ConfigsFolder.. ConfigSelected .. ".json")
                                        local Success, Error = Library:LoadConfig(ConfigContent)

                                        if Success then
                                            Library:Notification{Name = "loaded config succesfully", Time = 3}
                                        else
                                            Library:Notification{Name = "failed to load config: ".. Error, Time = 3}
                                        end
                                    end
                                end
                            end
                        })

                        ConfigsSection:Button({
                            Name = "save",
                            Callback = function()
                                if ConfigSelected then
                                    if isfile(ConfigsFolder.. ConfigSelected .. ".json") then
                                        local Success, Error = pcall(function()
                                            writefile(ConfigsFolder .. ConfigSelected .. ".json", Library:GetConfig())
                                        end)

                                        if Success then
                                            Library:Notification{Name = "saved config succesfully", Time = 3}
                                        else
                                            Library:Notification{Name = "failed to save config: ".. Error, Time = 3}
                                        end
                                    end
                                end
                            end
                        })

                        ConfigsSection:Button({
                            Name = "refresh",
                            Callback = function()
                                Library:GetConfigsList(ConfigsDropdown)
                            end
                        })

                        Library:GetConfigsList(ConfigsDropdown)
                    end

                    local ThemingSection = SettingsPage:Section({Name = "theming", Side = 1}) do
                        for Index, Value in Library.Theme do
                            ThemingSection:Label({Name = Index}):Colorpicker({
                                Name = Index,
                                Flag = Index,
                                Default = Value,
                                Callback = function(Value)
                                    Library.Theme[Index] = Value
                                    Library:ChangeTheme(Index, Value)
                                end
                            })
                        end
                    end

                    local OtherSection = SettingsPage:Section({Name = "other", Side = 2}) do
                        OtherSection:Button({
                            Name = "unload",
                            Callback = function()
                                Library:Exit()
                            end
                        })

                        OtherSection:Label({Name = "ui bind"}):Keybind({Flag = "uibind", ShowInKeybindsList = false, Mode = "Toggle", Default = Enum.KeyCode.RightShift, Callback = function(Value)
                            Library.MenuKeybind = Flags["uibind"].Key
                        end})

                        OtherSection:Dropdown({
                            Name = "animation style",
                            Items = {"Linear", "Quad", "Quart", "Back", "Bounce", "Circular", "Cubic", "Elastic", "Exponential", "Sine", "Quint"},
                            Default = "Cubic",
                            Callback = function(Value)
                                Library.Animation.Style = Value
                            end
                        })

                        OtherSection:Dropdown({
                            Name = "animation direction",
                            Items = {"In", "Out", "InOut"},
                            Default = "Out",
                            Callback = function(Value)
                                Library.Animation.Direction = Value
                            end
                        })

                        OtherSection:Slider({
                            Name = "animation time",
                            Min = 0,
                            Max = 1,
                            Default = 0.25,
                            Decimals = 0.01,
                            Suffix = "s",
                            Callback = function(Value)
                                Library.Animation.Time = Value
                            end
                        })
                    end
                end

                return SettingsPage
            end
        end
    end
end 

getgenv().Library = Library
return Library
