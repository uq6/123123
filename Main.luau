-- Cached
local Genv = getgenv()
--
local loadfile = Genv.loadfile
local checkcaller = Genv.checkcaller
local newcclosure = Genv.newcclosure
local hookfunction = Genv.hookfunction
local clonefunction = Genv.clonefunction
local hookmetamethod = Genv.hookmetamethod
local restorefunction = Genv.restorefunction
local getcallingscript = Genv.getcallingscript
local getnamecallmethod = Genv.getnamecallmethod
local restoremetamethod = function(Object, Metamethod)
    local Metatable = getrawmetatable(Object)
    return restorefunction(Metatable[Metamethod])
end
--
local GetService = game.GetService
--
local IsA = game.IsA
local Clone = game.Clone
local Destroy = game.Destroy
local GetChildren = game.GetChildren
local FindFirstChild = game.FindFirstChild
local GetDescendants = game.GetDescendants
local IsDescendantOf = game.IsDescendantOf
local FindFirstChildOfClass = game.FindFirstChildOfClass
--
local Drawing = Genv.Drawing
local DrawingNew = Drawing.new
--
local Mouse1Click = Genv.mouse1click
local Mouse1Press = Genv.mouse1press
local Mouse1Release = Genv.mouse1release
--
local OsDate = os.date
local OsClock = os.clock
--
local InstanceNew = Instance.new
--
local Color3FromRGB = Color3.fromRGB
local Color3New = Color3.new
--
local FontNew = Font.new
--
local RayNew = Ray.new
--
local Vector2New = Vector2.new
--
local Vector3New = Vector3.new
--
local CFrameNew = CFrame.new
local CFrameAngles = CFrame.Angles
--
local RaycastParamsNew = RaycastParams.new
--
local StringFind = string.find
local StringFormat = string.format
--
local TableFind = table.find
local TableSort = table.sort
local TableCreate = table.create
local TableInsert = table.insert
local TableRemove = table.remove
local TableClear = table.clear
local TableClone; TableClone = function(Table: table)
	local Clone = {}

	for Key, Value in Table do
		if typeof(Value) == "table" then
			Clone[Key] = TableClone(Value)
		else
			Clone[Key] = Value
		end
	end

	return Clone
end

local TableGetIndex = function(TargetTable: { [any]: any }): { any }
    local Keys = {}

    for Key, Value in TargetTable do
        TableInsert(Keys, Key)
    end

    return Keys
end
--
local TaskWait = task.wait
local TaskDefer = task.defer
local TaskDelay = task.delay
local TaskSpawn = task.spawn
--
local CryptBase64Decode = Genv.crypt.base64decode
--
local SetHiddenProperty = Genv.sethiddenproperty
local GetHiddenProperty = Genv.gethiddenproperty
--
local HitSoundAssets = {
    Hit = "",             -- 自定义命中音 assetId (填了就覆盖 bell.wav), 例 "rbxassetid://9120386436"
    Headshot = "",        -- 自定义爆头音 assetId (留空则复用命中音, 用 headshot pitch 提高音高)
}
--
local MathRandom = math.random
local MathClamp = math.clamp
local MathFloor = math.floor
local MathRound = math.round
local MathAcos = math.acos
local MathSine = math.sin
local MathSqrt = math.sqrt
local MathCos = math.cos
local MathMax = math.max
local MathMin = math.min
local MathRad = math.rad
local MathTan = math.tan
local MathPi = math.pi
--

local Stats = GetService(game, "Stats")
local Teams = GetService(game, "Teams")
local Players = GetService(game, "Players")
local Lighting = GetService(game, "Lighting")
local Workspace = GetService(game, "Workspace")
local RunService = GetService(game, "RunService")
local HttpService = GetService(game, "HttpService")
local SoundService = GetService(game, "SoundService")
local UserInputService = GetService(game, 'UserInputService')
--
local WriteFile = Genv.writefile
local ReadFile = Genv.readfile
local IsFile = Genv.isfile
local IsFolder = Genv.isfolder
local MakeFolder = Genv.makefolder
local GetCustomAsset = Genv.getcustomasset or Genv.getsynasset
--
local ColorSequenceNew = ColorSequence.new
local ColorSequenceKeypointNew = ColorSequenceKeypoint.new
local NumberSequenceNew = NumberSequence.new
local NumberRangeNew = NumberRange.new
local NumberSequenceKeypointNew = NumberSequenceKeypoint.new
local Terrain = FindFirstChildOfClass(Workspace, "Terrain")
--
local BeamTracerConfig = {
    Texture = "rbxassetid://14715282464",
    TextureMode = Enum.TextureMode.Stretch,
    Width0 = 0.25,
    Width1 = 0.55,
    LightEmission = 1,
    LightInfluence = 0,
    FaceCamera = true,
}

local BeamTextures = {
    { "border1", "rbxassetid://116218166180864" },
    { "chains1", "rbxassetid://16412020661" },
    { "chains2", "rbxassetid://6479047126" },
    { "colored", "rbxassetid://14198337838" },
    { "curve1", "rbxassetid://124753331461910" },
    { "curve2", "rbxassetid://14438356564" },
    { "curve3", "rbxassetid://14438356564" },
    { "dna1", "rbxassetid://14438356564" },
    { "dna2", "rbxassetid://14438356564" },
    { "dna3", "rbxassetid://86070025247863" },
    { "dna4", "rbxassetid://138486973142547" },
    { "dna5", "rbxassetid://18568183566" },
    { "dna6", "rbxassetid://82098711870714" },
    { "electric1", "rbxassetid://446111271" },
    { "fade1", "rbxassetid://9421370805" },
    { "glow1", "rbxassetid://4839671501" },
    { "glow2", "rbxassetid://15022676703" },
    { "glow3", "rbxassetid://13576015697" },
    { "grid1", "rbxassetid://14050828219" },
    { "laser", "rbxassetid://16892453445" },
    { "laser2", "rbxassetid://18453651571" },
    { "laser3_Colored", "rbxassetid://11767688250" },
    { "laser4", "rbxassetid://128997815146079" },
    { "laser5", "rbxassetid://15398093472" },
    { "laser6", "rbxassetid://119237127898216" },
    { "laser7", "rbxassetid://127644217050149" },
    { "pattern", "rbxassetid://8098345726" },
    { "pattern2", "rbxassetid://5319764523" },
    { "pattern3", "rbxassetid://1274380363" },
    { "pattern4", "rbxassetid://6933806553" },
    { "pattern5", "rbxassetid://108170985018134" },
    { "pattern6", "rbxassetid://16510025756" },
    { "pattern7", "rbxassetid://86470467217654" },
    { "pattern8", "rbxassetid://3517446796" },
    { "pixels_COLORED1", "rbxassetid://102929992237253" },
    { "plant1", "rbxassetid://18664898738" },
    { "ray1", "rbxassetid://13589383451" },
    { "ray2", "rbxassetid://124024562879507" },
    { "ray3", "rbxassetid://16726866463" },
    { "ray4", "rbxassetid://18837316844" },
    { "wind1", "rbxassetid://4537267850" },
    { "wind2", "rbxassetid://4537255327" },
    { "arrow1", "rbxassetid://17476697388" },
    { "bullets1", "rbxassetid://9841273413" },
    { "bullets2", "rbxassetid://1858602290" },
    { "curve4", "rbxassetid://4537267850" },
    { "curve5", "rbxassetid://1263079249" },
    { "curve6", "rbxassetid://12781806168" },
    { "dna", "rbxassetid://7071778278" },
    { "dna7", "rbxassetid://6479047126" },
    { "laser1", "rbxassetid://6091329339" },
    { "laser3", "rbxassetid://1277456789" },
    { "line1", "rbxassetid://16726866463" },
    { "line2", "rbxassetid://18804963960" },
    { "line3", "rbxassetid://14987385912" },
    { "line4", "rbxassetid://80526693693402" },
    { "line5", "rbxassetid://88341572922411" },
    { "pattern1", "rbxassetid://16892453445" },
    { "solid", "" },
}
local BeamTextureNames = {}
for i = 1, #BeamTextures do BeamTextureNames[i] = BeamTextures[i][1] end

local KillParticleStyles = { "Sparks", "Dots", "Catalyst", "Mist", "Chiral" }

local SkyboxPresets = {
    { Name = "blank",
        SkyboxBk = 'http://www.roblox.com/asset/?ID=1361097',
        SkyboxDn = 'http://www.roblox.com/asset/?ID=1361097',
        SkyboxFt = 'http://www.roblox.com/asset/?ID=1361097',
        SkyboxLf = 'http://www.roblox.com/asset/?ID=1361097',
        SkyboxRt = 'http://www.roblox.com/asset/?ID=1361097',
        SkyboxUp = 'http://www.roblox.com/asset/?ID=1361097',
        MoonTextureId = '',
        SunTextureId = '',
        StarCount = 0,
        SunAngularSize = 1,
    },
    { Name = "red night sky",
        SkyboxBk = 'http://www.roblox.com/Asset/?ID=401664839',
        SkyboxDn = 'http://www.roblox.com/asset/?ID=401664862',
        SkyboxFt = 'http://www.roblox.com/asset/?ID=401664960',
        SkyboxLf = 'http://www.roblox.com/asset/?ID=401664881',
        SkyboxRt = 'http://www.roblox.com/asset/?ID=401664901',
        SkyboxUp = 'http://www.roblox.com/asset/?ID=401664936',
        MoonTextureId = 'rbxasset://sky/moon.jpg',
        SunTextureId = 'rbxasset://sky/sun.jpg',
        StarCount = 1000,
        SunAngularSize = 21,
    },
    { Name = "purple galaxy",
        SkyboxBk = 'http://www.roblox.com/Asset/?ID=14543264135',
        SkyboxDn = 'http://www.roblox.com/asset/?ID=14543358958',
        SkyboxFt = 'http://www.roblox.com/asset/?ID=14543257810',
        SkyboxLf = 'http://www.roblox.com/asset/?ID=14543275895',
        SkyboxRt = 'http://www.roblox.com/asset/?ID=14543280890',
        SkyboxUp = 'http://www.roblox.com/asset/?ID=14543371676',
        MoonTextureId = 'rbxasset://sky/moon.jpg',
        SunTextureId = 'rbxasset://sky/sun.jpg',
        StarCount = 1000,
        SunAngularSize = 21,
    },
    { Name = "purple clouds",
        SkyboxBk = "rbxassetid://151165214",
        SkyboxDn = "rbxassetid://151165197",
        SkyboxFt = "rbxassetid://151165224",
        SkyboxLf = "rbxassetid://151165191",
        SkyboxRt = "rbxassetid://151165206",
        SkyboxUp = "rbxassetid://151165227",
        MoonTextureId = 'rbxasset://sky/moon.jpg',
        SunTextureId = 'rbxasset://sky/sun.jpg',
        StarCount = 1000,
        SunAngularSize = 21,
    },
    { Name = "cloudy skies",
        SkyboxBk = "rbxassetid://151165214",
        SkyboxDn = "rbxassetid://151165197",
        SkyboxFt = "rbxassetid://151165224",
        SkyboxLf = "rbxassetid://151165191",
        SkyboxRt = "rbxassetid://151165206",
        SkyboxUp = "rbxassetid://151165227",
        MoonTextureId = 'rbxasset://sky/moon.jpg',
        SunTextureId = 'rbxasset://sky/sun.jpg',
        StarCount = 1000,
        SunAngularSize = 21,
    },
    { Name = "purple nebula",
        SkyboxBk = "rbxassetid://159454299",
        SkyboxDn = "rbxassetid://159454296",
        SkyboxFt = "rbxassetid://159454293",
        SkyboxLf = "rbxassetid://159454286",
        SkyboxRt = "rbxassetid://159454300",
        SkyboxUp = "rbxassetid://159454288",
        MoonTextureId = 'rbxasset://sky/moon.jpg',
        SunTextureId = 'rbxasset://sky/sun.jpg',
        StarCount = 1000,
        SunAngularSize = 21,
    },
    { Name = "purple and blue",
        SkyboxBk = "rbxassetid://149397692",
        SkyboxDn = "rbxassetid://149397686",
        SkyboxFt = "rbxassetid://149397697",
        SkyboxLf = "rbxassetid://149397684",
        SkyboxRt = "rbxassetid://149397688",
        SkyboxUp = "rbxassetid://149397702",
        MoonTextureId = 'rbxasset://sky/moon.jpg',
        SunTextureId = 'rbxasset://sky/sun.jpg',
        StarCount = 1000,
        SunAngularSize = 21,
    },
    { Name = "vivid Skies",
        SkyboxBk = "rbxassetid://271042516",
        SkyboxDn = "rbxassetid://271077243",
        SkyboxFt = "rbxassetid://271042556",
        SkyboxLf = "rbxassetid://271042310",
        SkyboxRt = "rbxassetid://271042467",
        SkyboxUp = "rbxassetid://271077958",
        MoonTextureId = 'rbxasset://sky/moon.jpg',
        SunTextureId = 'rbxasset://sky/sun.jpg',
        StarCount = 1000,
        SunAngularSize = 21,
    },
    { Name = "twighlight",
        SkyboxBk = "rbxassetid://264908339",
        SkyboxDn = "rbxassetid://264907909",
        SkyboxFt = "rbxassetid://264909420",
        SkyboxLf = "rbxassetid://264909758",
        SkyboxRt = "rbxassetid://264908886",
        SkyboxUp = "rbxassetid://264907379",
        MoonTextureId = 'rbxasset://sky/moon.jpg',
        SunTextureId = 'rbxasset://sky/sun.jpg',
        StarCount = 1000,
        SunAngularSize = 21,
    },
    { Name = "vaporwave",
        SkyboxBk = "rbxassetid://1417494030",
        SkyboxDn = "rbxassetid://1417494146",
        SkyboxFt = "rbxassetid://1417494253",
        SkyboxLf = "rbxassetid://1417494402",
        SkyboxRt = "rbxassetid://1417494499",
        SkyboxUp = "rbxassetid://1417494643",
        MoonTextureId = 'rbxasset://sky/moon.jpg',
        SunTextureId = 'rbxasset://sky/sun.jpg',
        StarCount = 1000,
        SunAngularSize = 21,
    },
    { Name = "clouds",
        SkyboxBk = "rbxassetid://570557514",
        SkyboxDn = "rbxassetid://570557775",
        SkyboxFt = "rbxassetid://570557559",
        SkyboxLf = "rbxassetid://570557620",
        SkyboxRt = "rbxassetid://570557672",
        SkyboxUp = "rbxassetid://570557727",
        MoonTextureId = 'rbxasset://sky/moon.jpg',
        SunTextureId = 'rbxasset://sky/sun.jpg',
        StarCount = 1000,
        SunAngularSize = 21,
    },
    { Name = "night sky",
        SkyboxBk = "rbxassetid://12064107",
        SkyboxDn = "rbxassetid://12064152",
        SkyboxFt = "rbxassetid://12064121",
        SkyboxLf = "rbxassetid://12063984",
        SkyboxRt = "rbxassetid://12064115",
        SkyboxUp = "rbxassetid://12064131",
        MoonTextureId = 'rbxasset://sky/moon.jpg',
        SunTextureId = 'rbxasset://sky/sun.jpg',
        StarCount = 1000,
        SunAngularSize = 21,
    },
    { Name = "setting sun",
        SkyboxBk = "rbxassetid://626460377",
        SkyboxDn = "rbxassetid://626460216",
        SkyboxFt = "rbxassetid://626460513",
        SkyboxLf = "rbxassetid://626473032",
        SkyboxRt = "rbxassetid://626458639",
        SkyboxUp = "rbxassetid://626460625",
        MoonTextureId = 'rbxasset://sky/moon.jpg',
        SunTextureId = 'rbxasset://sky/sun.jpg',
        StarCount = 1000,
        SunAngularSize = 21,
    },
    { Name = "fade blue",
        SkyboxBk = "rbxassetid://153695414",
        SkyboxDn = "rbxassetid://153695352",
        SkyboxFt = "rbxassetid://153695452",
        SkyboxLf = "rbxassetid://153695320",
        SkyboxRt = "rbxassetid://153695383",
        SkyboxUp = "rbxassetid://153695471",
        MoonTextureId = 'rbxasset://sky/moon.jpg',
        SunTextureId = 'rbxasset://sky/sun.jpg',
        StarCount = 1000,
        SunAngularSize = 21,
    },
    { Name = "elegant morning",
        SkyboxBk = "rbxassetid://153767241",
        SkyboxDn = "rbxassetid://153767216",
        SkyboxFt = "rbxassetid://153767266",
        SkyboxLf = "rbxassetid://153767200",
        SkyboxRt = "rbxassetid://153767231",
        SkyboxUp = "rbxassetid://153767288",
        MoonTextureId = 'rbxasset://sky/moon.jpg',
        SunTextureId = 'rbxasset://sky/sun.jpg',
        StarCount = 1000,
        SunAngularSize = 21,
    },
    { Name = "neptune",
        SkyboxBk = "rbxassetid://218955819",
        SkyboxDn = "rbxassetid://218953419",
        SkyboxFt = "rbxassetid://218954524",
        SkyboxLf = "rbxassetid://218958493",
        SkyboxRt = "rbxassetid://218957134",
        SkyboxUp = "rbxassetid://218950090",
        MoonTextureId = 'rbxasset://sky/moon.jpg',
        SunTextureId = 'rbxasset://sky/sun.jpg',
        StarCount = 1000,
        SunAngularSize = 21,
    },
    { Name = "redshift",
        SkyboxBk = "rbxassetid://401664839",
        SkyboxDn = "rbxassetid://401664862",
        SkyboxFt = "rbxassetid://401664960",
        SkyboxLf = "rbxassetid://401664881",
        SkyboxRt = "rbxassetid://401664901",
        SkyboxUp = "rbxassetid://401664936",
        MoonTextureId = 'rbxasset://sky/moon.jpg',
        SunTextureId = 'rbxasset://sky/sun.jpg',
        StarCount = 1000,
        SunAngularSize = 21,
    },
}
local SkyboxNames = {}
for i = 1, #SkyboxPresets do SkyboxNames[i] = SkyboxPresets[i].Name end
--

local GetPlayers = Players.GetPlayers
local GetPlayerFromCharacter = Players.GetPlayerFromCharacter

--

local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local Raycast = Workspace.Raycast
local FindPartOnRay = Workspace.FindPartOnRay
local FindPartOnRayWithWhitelist = Workspace.FindPartOnRayWithWhitelist
local FindPartOnRayWithIgnoreList = Workspace.FindPartOnRayWithIgnoreList
local WorldToScreenPoint = Camera.WorldToScreenPoint
local WorldToViewportPoint = Camera.WorldToViewportPoint
local ScreenPointToRay = Camera.ScreenPointToRay
local ViewportPointToRay = Camera.ViewportPointToRay
local GetMouseLocation = UserInputService.GetMouseLocation
local IsMouseButtonPressed = UserInputService.IsMouseButtonPressed
local IsFriendsWithAsync = LocalPlayer.IsFriendsWithAsync

-- [FIX] 部分注入器的 clonefunction 对 Roblox 的 C 方法会直接返回原对象 (甚至返回非函数),
-- 之后 methods 下拉框的 hookfunction / RestoreAll 就会把这个共享引用一起改坏,
-- 结果是 "attempt to call a Instance value"。这里校验一次, 坏了就退回原方法
-- (从本脚本调用时 checkcaller() 为真, hook 会直接放行到原函数, 行为一致)。
local SafeClone = function(Function)
    if type(Function) ~= "function" then
        return Function
    end

    local Success, Cloned = pcall(clonefunction, Function)

    if not Success or type(Cloned) ~= "function" then
        return Function
    end

    return Cloned
end

local RaycastCloned = SafeClone(Raycast)
local FindPartOnRayCloned = SafeClone(FindPartOnRay)
local FindPartOnRayWithWhitelistCloned = SafeClone(FindPartOnRayWithWhitelist)
local FindPartOnRayWithIgnoreListCloned = SafeClone(FindPartOnRayWithIgnoreList)
local WorldToViewportPointCloned = SafeClone(WorldToViewportPoint)
local WorldToScreenPointCloned = SafeClone(WorldToScreenPoint)
local ViewportPointToRayCloned = SafeClone(ViewportPointToRay)
local ScreenPointToRayCloned = SafeClone(ScreenPointToRay)
local GetMouseLocationCloned = SafeClone(GetMouseLocation)
local IsMouseButtonPressedCloned = SafeClone(IsMouseButtonPressed)

--

local TaskScheduler = loadfile('dreamybull.club/Dependencies/TaskScheduler.luau')() do
    
end

--

local HookManager = loadfile('dreamybull.club/Dependencies/HookManager.luau')() do
    
end

--

local Aimbot = {
    Enabled = true,
    FieldOfView = 100,
    MaxDistance = 1000,

    SortType = 'ViewportDistance',
    ScreenOrigin = 'Center',

    VisibleCheckSettings = {
        IgnoreNonCollidable = true,

        MaxPierces = 2,
        TransparencyThreshold = 1,

        ScanOrigin = 'Camera',
    },

    BulletManipulation = {
        Enabled = false,
        ForceTeleport = false,

        ScanOffset = 5,

        ForceTPOffset = Vector3New(0, 1, 0),

        ScanOffsets = {
            Vector3New(0, 0, 0),
            Vector3New(0, 1, 0),
            Vector3New(0, -1, 0),
            Vector3New(1, 0, 0),
            Vector3New(-1, 0, 0)
        },
    },

    StickyAim = {
        Enabled = true
    },

    MultiPoint = {
        Enabled = false,
        Spread = 0.45,
        PointCount = 8
    },

    Checks = {
        Team = true,
        Visible = true,
        OffScreen = true,
        ForceField = true,
    },

    BodyParts = {
        'Head'
    },

    Categories = {
        'NPCs',
        'Players'
    },

    AddedFolders = {},

    LastRefresh =  0,
    StickyTarget = nil,
    CurrentTargetInfo = nil
} do
    local WallCheckParams = RaycastParamsNew()
    WallCheckParams.FilterType = Enum.RaycastFilterType.Exclude
    WallCheckParams.IgnoreWater = true

    local WallCheckIgnoreList = {} -- [OPT] 复用同一张忽略表, IsVisible 每次调用不再分配新表

    -- [OPT+FIX] IsFriendsWithAsync 是会挂起的 Web 请求, 原来被放在瞄准循环和 ESP flag 条件里
    -- 每帧每目标调用一次 -> 卡顿 + 请求被限流。现在按 UserId 异步缓存, 热路径变成一次表查询。
    local FriendCache = {}

    local function IsFriendCached(Player)
        local UserId = Player.UserId

        local Cached = FriendCache[UserId]
        if Cached ~= nil then return Cached end

        FriendCache[UserId] = false
        TaskScheduler:CreateThread(function()
            local Success, Result = pcall(IsFriendsWithAsync, LocalPlayer, UserId)
            FriendCache[UserId] = (Success and Result) or false
        end)

        return false
    end

    Aimbot.IsFriendCached = IsFriendCached

    function Aimbot:IsVisible(Character: Instance, Origin: Vector3, Position: Vector3, Settings: table): boolean
        local Pierces = 0
        local Direction = Position - Origin

        -- [FIX] RaycastCloned 可能在运行期被 hookfunction / RestoreAll 改坏, 每次调用取一个可用的
        local RaycastFunction = RaycastCloned

        if type(RaycastFunction) ~= "function" then
            RaycastFunction = Workspace.Raycast

            if type(RaycastFunction) ~= "function" then
                return false
            end
        end

        -- [OPT] 复用模块级表; 给 FilterDescendantsInstances 赋值会在引擎侧拷贝数组, 只在列表变化时赋值
        -- [FIX] LocalPlayer.Character 为 nil 时不能留空洞, 否则数组长度不确定
        local IgnoreList = WallCheckIgnoreList
        TableClear(IgnoreList)

        local LocalCharacter = LocalPlayer.Character
        if LocalCharacter then
            TableInsert(IgnoreList, LocalCharacter)
        end

        TableInsert(IgnoreList, Camera)

        local MaxPierces = Settings.MaxPierces
        local IgnoreNonCollidable = Settings.IgnoreNonCollidable
        local TransparencyThreshold = Settings.TransparencyThreshold

        WallCheckParams.FilterDescendantsInstances = IgnoreList

        while Pierces < MaxPierces do
            local Result = RaycastFunction(Workspace, Origin, Direction, WallCheckParams)
            if not Result then return true end

            local HitInstance = Result.Instance
            if IsDescendantOf(HitInstance, Character) then return true end

            if HitInstance.Transparency >= TransparencyThreshold or (IgnoreNonCollidable and not HitInstance.CanCollide) then
                Pierces += 1
                TableInsert(IgnoreList, HitInstance)
                WallCheckParams.FilterDescendantsInstances = IgnoreList -- 列表变了才重新赋值

                continue
            end

            return false
        end

        return false
    end

    --[[
        [OPT] Multi-point 优化。

        原实现的问题 (每帧 * 每个目标 * 每个身体部位都发生一次):
          1. 每次都新建一张 Points 表 + 每个点新建一个 Vector3 -> GC 压力大
          2. phi/theta/方向向量只取决于"点的序号", 和目标位置无关, 却每帧重算
             (里面还有 acos / sqrt(5) / 两个 sin + 两个 cos, 是最贵的部分)

        现在: 单位球面上的方向 (Fibonacci sphere) 是纯几何常量, 只和 i / PointCount 有关,
        所以按 PointCount 缓存一份"单位方向 + 半径系数"。之后每帧只做
        Center + Dir * (Radius) + clamp, 没有三角函数、没有新表 (复用 self._PointBuffer)、
        Vector3 数量降到最少。扫描点数不变, 命中率不变, 但开销大幅下降。
    --]]
    Aimbot._PointCache = {}   -- [PointCount] = { {Dir=unitVec3, R=系数}, ... }
    Aimbot._PointBuffer = {}  -- 复用的输出表

    function Aimbot:GetPoints(Part: BasePart, Settings: table): {Vector3}
        local Center = Part.Position

        local Buffer = self._PointBuffer
        Buffer[1] = Center

        local PointCount = Settings.PointCount

        if not Settings.Enabled or PointCount <= 1 then

            for Index = #Buffer, 2, -1 do
                Buffer[Index] = nil
            end

            return Buffer
        end

        local Template = self._PointCache[PointCount]
        if not Template then
            Template = {}

            local GoldenAngle = MathPi * (1 + MathSqrt(5))

            for i = 1, PointCount - 1 do
                local Ratio = i / PointCount
                local phi = MathAcos(1 - 2 * Ratio)
                local theta = GoldenAngle * i

                local SinPhi = MathSine(phi)

                Template[i] = {
                    Dir = Vector3New(SinPhi * MathCos(theta), SinPhi * MathSine(theta), MathCos(phi)),
                    R = Ratio,
                }
            end

            self._PointCache[PointCount] = Template
        end

        local Size = Part.Size
        local HalfX = Size.X * 0.5
        local HalfY = Size.Y * 0.5
        local HalfZ = Size.Z * 0.5
        local MaxRadius = Size.Magnitude * 0.5 * Settings.Spread

        local CenterX, CenterY, CenterZ = Center.X, Center.Y, Center.Z
        local MinX, MaxX = CenterX - HalfX, CenterX + HalfX
        local MinY, MaxY = CenterY - HalfY, CenterY + HalfY
        local MinZ, MaxZ = CenterZ - HalfZ, CenterZ + HalfZ

        local Count = #Template
        for i = 1, Count do
            local Data = Template[i]
            local Dir = Data.Dir
            local Scale = MaxRadius * Data.R

            Buffer[i + 1] = Vector3New(
                MathClamp(CenterX + Dir.X * Scale, MinX, MaxX),
                MathClamp(CenterY + Dir.Y * Scale, MinY, MaxY),
                MathClamp(CenterZ + Dir.Z * Scale, MinZ, MaxZ)
            )
        end

        for Index = #Buffer, Count + 2, -1 do
            Buffer[Index] = nil
        end

        return Buffer
    end

    function Aimbot:GetOrigins(Settings: table): {Vector3}
        local BaseOrigin = (Settings.ScanOrigin == 'Head' and LocalPlayer.Character and
                           (FindFirstChild(LocalPlayer.Character, "Head") or FindFirstChild(LocalPlayer.Character, "HumanoidRootPart")).Position)
                           or Camera.CFrame.Position

        local Origins = { BaseOrigin }

        if self.BulletManipulation.Enabled then
            for _, Offset in Settings.ScanOffsets do
                TableInsert(Origins, BaseOrigin + Offset * Settings.ScanOffset)
            end
        end

        return Origins
    end

    function Aimbot:ScanTarget(Target: Instance, Info: table, Settings: table)
        local IsPlayer = IsA(Target, 'Player')
        if IsPlayer and Target == LocalPlayer then return end

        local Character = (IsPlayer and Target.Character) or Target
        if not Character then return end

        local Humanoid = FindFirstChildOfClass(Character, "Humanoid")
        if not Humanoid or Humanoid.Health <= 0 then return end

        local RootPart = FindFirstChild(Character, "HumanoidRootPart")
        if not RootPart then return end

        if Settings.Checks.Team and IsPlayer and FindFirstChildOfClass(Teams, "Team") and Target.Team == LocalPlayer.Team then return end -- [OPT] 不再每次分配 GetChildren 表
        if Settings.Checks.ForceField and FindFirstChildOfClass(Character, "ForceField") then return end
        if Settings.Checks.Friend and IsPlayer and IsFriendCached(Target) then return end -- [OPT] 走缓存, 不再在瞄准循环里发 Web 请求

        local Distance = (Info.Origins[1] - Info.LocalPosition).Magnitude
        if Distance > Settings.MaxDistance then return end

        local LastInfo = nil

        local IsSticky = (self.StickyTarget ~= nil and self.StickyTarget == Target)

        for _, BodyPartName in Settings.BodyParts do
            local Part = FindFirstChild(Character, BodyPartName)
            if not Part or not IsA(Part, "BasePart") then continue end

            local Points = self:GetPoints(Part, Settings.MultiPoint)

            for _, Point in Points do
                local ScreenPosition, OnScreen = WorldToViewportPointCloned(Camera, Point)
                if not IsSticky and Settings.Checks.OffScreen and not OnScreen then continue end

                local DeltaX = ScreenPosition.X - Info.OriginX
                local DeltaY = ScreenPosition.Y - Info.OriginY
                local FOVDistance = MathSqrt(DeltaX * DeltaX + DeltaY * DeltaY) -- [OPT] 免去内层循环每个点一次 Vector2 分配
                if not IsSticky and FOVDistance > (Settings.FieldOfView or 0/0) then continue end

                if LastInfo and LastInfo.ViewportDistance <= FOVDistance then continue end

                local Origin = Info.Origins[1]

                local ForceManipulationEnabled = self.BulletManipulation.Enabled and self.BulletManipulation.ForceTeleport
                if ForceManipulationEnabled then
                    Origin = Point + self.BulletManipulation.ForceTPOffset
                end

                if not ForceManipulationEnabled and Settings.Checks.Visible then
                    local IsVisible = false

                    for _, ManipulatedOrigin in Info.Origins do
                        if self:IsVisible(Character, ManipulatedOrigin, Point, self.VisibleCheckSettings) then
                            IsVisible = true
                            Origin = ManipulatedOrigin
                            break
                        end
                    end

                    if not IsVisible then
                        continue
                    end
                end

                LastInfo = {
                    Target = Target,
                    HitPart = Part,
                    HitPosition = Point,
                    ScreenPosition = ScreenPosition,
                    Origin = Origin,
                    Distance = Distance,
                    ViewportDistance = FOVDistance,
                    Health = Humanoid.Health
                }
            end
        end

        return LastInfo
    end

    function Aimbot:GetTarget(Settings: table)
        if not Settings.Enabled then
            Aimbot.CurrentTargetInfo = nil
            Aimbot.StickyTarget = nil
            return
        end

        local LocalCharacter = LocalPlayer.Character
        if not LocalCharacter then
            Aimbot.CurrentTargetInfo = nil
            return
        end

        local LocalRoot = FindFirstChild(LocalCharacter, "HumanoidRootPart")
        if not LocalRoot then
            Aimbot.CurrentTargetInfo = nil
            return
        end

        local LocalPosition = LocalRoot.Position
        local Vector2Origin = (Settings.ScreenOrigin == 'Center' and (Camera.ViewportSize * 0.5)) or GetMouseLocationCloned(UserInputService)
        local Origins = self:GetOrigins({
            ScanOffset = Aimbot.BulletManipulation.ScanOffset,
            ScanOffsets = Aimbot.BulletManipulation.ScanOffsets,
            ScanOrigin = Aimbot.VisibleCheckSettings.ScanOrigin
        })

        local ScanPayload = {
            Origins = Origins,
            LocalPosition = LocalPosition,
            Vector2Origin = Vector2Origin,
            OriginX = Vector2Origin.X, -- [OPT] 拆成数值给 ScanTarget 内层循环用
            OriginY = Vector2Origin.Y
        }

        if Settings.StickyAim.Enabled then
            if Aimbot.StickyTarget then
                local IsPlayer = IsA(Aimbot.StickyTarget, 'Player')
                local TargetCharacter = (IsPlayer and Aimbot.StickyTarget.Character) or Aimbot.StickyTarget
                local TargetHumanoid = TargetCharacter and FindFirstChildOfClass(TargetCharacter, "Humanoid")

                if not TargetCharacter or not TargetCharacter.Parent or not TargetHumanoid or TargetHumanoid.Health <= 0 then
                    Aimbot.StickyTarget = nil
                end
            end

            if Aimbot.StickyTarget then
                local StuckInfo = Aimbot:ScanTarget(Aimbot.StickyTarget, ScanPayload, Settings)

                if StuckInfo then
                    Aimbot.CurrentTargetInfo = StuckInfo
                    return StuckInfo
                end
            end
        else
            Aimbot.StickyTarget = nil
        end

        Aimbot.CurrentTargetInfo = nil
        local ValidTargets = {}

        if TableFind(self.Categories, 'Players') then
            for _, Player in GetPlayers(Players) do
                local PlayerInfo = Aimbot:ScanTarget(Player, ScanPayload, Settings)
                if PlayerInfo then
                    TableInsert(ValidTargets, PlayerInfo)
                end
            end
        end

        if TableFind(self.Categories, 'NPCs') then
            for _, Folder in Aimbot.AddedFolders do
                for _, Object in GetChildren(Folder) do
                    if FindFirstChild(Players, Object.Name) then continue end
                    if GetPlayerFromCharacter(Players, Object) then continue end

                    local NPCInfo = Aimbot:ScanTarget(Object, ScanPayload, Settings)
                    if NPCInfo then
                        TableInsert(ValidTargets, NPCInfo)
                    end
                end
            end
        end

        if #ValidTargets == 0 then
            return
        end

        TableSort(ValidTargets, function(TargetInfo1, TargetInfo2)
            return TargetInfo1[Settings.SortType] < TargetInfo2[Settings.SortType]
        end)

        local FinalTarget = ValidTargets[1] do
            Aimbot.CurrentTargetInfo = FinalTarget

            if Settings.StickyAim.Enabled and not Aimbot.StickyTarget then
                Aimbot.StickyTarget = FinalTarget.Target
            end

            return FinalTarget
        end
    end

    TaskScheduler:CreateDelayThread(0, function()
        repeat TaskWait() until Genv.Connection and Genv.Library and Genv.Library.TargetIndicatorItem

        Genv.Library.TargetIndicatorItem:ResetFade()

        Genv.Connection.Add('Aimbot', RunService.RenderStepped, function(DeltaTime: number)
            local NewTick = tick()
            if NewTick - Aimbot.LastRefresh < 1/120 then return end

            local TargetInfo = Aimbot:GetTarget(Aimbot)

            local Indicator = Genv.Library.TargetIndicatorItem do
                local Target = TargetInfo and TargetInfo.Target

                -- 目标消失或更换时交给 TransitionTo 做 不透明 -> 透明 -> 换目标 -> 不透明
                if Aimbot.IndicatorTarget ~= Target then
                    Aimbot.IndicatorTarget = Target
                    Indicator:TransitionTo(Target)
                end
            end

            Aimbot.LastRefresh = NewTick
        end)
    end)

    TaskScheduler:AddLoop('GC Clear', 3.5, function()
        for Index = #Aimbot.AddedFolders, 1, -1 do -- [FIX] 正向遍历时 TableRemove 会跳过元素, 改为倒序
            local Folder = Aimbot.AddedFolders[Index]
            local ChildrenAmount = #GetChildren(Folder)
            if Folder.Parent == nil or ChildrenAmount <= 0 then
                TableRemove(Aimbot.AddedFolders, Index)
            end
        end
    end)
end

--

local ESP, Easing, Utility, Connection = loadfile('dreamybull.club/Dependencies/ESP.luau')() do
    do
        local function Filter(Object: Instance): boolean
            if not IsA(Object, 'Model') then return false end

            if FindFirstChild(Players, Object.Name) then return false end
            if GetPlayerFromCharacter(Players, Object) then return false end

            if not FindFirstChildOfClass(Object, 'Humanoid') and not FindFirstChild(Object, 'HumanoidRootPart') then return false end

            local FolderParent = Object.Parent

            if not TableFind(Aimbot.AddedFolders, FolderParent) then
                TableInsert(Aimbot.AddedFolders, FolderParent)

                ESP.ChangeCategoryInfo('NPCs', 'Folders', Aimbot.AddedFolders)
            end

            return true
        end

        ESP.AddCategory('NPCs', Aimbot.AddedFolders, {
            'NPCs'
        }) do
            for _, Object in GetDescendants(Workspace) do
                local Result = Filter(Object)
                if Result then
                    ESP.Create(Object)
                end
            end

            Connection.Add("NPCs/NPCAdded", Workspace.DescendantAdded, function(Object: Instance)
                local Result = Filter(Object)
                if Result then
                    ESP.Create(Object)
                end
            end)

            Connection.Add("NPCs/NPCRemoving", Workspace.DescendantRemoving, function(Object: Instance)
                ESP.Remove(Object)
            end)
        end
    end

    do
        ESP.RegisterFlags({
            Name = 'forcefield',
            Text = 'ff',
            Color = Color3New(0.356862, 0.709803, 1),
            Category = {
                NPCs = {},
                Players = {}
            },
            Condition = function(Object: Instance)
                local Character = (Object:IsA('Player') and Object.Character) or Object
                return FindFirstChildOfClass(Character, 'ForceField') ~= nil
            end
        })

        ESP.RegisterFlags({
            Name = 'friend',
            Text = 'friend',
            Color = Color3New(0.247058, 1, 0.411764),
            Category = {
                Players = {}
            },
            Condition = function(Object: Instance)
                local IsPlayer = IsA(Object, 'Player')
                return IsPlayer and Aimbot.IsFriendCached(Object) -- [OPT+FIX] 原来每个 ESP tick 每玩家发一次 Web 请求
            end
        })

        ESP.RegisterFlags({
            Name = 'visible',
            Text = 'visible',
            Color = Color3New(1, 0.8, 0.368627),
            Category = {
                NPCs = {},
                Players = {}
            },
            Condition = function(Object: Instance): boolean
                local Character = (Object:IsA('Player') and Object.Character) or Object
                local LocalCharacter = LocalPlayer.Character
                if not Character or not LocalCharacter then return false end

                local TarFindFirstChild = FindFirstChild(Character, 'Head') or FindFirstChild(Character, 'HumanoidRootPart')
                if not TarFindFirstChild then return false end

                local Position = TarFindFirstChild.Position
                local Origin = Camera.CFrame.Position
                if Aimbot.VisibleCheckSettings.ScanOrigin == 'Head' then
                    local LocalPart = FindFirstChild(LocalCharacter, 'Head') or FindFirstChild(LocalCharacter, 'HumanoidRootPart')
                    if LocalPart then
                        Origin = LocalPart.Position
                    end
                end

                return Aimbot:IsVisible(Character, Origin, Position, Aimbot.VisibleCheckSettings)
            end
        })

        ESP.RegisterFlags({
            Name = 'sticky',
            Text = 'sticky',
            Color = Color3New(0.380392, 0.341176, 0.945098),
            Category = {
                NPCs = {},
                Players = {}
            },
            Condition = function(Object: Instance)
                return Aimbot.StickyTarget ~= nil and Aimbot.StickyTarget == Object
            end
        })

        ESP.RegisterFlags({
            Name = 'targeting',
            Text = 'targeting',
            Color = Color3New(0.992156, 0.266666, 0.266666),
            Category = {
                NPCs = {},
                Players = {}
            },
            Condition = function(Object: Instance)
                local CurrentTargetInfo = Aimbot.CurrentTargetInfo
                return CurrentTargetInfo ~= nil and CurrentTargetInfo.Target == Object
            end
        })
    end
end

--

local MiscFunctions = {
    Settings = {
        Movement = {
            SpeedEnabled = false,
            SpeedValue = 50,
            FlyEnabled = false,
            FlyValue = 100,
            DirectionMethod = 'Custom', -- 选项: 'MoveDirection' 或 'Custom'
        },
        Desync = {
            Enabled = false,
            Tick = 15,
            Mode = 'Manual', -- 选项: 'Manual', 'Random', 'Invisible'
            AngleMode = 'Manual', -- 选项: 'Manual', 'Random', 'Spin'
            ManualAngles = Vector3New(0, 0, 0),
            ManualOffset = Vector3New(0, 0, 0),
            SpinSpeed = 10,
            SpinAngles = {'Y'}, -- 可多选: 'X', 'Y', 'Z'
            RandomBounds = {
                Min = Vector3New(0, 0, 0),
                Max = Vector3New(0, 0, 0)
            },
            Visualize = true
        }
    },

    DesyncData = {
        Angle = 0,
        Frames = {},
        OldCFrame = nil,
        IsDesyncing = false,
        Clone = nil,
        Highlight = InstanceNew('Highlight', Camera)
    },

    WasFlying = false
} do
    local UpVector = Vector3New(0, 1, 0) -- [OPT] 飞行时每帧不再分配

    function MiscFunctions:UpdateMovement(DeltaTime: number)
        local Character = LocalPlayer.Character
        if not Character then return end

        local RootPart = FindFirstChild(Character, "HumanoidRootPart")
        local Humanoid = FindFirstChildOfClass(Character, "Humanoid")

        if not RootPart or not Humanoid or Humanoid.Health <= 0 then return end

        local Settings = self.Settings.Movement
        local FlyEnabled = Settings.FlyEnabled
        local SpeedEnabled = Settings.SpeedEnabled

        if not FlyEnabled and not SpeedEnabled then
            if RootPart.Anchored and self.WasFlying then
                RootPart.Anchored = false
                self.WasFlying = false
            end

            return
        end

        local Direction = Vector3New()

        if Settings.DirectionMethod == 'MoveDirection' then
            Direction = Humanoid.MoveDirection
        elseif Settings.DirectionMethod == 'Custom' then
            local CamCF = Camera.CFrame
            local Look = CamCF.LookVector
            local Right = CamCF.RightVector

            if FlyEnabled then
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then Direction += Look end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then Direction -= Look end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then Direction -= Right end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then Direction += Right end
            else
                local FlatLook = Vector3New(Look.X, 0, Look.Z).Unit
                local FlatRight = Vector3New(Right.X, 0, Right.Z).Unit

                if UserInputService:IsKeyDown(Enum.KeyCode.W) then Direction += FlatLook end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then Direction -= FlatLook end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then Direction -= FlatRight end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then Direction += FlatRight end
            end

            if Direction.Magnitude > 0 then
                Direction = Direction.Unit
            end
        end

        if FlyEnabled then
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then Direction += UpVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then Direction -= UpVector end
        end

        if Direction.Magnitude == 0 then
            if FlyEnabled then
                RootPart.Anchored = true
                self.WasFlying = true
            end

            return
        end

        if FlyEnabled then
            RootPart.Anchored = true
            self.WasFlying = true

            local Displacement = Direction * Settings.FlyValue * DeltaTime
            RootPart.CFrame = RootPart.CFrame + Displacement
        elseif SpeedEnabled then
            RootPart.Anchored = false
            self.WasFlying = false

            local Displacement = Direction * Settings.SpeedValue * DeltaTime
            RootPart.CFrame = RootPart.CFrame + Displacement
        end
    end

    function MiscFunctions:GetDesyncOrigin()
        local Frames = self.DesyncData.Frames
        local Tick = self.Settings.Desync.Tick

        if Frames[#Frames - Tick] then
            return Frames[#Frames - Tick]
        end

        return Frames[#Frames] or CFrameNew()
    end

    function MiscFunctions:UpdateDesync(DeltaTime: number)
        local Settings = self.Settings.Desync
        local Data = self.DesyncData

        if not Settings.Enabled then
            if Data.Clone then
                Destroy(Data.Clone)
                Data.Clone = nil
            end

            Data.OldCFrame = nil
            Data.IsDesyncing = false
            return
        end

        local Character = LocalPlayer.Character
        local RootPart = Character and FindFirstChild(Character, "HumanoidRootPart")
        local Humanoid = Character and FindFirstChildOfClass(Character, "Humanoid")
        if not Character or not RootPart or not Humanoid or Humanoid.Health <= 0 then return end

        Data.OldCFrame = RootPart.CFrame
        TableInsert(Data.Frames, RootPart.CFrame)

        -- [OPT+FIX] 原判断把 Frames 和它自己比较, 永远为 false -> 60Hz 无限堆积 CFrame (内存泄漏)
        local MaxFrames = Settings.Tick + 1
        while #Data.Frames > MaxFrames do
            TableRemove(Data.Frames, 1)
        end

        local FakeCFrame = self:GetDesyncOrigin()

        Data.Angle += 10 * DeltaTime * Settings.SpinSpeed
        if Data.Angle >= 360 then Data.Angle = 0 end

        if Settings.AngleMode == 'Manual' then
            FakeCFrame *= CFrameAngles(MathRad(Settings.ManualAngles.X), MathRad(Settings.ManualAngles.Y), MathRad(Settings.ManualAngles.Z))
        elseif Settings.AngleMode == 'Random' then
            local Rand = MathRad(MathRandom(1, 180))

            FakeCFrame *= CFrameAngles(Rand, Rand, Rand)
        elseif Settings.AngleMode == 'Spin' then
            local SpinX = TableFind(Settings.SpinAngles, 'X') and MathRad(Data.Angle) or 0
            local SpinY = TableFind(Settings.SpinAngles, 'Y') and MathRad(Data.Angle) or 0
            local SpinZ = TableFind(Settings.SpinAngles, 'Z') and MathRad(Data.Angle) or 0

            FakeCFrame *= CFrameAngles(SpinX, SpinY, SpinZ)
        end

        if Settings.Mode == 'Manual' then
            FakeCFrame *= CFrameNew(Settings.ManualOffset)
        elseif Settings.Mode == 'Random' then
            local Bounds = Settings.RandomBounds
            local RandX = MathRandom(Bounds.Min.X, Bounds.Max.X)
            local RandY = MathRandom(Bounds.Min.Y, Bounds.Max.Y)
            local RandZ = MathRandom(Bounds.Min.Z, Bounds.Max.Z)

            FakeCFrame *= CFrameNew(RandX, RandY, RandZ)
        elseif Settings.Mode == 'Invisible' then
            FakeCFrame = CFrameNew(0/0, 0/0, 0/0)
        end

        if Settings.Visualize then
            Character.Archivable = true

            if not Data.Clone then
                local NewReplicationObject = Clone(Character)
                NewReplicationObject.Name = ''
                NewReplicationObject.Humanoid.DisplayName = ' '
                NewReplicationObject.Parent = Workspace

                -- [OPT] 只在克隆创建时跑一次; 原来每个 Heartbeat 帧都开新线程 + GetChildren
                for _, Part in GetChildren(NewReplicationObject) do
                    if StringFind(Part.ClassName, 'Part') then
                        Part.CanCollide = false
                    end
                end

                Data.Clone = NewReplicationObject
                Data.Highlight.Adornee = NewReplicationObject
            end

            Data.Clone:PivotTo(FakeCFrame)
        elseif Data.Clone then
            Destroy(Data.Clone)
            Data.Clone = nil
        end

        RootPart.CFrame = FakeCFrame
        Data.IsDesyncing = true
    end

    function MiscFunctions:ResumeDesync()
        local Data = self.DesyncData
        if not Data.IsDesyncing or not Data.OldCFrame then return end

        local Character = LocalPlayer.Character
        local RootPart = Character and FindFirstChild(Character, "HumanoidRootPart")

        if RootPart then
            RootPart.CFrame = Data.OldCFrame
        end

        Data.IsDesyncing = false
    end

    TaskScheduler:CreateDelayThread(0, function()
        repeat TaskWait() until Genv.Connection

        Genv.Connection.Add('Misc', RunService.Heartbeat, function(DeltaTime: number)
            MiscFunctions:UpdateMovement(DeltaTime)
            MiscFunctions:UpdateDesync(DeltaTime)
        end)

       RunService:BindToRenderStep('Desync$$$', 0, function(DeltaTime: number)
            MiscFunctions:ResumeDesync()
        end)
    end)
end

--

local Visuals = {
    LastRefresh = 0,

    AimbotVisuals = {
        CurrentCircleRadius = nil,
        CurrentCirclePosition = nil,

        Circle = Utility.CreateDrawing('Circle', {
            Filled = false,
            Visible = false,
            NumSides = 96,
            ZIndex = 101,
            Thickness = 1.5,
            Color = Color3New(1, 1, 1),
        }),

        CircleFilled = Utility.CreateDrawing('Circle', {
            Filled = true,
            Visible = false,
            NumSides = 96,
            ZIndex = 101,
            Thickness = 1.5,
            Color = Color3New(1, 1, 1),
        }),

        CircleOutline = Utility.CreateDrawing('Circle', {
            Filled = false,
            Visible = false,
            NumSides = 96,
            ZIndex = 100,
            Thickness = 3,
            Color = Color3New(),
        })
    },

    TargetGlow = {
        Enabled = false,

        CurrentGlowAlpha = 0,
        CurrentGlowPosition = nil,

        Core = Utility.CreateDrawing('Circle', {
            Filled = true,
            Visible = true,
            NumSides = 32,
            ZIndex = 120,
            Radius = 3,
            Color = Color3FromRGB(0, 180, 255),
            Transparency = 1
        }),

        Layers = {}
    },

    ThirdPerson = {
        Enabled = false,
        Active = false,

        XOffset = 0,
        YOffset = 2,
        ZOffset = 8,
    },

    FOVChanger = {
        Enabled = false,       -- 开关; hook 里只读这个布尔, 最快
        Writing = false,       -- 我们自己写 FOV 时置真, 让 hook 不把它记成游戏的 RealFOV
        Value = 90,            -- 想要锁定的 FOV
        RealFOV = 70,          -- 游戏真正想要的 FOV (只记游戏写入的), 关闭时用它还原
    },

    AspectRatio = {
        Enabled = false,
        Ratio = 1,             -- 1 = 原样; <1 变扁(宽), >1 变细(窄)
    },

    AutoShoot = {
        Enabled = false,
        Active = false,

        Mode = "Silent",

        Delay = 0.1,
        LastShot = 0,

        CrosshairTeamCheck = true,
        CrosshairWallCheck = false,
        CrosshairMaxDistance = 5000,
    },

    HitSound = {
        Settings = {
            Enabled = false,

            Volume = 3,
            PlaybackSpeed = 1,

            UseHeadshotSound = false,
            HeadshotPitch = 1.15,

            HitSoundId = HitSoundAssets.Hit,
            HeadshotSoundId = HitSoundAssets.Headshot,
        },

        Pool = {},
        PoolIndex = 0,
    },

    Tracers = {
        Settings = {
            Enabled = false,

            Style = 'Drawing',     -- Drawing / Beam
            OriginMode = 'Head',   -- Bottom / Camera / Head

            Color = Color3FromRGB(255, 255, 255),

            Thickness = 2,         -- Drawing 线宽 (px)

            BeamTexture = 'ray1',  -- Beam 贴图 (见顶部 BeamTextures; 'solid'=无贴图纯色)
            BeamWidth0 = .25,      -- Beam 起点宽 (studs)
            BeamWidth1 = .55,      -- Beam 终点宽 (studs)
            BeamLightEmission = 1, -- Beam 辉光 (0-1)
            BeamTintEnds = true,   -- Beam 两端淡出到黑

            Lifetime = 2,          -- 存活时间 (s)
        },

        Active = {},
        LinePool = {},
        OutlinePool = {},
        BeamPool = {},
    },

    KillParticle = {
        Settings = {
            Enabled = false,
            TeamKills = false,          -- 是否对队友死亡也触发

            Style = "Sparks",           -- Sparks / Dots / Catalyst / Mist / Chiral (参考资源 1:1)
            Color = Color3FromRGB(255, 255, 255),

            Scale = 1,                  -- 整体大小倍率 (缩放粒子 Size 序列)
            Lifetime = 2,               -- 特效模型存活 (秒), 到点销毁
        },

        Active = {},                    -- 存活中的特效 { Model=, DeathTime= }
        DeadCache = setmetatable({}, { __mode = "k" }), -- 已经触发过的角色, 防重复
    },

    DamageNumbers = {
        Settings = {
            Enabled = false,
            ShowTeamDamage = false,
            UseHeadshotColor = true,

            EnemyColor = Color3FromRGB(255, 80, 80),
            TeamColor = Color3FromRGB(255, 216, 88),
            HeadshotColor = Color3FromRGB(255, 215, 0),

            BaseSize = 18,
            BaseHeight = 24,
            BaseDuration = 2.5,
            SpeedMultiplier = 1.2,

            MaxScale = 1.3,
            MinScale = 0.8,
            RiseHeight = 256,
            FadeStartPoint = 0.6,

            DistanceScalingEnabled = false,
            MinDistance = 50,
            MinDistanceScale = 0.7,
            MaxDistanceScale = 1,

            RandomOffsetEnabled = true,
            MaxRandomOffset = 1,

            MinDamage = 1,

            RequireShot = true,
            ShotWindow = 1,
            MaxDistance = 2000,
        },

        Active = {},
        Digits = {},
        Pool = {},

        -- 弱键: 角色销毁后自动回收
        HealthCache = setmetatable({}, { __mode = "k" }),

        Base64DigitData = {
                "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",
                "iVBORw0KGgoAAAANSUhEUgAAADsAAABpCAMAAACzvat9AAAABGdBTUEAALGPC/xhBQAAAAFzUkdCAK7OHOkAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAFHUExURUdwTAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJOVkwAAAJWYlZCUkKCgoKCkoKioqJWZlXBwcJufm6isqJiYmJicmNDU0AgECJWXlbC0sK2xrZ2hnaWppdjc2KOno5udmwAEAMDEwODg4Li8uKiwqKuvqz07PdDY0MjMyMjIyJucm7W4tZOXk5CQkNjg2HBzcMDAwLO3s7u8u+Dk4NjY2LCwsDg8OEA8QNDQ0JibmLi4uGtta5iZmEtNS7O1s7u/uzU1NaCooL2/vdPV083PzbW5tcPIw73AvWVoZT08PZ2jnWVjZYuLi5CTkDs9O5iUmEVHRWtra0VFRcDIwEBDQEtPS8jQyDU3NWVlZWBgYDU5NSgoKHh4eGtva2BjYGNhY0hLSDMzM4CFgJCVkDg5ONTzYykAAAARdFJOUwD99vjm/PH+lPr7+ZXKzvXNypRhVgAAAplJREFUWMPt2HlT2kAYgPEISELvLiSghCNWAaGUxhYaKFakXOVsqz2t9r77/f/u+26ARmRDYqZTqTwzjplMfmSzWcHAcWc1wUdovEuwSz3EGO+1cVKekFSqXv9G8HcqBdqGJKQeT6cLhcLP0OEhWOK1Ll/vp9PUFu5DUUsn1iXZr1QmLLEyRXB59c2N45VnW3rSFFwoBVG9Tqcz2w4vFKYoTeFtvW6325lhxxeK10nlpp6qql1Te0lfA59yuVy5XK4cHfX7mlaiNdGb2MtUvozm0FYqar8/GJRKd2i9ZtPEChd1GaW2oqraYFCtolPwp9drMi2Vb6Xo0KqaplUhZRzbLsH+j7v6/cAJymQyRQBr44rFjDbdemH3M6MsFotrx2PaZaAbfyQ9YThrKAx4ltWlooRPxLQw5jcHcP/bKPHI9RNllQxjrmD3gdpuN1DCgYnJzCysxR/tRgNPKSWkKZlYFwwaqcRsPcuyAuynh9xglQgrrHUFM/0Z6CqjWfaDiY2YWRh0CmyEmYnFu/RKFHchGQpARplMPn20zbTw6dECW6vVRjZkSDa1ONOiSCHaL3asPuihfU9IIHDXkCwnzSwMeu9FHpLf4fvA40g8fn1cPJ6UbrItDpra78S2xTW9l89/jZGhlW1YF9pYDK3PruVGH9LXcPOhtOUPBCzbK1S69ZdB67duOeGq2y1wIyvassbhO7ErwYU9PzYQWpW24Z+uU9vnc2b9W2L4SSx2bmwoJAVvLezCLuxcWvzb/3XK93a09xb2bFu/GFxZ2P/ZOlkbaAUHdtmBtTBoYfJZA60oWrIXnFnpX9glfAYfPbtjuO3U8n/XeghptXagB8Nwu9UixGNhbfjI1HzWvvL2EZ7njd9688Tn4ea638jrJxcPaZfMAAAAAElFTkSuQmCC",
                "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",
                "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",
                "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",
                "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",
                "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",
                "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",
                "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",
                "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"
        }
    },
} do

    local GlowConfig = {
        { Radius = 4,  Opacity = 0.35 },
        { Radius = 8,  Opacity = 0.24 },
        { Radius = 12, Opacity = 0.15 },
        { Radius = 16, Opacity = 0.08 },
        { Radius = 20, Opacity = 0.04 },
        { Radius = 24, Opacity = 0.015 }
    }

    for i, Config in ipairs(GlowConfig) do
        Visuals.TargetGlow.Layers[i] = Utility.CreateDrawing('Circle', {
            Filled = true,
            Visible = false,
            NumSides = 32,
            ZIndex = 120 - i,
            Radius = Config.Radius,
            Color = Color3FromRGB(0, 180, 255),
            Transparency = Config.Opacity
        })
    end

    Connection.Add('FOV Circle', RunService.RenderStepped, function(DeltaTime: number)
        local NewTick = tick()
        if NewTick - Visuals.LastRefresh <= 1/240 then return end
        Visuals.LastRefresh = NewTick -- [FIX] 原来放在末尾, glow 分支提前 return 时不更新 -> 节流失效跑满帧

        do
            local ScreenOriginPosition = (Aimbot.ScreenOrigin == 'Center' and (Camera.ViewportSize * 0.5)) or GetMouseLocationCloned(UserInputService)
            local TargetPositon = ScreenOriginPosition
            local CurrentCirclePosition = Visuals.AimbotVisuals.CurrentCirclePosition

            if Aimbot.StickyTarget and Aimbot.CurrentTargetInfo and Aimbot.CurrentTargetInfo.Target == Aimbot.StickyTarget then
                local ScreenPosition = Aimbot.CurrentTargetInfo.ScreenPosition do
                    TargetPositon = (ScreenPosition.Z > 0 and Vector2New(ScreenPosition.X, ScreenPosition.Y)) or Vector2New(9e9, 9e9)
                end
            end

            if not CurrentCirclePosition then
                CurrentCirclePosition = TargetPositon
            else
                local SmoothSpeed = 18
                CurrentCirclePosition = CurrentCirclePosition:Lerp(TargetPositon, MathMin(1, DeltaTime * SmoothSpeed))
            end

            Visuals.AimbotVisuals.CurrentCirclePosition = CurrentCirclePosition

            local BaseRadius = Aimbot.FieldOfView or 90
            local TargetRadius = BaseRadius

            if Aimbot.StickyTarget and Aimbot.CurrentTargetInfo and Aimbot.CurrentTargetInfo.Target == Aimbot.StickyTarget then
                local HitPos3D = Aimbot.CurrentTargetInfo.HitPosition
                if HitPos3D then
                    local Distance = (Camera.CFrame.Position - HitPos3D).Magnitude
                    if Distance > 0.1 then
                        local ReferenceDistance = 50
                        local ReferenceCameraFOV = 90

                        local CalculatedRadius = BaseRadius
                            * (ReferenceDistance / Distance)
                            * (MathTan(MathRad(ReferenceCameraFOV * 0.5)) / MathTan(MathRad(Camera.FieldOfView * 0.5)))

                        local MinFOVBound = 10
                        local MaxFOVBound = 500

                        TargetRadius = MathClamp(CalculatedRadius, MinFOVBound, MaxFOVBound)
                    end
                end
            end

            local CurrentCircleRadius = Visuals.AimbotVisuals.CurrentCircleRadius
            if not CurrentCircleRadius then
                CurrentCircleRadius = TargetRadius
            else
                local RadiusSmoothSpeed = 15
                CurrentCircleRadius = CurrentCircleRadius + (TargetRadius - CurrentCircleRadius) * MathMin(1, DeltaTime * RadiusSmoothSpeed)
            end

            Visuals.AimbotVisuals.CurrentCircleRadius = CurrentCircleRadius

            local Circle = Visuals.AimbotVisuals.Circle
            local CircleFilled = Visuals.AimbotVisuals.CircleFilled
            local CircleOutline = Visuals.AimbotVisuals.CircleOutline

            if Circle then
                Circle.Position = CurrentCirclePosition
                Circle.Radius = CurrentCircleRadius
            end

            if CircleOutline then
                CircleOutline.Position = CurrentCirclePosition
                CircleOutline.Radius = CurrentCircleRadius
            end

            if CircleFilled then
                CircleFilled.Position = CurrentCirclePosition
                CircleFilled.Radius = CurrentCircleRadius
            end
        end

        do
            local Glow = Visuals.TargetGlow
            if not Visuals.TargetGlow.Enabled then
                Glow.Core.Visible = false

                for Index, Layer in ipairs(Glow.Layers) do
                    Layer.Visible = false
                end

                return
            end

            local TargetInfo = Aimbot.CurrentTargetInfo
            local HasTarget = TargetInfo and TargetInfo.ScreenPosition and TargetInfo.ScreenPosition.Z > 0

            local TargetAlpha = HasTarget and 1 or 0
            local AlphaSpeed = 12

            Glow.CurrentGlowAlpha = Glow.CurrentGlowAlpha + (TargetAlpha - Glow.CurrentGlowAlpha) * MathMin(1, DeltaTime * AlphaSpeed)

            if Glow.CurrentGlowAlpha <= 0.01 then
                Glow.Core.Visible = false

                for _, Layer in ipairs(Glow.Layers) do
                    Layer.Visible = false
                end

                return
            end

            if HasTarget then
                local ScreenPos = Vector2New(TargetInfo.ScreenPosition.X, TargetInfo.ScreenPosition.Y)
                local GlowPosition = Glow.CurrentGlowPosition -- [FIX] 原来读写的是意外的全局变量
                if not GlowPosition then
                    GlowPosition = ScreenPos
                else
                    local MoveSpeed = 50
                    GlowPosition = GlowPosition:Lerp(ScreenPos, MathMin(1, DeltaTime * MoveSpeed))
                end
                Glow.CurrentGlowPosition = GlowPosition
            end

            local GlowPosition = Glow.CurrentGlowPosition
            if not GlowPosition then return end

            local Time = OsClock()
            local RippleSpeed = 4.5

            Glow.Core.Position = GlowPosition
            Glow.Core.Transparency = Glow.CurrentGlowAlpha
            Glow.Core.Visible = true

            local CoreColor = Glow.Core.Color
            if Glow.LastLayerColor ~= CoreColor then -- [OPT] Drawing 属性写入有开销, 颜色不变就不刷 6 层
                Glow.LastLayerColor = CoreColor

                for _, Layer in ipairs(Glow.Layers) do
                    Layer.Color = CoreColor
                end
            end

            for Index, Layer in ipairs(Glow.Layers) do
                local Config = GlowConfig[Index]
                local PhaseShift = Index * 0.45
                local Wave = (MathSine(Time * RippleSpeed - PhaseShift) + 1) * 0.5

                local DynamicRadius = Config.Radius + (Wave * Config.Radius * 0.15)
                local DynamicOpacity = Config.Opacity * Glow.CurrentGlowAlpha * (0.4 + Wave * 0.6)

                Layer.Position = GlowPosition
                Layer.Radius = DynamicRadius
                Layer.Transparency = DynamicOpacity
                Layer.Visible = true
            end
        end
    end)
end

--

do
    local ThirdPerson = Visuals.ThirdPerson
    local FOVChanger = Visuals.FOVChanger
    local AspectRatio = Visuals.AspectRatio

    local function StretchCFrame(CF, Ratio)
        if Ratio > 3 then Ratio = 3 elseif Ratio < 0.35 then Ratio = 0.35 end

        local Position = CF.Position
        local Right = CF.RightVector
        local Up = CF.UpVector
        local Look = CF.LookVector

        if Ratio > 1 then
            Right = Right * (1 / Ratio)
        elseif Ratio < 1 then
            Up = Up * Ratio
        end

        return CFrameNew(
            Position.X, Position.Y, Position.Z,
            Right.X, Up.X, -Look.X,
            Right.Y, Up.Y, -Look.Y,
            Right.Z, Up.Z, -Look.Z
        )
    end

    -- 计算相机写入要落地的值(第三人称偏移 / 屏幕伸缩 / FOV 锁定)。逻辑出错时由下方 hook 的 pcall 退回原始 Value。
    local function ComputeCameraWrite(Index, Value)
        if Index == "CFrame" then
            if ThirdPerson.Active then
                Value *= CFrameNew(ThirdPerson.XOffset, ThirdPerson.YOffset, ThirdPerson.ZOffset)
            end
            if AspectRatio.Enabled and AspectRatio.Ratio ~= 1 then
                Value = StretchCFrame(Value, AspectRatio.Ratio)
            end
        elseif Index == "FieldOfView" then
            -- 只把"游戏"写入的 FOV 记为还原目标; 我们自己(每帧强制写)的不能记, 否则 RealFOV 会被污染成自定义值。
            -- RenderStepped 回调里 checkcaller() 可能为假, 顶部那道放行拦不住我们自己的写, 故再用 Writing 标记挡一层。
            if not FOVChanger.Writing then
                FOVChanger.RealFOV = Value
            end

            -- 开着就改成我们锁定的值, 让引擎侧永远拿到我们的 FOV, 不受游戏覆盖
            if FOVChanger.Enabled then
                Value = FOVChanger.Value
            end
        end

        return Value
    end

    -- 注意: hookmetamethod(Camera, ...) 实际挂在所有实例共享的 metatable 上, 每次任意属性写入都触发。
    -- 快速放行(非 Camera / 自己写)在最前, pcall 只在真正处理 Camera 写入时才走, 不拖累热路径。
    local OldNewIndex; OldNewIndex = hookmetamethod(Camera, "__newindex", newcclosure(function(Self, Index, Value)
        if Self ~= Camera or checkcaller() then return OldNewIndex(Self, Index, Value) end

        -- 逻辑出错就退回原始 Value, 绝不让错误从 metamethod 抛出去(否则每次相机写入都崩)
        local Ok, NewValue = pcall(ComputeCameraWrite, Index, Value)
        if Ok and NewValue ~= nil then
            Value = NewValue
        end

        return OldNewIndex(Self, Index, Value)
    end))
end

--

do -- Visuals.FOVChanger
    local FOVChanger = Visuals.FOVChanger

    FOVChanger.RealFOV = Camera.FieldOfView

    local function Write(Value)
        FOVChanger.Writing = true
        Camera.FieldOfView = Value
        FOVChanger.Writing = false
    end

    function FOVChanger.Apply()
        if FOVChanger.Enabled then
            Write(FOVChanger.Value)
        end
    end

    function FOVChanger.SetEnabled(Bool)
        if Bool then
            if not FOVChanger.Enabled then
                FOVChanger.RealFOV = Camera.FieldOfView
                FOVChanger.Enabled = true
            end
            Write(FOVChanger.Value)
        else
            if FOVChanger.Enabled then
                FOVChanger.Enabled = false
                Write(FOVChanger.RealFOV)
            end
        end
    end

    TaskScheduler:CreateDelayThread(0, function()
        repeat TaskWait() until Genv.Connection

        Genv.Connection.Add('FOVChanger', RunService.RenderStepped, function()
            if not FOVChanger.Enabled then return end
            if Camera.FieldOfView ~= FOVChanger.Value then
                Write(FOVChanger.Value)
            end
        end)
    end)
end

--

do
    local DamageNumbers = Visuals.DamageNumbers
    local Settings = DamageNumbers.Settings
    local Active = DamageNumbers.Active
    local Pool = DamageNumbers.Pool
    local HealthCache = DamageNumbers.HealthCache

    local MathPow = math.pow
    local MathASin = math.asin
    local MathAbs = math.abs
    local DoublePi = MathPi * 2

    for Index = 1, 10 do
        DamageNumbers.Digits[Index - 1] = CryptBase64Decode(DamageNumbers.Base64DigitData[Index])
    end

    local function QuartIn(t, b, c, d)
        t = t / d
        return c * MathPow(t, 4) + b
    end

    local function ElasticOut(t, b, c, d, a, p)
        if t == 0 then return b end
        t = t / d
        if t == 1 then return b + c end

        p = p or d * 0.3
        local s = 0

        if not a or a < MathAbs(c) then
            a = c
            s = p / 4
        else
            s = p / DoublePi * MathASin(c / a)
        end

        return a * MathPow(2, -10 * t) * MathSine((t * d - s) * DoublePi / p) + c + b
    end

    -- [OPT] Drawing 对象池: 打得快时不会一直 new/Remove
    local function AcquireImage()
        local Count = #Pool

        if Count > 0 then
            local Image = Pool[Count]
            Pool[Count] = nil
            return Image
        end

        return DrawingNew("Image")
    end

    local function ReleaseImage(Image)
        Image.Visible = false
        TableInsert(Pool, Image)
    end

    function DamageNumbers.Clear()
        for Index = #Active, 1, -1 do
            local Number = Active[Index]

            for _, Image in Number.Images do
                ReleaseImage(Image)
            end

            Active[Index] = nil
        end
    end

    function DamageNumbers.Show(Damage: number, WorldPosition: Vector3, IsHeadshot: boolean, IsEnemy: boolean)
        if Damage ~= Damage then return end
        if Damage > 9999 then Damage = 9999 end

        local Position = WorldPosition

        if Settings.RandomOffsetEnabled then
            local MaxOffset = Settings.MaxRandomOffset
            Position += Vector3New((MathRandom() * 2 - 1) * MaxOffset, 0, (MathRandom() * 2 - 1) * MaxOffset)
        end

        local ScreenPosition, OnScreen = WorldToViewportPointCloned(Camera, Position)
        if not OnScreen then return end

        local Color = Settings.EnemyColor

        if IsHeadshot and Settings.UseHeadshotColor then
            Color = Settings.HeadshotColor
        elseif not IsEnemy then
            Color = Settings.TeamColor
        end

        local DigitString = tostring(Damage)
        local Length = #DigitString

        local BaseSize = Settings.BaseSize
        local BaseHeight = Settings.BaseHeight
        local StartX = ScreenPosition.X - (Length * BaseSize) / 2
        local StartY = ScreenPosition.Y - 24

        local Images = {}

        for Index = 1, Length do
            local Digit = tonumber(string.sub(DigitString, Index, Index))
            local Data = DamageNumbers.Digits[Digit]
            if not Data then continue end

            local Image = AcquireImage()

            Image.Data = Data
            Image.Size = Vector2New(BaseSize, BaseHeight)
            Image.Position = Vector2New(StartX + (Index - 1) * BaseSize, StartY)
            Image.Color = Color
            Image.Transparency = 1
            Image.Visible = false

            TableInsert(Images, Image)
        end

        if #Images == 0 then return end

        TableInsert(Active, {
            Images = Images,
            WorldPosition = Position,
            StartTime = tick(),
            Duration = Settings.BaseDuration / Settings.SpeedMultiplier,
            Digits = #Images,
            BaseColor = Color
        })
    end

    function DamageNumbers.Update()
        local Count = #Active
        if Count == 0 then return end

        local CurrentTime = tick()
        local CameraPosition = Camera.CFrame.Position

        local BaseSize = Settings.BaseSize
        local BaseHeight = Settings.BaseHeight
        local MinScale = Settings.MinScale
        local MaxScale = Settings.MaxScale
        local RiseHeight = Settings.RiseHeight
        local FadeStartPoint = Settings.FadeStartPoint

        for Index = Count, 1, -1 do
            local Number = Active[Index]
            local ElapsedTime = CurrentTime - Number.StartTime
            local Progress = ElapsedTime / Number.Duration

            if Progress > 1 then
                for _, Image in Number.Images do
                    ReleaseImage(Image)
                end

                TableRemove(Active, Index)
                continue
            end

            local ScreenPosition, OnScreen = WorldToViewportPointCloned(Camera, Number.WorldPosition)

            if not OnScreen then
                for _, Image in Number.Images do
                    Image.Visible = false
                end

                continue
            end

            local DistanceScale = 1

            if Settings.DistanceScalingEnabled then
                local Distance = (CameraPosition - Number.WorldPosition).Magnitude

                local MinDist = Settings.MinDistance
                local MaxDist = Settings.MaxDistance
                local MinDistScale = Settings.MinDistanceScale
                local MaxDistScale = Settings.MaxDistanceScale

                if Distance <= MinDist then
                    DistanceScale = MaxDistScale
                elseif Distance >= MaxDist then
                    DistanceScale = MinDistScale
                else
                    local Alpha = (Distance - MinDist) / (MaxDist - MinDist)
                    DistanceScale = MaxDistScale + Alpha * (MinDistScale - MaxDistScale)
                end
            end

            local CurrentSize = BaseSize * DistanceScale
            local CurrentHeight = BaseHeight * DistanceScale

            local BaseFade = QuartIn(Progress, 0, 1, 1)
            local Transparency = 1 - BaseFade

            local DigitCount = Number.Digits
            local TotalWidth = DigitCount * CurrentSize
            local BaseX = ScreenPosition.X - TotalWidth / 2
            local BaseY = ScreenPosition.Y - 24 - RiseHeight * BaseFade

            for DigitIndex, Image in Number.Images do
                local DigitDuration = 1 + DigitIndex * 0.25

                local Elastic = ElasticOut(ElapsedTime, 0, 1, DigitDuration) - BaseFade
                local Scale = MinScale + Elastic * MaxScale

                local Spacing = CurrentSize * Scale
                local CenterOffset = (DigitCount * Spacing - TotalWidth) / 2

                Image.Position = Vector2New(BaseX + (DigitIndex - 1) * Spacing - CenterOffset, BaseY)
                Image.Size = Vector2New(CurrentSize * Scale, CurrentHeight * Scale)
                Image.Transparency = (Progress > FadeStartPoint and Transparency) or 1
                Image.Color = Number.BaseColor
                Image.Visible = true
            end
        end
    end

    local function IsEnemyPlayer(Player: Player): boolean
        if not FindFirstChildOfClass(Teams, "Team") then return true end

        return Player.Team ~= LocalPlayer.Team
    end

    local LastShotTick = 0

    -- [FIX] 打远处的目标时, 掉血要等 子弹飞行 + 服务器往返 才会传回本地,
    -- 固定窗口会把这些全判成"不是我打的"。这里自动叠加当前 ping。
    local CachedPing = 0

    TaskScheduler:AddLoop('DamageNumbers/Ping', 1, function()
        local Success, Ping = pcall(function()
            return Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
        end)

        CachedPing = (Success and type(Ping) == "number" and Ping / 1000) or 0
    end)

    local function HasFiredRecently(): boolean
        if not Settings.RequireShot then return true end

        if IsMouseButtonPressedCloned(UserInputService, Enum.UserInputType.MouseButton1) then
            return true
        end

        -- [FIX] trigger / auto shoot 开着时: 它用 mouse1click 虚拟开火, 物理键不会按下,
        -- 而它的开火时间戳写在 AutoShoot.LastShot。直接读这个最可靠 (不受两个 Heartbeat
        -- 连接的先后顺序影响), 否则打出去的伤害传回来时窗口常常已经错过 -> 数字几乎不显示。
        local AutoShoot = Visuals.AutoShoot
        if AutoShoot and AutoShoot.Active then
            if (tick() - (AutoShoot.LastShot or 0)) <= (Settings.ShotWindow + CachedPing) then
                return true
            end
        end

        local Recent = MathMax(LastShotTick, DamageNumbers.LastShotTick or 0)
        return (tick() - Recent) <= (Settings.ShotWindow + CachedPing)
    end

    local function ScanTarget(Object: Instance, Character: Instance, IsEnemy: boolean, CanShow: boolean)
        if not Character then return end

        local Humanoid = FindFirstChildOfClass(Character, "Humanoid")
        if not Humanoid then return end

        local Health = Humanoid.Health
        local LastHealth = HealthCache[Character]

        HealthCache[Character] = Health

        local KillParticle = Visuals.KillParticle
        if KillParticle and KillParticle.Settings.Enabled and LastHealth and LastHealth > 0 and Health <= 0 then
            if IsEnemy or KillParticle.Settings.TeamKills then
                if not KillParticle.DeadCache[Character] then
                    KillParticle.DeadCache[Character] = true

                    local KillPart = FindFirstChild(Character, 'UpperTorso')
                        or FindFirstChild(Character, 'Torso')
                        or FindFirstChild(Character, 'HumanoidRootPart')
                        or FindFirstChild(Character, 'Head')

                    if KillPart then
                        KillParticle.OnKill(KillPart.Position)
                    end
                end
            end
        elseif Health > 0 then
            if KillParticle and KillParticle.DeadCache[Character] then
                KillParticle.DeadCache[Character] = nil
            end
        end

        if not CanShow then return end
        if not LastHealth or Health >= LastHealth then return end

        local Damage = MathFloor(LastHealth - Health + 0.5)
        if Damage < Settings.MinDamage then return end

        if not IsEnemy and not Settings.ShowTeamDamage then return end

        local Part = FindFirstChild(Character, 'UpperTorso')
            or FindFirstChild(Character, 'Torso')
            or FindFirstChild(Character, 'HumanoidRootPart')

        if not Part then return end

        local Position = Part.Position

        local LocalCharacter = LocalPlayer.Character
        local LocalRoot = LocalCharacter and FindFirstChild(LocalCharacter, "HumanoidRootPart")
        if LocalRoot and (LocalRoot.Position - Position).Magnitude > Settings.MaxDistance then return end

        local TargetInfo = Aimbot.CurrentTargetInfo
        local IsHeadshot = TargetInfo ~= nil
            and TargetInfo.Target == Object
            and TargetInfo.HitPart ~= nil
            and TargetInfo.HitPart.Name == 'Head'

        if Settings.Enabled then
            DamageNumbers.Show(Damage, Position, IsHeadshot, IsEnemy)
        end

        local HitSound = Visuals.HitSound
        if HitSound and HitSound.Settings.Enabled and HitSound.OnHit then
            HitSound.OnHit(Damage, Position, IsHeadshot, IsEnemy)
        end

        local Tracers = Visuals.Tracers
        if Tracers and Tracers.Settings.Enabled and Tracers.OnHit then
            Tracers.OnHit(Damage, Position, IsHeadshot, IsEnemy)
        end
    end

    function DamageNumbers.Scan()
        if DamageNumbers.LastShotTick and DamageNumbers.LastShotTick > LastShotTick then
            LastShotTick = DamageNumbers.LastShotTick
        end

        local CanShow = HasFiredRecently()

        for _, Player in GetPlayers(Players) do
            if Player == LocalPlayer then continue end

            ScanTarget(Player, Player.Character, IsEnemyPlayer(Player), CanShow)
        end

        for _, Folder in Aimbot.AddedFolders do
            for _, Object in GetChildren(Folder) do
                ScanTarget(Object, Object, true, CanShow)
            end
        end
    end

    TaskScheduler:CreateDelayThread(0, function()
        repeat TaskWait() until Genv.Connection

        Genv.Connection.Add('DamageNumbers/Shot', UserInputService.InputBegan, function(Input, GPE)
            if GPE then return end

            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                LastShotTick = tick()
            end
        end)

        Genv.Connection.Add('DamageNumbers', RunService.Heartbeat, function()
            local DamageOn = Settings.Enabled
            local HitSound = Visuals.HitSound
            local Tracers = Visuals.Tracers
            local KillParticle = Visuals.KillParticle
            local HitSoundOn = HitSound and HitSound.Settings.Enabled
            local TracerOn = Tracers and Tracers.Settings.Enabled
            local KillOn = KillParticle and KillParticle.Settings.Enabled

            if not DamageOn and #Active > 0 then DamageNumbers.Clear() end
            if Tracers and not TracerOn and #Tracers.Active > 0 and Tracers.Clear then Tracers.Clear() end

            if DamageOn or HitSoundOn or TracerOn or KillOn then
                DamageNumbers.Scan()
            end

            if DamageOn then DamageNumbers.Update() end
            if TracerOn and Tracers.Update then Tracers.Update() end
        end)
    end)
end

--

do -- Visuals.HitSound
    local HitSound = Visuals.HitSound
    local Settings = HitSound.Settings

    local Sound = {
        Pool = HitSound.Pool,
        PoolSize = 6,
        Directory = "dreamybull.club/HitSounds",
        BundledLabel = "bundled bell",
        AudioExtensions = { mp3 = true, wav = true, ogg = true, flac = true, m4a = true, aac = true },
    }

    HitSound.FileMap = {}

    function Sound.ExtensionOf(Path)
        return (Path:match("%.([%w]+)$") or ""):lower()
    end

    function Sound.NameOf(Path)
        return Path:match("[^/\\]+$") or Path
    end

    function Sound.EnsurePool()
        for Index = #Sound.Pool + 1, Sound.PoolSize do
            local Instance = InstanceNew("Sound")
            Instance.Parent = SoundService
            Sound.Pool[Index] = Instance
        end
    end

    -- 用池里的下一个 Sound 播放指定 Id (供命中和试听共用)
    function Sound.PlayId(SoundId, Volume, PlaybackSpeed)
        if not SoundId or SoundId == "" then return end

        Sound.EnsurePool()
        HitSound.PoolIndex = (HitSound.PoolIndex % Sound.PoolSize) + 1

        local Instance = Sound.Pool[HitSound.PoolIndex]
        if Instance.SoundId ~= SoundId then Instance.SoundId = SoundId end
        Instance.Volume, Instance.PlaybackSpeed, Instance.TimePosition = Volume, PlaybackSpeed, 0
        Instance:Play()
    end

    function Sound.ScanFiles()
        local Map = {}
        local Names = { Sound.BundledLabel }

        local ListFiles = Genv.listfiles
        if ListFiles then
            pcall(function()
                if MakeFolder and not (IsFolder and IsFolder(Sound.Directory)) then
                    pcall(MakeFolder, "dreamybull.club")
                    pcall(MakeFolder, Sound.Directory)
                end
            end)

            local Success, Files = pcall(ListFiles, Sound.Directory)
            if Success and type(Files) == "table" then
                for _, Path in ipairs(Files) do
                    if Sound.AudioExtensions[Sound.ExtensionOf(Path)] then
                        local Name = Sound.NameOf(Path)
                        Map[Name] = Path
                        TableInsert(Names, Name)
                    end
                end
            end
        end

        HitSound.FileMap = Map
        return Names
    end

    function Sound.SelectFile(Name)
        if (not Name) or Name == Sound.BundledLabel then return end

        local Path = HitSound.FileMap[Name]
        if not (Path and GetCustomAsset) then return false end

        local Success, Asset = pcall(GetCustomAsset, Path)
        if Success and Asset then
            Settings.HitSoundId = Asset
            return true
        end

        return false
    end

    function Sound.Preview()
        Sound.PlayId(Settings.HitSoundId, Settings.Volume, Settings.PlaybackSpeed)
    end

    function Sound.OnHit(Damage: number, Position: Vector3, IsHeadshot: boolean, IsEnemy: boolean)
        local UseHeadshot = IsHeadshot and Settings.UseHeadshotSound
        local HasHeadshotSound = Settings.HeadshotSoundId and Settings.HeadshotSoundId ~= ""

        local SoundId = (UseHeadshot and HasHeadshotSound and Settings.HeadshotSoundId) or Settings.HitSoundId

        local PlaybackSpeed = Settings.PlaybackSpeed
        if UseHeadshot and not HasHeadshotSound then
            PlaybackSpeed = PlaybackSpeed * Settings.HeadshotPitch
        end

        Sound.PlayId(SoundId, Settings.Volume, PlaybackSpeed)
    end

    HitSound.ScanFiles = Sound.ScanFiles
    HitSound.SelectFile = Sound.SelectFile
    HitSound.Preview = Sound.Preview
    HitSound.OnHit = Sound.OnHit
end

--

do -- Visuals.Tracers
    local Tracers = Visuals.Tracers
    local Settings = Tracers.Settings
    local Active = Tracers.Active

    local T = {
        Pools = { Line = Tracers.LinePool, Outline = Tracers.OutlinePool, Beam = Tracers.BeamPool },
        Anchor = nil,
    }

    function T.EnsureAnchor()
        if T.Anchor and T.Anchor.Parent then return T.Anchor end

        local Part = InstanceNew("Part")
        Part.Anchored, Part.CanCollide, Part.CanQuery, Part.CanTouch, Part.Locked = true, false, false, false, true
        Part.Transparency = 1
        Part.Size = Vector3New(0.05, 0.05, 0.05)
        Part.CFrame = CFrameNew(0, 0, 0)
        Part.Parent = Workspace

        T.Anchor = Part
        return Part
    end

    T.Factory = {
        Line = function()
            local L = DrawingNew("Line"); L.ZIndex = 90; return L
        end,
        Outline = function()
            local L = DrawingNew("Line"); L.ZIndex = 89; L.Color = Color3New(0, 0, 0); return L
        end,
        Beam = function()
            local Anchor = T.EnsureAnchor()
            local A0 = InstanceNew("Attachment"); A0.Parent = Anchor
            local A1 = InstanceNew("Attachment"); A1.Parent = Anchor
            local B = InstanceNew("Beam")
            B.TextureMode, B.LightInfluence, B.FaceCamera = BeamTracerConfig.TextureMode, 0, true
            B.Attachment0, B.Attachment1, B.Enabled = A0, A1, false
            B.Parent = Workspace
            return { A0 = A0, A1 = A1, Beam = B }
        end,
    }

    function T.Acquire(Kind)
        local Pool = T.Pools[Kind]
        local Count = #Pool

        if Count > 0 then
            local Obj = Pool[Count]; Pool[Count] = nil
            return Obj
        end

        return T.Factory[Kind]()
    end

    function T.Release(Entry)
        if Entry.Line then Entry.Line.Visible = false; TableInsert(T.Pools.Line, Entry.Line) end
        if Entry.Outline then Entry.Outline.Visible = false; TableInsert(T.Pools.Outline, Entry.Outline) end
        if Entry.Beam then Entry.Beam.Beam.Enabled = false; TableInsert(T.Pools.Beam, Entry.Beam) end
    end

    function T.BeamColor(C, Tint)
        if not Tint then return ColorSequenceNew(C) end

        return ColorSequenceNew({
            ColorSequenceKeypointNew(0, Color3New(0, 0, 0)),
            ColorSequenceKeypointNew(0.15, C),
            ColorSequenceKeypointNew(0.85, C),
            ColorSequenceKeypointNew(1, Color3New(0, 0, 0)),
        })
    end

    function T.OriginWorld(Mode)
        if Mode == 'Head' then
            local Char = LocalPlayer.Character
            local Part = Char and (FindFirstChild(Char, "Head") or FindFirstChild(Char, "HumanoidRootPart"))
            if Part then return Part.Position end
        end

        return (Camera.CFrame * CFrameNew(0.6, -0.7, -1.2)).Position
    end

    T.Segments = 20

    Tracers.Clear = function()
        for Index = #Active, 1, -1 do
            T.Release(Active[Index])
            Active[Index] = nil
        end
    end

    Tracers.OnHit = function(Damage: number, Position: Vector3, IsHeadshot: boolean, IsEnemy: boolean)
        local Entry = {
            Style = Settings.Style,
            WorldPos = Position,
            OriginWorldPos = T.OriginWorld(Settings.OriginMode),
            OriginMode = Settings.OriginMode,
            Color = Settings.Color,
            StartTime = tick(),
            Lifetime = Settings.Lifetime,
        }

        if Settings.Style == 'Beam' then
            local Bundle = T.Acquire("Beam")
            Bundle.A0.Position = Entry.OriginWorldPos
            Bundle.A1.Position = Position

            local B = Bundle.Beam
            local BeamIdx = TableFind(BeamTextureNames, Settings.BeamTexture)
            B.Texture = (BeamIdx and BeamTextures[BeamIdx][2]) or ""
            B.LightEmission = Settings.BeamLightEmission
            B.Width0, B.Width1 = Settings.BeamWidth0, Settings.BeamWidth1
            B.Color = T.BeamColor(Settings.Color, Settings.BeamTintEnds)
            B.Transparency = NumberSequenceNew(0)
            B.Enabled = true

            Entry.Beam = Bundle
        else
            Entry.Outline = T.Acquire("Outline")
            Entry.Line = T.Acquire("Line")
            Entry.Line.Color = Settings.Color
        end

        TableInsert(Active, Entry)
    end

    function T.Step(Entry, Progress)
        if Entry.Style == 'Beam' then
            local Fade = (Progress < 0.6) and 0 or ((Progress - 0.6) / 0.4)
            Entry.Beam.Beam.Transparency = NumberSequenceNew(Fade)
            return
        end

        local Line, Outline = Entry.Line, Entry.Outline

        -- [FIX] 照抄参考渲染: 沿世界线 Origin->命中点 取样 N 段,
        -- 只保留在相机前方 (ScreenPoint.Z > 0) 的部分, 从"第一个可见点"画到"最后一个可见点"。
        -- 这样相机往前移时线会在近裁剪面处被裁掉, 而不是整条消失或把起点吸到屏幕底部。
        local Origin = Entry.OriginWorldPos
        local LineVector = Entry.WorldPos - Origin
        local Length = LineVector.Magnitude

        if Length <= 0 then
            Line.Visible = false
            Outline.Visible = false
            return
        end

        local Direction = LineVector.Unit
        local Segments = T.Segments
        local SegmentLength = Length / Segments

        local VisibleStart, VisibleEnd

        for i = 0, Segments do
            local Point = Origin + Direction * (i * SegmentLength)
            local ScreenPoint = WorldToViewportPointCloned(Camera, Point)

            if ScreenPoint.Z > 0 then
                if not VisibleStart then VisibleStart = Point end
                VisibleEnd = Point
            end
        end

        if not (VisibleStart and VisibleEnd) then
            Line.Visible = false
            Outline.Visible = false
            return
        end

        local StartScreen = WorldToViewportPointCloned(Camera, VisibleStart)
        local EndScreen = WorldToViewportPointCloned(Camera, VisibleEnd)

        local Alpha = 1 - Progress
        local FromV = Vector2New(StartScreen.X, StartScreen.Y)
        local ToV = Vector2New(EndScreen.X, EndScreen.Y)

        Outline.From, Outline.To = FromV, ToV
        Outline.Thickness = Settings.Thickness + 2
        Outline.Transparency = Alpha
        Outline.Visible = true

        Line.From, Line.To = FromV, ToV
        Line.Color = Entry.Color
        Line.Thickness = Settings.Thickness
        Line.Transparency = Alpha
        Line.Visible = true
    end

    Tracers.Update = function()
        local Count = #Active
        if Count == 0 then return end

        local Now = tick()

        for Index = Count, 1, -1 do
            local Entry = Active[Index]
            local Progress = (Now - Entry.StartTime) / Entry.Lifetime

            if Progress >= 1 then
                T.Release(Entry)
                TableRemove(Active, Index)
                continue
            end

            T.Step(Entry, Progress)
        end
    end
end
--

do -- Visuals.KillParticle
    local KillParticle = Visuals.KillParticle
    local Settings = KillParticle.Settings
    local Active = KillParticle.Active

    local K = {}

    function K.ScaleSequence(Sequence, Scale)
        local Keypoints = {}
        for _, Keypoint in ipairs(Sequence.Keypoints) do
            Keypoints[#Keypoints + 1] = NumberSequenceKeypointNew(
                Keypoint.Time,
                Keypoint.Value * Scale,
                Keypoint.Envelope * Scale
            )
        end
        return NumberSequenceNew(Keypoints)
    end

    function K.Anchor(Position)
        local Part = InstanceNew("Part")
        Part.Anchored, Part.CanCollide, Part.CanQuery, Part.CanTouch, Part.Locked = true, false, false, false, true
        Part.Transparency = 1
        Part.Size = Vector3New(0.1, 0.1, 0.1)
        Part.CFrame = CFrameNew(Position)
        Part.Parent = Workspace
        return Part
    end

    K.Styles = {}

    function K.Styles.Sparks(Origin, Color, Scale)
        local Part = K.Anchor(Origin)
        local Attachment = InstanceNew("Attachment")
        Attachment.Parent = Part

        local Shards = InstanceNew("ParticleEmitter")
        Shards.Brightness = 4
        Shards.Color = ColorSequenceNew(Color)
        Shards.Drag = 7.5
        Shards.Lifetime = NumberRangeNew(0.5, 1)
        Shards.Orientation = Enum.ParticleOrientation.VelocityParallel
        Shards.Rate = 0
        Shards.Rotation = NumberRangeNew(90, 90)
        Shards.Size = K.ScaleSequence(NumberSequenceNew({
            NumberSequenceKeypointNew(0, 0),
            NumberSequenceKeypointNew(0.24537815153598785, 0.675000011920929),
            NumberSequenceKeypointNew(1, 0),
        }), Scale)
        Shards.Speed = NumberRangeNew(10, 15)
        Shards.SpreadAngle = Vector2New(-360, 360)
        Shards.Squash = NumberSequenceNew(0.10999999940395355)
        Shards.Texture = "rbxassetid://8030734851"
        Shards.Parent = Attachment

        local Slash = InstanceNew("ParticleEmitter")
        Slash.Brightness = 4
        Slash.Color = ColorSequenceNew(Color)
        Slash.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
        Slash.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
        Slash.Lifetime = NumberRangeNew(0.8, 1.5)
        Slash.LightEmission = 1
        Slash.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
        Slash.Rate = 0
        Slash.RotSpeed = NumberRangeNew(-360, 360)
        Slash.Rotation = NumberRangeNew(-180, 180)
        Slash.Size = K.ScaleSequence(NumberSequenceNew({
            NumberSequenceKeypointNew(0, 1.6918035745620728),
            NumberSequenceKeypointNew(0.45546218752861023, 2.3400001525878906),
            NumberSequenceKeypointNew(0.7042016983032227, 1.350000023841858),
            NumberSequenceKeypointNew(1, 1.2600001096725464),
        }), Scale)
        Slash.Speed = NumberRangeNew(2.880000114440918, 4.320000171661377)
        Slash.SpreadAngle = Vector2New(6, 6)
        Slash.Texture = "rbxassetid://17853203150"
        Slash.TimeScale = 0.7
        Slash.Parent = Attachment

        local Sparkles = InstanceNew("ParticleEmitter")
        Sparkles.Acceleration = Vector3New(0, 18, 0)
        Sparkles.Brightness = 5
        Sparkles.Color = ColorSequenceNew(Color)
        Sparkles.Drag = 6
        Sparkles.EmissionDirection = Enum.NormalId.Back
        Sparkles.FlipbookFramerate = NumberRangeNew(0, 0)
        Sparkles.FlipbookMode = Enum.ParticleFlipbookMode.Random
        Sparkles.Lifetime = NumberRangeNew(0.2, 0.5)
        Sparkles.LightEmission = 1
        Sparkles.Rate = 0
        Sparkles.RotSpeed = NumberRangeNew(-100, 100)
        Sparkles.Rotation = NumberRangeNew(0, 360)
        Sparkles.ShapeInOut = Enum.ParticleEmitterShapeInOut.Inward
        Sparkles.ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface
        Sparkles.Size = K.ScaleSequence(NumberSequenceNew({
            NumberSequenceKeypointNew(0, 0),
            NumberSequenceKeypointNew(0.48067227005958557, 0.5114758014678955),
            NumberSequenceKeypointNew(1, 0),
        }), Scale)
        Sparkles.Speed = NumberRangeNew(10.8, 18)
        Sparkles.SpreadAngle = Vector2New(360, 360)
        Sparkles.Texture = "rbxassetid://10598374841"
        Sparkles.TimeScale = 0.8
        Sparkles.ZOffset = -1
        Sparkles.Parent = Attachment

        Shards:Emit(12)
        Slash:Emit(3)
        Sparkles:Emit(20)

        return Part
    end

    function K.Styles.Dots(Origin, Color, Scale)
        local Part = K.Anchor(Origin)

        local Emitter = InstanceNew("ParticleEmitter")
        Emitter.Texture = "rbxassetid://124005197513236"
        Emitter.Lifetime = NumberRangeNew(0.875, 2.125)
        Emitter.Brightness = 20
        Emitter.ZOffset = 0.8
        Emitter.Rate = 18
        Emitter.Rotation = NumberRangeNew(-360, 360)
        Emitter.RotSpeed = NumberRangeNew(-80, 80)
        Emitter.SpreadAngle = Vector2New(-90, 90)
        Emitter.Speed = NumberRangeNew(7.2, 16)
        Emitter.EmissionDirection = Enum.NormalId.Top
        Emitter.Shape = Enum.ParticleEmitterShape.Box
        Emitter.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
        Emitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
        Emitter.Drag = 4.4
        Emitter.LockedToPart = false
        Emitter.Color = ColorSequenceNew(Color)
        Emitter.Acceleration = Vector3New(0, 0, 0)
        Emitter.Size = NumberSequenceNew(Scale)
        Emitter.Parent = Part

        Emitter:Emit(1)
        Emitter.Transparency = NumberSequenceNew({
            NumberSequenceKeypointNew(0, 0),
            NumberSequenceKeypointNew(1, 0.7),
        })

        return Part
    end

    function K.Styles.Catalyst(Origin, Color, Scale)
        local Part = K.Anchor(Origin)

        local Emitter = InstanceNew("ParticleEmitter")
        Emitter.Texture = "rbxassetid://12602224662"
        Emitter.Lifetime = NumberRangeNew(1, 1)
        Emitter.Rate = 3
        Emitter.Rotation = NumberRangeNew(-1000, 1000)
        Emitter.RotSpeed = NumberRangeNew(-10, 10)
        Emitter.SpreadAngle = Vector2New(-1000, 1000)
        Emitter.Speed = NumberRangeNew(0, 0)
        Emitter.EmissionDirection = Enum.NormalId.Top
        Emitter.Shape = Enum.ParticleEmitterShape.Box
        Emitter.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
        Emitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
        Emitter.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid8x8
        Emitter.FlipbookBlendFrames = true
        Emitter.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
        Emitter.Drag = 1
        Emitter.LockedToPart = false
        Emitter.Color = ColorSequenceNew(Color)
        Emitter.Acceleration = Vector3New(0, 0, 0)
        Emitter.Size = NumberSequenceNew(Scale)
        Emitter.Parent = Part

        Emitter:Emit(1)
        Emitter.Transparency = NumberSequenceNew({
            NumberSequenceKeypointNew(0, 0),
            NumberSequenceKeypointNew(1, 0.7),
        })

        return Part
    end

    function K.Styles.Mist(Origin, Color, Scale)
        local Part = K.Anchor(Origin)

        local Emitter = InstanceNew("ParticleEmitter")
        Emitter.Texture = "rbxassetid://12830011666"
        Emitter.Lifetime = NumberRangeNew(0.5, 0.5)
        Emitter.RotSpeed = NumberRangeNew(10, 100)
        Emitter.Speed = NumberRangeNew(0, 0)
        Emitter.Brightness = 20
        Emitter.SpreadAngle = Vector2New(-180, 180)
        Emitter.Size = K.ScaleSequence(NumberSequenceNew({
            NumberSequenceKeypointNew(0, 0.18),
            NumberSequenceKeypointNew(0.192, 0.0625),
            NumberSequenceKeypointNew(0.408, 2.75),
            NumberSequenceKeypointNew(1, 6),
        }), Scale)
        Emitter.Color = ColorSequenceNew(Color)
        Emitter.LightEmission = 540
        Emitter.VelocitySpread = 0
        Emitter.Enabled = true
        Emitter.EmissionDirection = Enum.NormalId.Top
        Emitter.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid1x1
        Emitter.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
        Emitter.Shape = Enum.ParticleEmitterShape.Box
        Emitter.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
        Emitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
        Emitter.ZOffset = 2.5
        Emitter.Rate = 0.5
        Emitter.Parent = Part

        Emitter:Emit(1)
        Emitter.Transparency = NumberSequenceNew({
            NumberSequenceKeypointNew(0, 0),
            NumberSequenceKeypointNew(1, 0.7),
        })

        return Part
    end

    function K.Styles.Chiral(Origin, Color, Scale)
        local Part = K.Anchor(Origin)

        local Emitter = InstanceNew("ParticleEmitter")
        Emitter.Texture = "rbxassetid://15011464541"
        Emitter.Lifetime = NumberRangeNew(3, 3)
        Emitter.Rate = 3
        Emitter.Rotation = NumberRangeNew(-1000, 1000)
        Emitter.RotSpeed = NumberRangeNew(-10, 10)
        Emitter.SpreadAngle = Vector2New(-1000, 1000)
        Emitter.Speed = NumberRangeNew(0, 0)
        Emitter.EmissionDirection = Enum.NormalId.Top
        Emitter.Shape = Enum.ParticleEmitterShape.Box
        Emitter.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
        Emitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
        Emitter.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid8x8
        Emitter.FlipbookBlendFrames = true
        Emitter.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
        Emitter.Drag = 1
        Emitter.LockedToPart = false
        Emitter.Color = ColorSequenceNew(Color)
        Emitter.Acceleration = Vector3New(0, 0, 0)
        Emitter.Size = NumberSequenceNew(Scale)
        Emitter.Parent = Part

        Emitter:Emit(1)
        Emitter.Transparency = NumberSequenceNew({
            NumberSequenceKeypointNew(0, 0),
            NumberSequenceKeypointNew(1, 0.7),
        })

        return Part
    end

    function K.Spawn(Position)
        local Builder = K.Styles[Settings.Style] or K.Styles.Sparks
        local Scale = MathMax(Settings.Scale, 0.1)

        local Part = Builder(Position, Settings.Color, Scale)
        TableInsert(Active, { Part = Part, DeathTime = tick() })
    end

    function K.Update()
        local Count = #Active
        if Count == 0 then return end

        local Now = tick()

        for Index = Count, 1, -1 do
            local Effect = Active[Index]

            if Now - Effect.DeathTime < Settings.Lifetime then
                continue
            end

            pcall(Destroy, Effect.Part)
            TableRemove(Active, Index)
        end
    end

    function KillParticle.Clear()
        for Index = #Active, 1, -1 do
            pcall(Destroy, Active[Index].Part)
            Active[Index] = nil
        end
    end

    KillParticle.OnKill = K.Spawn
    KillParticle.Update = K.Update

    TaskScheduler:CreateDelayThread(0, function()
        repeat TaskWait() until Genv.Connection

        Genv.Connection.Add('KillParticle', RunService.Heartbeat, function()
            if not Settings.Enabled and #Active > 0 then KillParticle.Clear() end
            K.Update()
        end)
    end)
end

--

do -- Visuals.AutoShoot
    local AutoShoot = Visuals.AutoShoot

    local T = {
        Params = RaycastParamsNew(),
        Ignore = {},
    }
    T.Params.FilterType = Enum.RaycastFilterType.Exclude
    T.Params.IgnoreWater = true

    function T.Shoot()
        if Mouse1Click then
            return Mouse1Click()
        end

        if not Mouse1Press or not Mouse1Release then return end

        Mouse1Press()
        TaskScheduler:CreateDelayThread(1/60, Mouse1Release)
    end

    function T.CharacterFromPart(Part)
        local Current = Part

        for _ = 1, 3 do
            if not Current or Current == Workspace then return nil end

            local Humanoid = FindFirstChildOfClass(Current, "Humanoid")
            if Humanoid then return Current, Humanoid end

            Current = Current.Parent
        end

        return nil
    end

    function T.PassesTeamCheck(Character)
        if not AutoShoot.CrosshairTeamCheck then return true end
        if not IsA(Character, "Model") then return true end

        local TargetPlayer = GetPlayerFromCharacter(Players, Character)
        if TargetPlayer and FindFirstChildOfClass(Teams, "Team") and TargetPlayer.Team == LocalPlayer.Team then
            return false
        end

        return true
    end

    function T.CharacterUnderCrosshair()
        local Origin = Camera.CFrame.Position
        local Direction = Camera.CFrame.LookVector * AutoShoot.CrosshairMaxDistance

        local Ignore = T.Ignore
        TableClear(Ignore)

        local LocalCharacter = LocalPlayer.Character
        if LocalCharacter then TableInsert(Ignore, LocalCharacter) end
        TableInsert(Ignore, Camera)

        T.Params.FilterDescendantsInstances = Ignore

        for _ = 1, 10 do
            local Result = RaycastCloned(Workspace, Origin, Direction, T.Params)
            if not Result then return nil end

            local Character, Humanoid = T.CharacterFromPart(Result.Instance)
            if Character then return Character, Humanoid end

            TableInsert(Ignore, Result.Instance)
            T.Params.FilterDescendantsInstances = Ignore
        end

        return nil
    end

    function T.CrosshairValid()
        local Character, Humanoid = T.CharacterUnderCrosshair()
        if not Character or Humanoid.Health <= 0 then return false end
        if not T.PassesTeamCheck(Character) then return false end

        if AutoShoot.CrosshairWallCheck then
            local Part = FindFirstChild(Character, "HumanoidRootPart")
                or FindFirstChild(Character, "Torso")
                or FindFirstChild(Character, "UpperTorso")
            if not Part then return false end

            local Origin = Camera.CFrame.Position
            local ScanOrigin = Aimbot.VisibleCheckSettings.ScanOrigin
            if ScanOrigin == 'Head' then
                local LocalCharacter = LocalPlayer.Character
                local LocalPart = LocalCharacter and (FindFirstChild(LocalCharacter, 'Head') or FindFirstChild(LocalCharacter, 'HumanoidRootPart'))
                if LocalPart then Origin = LocalPart.Position end
            end

            if not Aimbot:IsVisible(Character, Origin, Part.Position, Aimbot.VisibleCheckSettings) then
                return false
            end
        end

        return true
    end

    function T.ShouldShoot()
        if AutoShoot.Mode == "Crosshair" then
            return T.CrosshairValid()
        end

        return Aimbot.Enabled and Aimbot.CurrentTargetInfo ~= nil
    end

    TaskScheduler:CreateDelayThread(0, function()
        repeat TaskWait() until Genv.Connection

        Genv.Connection.Add('AutoShoot', RunService.Heartbeat, function()
            if not AutoShoot.Active then return end

            local WindowItem = Genv.Library and Genv.Library.WindowItem
            if WindowItem and WindowItem.IsOpen then return end

            local NewTick = tick()
            if NewTick - AutoShoot.LastShot < AutoShoot.Delay then return end

            if not T.ShouldShoot() then return end

            T.Shoot()

            AutoShoot.LastShot = NewTick
            Visuals.DamageNumbers.LastShotTick = NewTick
        end)
    end)
end

--

local Environment = { Enabled = false } do
    local Setting = false

    local function ReadLighting(Property, Fallback)
        local Success, Value = pcall(function() return Lighting[Property] end)
        if Success and Value ~= nil then return Value end
        return Fallback
    end

    local LightingGroups = {
        Lighting = { "Brightness", "ClockTime", "ExposureCompensation", "EnvironmentDiffuseScale", "EnvironmentSpecularScale", "GlobalShadows" },
        Colors = { "Ambient", "OutdoorAmbient", "ColorShift_Top", "ColorShift_Bottom" },
        Fog = { "FogColor", "FogStart", "FogEnd" },
    }

    local AtmosphereProps = { "Density", "Offset", "Glare", "Haze", "Color", "Decay" }

    Environment.Values = {
        Brightness = ReadLighting("Brightness", 2),
        ClockTime = ReadLighting("ClockTime", 14),
        ExposureCompensation = ReadLighting("ExposureCompensation", 0),
        EnvironmentDiffuseScale = ReadLighting("EnvironmentDiffuseScale", 1),
        EnvironmentSpecularScale = ReadLighting("EnvironmentSpecularScale", 1),
        GlobalShadows = ReadLighting("GlobalShadows", true),

        Ambient = ReadLighting("Ambient", Color3FromRGB(0, 0, 0)),
        OutdoorAmbient = ReadLighting("OutdoorAmbient", Color3FromRGB(128, 128, 128)),
        ColorShift_Top = ReadLighting("ColorShift_Top", Color3FromRGB(0, 0, 0)),
        ColorShift_Bottom = ReadLighting("ColorShift_Bottom", Color3FromRGB(0, 0, 0)),

        FogColor = ReadLighting("FogColor", Color3FromRGB(191, 191, 191)),
        FogStart = ReadLighting("FogStart", 0),
        FogEnd = ReadLighting("FogEnd", 100000),

        Technology = "Keep",
    }

    Environment.Atmo = {
        Density = 0.3,
        Offset = 0.25,
        Glare = 0,
        Haze = 0,
        Color = Color3FromRGB(199, 170, 107),
        Decay = Color3FromRGB(106, 112, 125),
    }

    do
        local Existing = FindFirstChildOfClass(Lighting, "Atmosphere")
        if Existing then
            for _, Property in ipairs(AtmosphereProps) do
                local Success, Value = pcall(function() return Existing[Property] end)
                if Success and Value ~= nil then Environment.Atmo[Property] = Value end
            end
        end
    end

    Environment.Groups = { Lighting = false, Colors = false, Fog = false, Atmosphere = false }
    Environment.ActiveProps = {}
    Environment.Cache = nil
    Environment.LightingConn = nil

    Environment.Atmosphere = nil
    Environment.AtmosphereCreated = false
    Environment.AtmosphereCache = nil
    Environment.AtmosphereConn = nil

    Environment.TechOriginal = nil
    Environment.TechCacheValid = false
    Environment.TechChanged = false

    Environment.SkyOn = false
    Environment.SkyPreset = "purple galaxy"
    Environment.OurSky = nil
    Environment.StashedSky = nil

    local function WriteLighting(Property, Value)
        if Value == nil then return end
        Setting = true
        pcall(function() Lighting[Property] = Value end)
        Setting = false
    end

    local function ApplyProp(Property)
        WriteLighting(Property, Environment.Values[Property])
    end

    local function RestoreProp(Property)
        if Environment.Cache then
            WriteLighting(Property, Environment.Cache[Property])
        end
    end

    --// Technology
    local function ApplyTechnology()
        local Name = Environment.Values.Technology

        if Name == "Keep" then
            if Environment.TechChanged and Environment.TechCacheValid and SetHiddenProperty then
                pcall(SetHiddenProperty, Lighting, "Technology", Environment.TechOriginal)
            end
            Environment.TechChanged = false
            return
        end

        if not SetHiddenProperty then return end

        local Ok, EnumItem = pcall(function() return Enum.Technology[Name] end)
        if not Ok or not EnumItem then return end

        local Success = pcall(SetHiddenProperty, Lighting, "Technology", EnumItem)
        if not Success then
            pcall(SetHiddenProperty, Lighting, "Technology", EnumItem.Value) -- 有些执行器要数值
        end

        Environment.TechChanged = true
    end

    --// Atmosphere
    local function OnAtmosphereChanged(Property)
        if Setting then return end
        if not Environment.Enabled or not Environment.Groups.Atmosphere then return end

        local Atmosphere = Environment.Atmosphere
        if not Atmosphere then return end

        local Desired = Environment.Atmo[Property]
        if Desired == nil then return end

        local Success, Current = pcall(function() return Atmosphere[Property] end)
        if Success and Current ~= Desired then
            Setting = true
            pcall(function() Atmosphere[Property] = Desired end)
            Setting = false
        end
    end

    local function EnableAtmosphere()
        local Atmosphere = FindFirstChildOfClass(Lighting, "Atmosphere")

        if Atmosphere then
            Environment.AtmosphereCreated = false
            Environment.AtmosphereCache = {}
            for _, Property in ipairs(AtmosphereProps) do
                local Success, Value = pcall(function() return Atmosphere[Property] end)
                if Success then Environment.AtmosphereCache[Property] = Value end
            end
        else
            Atmosphere = InstanceNew("Atmosphere")
            Atmosphere.Parent = Lighting
            Environment.AtmosphereCreated = true
            Environment.AtmosphereCache = nil
        end

        Environment.Atmosphere = Atmosphere

        Setting = true
        for _, Property in ipairs(AtmosphereProps) do
            pcall(function() Atmosphere[Property] = Environment.Atmo[Property] end)
        end
        Setting = false

        Environment.AtmosphereConn = Atmosphere.Changed:Connect(OnAtmosphereChanged)
    end

    local function DisableAtmosphere()
        if Environment.AtmosphereConn then
            Environment.AtmosphereConn:Disconnect()
            Environment.AtmosphereConn = nil
        end

        local Atmosphere = Environment.Atmosphere
        if Atmosphere then
            if Environment.AtmosphereCreated then
                pcall(Destroy, Atmosphere)
            elseif Environment.AtmosphereCache then
                Setting = true
                for Property, Value in pairs(Environment.AtmosphereCache) do
                    pcall(function() Atmosphere[Property] = Value end)
                end
                Setting = false
            end
        end

        Environment.Atmosphere = nil
        Environment.AtmosphereCreated = false
        Environment.AtmosphereCache = nil
    end

    local function OnLightingChanged(Property)
        if Setting then return end
        if not Environment.Enabled then return end
        if not Environment.ActiveProps[Property] then return end

        local Desired = Environment.Values[Property]
        if Desired == nil then return end

        local Success, Current = pcall(function() return Lighting[Property] end)
        if Success and Current ~= Desired then
            Setting = true
            pcall(function() Lighting[Property] = Desired end)
            Setting = false
        end
    end

    local function ApplyGroup(GroupName, On)
        local Props = LightingGroups[GroupName]
        if not Props then return end

        for _, Property in ipairs(Props) do
            if On then
                Environment.ActiveProps[Property] = true
                ApplyProp(Property)
            else
                Environment.ActiveProps[Property] = nil
                RestoreProp(Property)
            end
        end
    end

    -- //skyboxes
    local function ApplySkyProps(Sky, Preset)
        for Key, Value in pairs(Preset) do
            if Key ~= "Name" then
                pcall(function() Sky[Key] = Value end)
            end
        end
    end

    local function EnableSky()
        local Existing = FindFirstChildOfClass(Lighting, "Sky")
        if Existing and Existing ~= Environment.OurSky then
            Environment.StashedSky = Existing
            pcall(function() Existing.Parent = nil end)
        end

        if not Environment.OurSky then
            Environment.OurSky = InstanceNew("Sky")
        end

        local SkyIdx = TableFind(SkyboxNames, Environment.SkyPreset)
        local Preset = SkyIdx and SkyboxPresets[SkyIdx]
        if Preset then ApplySkyProps(Environment.OurSky, Preset) end
        pcall(function() Environment.OurSky.Parent = Lighting end)
    end

    local function DisableSky()
        if Environment.OurSky then
            pcall(Destroy, Environment.OurSky)
            Environment.OurSky = nil
        end
        if Environment.StashedSky then
            pcall(function() Environment.StashedSky.Parent = Lighting end)
            Environment.StashedSky = nil
        end
    end

    function Environment:Enable()
        if self.Enabled then return end

        self.Cache = {}

        for _, Props in pairs(LightingGroups) do
            for _, Property in ipairs(Props) do
                local Success, Value = pcall(function() return Lighting[Property] end)
                if Success then self.Cache[Property] = Value end
            end
        end

        self.TechCacheValid = false

        if GetHiddenProperty then
            local Success, Value = pcall(GetHiddenProperty, Lighting, "Technology")
            if Success then
                self.TechOriginal = Value
                self.TechCacheValid = true
            end
        end

        self.Enabled = true

        for GroupName in pairs(LightingGroups) do
            if self.Groups[GroupName] then
                ApplyGroup(GroupName, true)
            end
        end

        ApplyTechnology()

        if self.Groups.Atmosphere then
            EnableAtmosphere()
        end

        if self.SkyOn then
            EnableSky()
        end

        self.LightingConn = Lighting.Changed:Connect(OnLightingChanged)
    end

    function Environment:Disable()
        if not self.Enabled then return end

        self.Enabled = false

        if self.LightingConn then
            self.LightingConn:Disconnect()
            self.LightingConn = nil
        end

        DisableAtmosphere()
        DisableSky()

        if self.TechChanged and self.TechCacheValid and SetHiddenProperty then
            pcall(SetHiddenProperty, Lighting, "Technology", self.TechOriginal)
        end

        self.TechChanged = false

        if self.Cache then
            Setting = true

            for Property, Value in pairs(self.Cache) do
                pcall(function() Lighting[Property] = Value end)
            end

            Setting = false
        end

        self.Cache = nil
        self.ActiveProps = {}
    end

    function Environment:SetEnabled(On)
        if On then self:Enable() else self:Disable() end
    end

    function Environment:SetGroup(GroupName, On)
        self.Groups[GroupName] = On
        if not self.Enabled then return end

        if GroupName == "Atmosphere" then
            if On then EnableAtmosphere() else DisableAtmosphere() end
            return
        end

        ApplyGroup(GroupName, On)
    end

    function Environment:Set(Property, Value)
        self.Values[Property] = Value
        if self.Enabled and self.ActiveProps[Property] then
            ApplyProp(Property)
        end
    end

    function Environment:SetTechnology(Name)
        self.Values.Technology = Name
        if self.Enabled then ApplyTechnology() end
    end

    function Environment:SetAtmo(Property, Value)
        self.Atmo[Property] = Value
        if self.Enabled and self.Groups.Atmosphere and self.Atmosphere then
            Setting = true
            pcall(function() self.Atmosphere[Property] = Value end)
            Setting = false
        end
    end

    function Environment:SetSky(On)
        self.SkyOn = On
        if not self.Enabled then return end
        if On then EnableSky() else DisableSky() end
    end

    function Environment:SetSkyPreset(Name)
        self.SkyPreset = Name
        if self.Enabled and self.SkyOn and self.OurSky then
            local SkyIdx = TableFind(SkyboxNames, Name)
            local Preset = SkyIdx and SkyboxPresets[SkyIdx]
            if Preset then ApplySkyProps(self.OurSky, Preset) end
        end
    end

    Visuals.Environment = Environment
end

--

local Library = loadfile('dreamybull.club/Dependencies/UI.luau')() do
    local Window = Library:Window({ Name = 'dreamybull<font color="rgb(126, 192, 255)">.club</font> | @0f14 | lifetime', Rank = "developer" }) do
        do -- ui intializing
            local Watermark = Window:Watermark({
                Name = 'dreamybull<font color="rgb(126, 192, 255)">.club</font>',
                SubName = ""
            }) do

                local function GetChineseWeatherEmoji(WeatherText: string): string
                    if WeatherText:find("晴") then return "☀️"
                        elseif WeatherText:find("阴") then return "☁️"
                        elseif WeatherText:find("多云") then return "⛅"
                        elseif WeatherText:find("雷阵雨") or WeatherText:find("雷") then return "⛈️"
                        elseif WeatherText:find("雨") or WeatherText:find("阵雨") then return "🌧️"
                        elseif WeatherText:find("雪") or WeatherText:find("冰雹") then return "❄️"
                        elseif WeatherText:find("雾") or WeatherText:find("霾") then return "🌫️"
                    end

                    return "🌤️"
                end

                local function FetchWeather(CityId: string): string
                    local HttpRequest = Genv.request
                    if not HttpRequest then return "🌤️" end

                    local Url = "http://aider.meizu.com/app/weather/listWeather?cityIds=" .. tostring(CityId) -- api for chinese ppl

                    local Success, Response = pcall(HttpRequest, {
                        Url = Url,
                        Method = "GET"
                    })

                    if Success and Response.StatusCode == 200 then
                        local DecodeSuccess, Data = pcall(function()
                            return HttpService:JSONDecode(Response.Body)
                        end)

                        if DecodeSuccess and Data and Data.code == "200" and Data.value and Data.value[1] then
                            local Realtime = Data.value[1].realtime
                            if Realtime then
                                local Temp = tonumber(Realtime.temp) or 0
                                local Weather = Realtime.weather or "unknown"
                                local Emoji = GetChineseWeatherEmoji(Weather)

                                return StringFormat("%s %d°C", Emoji, Temp)
                            end
                        end
                    end

                    return "🌤️"
                end

                local ThemeColor = "rgb(126, 192, 255)"
                local Divider = ' <font color="' .. ThemeColor .. '">│</font> '

                local WeatherAndTemperature = "🌤️" -- [OPT] 异步获取, 原来同步 HTTP 请求会卡住整个加载
                TaskScheduler:CreateThread(function()
                    WeatherAndTemperature = FetchWeather('101010100') -- wassup beijing
                end)

                TaskScheduler:AddLoop('Watermark Refresh', 1, function(DeltaTime: number)
                    local Date = OsDate():gsub(' ', '-')

                    local FormattedText = StringFormat("%s%s%s", Date, Divider, WeatherAndTemperature)

                    Watermark:SetSubText(FormattedText)
                end)
            end

            local KeybindList = Window:KeybindList({
                Name = 'hot<font color="rgb(126, 192, 255)">keys</font>'
            })

            local TargetIndicator = Window:TargetIndicator({
                Name = "target<font color='rgb(0, 80, 255)'> info</font>"
            })

            local StaffList = Window:StaffList({
                Name ='staff<font color="rgb(0, 80, 255)"> list</font>'
            }) do
                StaffList:Add("0f14", "<3333")
            end

        end

        local CombatPage = Window:Page({ Name = "combat" }) do
            local SilentMultiSection = CombatPage:MultiSection({ Side = 1 }) do
                local FlagStart = 'Combat/Aimbot/'

                -- [FIX] 原来 "enabled" 开关没有 Callback, 只有 keybind 回调会写 Aimbot.Enabled。
                -- 初始化时 keybind 以 true 触发, 但那一刻开关还是 false -> false and true = false;
                -- 之后打开开关又没有回调 -> 一直是 false, 必须手动切一次 mode 才生效。
                -- 现在两边都调用同一个函数重新求值。
                local function RefreshAimbotEnabled()
                    local MasterOn = Library.Flags[FlagStart .. 'EnabledToggle'] and true or false
                    local KeybindFlag = Library.Flags[FlagStart .. 'Enabled']
                    local KeybindOn = (KeybindFlag == nil) or (KeybindFlag.Toggled and true or false)

                    Aimbot.Enabled = MasterOn and KeybindOn
                end

                local MainSection = SilentMultiSection:Add('silent')
                local MasterSwitch = MainSection:Toggle({Name = "enabled", Flag = FlagStart .. 'EnabledToggle', Default = false, Callback = function(Boolean)
                    TaskScheduler:CreateQueueThread(RefreshAimbotEnabled)
                end}) do

                    MasterSwitch:Keybind({Name = "silent-aim", Flag = FlagStart .. 'Enabled', ShowInKeybindsList = true, Mode = 'Always', Default = 'None', Callback = function(Boolean)
                        TaskScheduler:CreateQueueThread(RefreshAimbotEnabled)
                    end})

                    local MasterSwitchFolder = MasterSwitch:Settings() do

                        --

                        local StickyToggle = MasterSwitchFolder:Toggle({Name = "sticky", Flag = FlagStart .. 'StickyAim', Default = false, Callback = function(Boolean)
                            Aimbot.StickyAim.Enabled = Boolean
                        end})

                        --

                        local FOVToggle = MasterSwitchFolder:Toggle({Name = "field of view", Flag = FlagStart .. 'FieldOfViewEnabled', Default = false, Callback = function(Boolean)
                            TaskScheduler:CreateQueueThread(function()
                                Aimbot.FieldOfView = (Boolean and Library.Flags[FlagStart .. 'FieldOfView']) or nil
                            end)
                        end}); do
                            local FOVFolder = FOVToggle:Settings() do
                                local FOVSlider = FOVFolder:Slider({ Name = "field of view", Flag = FlagStart .. "FieldOfView", Min = 10, Max = 1000, Default = 100, Decimals = 10, Suffix = "px", Callback = function(Number)
                                    TaskScheduler:CreateQueueThread(function()
                                        Aimbot.FieldOfView = (Library.Flags[FlagStart .. 'FieldOfViewEnabled'] and Number) or nil
                                    end)
                                end})
                            end
                        end

                        --

                        local MultiPointToggle = MasterSwitchFolder:Toggle({Name = "multi-point", Flag = FlagStart .. 'MultiPoint', Default = false, Callback = function(Boolean)
                            Aimbot.MultiPoint.Enabled = Boolean
                        end}); local MultiPointFolder = MultiPointToggle:Settings() do
                            local ScaleSlider = MultiPointFolder:Slider({ Name = "scale", Flag = FlagStart .. "Scale", Min = 0.05, Max = 1, Default = 0.45, Decimals = 0.05, Suffix = "%", Callback = function(Number)
                                Aimbot.MultiPoint.Spread = Number
                            end})

                            local PointCountSlider = MultiPointFolder:Slider({ Name = "point count", Flag = FlagStart .. "PointCount", Min = 1, Max = 32, Default = 8, Decimals = 1, Suffix = "", Callback = function(Number)
                                Aimbot.MultiPoint.PointCount = Number
                            end})
                        end

                        --

                        local WallbangToggle = MasterSwitchFolder:Toggle({Name = "wallbang", Flag = FlagStart .. 'Wallbang', Default = false})

                        --

                        local ManipulationToggle = MasterSwitchFolder:Toggle({Name = "manipulation", Flag = FlagStart .. 'Manipulation', Default = false, Callback = function(Boolean)
                            Aimbot.BulletManipulation.Enabled = Boolean
                        end}); local ManipulationFolder = ManipulationToggle:Settings() do
                            local ForceTeleportToggle = ManipulationFolder:Toggle({Name = "force teleport", Flag = FlagStart .. 'ForceTeleport', Default = false, Callback = function(Boolean)
                                Aimbot.BulletManipulation.ForceTeleport = Boolean
                            end})

                            local ScanOffsetSlider = ManipulationFolder:Slider({ Name = "offset", Flag = FlagStart .. "Scale", Min = .5, Max = 30, Default = 0.45, Decimals = 0.5, Suffix = "st", Callback = function(Number)
                                Aimbot.BulletManipulation.ScanOffset = Number
                            end})
                        end

                        --

                        local DistanceSlider = MasterSwitchFolder:Slider({ Name = "max distance", Flag = FlagStart .. "MaxDistance", Min = 25, Max = 5000, Default = 1000, Decimals = 25, Suffix = "st", Callback = function(Number)
                            Aimbot.MaxDistance = Number
                        end})

                        --

                        local OriginDropdown = MasterSwitchFolder:Dropdown({ Name = "origin", Default = 'Mouse', Flag = FlagStart .. "ScreenOrigin", Items = {'Center', 'Mouse'}, Multi = false, Callback = function(Option)
                            Aimbot.ScreenOrigin = Option
                        end})

                        --

                        local SortDropdown = MasterSwitchFolder:Dropdown({ Name = "sorted by", Default = 'ViewportDistance', Flag = FlagStart .. "SortedBy", Items = {'ViewportDistance', 'Distance', 'Health'}, Multi = false, Callback = function(Option)
                            Aimbot.SortType = Option
                        end})

                        --

                        local BodyPartDropdown = MasterSwitchFolder:Dropdown({ Name = "body parts", Default = { 'Head' }, Flag = FlagStart .. "BodyParts", Items = {
                            'Head',
                            'HumanoidRootPart','UpperTorso','LowerTorso','Torso',
                            'RightUpperArm','RightLowerArm','LeftUpperArm','LeftLowerArm','LeftLeg','Left Arm',
                            'RightUpperLeg','RightLowerLeg','LeftUpperLeg','LeftLowerLeg','Right Leg','Right Arm'
                        }, Multi = true, Callback = function(Option)
                            Aimbot.BodyParts = Option
                        end})

                        --

                        local CategoriesDropdown = MasterSwitchFolder:Dropdown({ Name = "categories", Default = { 'Players' }, Flag = FlagStart .. "Categories", Items = {'Players', 'NPCs'}, Multi = true, Callback = function(Option)
                            Aimbot.Categories = Option
                        end})

                        --

                        local IgnoreDropdown = MasterSwitchFolder:Dropdown({ Name = "exclusion", Default = { 'Friend', 'OffScreen', 'ForceField' }, Flag = FlagStart .. "Exclusion", Items = { 'Team', 'Friend', 'Visible', 'OffScreen', 'ForceField' }, Multi = true, Callback = function(Option)
                            local Default = {
                                Team = false,
                                Friend = false,
                                Visible = false,
                                OffScreen = false,
                                ForceField = false
                            }

                            for _, Check in Option do
                                Default[Check] = true
                            end

                            Default.Visible = Default.Visible and not Library.Flags[FlagStart .. 'Wallbang']

                            Aimbot.Checks = Default
                        end})

                        local MethodsDropdown = MasterSwitchFolder:Dropdown({ Name = "methods", Default = { 'Raycast' }, Flag = FlagStart .. "Methods", Items = {
                            'Raycast',
                            'FindPartOnRayWithIgnoreList','FindPartOnRayWithWhitelist','FindPartOnRay',
                            'WorldToViewportPoint','WorldToScreenPoint', 'ViewportPointToRay','ScreenPointToRay',
                            'GetMouseLocation'
                        }, Multi = true, Callback = function(Option)
                            HookManager:RestoreAll()
                            HookManager:RestoreMetamethod(game, '__namecall')

                            if #Option <= 0 then return end

                            local Flags = Library.Flags

                            local function CheckIfValid()
                                local Caller = checkcaller()
                                if Caller then return end

                                local Calling = getcallingscript()
                                local CallingName = Calling and Calling.Name
                                if CallingName and (CallingName == 'ControlScript' or CallingName == 'ControlModule' or CallingName == 'CameraModule') then return end

                                return true
                            end

                            local Functions = {
                                Raycast = { Self = Workspace, OriginalFunction = Workspace.Raycast, Hook = function(Old, Self, Origin, Direction, RaycastParameters, ...) -- [OPT] 具名参数, 每次调用不再分配 {...} 表
                                    local Target = Aimbot.CurrentTargetInfo
                                    if not Target then return Old(Self, Origin, Direction, RaycastParameters, ...) end

                                    local IsValid = CheckIfValid()
                                    if not IsValid then return Old(Self, Origin, Direction, RaycastParameters, ...) end

                                    local Wallbang = Flags['Combat/Aimbot/Wallbang']
                                    local OldFilterType, OldFilterList

                                    if Wallbang and RaycastParameters then
                                        OldFilterType = RaycastParameters.FilterType
                                        OldFilterList = RaycastParameters.FilterDescendantsInstances
                                        RaycastParameters.FilterType = Enum.RaycastFilterType.Include
                                        RaycastParameters.FilterDescendantsInstances = { Target.HitPart.Parent }
                                    end

                                    local Result = Old(Workspace, Target.Origin, Target.HitPosition - Target.Origin, RaycastParameters) do

                                        if Wallbang and RaycastParameters then -- [FIX] 原来只是把局部变量赋回自己, 参数实际没还原
                                            RaycastParameters.FilterType = OldFilterType
                                            RaycastParameters.FilterDescendantsInstances = OldFilterList
                                        end

                                        return Result
                                    end
                                end },

                                FindPartOnRayWithIgnoreList = { Self = Workspace, OriginalFunction = Workspace.FindPartOnRayWithIgnoreList, Hook = function(Old, Self, Ray, ...) -- [OPT] 免去 {...} + unpack
                                    local Target = Aimbot.CurrentTargetInfo
                                    if not Target then return Old(Self, Ray, ...) end

                                    local IsValid = CheckIfValid()
                                    if not IsValid then return Old(Self, Ray, ...) end

                                    local NewRay do
                                        local Origin = Target.Origin
                                        local HitPosition = Target.HitPosition

                                        NewRay = RayNew(Origin, HitPosition - Origin)
                                    end

                                    local Wallbang = Flags['Combat/Aimbot/Wallbang']
                                    if Wallbang then
                                        return FindPartOnRayWithWhitelistCloned(Workspace, NewRay, { Target.HitPart.Parent }, true) -- [FIX] 用 clone, 避免命中自己的 whitelist 钩子造成递归
                                    end

                                    return Old(Workspace, NewRay, ...)
                                end },

                                FindPartOnRayWithWhitelist = { Self = Workspace, OriginalFunction = Workspace.FindPartOnRayWithWhitelist, Hook = function(Old, Self, Ray, ...) -- [OPT] 免去 {...} + unpack
                                    local Target = Aimbot.CurrentTargetInfo
                                    if not Target then return Old(Self, Ray, ...) end

                                    local IsValid = CheckIfValid()
                                    if not IsValid then return Old(Self, Ray, ...) end

                                    local NewRay do
                                        local Origin = Target.Origin
                                        local HitPosition = Target.HitPosition

                                        NewRay = RayNew(Origin, HitPosition - Origin)
                                    end

                                    local Wallbang = Flags['Combat/Aimbot/Wallbang']
                                    if Wallbang then
                                        return Old(Workspace, NewRay, { Target.HitPart.Parent }, true)
                                    end

                                    return Old(Workspace, NewRay, ...)
                                end },

                                FindPartOnRay = { Self = Workspace, OriginalFunction = Workspace.FindPartOnRay, Hook = function(Old, Self, Ray, ...) -- [OPT] 免去 {...} + unpack
                                    local Target = Aimbot.CurrentTargetInfo
                                    if not Target then return Old(Self, Ray, ...) end

                                    local IsValid = CheckIfValid()
                                    if not IsValid then return Old(Self, Ray, ...) end

                                    local NewRay do
                                        local Origin = Target.Origin
                                        local HitPosition = Target.HitPosition

                                        NewRay = RayNew(Origin, HitPosition - Origin)
                                    end

                                    local Wallbang = Flags['Combat/Aimbot/Wallbang']
                                    if Wallbang then
                                        return FindPartOnRayWithWhitelistCloned(Workspace, NewRay, { Target.HitPart.Parent }, true)
                                    end

                                    return Old(Workspace, NewRay, ...)
                                end },

                                WorldToViewportPoint = { Self = Camera, OriginalFunction = Camera.WorldToViewportPoint, Hook = function(Old, Self, ...)
                                    local Target = Aimbot.CurrentTargetInfo
                                    if not Target then return Old(Self, ...) end

                                    local IsValid = CheckIfValid()
                                    if not IsValid then return Old(Self, ...) end

                                    return Old(Camera, Target.HitPosition)
                                end },

                                WorldToScreenPoint = { Self = Camera, OriginalFunction = Camera.WorldToScreenPoint, Hook = function(Old, Self, ...)
                                    local Target = Aimbot.CurrentTargetInfo
                                    if not Target then return Old(Self, ...) end

                                    local IsValid = CheckIfValid()
                                    if not IsValid then return Old(Self, ...) end

                                    return Old(Camera, Target.HitPosition)
                                end },

                                ViewportPointToRay = { Self = Camera, OriginalFunction = Camera.ViewportPointToRay, Hook = function(Old, Self, ...)
                                    local Target = Aimbot.CurrentTargetInfo
                                    if not Target then return Old(Self, ...) end

                                    local IsValid = CheckIfValid()
                                    if not IsValid then return Old(Self, ...) end

                                    local Origin = Target.Origin
                                    local HitPosition = Target.HitPosition

                                    return RayNew(Origin, HitPosition - Origin)
                                end },

                                ScreenPointToRay = { Self = Camera, OriginalFunction = Camera.ScreenPointToRay, Hook = function(Old, Self, ...) -- [FIX] 原来错挂到 ViewportPointToRay 上
                                    local Target = Aimbot.CurrentTargetInfo
                                    if not Target then return Old(Self, ...) end

                                    local IsValid = CheckIfValid()
                                    if not IsValid then return Old(Self, ...) end

                                    local Origin = Target.Origin
                                    local HitPosition = Target.HitPosition

                                    return RayNew(Origin, HitPosition - Origin)
                                end },

                                GetMouseLocation = { Self = UserInputService, OriginalFunction = UserInputService.GetMouseLocation, Hook = function(Old, Self, ...)
                                    local Target = Aimbot.CurrentTargetInfo
                                    if not Target then return Old(Self, ...) end

                                    local IsValid = CheckIfValid()
                                    if not IsValid then return Old(Self, ...) end

                                    local ScreenPosition = Target.ScreenPosition
                                    return Vector2New(ScreenPosition.X, ScreenPosition.Y)
                                end },
                            }

                            local Allowed = {}

                            for _, MetamethodName in Option do
                                local FunctionInfo = Functions[MetamethodName] do
                                    HookManager:HookFunction(FunctionInfo.OriginalFunction, FunctionInfo.Hook)
                                    Allowed[MetamethodName] = true
                                end
                            end

                            local Old; Old = HookManager:HookMetamethod(game, '__namecall', newcclosure(function(Self, ...)
                                if not Old then return end -- Old 没拿到就啥都不做(极端兜底), 不崩

                                local Target = Aimbot.CurrentTargetInfo
                                if not Target then return Old(Self, ...) end

                                local IsValid = CheckIfValid()
                                if not IsValid then return Old(Self, ...) end

                                local Method = getnamecallmethod()
                                local IsAllowed = rawget(Allowed, Method)
                                if not IsAllowed then return Old(Self, ...) end

                                local FunctionInfo = rawget(Functions, Method)
                                if not FunctionInfo or Self ~= FunctionInfo.Self then return Old(Self, ...) end

                                -- 重定向逻辑出错就退回原始方法, 绝不把错误抛给游戏(否则该方法每次调用都崩)
                                local Ok, r1, r2, r3, r4, r5, r6 = pcall(FunctionInfo.Hook, Old, Self, ...)
                                if Ok then return r1, r2, r3, r4, r5, r6 end
                                return Old(Self, ...)
                            end))
                        end})
                    end
                end
            end

            local AutoShootSection = CombatPage:Section({ Name = "trigger", Side = 2 }) do
                local FlagStart = 'Combat/AutoShoot/'

                local function RefreshAutoShoot()
                    local MasterOn = Library.Flags[FlagStart .. 'Enabled'] and true or false
                    local KeybindFlag = Library.Flags[FlagStart .. 'Keybind']
                    local KeybindOn = (KeybindFlag == nil) or (KeybindFlag.Toggled and true or false)

                    Visuals.AutoShoot.Enabled = MasterOn
                    Visuals.AutoShoot.Active = MasterOn and KeybindOn
                end

                local AutoShootToggle = AutoShootSection:Toggle({Name = "enabled", Flag = FlagStart .. 'Enabled', Default = false, Callback = function(Boolean)
                    TaskScheduler:CreateQueueThread(RefreshAutoShoot)
                end}) do
                    AutoShootToggle:Keybind({Name = "auto shoot", Flag = FlagStart .. 'Keybind', ShowInKeybindsList = true, Mode = 'Always', Default = 'None', Callback = function(Boolean)
                        TaskScheduler:CreateQueueThread(RefreshAutoShoot)
                    end})

                    local AutoShootSettings = AutoShootToggle:Settings() do
                        local ModeDropdown = AutoShootSettings:Dropdown({
                            Name = "mode",
                            Flag = FlagStart .. 'Mode',
                            Items = { "Silent", "Crosshair" },
                            Default = "Silent",
                            Callback = function(Value)
                                Visuals.AutoShoot.Mode = Value
                            end
                        })

                        AutoShootSettings:Slider({ Name = "delay", Flag = FlagStart .. 'Delay', Min = 0, Max = 1, Default = 0.1, Decimals = 0.01, Suffix = "s", Callback = function(Number)
                            Visuals.AutoShoot.Delay = Number
                        end})

                        local ChecksDropdown = AutoShootSettings:Dropdown({ Name = "checks", Flag = FlagStart .. 'Checks', Multi = true, Default = { 'Team' }, Items = { 'Team', 'Wall' }, Callback = function(Option)
                            Visuals.AutoShoot.CrosshairTeamCheck = false
                            Visuals.AutoShoot.CrosshairWallCheck = false

                            for _, Check in Option do
                                if Check == 'Team' then
                                    Visuals.AutoShoot.CrosshairTeamCheck = true
                                elseif Check == 'Wall' then
                                    Visuals.AutoShoot.CrosshairWallCheck = true
                                end
                            end
                        end})

                        AutoShootSettings:Slider({ Name = "max distance", Flag = FlagStart .. 'CrosshairMaxDistance', Min = 100, Max = 10000, Default = 5000, Decimals = 100, Suffix = "st", Callback = function(Number)
                            Visuals.AutoShoot.CrosshairMaxDistance = Number
                        end})
                    end
                end
            end
        end

        local ESPPage = Window:Page({ Name = "esp" }) do
            local SideNumber = 0

            local ESPSettings = ESPPage:Section({ Name = "settings", Side = 1}) do
                local RefreshRateSlider = ESPSettings:Slider({ Name = "refresh rate", Flag = "ESP/RefreshRate", Min = 4, Max = 240, Default = 120, Decimals = 4, Suffix = "hz", Callback = function(Number)
                    ESP.Settings['RefreshRate'] = Number
                end})
            end

            for Category, BaseInfo in ESP.Settings do
                if Category == 'RefreshRate' then continue end

                SideNumber = SideNumber + 1

                local ESPMultiSection = ESPPage:MultiSection({ Side = (SideNumber % 2) + 1 })

                for Class, Settings in BaseInfo do
                    if Class == 'Folders' then continue end

                    local FlagStart = "ESP/" .. Category .. '/' .. Class .. '/'

                    local MainSection = ESPMultiSection:Add(Class:lower())

                    local MasterSwitch = MainSection:Toggle({Name = "enabled", Flag = FlagStart .. 'Enabled', Default = false, Callback = function(Boolean)
                        ESP.Settings[Category][Class]['Enabled'] = Boolean
                    end}) do

                        local MasterSwitchFolder = MasterSwitch:Settings() do
                            local HumanoidCheckToggle = MasterSwitchFolder:Toggle({Name = "humanoid check", Flag = FlagStart .. 'HumanoidCheck', Default = true, Callback = function(Boolean)
                                ESP.Settings[Category][Class]['HumanoidCheck'] = Boolean
                            end})

                            --

                            local FlagsMasterSwitch = MasterSwitchFolder:Toggle({Name = "flags", Flag = FlagStart .. 'Flags', Default = false, Callback = function(Boolean)
                                ESP.Settings[Category][Class]['Flags'] = Boolean
                            end}) do

                                local FlagsSettings = FlagsMasterSwitch:Settings()

                                local function RefreshFlagsSettings()
                                    TaskScheduler:CreateQueueThread(function()
                                        for _, FlagInfo in ipairs(ESP.FlagsRegistry) do
                                            local FlagName = FlagInfo.Name
                                            local MasterOn = Library.Flags[FlagStart .. 'Flags']
                                            local SpecificOn = Library.Flags[FlagStart .. 'Flags/' .. FlagName]

                                            FlagInfo.Category[Category] = FlagInfo.Category[Category] or {}
                                            local TargetCategoryTable = FlagInfo.Category[Category]

                                            local ClassIndex = TableFind(TargetCategoryTable, Class)

                                            if MasterOn and SpecificOn then
                                                if not ClassIndex then
                                                    TableInsert(TargetCategoryTable, Class)
                                                end
                                            elseif ClassIndex then
                                                TableRemove(TargetCategoryTable, ClassIndex)
                                            end

                                            local ColorFlag = Library.Flags[FlagStart .. 'Flags/' .. FlagName .. '/Color']
                                            local PickedColor = ColorFlag and ColorFlag.Color
                                            if PickedColor then
                                                ESP.ChangeFlagSettings(FlagName, "Color", PickedColor)
                                            end
                                        end
                                    end)
                                end

                                for _, FlagInfo in ipairs(ESP.FlagsRegistry) do
                                    local CategoryInfo = FlagInfo.Category[Category]
                                    if not CategoryInfo then continue end

                                    local FlagToggle = FlagsSettings:Toggle({ Name = FlagInfo.Name:lower(), Flag = FlagStart .. 'Flags/' .. FlagInfo.Name, Default = false, Callback = RefreshFlagsSettings }) do
                                        FlagToggle:Colorpicker({ Flag = FlagStart .. 'Flags/' .. FlagInfo.Name .. '/Color', Default = FlagInfo.Color, Callback = RefreshFlagsSettings })
                                    end
                                end
                            end

                            --

                            local NameToggle = MasterSwitchFolder:Toggle({Name = "name", Flag = FlagStart .. 'Name/Enabled', Default = false, Callback = function(Boolean)
                                ESP.Settings[Category][Class]['Name']['Enabled'] = Boolean
                            end}) do
                                NameToggle:Colorpicker({Flag = FlagStart .. 'Name/Color', Default = Color3.fromRGB(255, 255, 255), Callback = function(Color, Alpha)
                                    ESP.Settings[Category][Class]['Name']['Color'] = Color
                                end})
                            end

                            --

                            local ToolToggle = MasterSwitchFolder:Toggle({Name = "tool", Flag = FlagStart .. 'Tool/Enabled', Default = false, Callback = function(Boolean)
                                ESP.Settings[Category][Class]['Tool']['Enabled'] = Boolean
                            end}) do
                                ToolToggle:Colorpicker({Flag = FlagStart .. 'Tool/Color', Default = Color3.fromRGB(255, 255, 255), Callback = function(Color, Alpha)
                                    ESP.Settings[Category][Class]['Tool']['Color'] = Color
                                end})
                            end

                            --

                            local DistanceToggle = MasterSwitchFolder:Toggle({Name = "distance", Flag = FlagStart .. 'Distance/Enabled', Default = false, Callback = function(Boolean)
                                ESP.Settings[Category][Class]['Distance']['Enabled'] = Boolean
                            end}) do
                                DistanceToggle:Colorpicker({Flag = FlagStart .. 'Distance/Color', Default = Color3.fromRGB(255, 255, 255), Callback = function(Color, Alpha)
                                    ESP.Settings[Category][Class]['Distance']['Color'] = Color
                                end})
                            end

                            --

                            local BoxToggle = MasterSwitchFolder:Toggle({Name = "box", Flag = FlagStart .. 'Box/Enabled', Default = false, Callback = function(Boolean)
                                ESP.Settings[Category][Class]['Box']['Enabled'] = Boolean
                            end}) do
                                BoxToggle:Colorpicker({Flag = FlagStart .. 'Box/Color', Default = Color3.fromRGB(255, 255, 255), Callback = function(Color, Alpha)
                                    ESP.Settings[Category][Class]['Box']['Color'] = Color
                                end})
                            end

                            --

                            local FilledBoxToggle = MasterSwitchFolder:Toggle({Name = "filled box", Flag = FlagStart .. 'FilledBox/Enabled', Default = false, Callback = function(Boolean)
                                ESP.Settings[Category][Class]['FilledBox']['Enabled'] = Boolean
                            end}) do
                                FilledBoxToggle:Colorpicker({Flag = FlagStart .. 'FilledBox/Color' , Alpha = 0.5, Default = Color3.fromRGB(255, 255, 255), Callback = function(Color, Alpha)
                                    ESP.Settings[Category][Class]['FilledBox']['Color'] = Color
                                    ESP.Settings[Category][Class]['FilledBox']['Transparency'] = 1 - Alpha
                                end})
                            end

                            --

                            local ChamsToggle = MasterSwitchFolder:Toggle({Name = "chams", Flag = FlagStart .. 'Chams/Enabled', Default = false, Callback = function(Boolean)
                                ESP.Settings[Category][Class]['Chams']['Enabled'] = Boolean
                            end}) do
                                ChamsToggle:Colorpicker({Flag = FlagStart .. 'Chams/FillColor', Default = Color3.fromRGB(255, 255, 255), Callback = function(Color, Alpha)
                                    ESP.Settings[Category][Class]['Chams']['FillColor'] = Color
                                    ESP.Settings[Category][Class]['Chams']['FillTransparency'] = Alpha
                                end})

                                ChamsToggle:Colorpicker({Flag = FlagStart .. 'Chams/OutlineColor', Default = Color3.fromRGB(255, 255, 255), Callback = function(Color, Alpha)
                                    ESP.Settings[Category][Class]['Chams']['OutlineColor'] = Color
                                    ESP.Settings[Category][Class]['Chams']['OutlineTransparency'] = Alpha
                                end})

                                local ChamsSettings = ChamsToggle:Settings() do
                                    local ThroughWallsToggle = ChamsSettings:Toggle({Name = "through walls", Flag = FlagStart .. 'Chams/ThroughWalls', Default = false, Callback = function(Boolean)
                                        ESP.Settings[Category][Class]['Chams']['ShowThroughWalls'] = Boolean
                                    end})

                                    local GlowSizeSlider = ChamsSettings:Slider({ Name = "chams glow size", Flag = "Chams/GlowSize", Min = 0.1, Max = 10, Default = 5, Decimals = 0.5, Suffix = "x", Callback = function(Number)
                                        ESP.Settings[Category][Class]['Chams']['GlowSize'] = Number
                                    end})

                                    local ChamsMethodDropdown = ChamsSettings:Dropdown({ Name = "chams method", Default = 'Highlight', Flag = "Chams/Method", Items = {"Glow", "LayeredGlow", "Highlight", "BoxHandleAdornment"}, Multi = false, Callback = function(Option)
                                        ESP.Settings[Category][Class]['Chams']['Method'] = Option
                                    end})
                                end
                            end

                            --

                            local HealthbarToggle = MasterSwitchFolder:Toggle({Name = "health", Flag = FlagStart .. 'HealthBar/Enabled', Default = false, Callback = function(Boolean)
                                ESP.Settings[Category][Class]['HealthBar']['Enabled'] = Boolean
                            end}) do
                                HealthbarToggle:Colorpicker({Flag = FlagStart .. 'Healthbar/HealthyColor', Default = Color3.fromRGB(0, 255, 0), Callback = function(Color, Alpha)
                                    ESP.Settings[Category][Class]['HealthBar']['HealthyColor'] = Color
                                end})

                                HealthbarToggle:Colorpicker({Flag = FlagStart .. 'Healthbar/DyingColor', Default = Color3.fromRGB(255, 0, 0), Callback = function(Color, Alpha)
                                    ESP.Settings[Category][Class]['HealthBar']['DyingColor'] = Color
                                end})
                            end

                            --

                            local HealthTextToggle = MasterSwitchFolder:Toggle({Name = "health text", Flag = FlagStart .. 'HealthValue/Enabled', Default = false, Callback = function(Boolean)
                                ESP.Settings[Category][Class]['HealthValue']['Enabled'] = Boolean
                            end}) do
                                HealthTextToggle:Colorpicker({Flag = FlagStart .. 'HealthValue/Color', Default = Color3.fromRGB(255, 255, 255), Callback = function(Color, Alpha)
                                    ESP.Settings[Category][Class]['HealthValue']['Color'] = Color
                                end})
                            end

                            --

                            local EasingStyles = TableGetIndex(Easing); do
                                EasingStyles.Fade = nil
                            end

                            local EasingSpeedSlider = MasterSwitchFolder:Slider({ Name = "easing speed multiplier", Flag = FlagStart .. "Easing/SpeedMultiplier", Min = 0.1, Max = 10, Default = 2.5, Decimals = 0.5, Suffix = "x", Callback = function(Number)
                                ESP.Settings[Category][Class]['Easing']['SpeedMultiplier'] = Number
                            end})

                            local EasingStyleMethodDropdown = MasterSwitchFolder:Dropdown({ Name = "easing style", Default = 'Quad', Flag = FlagStart .. "Easing/Style", Items = EasingStyles, Multi = false, Callback = function(Option)
                                ESP.Settings[Category][Class]['Easing']['Style'] = Option
                            end})

                            local EasingDirectionMethodDropdown = MasterSwitchFolder:Dropdown({ Name = "easing direction", Default = 'Out', Flag = FlagStart .. "Easing/Direction", Items = {'In', 'Out'}, Multi = false, Callback = function(Option)
                                ESP.Settings[Category][Class]['Easing']['Direction'] = Option
                            end})
                        end
                    end
                end
            end
        end

        local VisualsPage = Window:Page({Name = "visuals"}) do
            local FlagStart = 'Visuals/'

            local VisualsMultiSection = VisualsPage:MultiSection({ Side = 1 })
            local VisualSettings = VisualsMultiSection:Add('visuals') do
                local FOVToggle = VisualSettings:Toggle({Name = "fov circle", Flag = FlagStart .. 'FOVCircle', Default = false, Callback = function(Boolean)
                    TaskScheduler:CreateQueueThread(function()
                        Visuals.AimbotVisuals.Circle.Visible = Boolean
                        Visuals.AimbotVisuals.CircleFilled.Visible = Boolean and Library.Flags[FlagStart .. 'FOVFilled']
                        Visuals.AimbotVisuals.CircleOutline.Visible = Boolean
                    end)
                end}); local MasterSwitchFolder = FOVToggle:Settings() do
                    FOVToggle:Colorpicker({Flag = FlagStart .. 'FOVCircleColor', Default = Color3FromRGB(255, 255, 255), Callback = function(Color, Alpha)
                        Visuals.AimbotVisuals.Circle.Color = Color
                        Visuals.AimbotVisuals.Circle.Transparency = 1 - Alpha
                        Visuals.AimbotVisuals.CircleOutline.Transparency = 1 - Alpha
                    end})

                    local FOVFilledToggle = MasterSwitchFolder:Toggle({Name = "filled", Flag = FlagStart .. 'FOVFilled', Default = false, Callback = function(Boolean)
                        Visuals.AimbotVisuals.CircleFilled.Visible = Boolean
                    end}) do
                        FOVFilledToggle:Colorpicker({Flag = FlagStart .. 'FOVCircleFilledColor', Alpha = 0.5, Default = Color3FromRGB(255, 255, 255), Callback = function(Color, Alpha)
                            Visuals.AimbotVisuals.CircleFilled.Color = Color
                            Visuals.AimbotVisuals.CircleFilled.Transparency = 1 - Alpha
                        end})
                    end
                end

                local GlowToggle = VisualSettings:Toggle({Name = "target glow", Flag = FlagStart .. 'GlowEnabled', Default = false, Callback = function(Boolean)
                    Visuals.TargetGlow.Enabled = Boolean
                end}) do
                    GlowToggle:Colorpicker({Flag = FlagStart .. 'GlowColor', Alpha = 0.5, Default = Color3FromRGB(78, 184, 255), Callback = function(Color, Alpha)
                        Visuals.TargetGlow.Core.Color = Color
                    end})

                    local GlowSettings = GlowToggle:Settings() do
                        GlowSettings:Slider({ Name = "core radius", Flag = FlagStart .. 'GlowCoreSize', Min = 0.5, Max = 10, Default = 2, Decimals = .5, Suffix = "px", Callback = function(Number)
                            Visuals.TargetGlow.Core.Radius = Number
                        end})
                    end
                end

                local DesyncToggle = VisualSettings:Toggle({ Name = "desync", Flag = "Visuals/Desync/Visualize", Default = false, Callback = function(Boolean)
                    MiscFunctions.Settings.Desync.Visualize = Boolean
                end}) do
                    DesyncToggle:Colorpicker({Flag = 'Visuals/Desync/VisualizeColorFilled', Alpha = 0.5, Default = Color3FromRGB(78, 184, 255), Callback = function(Color, Alpha)
                        MiscFunctions.DesyncData.Highlight.FillColor = Color
                        MiscFunctions.DesyncData.Highlight.FillTransparency = Alpha
                    end})

                    DesyncToggle:Colorpicker({Flag = 'Visuals/Desync/VisualizeColorOutline', Alpha = 0.5, Default = Color3FromRGB(78, 184, 255), Callback = function(Color, Alpha)
                        MiscFunctions.DesyncData.Highlight.OutlineColor = Color
                        MiscFunctions.DesyncData.Highlight.OutlineTransparency = Alpha
                    end})
                end

                local KillFlag = 'Visuals/KillParticle/'
                local KillSettings = Visuals.KillParticle.Settings

                local KillToggle = VisualSettings:Toggle({ Name = "kill effect", Flag = KillFlag .. 'Enabled', Default = false, Callback = function(Boolean)
                    KillSettings.Enabled = Boolean
                end}) do
                    KillToggle:Colorpicker({ Flag = KillFlag .. 'Color', Default = Color3FromRGB(255, 255, 255), Callback = function(Color, Alpha)
                        KillSettings.Color = Color
                    end})

                    local KillFolder = KillToggle:Settings() do
                        KillFolder:Dropdown({ Name = "style", Flag = KillFlag .. 'Style', Multi = false, Default = KillSettings.Style, Items = KillParticleStyles, Callback = function(Option)
                            KillSettings.Style = Option
                        end})

                        KillFolder:Toggle({ Name = "team kills", Flag = KillFlag .. 'TeamKills', Default = false, Callback = function(Boolean)
                            KillSettings.TeamKills = Boolean
                        end})

                        KillFolder:Slider({ Name = "scale", Flag = KillFlag .. 'Scale', Min = 1, Max = 30, Default = 7.5, Decimals = 0.5, Suffix = "x", Callback = function(Number)
                            KillSettings.Scale = Number
                        end})

                        KillFolder:Slider({ Name = "effect lifetime", Flag = KillFlag .. 'Lifetime', Min = 0.5, Max = 8, Default = 2, Decimals = 0.1, Suffix = "s", Callback = function(Number)
                            KillSettings.Lifetime = Number
                        end})
                    end
                end

                local DamageToggle = VisualSettings:Toggle({Name = "damage numbers", Flag = FlagStart .. 'DamageNumbers', Default = false, Callback = function(Boolean)
                    Visuals.DamageNumbers.Settings.Enabled = Boolean
                end}) do
                    DamageToggle:Colorpicker({Flag = FlagStart .. 'DamageNumbers/EnemyColor', Default = Color3FromRGB(255, 80, 80), Callback = function(Color, Alpha)
                        Visuals.DamageNumbers.Settings.EnemyColor = Color
                    end})

                    local DamageFolder = DamageToggle:Settings() do
                        local TeamDamageToggle = DamageFolder:Toggle({Name = "show team damage", Flag = FlagStart .. 'DamageNumbers/ShowTeamDamage', Default = false, Callback = function(Boolean)
                            Visuals.DamageNumbers.Settings.ShowTeamDamage = Boolean
                        end}) do
                            TeamDamageToggle:Colorpicker({Flag = FlagStart .. 'DamageNumbers/TeamColor', Default = Color3FromRGB(255, 216, 88), Callback = function(Color, Alpha)
                                Visuals.DamageNumbers.Settings.TeamColor = Color
                            end})
                        end

                        local HeadshotToggle = DamageFolder:Toggle({Name = "headshot color", Flag = FlagStart .. 'DamageNumbers/UseHeadshotColor', Default = true, Callback = function(Boolean)
                            Visuals.DamageNumbers.Settings.UseHeadshotColor = Boolean
                        end}) do
                            HeadshotToggle:Colorpicker({Flag = FlagStart .. 'DamageNumbers/HeadshotColor', Default = Color3FromRGB(255, 215, 0), Callback = function(Color, Alpha)
                                Visuals.DamageNumbers.Settings.HeadshotColor = Color
                            end})
                        end

                        local RequireShotToggle = DamageFolder:Toggle({Name = "require shot", Flag = FlagStart .. 'DamageNumbers/RequireShot', Default = true, Callback = function(Boolean)
                            Visuals.DamageNumbers.Settings.RequireShot = Boolean
                        end}); local RequireShotFolder = RequireShotToggle:Settings() do
                            RequireShotFolder:Slider({ Name = "shot window", Flag = FlagStart .. 'DamageNumbers/ShotWindow', Min = 0.05, Max = 5, Default = 1, Decimals = 0.05, Suffix = "s", Callback = function(Number)
                                Visuals.DamageNumbers.Settings.ShotWindow = Number
                            end})
                        end

                        DamageFolder:Slider({ Name = "minimum damage", Flag = FlagStart .. 'DamageNumbers/MinDamage', Min = 1, Max = 100, Default = 1, Decimals = 1, Suffix = "", Callback = function(Number)
                            Visuals.DamageNumbers.Settings.MinDamage = Number
                        end})

                        DamageFolder:Slider({ Name = "max distance", Flag = FlagStart .. 'DamageNumbers/MaxDistance', Min = 25, Max = 2000, Default = 500, Decimals = 25, Suffix = "st", Callback = function(Number)
                            Visuals.DamageNumbers.Settings.MaxDistance = Number
                        end})

                        DamageFolder:Slider({ Name = "size", Flag = FlagStart .. 'DamageNumbers/BaseSize', Min = 10, Max = 72, Default = 18, Decimals = 2, Suffix = "px", Callback = function(Number)
                            Visuals.DamageNumbers.Settings.BaseSize = Number
                        end})

                        DamageFolder:Slider({ Name = "height", Flag = FlagStart .. 'DamageNumbers/BaseHeight', Min = 15, Max = 108, Default = 24, Decimals = 2, Suffix = "px", Callback = function(Number)
                            Visuals.DamageNumbers.Settings.BaseHeight = Number
                        end})

                        DamageFolder:Slider({ Name = "duration", Flag = FlagStart .. 'DamageNumbers/BaseDuration', Min = 0.5, Max = 5, Default = 2.5, Decimals = 0.1, Suffix = "s", Callback = function(Number)
                            Visuals.DamageNumbers.Settings.BaseDuration = Number
                        end})

                        DamageFolder:Slider({ Name = "speed multiplier", Flag = FlagStart .. 'DamageNumbers/SpeedMultiplier', Min = 0.1, Max = 3, Default = 1.2, Decimals = 0.1, Suffix = "x", Callback = function(Number)
                            Visuals.DamageNumbers.Settings.SpeedMultiplier = Number
                        end})

                        DamageFolder:Slider({ Name = "rise height", Flag = FlagStart .. 'DamageNumbers/RiseHeight', Min = 0, Max = 512, Default = 256, Decimals = 8, Suffix = "px", Callback = function(Number)
                            Visuals.DamageNumbers.Settings.RiseHeight = Number
                        end})

                        DamageFolder:Slider({ Name = "min scale", Flag = FlagStart .. 'DamageNumbers/MinScale', Min = 0.1, Max = 1, Default = 0.8, Decimals = 0.1, Suffix = "x", Callback = function(Number)
                            Visuals.DamageNumbers.Settings.MinScale = Number
                        end})

                        DamageFolder:Slider({ Name = "max scale", Flag = FlagStart .. 'DamageNumbers/MaxScale', Min = 1, Max = 4, Default = 1.3, Decimals = 0.1, Suffix = "x", Callback = function(Number)
                            Visuals.DamageNumbers.Settings.MaxScale = Number
                        end})

                        DamageFolder:Slider({ Name = "fade start point", Flag = FlagStart .. 'DamageNumbers/FadeStartPoint', Min = 0.1, Max = 0.9, Default = 0.6, Decimals = 0.1, Suffix = "", Callback = function(Number)
                            Visuals.DamageNumbers.Settings.FadeStartPoint = Number
                        end})

                        local RandomOffsetToggle = DamageFolder:Toggle({Name = "random offset", Flag = FlagStart .. 'DamageNumbers/RandomOffset', Default = true, Callback = function(Boolean)
                            Visuals.DamageNumbers.Settings.RandomOffsetEnabled = Boolean
                        end}); local RandomOffsetFolder = RandomOffsetToggle:Settings() do
                            RandomOffsetFolder:Slider({ Name = "max offset", Flag = FlagStart .. 'DamageNumbers/MaxRandomOffset', Min = 0.1, Max = 2, Default = 1, Decimals = 0.1, Suffix = "st", Callback = function(Number)
                                Visuals.DamageNumbers.Settings.MaxRandomOffset = Number
                            end})
                        end

                        local DistanceScalingToggle = DamageFolder:Toggle({Name = "distance scaling", Flag = FlagStart .. 'DamageNumbers/DistanceScaling', Default = false, Callback = function(Boolean)
                            Visuals.DamageNumbers.Settings.DistanceScalingEnabled = Boolean
                        end}); local DistanceScalingFolder = DistanceScalingToggle:Settings() do
                            DistanceScalingFolder:Slider({ Name = "min distance", Flag = FlagStart .. 'DamageNumbers/MinDistance', Min = 1, Max = 50, Default = 1, Decimals = 1, Suffix = "st", Callback = function(Number)
                                Visuals.DamageNumbers.Settings.MinDistance = Number
                            end})

                            DistanceScalingFolder:Slider({ Name = "max distance", Flag = FlagStart .. 'DamageNumbers/MaxDistance', Min = 50, Max = 1500, Default = 50, Decimals = 5, Suffix = "st", Callback = function(Number)
                                Visuals.DamageNumbers.Settings.MaxDistance = Number
                            end})

                            DistanceScalingFolder:Slider({ Name = "min distance scale", Flag = FlagStart .. 'DamageNumbers/MinDistanceScale', Min = 0.1, Max = 1, Default = 0.7, Decimals = 0.1, Suffix = "x", Callback = function(Number)
                                Visuals.DamageNumbers.Settings.MinDistanceScale = Number
                            end})

                            DistanceScalingFolder:Slider({ Name = "max distance scale", Flag = FlagStart .. 'DamageNumbers/MaxDistanceScale', Min = 1, Max = 3, Default = 1, Decimals = 0.1, Suffix = "x", Callback = function(Number)
                                Visuals.DamageNumbers.Settings.MaxDistanceScale = Number
                            end})
                        end
                    end
                end

                local HitSoundToggle = VisualSettings:Toggle({ Name = "hit sounds", Flag = FlagStart .. 'Visuals/HitSound/Enabled', Default = false, Callback = function(Boolean)
                    Visuals.HitSound.Settings.Enabled = Boolean
                end}) do
                    local HitSoundFolder = HitSoundToggle:Settings() do
                        HitSoundFolder:Slider({ Name = "volume", Flag = FlagStart .. 'Visuals/HitSound/Volume', Min = 0, Max = 10, Default = 3, Decimals = 0.1, Suffix = "", Callback = function(Number)
                            Visuals.HitSound.Settings.Volume = Number
                        end})

                        HitSoundFolder:Slider({ Name = "pitch", Flag = FlagStart .. 'Visuals/HitSound/PlaybackSpeed', Min = 0.5, Max = 3, Default = 1, Decimals = 0.05, Suffix = "x", Callback = function(Number)
                            Visuals.HitSound.Settings.PlaybackSpeed = Number
                        end})

                        local HitSoundFiles = Visuals.HitSound.ScanFiles()
                        local HitSoundFileDropdown = HitSoundFolder:Dropdown({ Name = "file", Flag = FlagStart .. 'Visuals/HitSound/File', Multi = false, Default = HitSoundFiles[1], Items = HitSoundFiles, Callback = function(Option)
                            Visuals.HitSound.SelectFile(Option)
                            Visuals.HitSound.Preview()
                        end}) do
                            HitSoundFolder:Button({ Name = "refresh files", Callback = function()
                                local Items = Visuals.HitSound.ScanFiles()
                                HitSoundFileDropdown:Refresh(Items)
                                Library:Notification({ Name = "hit sounds: " .. tostring(#Items - 1) .. " file(s) found", Time = 4 })
                            end})
                        end
                    end
                end

                local TracersToggle = VisualSettings:Toggle({ Name = "tracers", Flag = FlagStart .. 'Visuals/Tracers/Enabled', Default = false, Callback = function(Boolean)
                    Visuals.Tracers.Settings.Enabled = Boolean
                end}) do
                    TracersToggle:Colorpicker({ Flag = FlagStart .. 'Visuals/Tracers/Color', Default = Color3FromRGB(255, 255, 255), Callback = function(Color, Alpha)
                        Visuals.Tracers.Settings.Color = Color
                    end})

                    local TracersFolder = TracersToggle:Settings() do
                        TracersFolder:Dropdown({ Name = "style", Flag = FlagStart .. 'Visuals/Tracers/Style', Multi = false, Default = 'Drawing', Items = { 'Drawing', 'Beam' }, Callback = function(Option)
                            Visuals.Tracers.Settings.Style = Option
                            if Visuals.Tracers.Clear then Visuals.Tracers.Clear() end
                        end})

                        TracersFolder:Dropdown({ Name = "origin", Flag = FlagStart .. 'Visuals/Tracers/OriginMode', Multi = false, Default = 'Head', Items = { 'Bottom', 'Camera', 'Head' }, Callback = function(Option)
                            Visuals.Tracers.Settings.OriginMode = Option
                        end})

                        TracersFolder:Slider({ Name = "lifetime", Flag = FlagStart .. 'Visuals/Tracers/Lifetime', Min = 0.1, Max = 10, Default = 2, Decimals = 0.1, Suffix = "s", Callback = function(Number)
                            Visuals.Tracers.Settings.Lifetime = Number
                        end})

                        TracersFolder:Slider({ Name = "thickness (drawing)", Flag = FlagStart .. 'Visuals/Tracers/Thickness', Min = 1, Max = 10, Default = 1, Decimals = 0.5, Suffix = "px", Callback = function(Number)
                            Visuals.Tracers.Settings.Thickness = Number
                        end})

                        TracersFolder:Dropdown({ Name = "beam texture", Flag = FlagStart .. 'Visuals/Tracers/BeamTexture', Multi = false, Default = 'ray1', Items = BeamTextureNames, Callback = function(Option)
                            Visuals.Tracers.Settings.BeamTexture = Option
                        end})

                        TracersFolder:Slider({ Name = "beam start width", Flag = FlagStart .. 'Visuals/Tracers/BeamWidth0', Min = 0.05, Max = 6, Default = 0.3, Decimals = 0.05, Suffix = "", Callback = function(Number)
                            Visuals.Tracers.Settings.BeamWidth0 = Number
                        end})

                        TracersFolder:Slider({ Name = "beam end width", Flag = FlagStart .. 'Visuals/Tracers/BeamWidth1', Min = 0.05, Max = 6, Default = 0.3, Decimals = 0.05, Suffix = "", Callback = function(Number)
                            Visuals.Tracers.Settings.BeamWidth1 = Number
                        end})

                        TracersFolder:Slider({ Name = "beam glow", Flag = FlagStart .. 'Visuals/Tracers/BeamLightEmission', Min = 0, Max = 1, Default = 1, Decimals = 0.05, Suffix = "", Callback = function(Number)
                            Visuals.Tracers.Settings.BeamLightEmission = Number
                        end})

                        TracersFolder:Toggle({ Name = "beam fade ends", Flag = FlagStart .. 'Visuals/Tracers/BeamTintEnds', Default = true, Callback = function(Boolean)
                            Visuals.Tracers.Settings.BeamTintEnds = Boolean
                        end})
                    end
                end
            end

            local CameraSection = VisualsMultiSection:Add('camera') do
                local function RefreshThirdPerson()
                    local MasterOn = Library.Flags[FlagStart .. 'ThirdPersonEnabled'] and true or false
                    local KeybindFlag = Library.Flags[FlagStart .. 'ThirdPersonKeybind']
                    local KeybindOn = (KeybindFlag == nil) or (KeybindFlag.Toggled and true or false)

                    Visuals.ThirdPerson.Enabled = MasterOn
                    Visuals.ThirdPerson.Active = MasterOn and KeybindOn
                end

                local ThirdPersonToggle = CameraSection:Toggle({Name = "third person", Flag = FlagStart .. 'ThirdPersonEnabled', Default = false, Callback = function(Boolean)
                    TaskScheduler:CreateQueueThread(RefreshThirdPerson)
                end}) do
                    ThirdPersonToggle:Keybind({Name = "third person", Flag = FlagStart .. 'ThirdPersonKeybind', ShowInKeybindsList = true, Mode = 'Toggle', Default = Enum.UserInputType.MouseButton3, Callback = function(Boolean)
                        TaskScheduler:CreateQueueThread(RefreshThirdPerson)
                    end})

                    local ThirdPersonFolder = ThirdPersonToggle:Settings() do
                        ThirdPersonFolder:Slider({ Name = "x offset", Flag = FlagStart .. 'ThirdPersonXOffset', Min = -25, Max = 25, Default = 0, Decimals = 0.5, Suffix = "st", Callback = function(Number)
                            Visuals.ThirdPerson.XOffset = Number
                        end})

                        ThirdPersonFolder:Slider({ Name = "y offset", Flag = FlagStart .. 'ThirdPersonYOffset', Min = -25, Max = 25, Default = 2, Decimals = 0.5, Suffix = "st", Callback = function(Number)
                            Visuals.ThirdPerson.YOffset = Number
                        end})

                        ThirdPersonFolder:Slider({ Name = "z offset", Flag = FlagStart .. 'ThirdPersonZOffset', Min = -25, Max = 25, Default = 8, Decimals = 0.5, Suffix = "st", Callback = function(Number)
                            Visuals.ThirdPerson.ZOffset = Number
                        end})
                    end
                end

                local function RefreshFOVChangerEnabled()
                    local MasterOn = Library.Flags[FlagStart .. 'FOVChangerEnabled'] and true or false
                    local KeybindFlag = Library.Flags[FlagStart .. 'FOVChangerKeybind']
                    local KeybindOn = (KeybindFlag == nil) or (KeybindFlag.Toggled and true or false)

                    Visuals.FOVChanger.SetEnabled(MasterOn and KeybindOn)
                end

                local FOVChangerToggle = CameraSection:Toggle({ Name = "fov changer", Flag = FlagStart .. 'FOVChangerEnabled', Default = false, Callback = function(Boolean)
                    TaskScheduler:CreateQueueThread(RefreshFOVChangerEnabled)
                end}) do
                    FOVChangerToggle:Keybind({ Name = "fov changer", Flag = FlagStart .. 'FOVChangerKeybind', ShowInKeybindsList = true, Mode = 'Always', Default = 'None', Callback = function(Boolean)
                        TaskScheduler:CreateQueueThread(RefreshFOVChangerEnabled)
                    end})

                    local FOVChangerFolder = FOVChangerToggle:Settings() do
                        FOVChangerFolder:Slider({ Name = "fov", Flag = FlagStart .. 'FOVChangerValue', Min = 1, Max = 120, Default = 90, Decimals = 1, Callback = function(Number)
                            Visuals.FOVChanger.Value = Number
                            Visuals.FOVChanger.Apply()
                        end})
                    end
                end

                local AspectRatioToggle = CameraSection:Toggle({ Name = "aspect ratio", Flag = FlagStart .. 'AspectRatioEnabled', Default = false, Callback = function(Boolean)
                    Visuals.AspectRatio.Enabled = Boolean
                end}) do
                    local AspectRatioFolder = AspectRatioToggle:Settings() do
                        AspectRatioFolder:Slider({ Name = "ratio", Flag = FlagStart .. 'AspectRatioValue', Min = 0.5, Max = 2, Default = 1, Decimals = 0.05, Suffix = "x", Callback = function(Number)
                            Visuals.AspectRatio.Ratio = Number
                        end})
                    end
                end
            end

            local EnvironmentSection = VisualsMultiSection:Add('environment') do
                local EnvFlag = 'Visuals/Environment/'
                local Environment = Visuals.Environment

                local V = Environment.Values
                local A = Environment.Atmo

                local function Clamp(Value, Min, Max)
                    if Value < Min then return Min end
                    if Value > Max then return Max end
                    return Value
                end

                local EnvMasterToggle = EnvironmentSection:Toggle({ Name = "enabled", Flag = EnvFlag .. 'Enabled', Default = false, Callback = function(Boolean)
                    TaskScheduler:CreateQueueThread(function()
                        Environment:SetEnabled(Boolean)
                    end)
                end}) do
                    local EnvFolder = EnvMasterToggle:Settings() do
                        local LightingToggle = EnvFolder:Toggle({ Name = "lighting", Flag = EnvFlag .. 'Lighting', Default = false, Callback = function(Boolean)
                            Environment:SetGroup('Lighting', Boolean)
                        end}) do
                            local LightingFolder = LightingToggle:Settings() do
                                LightingFolder:Slider({ Name = "brightness", Flag = EnvFlag .. 'Brightness', Min = 0, Max = 10, Default = Clamp(V.Brightness, 0, 10), Decimals = 0.1, Suffix = "", Callback = function(Number)
                                    Environment:Set('Brightness', Number)
                                end})

                                LightingFolder:Slider({ Name = "clock time", Flag = EnvFlag .. 'ClockTime', Min = 0, Max = 24, Default = Clamp(V.ClockTime, 0, 24), Decimals = 0.1, Suffix = "h", Callback = function(Number)
                                    Environment:Set('ClockTime', Number)
                                end})

                                LightingFolder:Slider({ Name = "exposure", Flag = EnvFlag .. 'Exposure', Min = -5, Max = 5, Default = Clamp(V.ExposureCompensation, -5, 5), Decimals = 0.1, Suffix = "", Callback = function(Number)
                                    Environment:Set('ExposureCompensation', Number)
                                end})

                                LightingFolder:Slider({ Name = "diffuse scale", Flag = EnvFlag .. 'DiffuseScale', Min = 0, Max = 1, Default = Clamp(V.EnvironmentDiffuseScale, 0, 1), Decimals = 0.05, Suffix = "", Callback = function(Number)
                                    Environment:Set('EnvironmentDiffuseScale', Number)
                                end})

                                LightingFolder:Slider({ Name = "specular scale", Flag = EnvFlag .. 'SpecularScale', Min = 0, Max = 1, Default = Clamp(V.EnvironmentSpecularScale, 0, 1), Decimals = 0.05, Suffix = "", Callback = function(Number)
                                    Environment:Set('EnvironmentSpecularScale', Number)
                                end})

                                LightingFolder:Toggle({ Name = "global shadows", Flag = EnvFlag .. 'GlobalShadows', Default = V.GlobalShadows and true or false, Callback = function(Boolean)
                                    Environment:Set('GlobalShadows', Boolean)
                                end})
                            end
                        end

                        local ColorsToggle = EnvFolder:Toggle({ Name = "colors", Flag = EnvFlag .. 'Colors', Default = false, Callback = function(Boolean)
                            Environment:SetGroup('Colors', Boolean)
                        end}) do
                            ColorsToggle:Colorpicker({ Flag = EnvFlag .. 'Ambient', Default = V.Ambient, Callback = function(Color, Alpha)
                                Environment:Set('Ambient', Color)
                            end})

                            ColorsToggle:Colorpicker({ Flag = EnvFlag .. 'OutdoorAmbient', Default = V.OutdoorAmbient, Callback = function(Color, Alpha)
                                Environment:Set('OutdoorAmbient', Color)
                            end})

                            ColorsToggle:Colorpicker({ Flag = EnvFlag .. 'ColorShiftTop', Default = V.ColorShift_Top, Callback = function(Color, Alpha)
                                Environment:Set('ColorShift_Top', Color)
                            end})

                            ColorsToggle:Colorpicker({ Flag = EnvFlag .. 'ColorShiftBottom', Default = V.ColorShift_Bottom, Callback = function(Color, Alpha)
                                Environment:Set('ColorShift_Bottom', Color)
                            end})
                        end

                        local FogToggle = EnvFolder:Toggle({ Name = "fog", Flag = EnvFlag .. 'Fog', Default = false, Callback = function(Boolean)
                            Environment:SetGroup('Fog', Boolean)
                        end}) do
                            FogToggle:Colorpicker({ Flag = EnvFlag .. 'FogColor', Default = V.FogColor, Callback = function(Color, Alpha)
                                Environment:Set('FogColor', Color)
                            end})

                            local FogFolder = FogToggle:Settings() do
                                FogFolder:Slider({ Name = "fog start", Flag = EnvFlag .. 'FogStart', Min = 0, Max = 10000, Default = Clamp(V.FogStart, 0, 10000), Decimals = 10, Suffix = "st", Callback = function(Number)
                                    Environment:Set('FogStart', Number)
                                end})

                                FogFolder:Slider({ Name = "fog end", Flag = EnvFlag .. 'FogEnd', Min = 0, Max = 100000, Default = Clamp(V.FogEnd, 0, 100000), Decimals = 100, Suffix = "st", Callback = function(Number)
                                    Environment:Set('FogEnd', Number)
                                end})
                            end
                        end

                        local AtmosphereToggle = EnvFolder:Toggle({ Name = "atmosphere", Flag = EnvFlag .. 'Atmosphere', Default = false, Callback = function(Boolean)
                            Environment:SetGroup('Atmosphere', Boolean)
                        end}) do
                            AtmosphereToggle:Colorpicker({ Flag = EnvFlag .. 'AtmoColor', Default = A.Color, Callback = function(Color, Alpha)
                                Environment:SetAtmo('Color', Color)
                            end})

                            AtmosphereToggle:Colorpicker({ Flag = EnvFlag .. 'AtmoDecay', Default = A.Decay, Callback = function(Color, Alpha)
                                Environment:SetAtmo('Decay', Color)
                            end})

                            local AtmosphereFolder = AtmosphereToggle:Settings() do
                                AtmosphereFolder:Slider({ Name = "density", Flag = EnvFlag .. 'AtmoDensity', Min = 0, Max = 1, Default = Clamp(A.Density, 0, 1), Decimals = 0.01, Suffix = "", Callback = function(Number)
                                    Environment:SetAtmo('Density', Number)
                                end})

                                AtmosphereFolder:Slider({ Name = "offset", Flag = EnvFlag .. 'AtmoOffset', Min = -1, Max = 1, Default = Clamp(A.Offset, -1, 1), Decimals = 0.05, Suffix = "", Callback = function(Number)
                                    Environment:SetAtmo('Offset', Number)
                                end})

                                AtmosphereFolder:Slider({ Name = "glare", Flag = EnvFlag .. 'AtmoGlare', Min = 0, Max = 10, Default = Clamp(A.Glare, 0, 10), Decimals = 0.1, Suffix = "", Callback = function(Number)
                                    Environment:SetAtmo('Glare', Number)
                                end})

                                AtmosphereFolder:Slider({ Name = "haze", Flag = EnvFlag .. 'AtmoHaze', Min = 0, Max = 10, Default = Clamp(A.Haze, 0, 10), Decimals = 0.1, Suffix = "", Callback = function(Number)
                                    Environment:SetAtmo('Haze', Number)
                                end})
                            end
                        end

                        local SkyboxToggle = EnvFolder:Toggle({ Name = "skybox", Flag = EnvFlag .. 'Skybox', Default = false, Callback = function(Boolean)
                            Environment:SetSky(Boolean)
                        end}) do
                            local SkyboxFolder = SkyboxToggle:Settings() do
                                SkyboxFolder:Dropdown({ Name = "preset", Flag = EnvFlag .. 'SkyboxPreset', Multi = false, Default = 'purple galaxy', Items = SkyboxNames, Callback = function(Option)
                                    Environment:SetSkyPreset(Option)
                                end})
                            end
                        end

                        EnvFolder:Dropdown({ Name = "technology", Flag = EnvFlag .. 'Technology', Multi = false, Default = 'Keep', Items = { 'Keep', 'Legacy', 'Voxel', 'ShadowMap', 'Future', 'Compatibility' }, Callback = function(Option)
                            Environment:SetTechnology(Option)
                        end})
                    end
                end
            end
        end

        local MiscPage = Window:Page({Name = "misc"}) do
            local MovementSection = MiscPage:Section({ Name = "movement", Side = 1 }) do
                local function RefreshSpeedEnabled()
                    local MasterOn = Library.Flags['Misc/Movement/SpeedEnabled'] and true or false
                    local KeybindFlag = Library.Flags['Misc/Movement/SpeedEnabledKey']
                    local KeybindOn = (KeybindFlag == nil) or (KeybindFlag.Toggled and true or false)

                    MiscFunctions.Settings.Movement.SpeedEnabled = MasterOn and KeybindOn
                end

                local SpeedhackToggle = MovementSection:Toggle({ Name = "speed hack", Flag = "Misc/Movement/SpeedEnabled", Default = MiscFunctions.Settings.Movement.SpeedEnabled, Callback = function(Boolean)
                    TaskScheduler:CreateQueueThread(RefreshSpeedEnabled)
                end}) local SpeedhackFolder = SpeedhackToggle:Settings() do
                    SpeedhackToggle:Keybind({Name = "speed hack", Flag = 'Misc/Movement/SpeedEnabledKey', ShowInKeybindsList = true, Mode = 'Hold', Default = Enum.KeyCode.LeftShift, Callback = function(Boolean)
                        TaskScheduler:CreateQueueThread(RefreshSpeedEnabled)
                    end})

                    SpeedhackFolder:Slider({ Name = "speed", Flag = "Misc/Movement/SpeedValue", Min = 1, Max = 500, Default = MiscFunctions.Settings.Movement.SpeedValue, Decimals = 1, Callback = function(Number)
                        MiscFunctions.Settings.Movement.SpeedValue = Number
                    end})
                end

                local function RefreshFlyEnabled()
                    local MasterOn = Library.Flags['Misc/Movement/FlyEnabled'] and true or false
                    local KeybindFlag = Library.Flags['Misc/Movement/FlyEnabledKey']
                    local KeybindOn = (KeybindFlag == nil) or (KeybindFlag.Toggled and true or false)

                    MiscFunctions.Settings.Movement.FlyEnabled = MasterOn and KeybindOn
                end

                local FlyhackToggle = MovementSection:Toggle({ Name = "fly hack", Flag = "Misc/Movement/FlyEnabled", Default = MiscFunctions.Settings.Movement.FlyEnabled, Callback = function(Boolean)
                    TaskScheduler:CreateQueueThread(RefreshFlyEnabled)
                end}) local FlyhackFolder = FlyhackToggle:Settings() do
                    FlyhackToggle:Keybind({Name = "fly hack", Flag = 'Misc/Movement/FlyEnabledKey', ShowInKeybindsList = true, Default = Enum.KeyCode.X, Callback = function(Boolean)
                        TaskScheduler:CreateQueueThread(RefreshFlyEnabled)
                    end})

                    FlyhackFolder:Slider({ Name = "speed", Flag = "Misc/Movement/FlySpeedValue", Min = 1, Max = 500, Default = MiscFunctions.Settings.Movement.SpeedValue, Decimals = 1, Callback = function(Number)
                        MiscFunctions.Settings.Movement.FlyValue = Number
                    end})
                end

                MovementSection:Dropdown({ Name = "direction", Flag = "Misc/Movement/DirectionMethod", Items = {'MoveDirection', 'Custom'}, Default = MiscFunctions.Settings.Movement.DirectionMethod, Callback = function(Option)
                    MiscFunctions.Settings.Movement.DirectionMethod = Option
                end})
            end

            local DesyncSection = MiscPage:Section({ Name = "desync", Side = 2 }) do
                local function RefreshDesyncEnabled()
                    local MasterOn = Library.Flags['Misc/Desync/Enabled'] and true or false
                    local KeybindFlag = Library.Flags['Misc/Desync/EnabledKey']
                    local KeybindOn = (KeybindFlag == nil) or (KeybindFlag.Toggled and true or false)

                    MiscFunctions.Settings.Desync.Enabled = MasterOn and KeybindOn
                end

                local DesyncToggle = DesyncSection:Toggle({ Name = "enabled", Flag = "Misc/Desync/Enabled", Default = MiscFunctions.Settings.Desync.Enabled, Callback = function(Boolean)
                    TaskScheduler:CreateQueueThread(RefreshDesyncEnabled)
                end}) do

                    DesyncToggle:Keybind({Name = "desync", Flag = 'Misc/Desync/EnabledKey', ShowInKeybindsList = true, Default = Enum.KeyCode.H, Callback = function(Boolean)
                        TaskScheduler:CreateQueueThread(RefreshDesyncEnabled)
                    end})

                    local DesyncSettings = DesyncToggle:Settings() do
                        DesyncSettings:Dropdown({ Name = "offset mode", Flag = "Misc/Desync/OffsetMode", Items = {'Manual', 'Random', 'Invisible'}, Default = MiscFunctions.Settings.Desync.Mode, Callback = function(Option)
                            MiscFunctions.Settings.Desync.Mode = Option
                        end})

                        DesyncSettings:Dropdown({ Name = "angles mode", Flag = "Misc/Desync/AngleMode", Items = {'Manual', 'Random', 'Spin'}, Default = MiscFunctions.Settings.Desync.Mode, Callback = function(Option)
                            MiscFunctions.Settings.Desync.AngleMode = Option
                        end})

                        DesyncSettings:Dropdown({ Name = "spin angles", Flag = "Misc/Desync/SpinAngles", Multi = true, Items = {'X', 'Y', 'Z'}, Default = MiscFunctions.Settings.Desync.SpinAngles, Callback = function(Option)
                            MiscFunctions.Settings.Desync.SpinAngles = Option
                        end})

                        DesyncSettings:Slider({ Name = "frames", Flag = "Misc/Desync/Tick", Min = 0, Max = 500, Default = 0, Decimals = 1, Callback = function(Number)
                            MiscFunctions.Settings.Desync.Tick = Number
                        end})

                        DesyncSettings:Slider({ Name = "spin speed", Flag = "Misc/Desync/SpinSpeed", Min = 1, Max = 500, Default = 50, Decimals = 1, Callback = function(Number)
                            MiscFunctions.Settings.Desync.SpinSpeed = Number
                        end})

                        DesyncSettings:Slider({ Name = "offset x", Flag = "Misc/Desync/OffsetX", Min = -100, Max = 100, Default = 0, Decimals = 1, Callback = function(Number)
                            MiscFunctions.Settings.Desync.ManualOffset = Vector3New(Number, MiscFunctions.Settings.Desync.ManualOffset.Y, MiscFunctions.Settings.Desync.ManualOffset.Z)
                        end})

                        DesyncSettings:Slider({ Name = "offset y", Flag = "Misc/Desync/OffsetY", Min = -100, Max = 100, Default = 0, Decimals = 1, Callback = function(Number)
                            MiscFunctions.Settings.Desync.ManualOffset = Vector3New(MiscFunctions.Settings.Desync.ManualOffset.X, Number, MiscFunctions.Settings.Desync.ManualOffset.Z)
                        end})

                        DesyncSettings:Slider({ Name = "offset z", Flag = "Misc/Desync/OffsetZ", Min = -100, Max = 100, Default = 0, Decimals = 1, Callback = function(Number)
                            MiscFunctions.Settings.Desync.ManualOffset = Vector3New(MiscFunctions.Settings.Desync.ManualOffset.X, MiscFunctions.Settings.Desync.ManualOffset.Y, Number)
                        end})

                        DesyncSettings:Slider({ Name = "min x", Flag = "Misc/Desync/OffsetMinX", Min = -100, Max = 100, Default = 0, Decimals = 1, Callback = function(Number)
                            MiscFunctions.Settings.Desync.RandomBounds.Min = Vector3New(Number, MiscFunctions.Settings.Desync.RandomBounds.Min.Y, MiscFunctions.Settings.Desync.RandomBounds.Min.Z)
                        end})

                        DesyncSettings:Slider({ Name = "min y", Flag = "Misc/Desync/OffsetMinY", Min = -100, Max = 100, Default = 0, Decimals = 1, Callback = function(Number)
                            MiscFunctions.Settings.Desync.RandomBounds.Min = Vector3New(MiscFunctions.Settings.Desync.RandomBounds.Min.X, Number, MiscFunctions.Settings.Desync.RandomBounds.Min.Z)
                        end})

                        DesyncSettings:Slider({ Name = "min z", Flag = "Misc/Desync/OffsetMinZ", Min = -100, Max = 100, Default = 0, Decimals = 1, Callback = function(Number)
                            MiscFunctions.Settings.Desync.RandomBounds.Min = Vector3New(MiscFunctions.Settings.Desync.RandomBounds.Min.X, MiscFunctions.Settings.Desync.RandomBounds.Min.Y, Number)
                        end})

                        DesyncSettings:Slider({ Name = "max x", Flag = "Misc/Desync/OffsetMaxX", Min = -100, Max = 100, Default = 0, Decimals = 1, Callback = function(Number)
                            MiscFunctions.Settings.Desync.RandomBounds.Max = Vector3New(Number, MiscFunctions.Settings.Desync.RandomBounds.Max.Y, MiscFunctions.Settings.Desync.RandomBounds.Max.Z)
                        end})

                        DesyncSettings:Slider({ Name = "max y", Flag = "Misc/Desync/OffsetMaxY", Min = -100, Max = 100, Default = 0, Decimals = 1, Callback = function(Number)
                            MiscFunctions.Settings.Desync.RandomBounds.Max = Vector3New(MiscFunctions.Settings.Desync.RandomBounds.Max.X, Number, MiscFunctions.Settings.Desync.RandomBounds.Max.Z)
                        end})

                        DesyncSettings:Slider({ Name = "max z", Flag = "Misc/Desync/OffsetMaxZ", Min = -100, Max = 100, Default = 0, Decimals = 1, Callback = function(Number)
                            MiscFunctions.Settings.Desync.RandomBounds.Max = Vector3New(MiscFunctions.Settings.Desync.RandomBounds.Max.X, MiscFunctions.Settings.Desync.RandomBounds.Max.Y, Number)
                        end})

                        DesyncSettings:Slider({ Name = "angle x", Flag = "Misc/Desync/AngleX", Min = -180, Max = 180, Default = 0, Decimals = 1, Callback = function(Number)
                            MiscFunctions.Settings.Desync.ManualAngles = Vector3New(Number, MiscFunctions.Settings.Desync.ManualAngles.Y, MiscFunctions.Settings.Desync.ManualAngles.Z)
                        end})

                        DesyncSettings:Slider({ Name = "angle y", Flag = "Misc/Desync/AngleY", Min = -180, Max = 180, Default = 0, Decimals = 1, Callback = function(Number)
                            MiscFunctions.Settings.Desync.ManualAngles = Vector3New(MiscFunctions.Settings.Desync.ManualAngles.X, Number, MiscFunctions.Settings.Desync.ManualAngles.Z)
                        end})

                        DesyncSettings:Slider({ Name = "angle z", Flag = "Misc/Desync/AngleZ", Min = -180, Max = 180, Default = 0, Decimals = 1, Callback = function(Number)
                            MiscFunctions.Settings.Desync.ManualAngles = Vector3New(MiscFunctions.Settings.Desync.ManualAngles.X, MiscFunctions.Settings.Desync.ManualAngles.Y, Number)
                        end})
                    end
                end

            end
        end

        local SettingsPage = Window:InitWindow() do
            local VisibleCheckSettings = SettingsPage:Section({ Name = "visible-check settings", Side = 1}) do
                VisibleCheckSettings:Toggle({Name = "ignore non-collidable", Flag = 'Settings/VisibleCheck/IgnoreNonCollidable', Default = true, Callback = function(Boolean)
                    Aimbot.VisibleCheckSettings.IgnoreNonCollidable = Boolean
                end})

                VisibleCheckSettings:Slider({ Name = "max pierces", Flag = "Settings/VisibleCheck/MaxPierces", Min = 1, Max = 15, Default = 1, Decimals = 1, Suffix = "", Callback = function(Number)
                    Aimbot.VisibleCheckSettings.MaxPierces = Number
                end})

                VisibleCheckSettings:Slider({ Name = "transparency threshold", Flag = "Settings/VisibleCheck/TransparencyThreshold", Min = 0, Max = 1, Default = 1, Decimals = .05, Suffix = "", Callback = function(Number)
                    Aimbot.VisibleCheckSettings.TransparencyThreshold = Number
                end})

                VisibleCheckSettings:Dropdown({ Name = "scan origin", Default = 'Camera', Flag = "Settings/VisibleCheck/Origin", Items = {'Head', 'Camera'}, Multi = false, Callback = function(Option)
                    Aimbot.VisibleCheckSettings.ScanOrigin = Option
                end})
            end
        end
    end

    Library:Notification({
        Name = "@0f14 was here <33333333333333",
        Time = 5
    })
end

