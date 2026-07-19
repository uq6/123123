-- Cached
local Genv = getgenv()
--
local newcclosure = Genv.newcclosure or function(Function) return Function end
local hookfunction = Genv.hookfunction
local hookmetamethod = Genv.hookmetamethod
local isfunctionhooked = Genv.isfunctionhooked
local restorefunction = Genv.restorefunction
local getrawmetatable = getrawmetatable
--
-- 安全调用 hook 主体: 逻辑出错就退回原始函数/方法, 绝不让错误从 hook 里抛给游戏代码。
-- (被 hook 的通常是热路径 —— raycast / __namecall 等 —— 一次抛错就会让调用它的每处崩)
-- 用固定的返回槽(最多 6 个)转发, 避免 table.pack 在热路径上每次分配; 这些被 hook 的 API 返回值都 <= 3 个。
local function SafeInvoke(Function, Old, ...)
    local Ok, r1, r2, r3, r4, r5, r6 = pcall(Function, Old, ...)
    if Ok then
        return r1, r2, r3, r4, r5, r6
    end
    return Old(...)
end
--
local HookManager = {
    _Registry = {
        Functions = {},
        Metamethods = {}
    }
}

-- NewFunction 约定签名: function(Old, ...) —— Old(原始函数)由 HookManager 注入。
-- 注意: hookfunction 调用替身时只传原始调用参数, 不会自动带 Old, 所以必须在这里注入(否则 hook 里的 Old 会是 self, 调用即崩)。
function HookManager:HookFunction(TargetFunction, NewFunction)
    if not (hookfunction and TargetFunction and NewFunction) then return end
    if self._Registry.Functions[TargetFunction] then return end

    local Old
    local Replacement = newcclosure(function(...)
        if not Old then return end -- 装载瞬间的极端兜底
        return SafeInvoke(NewFunction, Old, ...)
    end)

    local Ok, Result = pcall(hookfunction, TargetFunction, Replacement)
    if not Ok then return end

    Old = Result
    self._Registry.Functions[TargetFunction] = TargetFunction
    return Old
end

-- 这里的 NewFunction 是调用方已经准备好的闭包(自行用 newcclosure + 捕获 Old)。
-- __namecall 这种超热路径不在这里包 pcall(避免每次方法调用都付开销); 由调用方在 body 里对"真正重定向"那一步做选择性 pcall。
function HookManager:HookMetamethod(Object, Metamethod, NewFunction)
    if not (hookmetamethod and Object and Metamethod and NewFunction) then return end

    -- 已经 hook 过同一个就先还原, 避免重复注入把 hook 层层叠加
    if self._Registry.Metamethods[Object] == Metamethod then
        self:RestoreMetamethod(Object, Metamethod)
    end

    local Ok, Old = pcall(hookmetamethod, Object, Metamethod, NewFunction)
    if not Ok then return end

    self._Registry.Metamethods[Object] = Metamethod
    return Old
end

function HookManager:RestoreFunction(Function)
    if not (restorefunction and Function) then return end

    -- isfunctionhooked 有些执行器没有; 没有就直接尝试还原(用 pcall 兜住)
    local ShouldRestore = true
    if isfunctionhooked then
        local Ok, Hooked = pcall(isfunctionhooked, Function)
        ShouldRestore = Ok and Hooked and true or false
    end

    if ShouldRestore then
        pcall(restorefunction, Function)
    end
end

function HookManager:RestoreMetamethod(Object, Metamethod)
    if not (restorefunction and Object and Metamethod) then return end

    -- 取 metatable 里的 metamethod 来还原; 没有 metatable / 取不到就安静跳过, 不崩
    local Ok, Function = pcall(function()
        if not getrawmetatable then return nil end
        local Metatable = getrawmetatable(Object)
        return Metatable and rawget(Metatable, Metamethod)
    end)

    if Ok and Function then
        self:RestoreFunction(Function)
    end

    self._Registry.Metamethods[Object] = nil
end

function HookManager:RestoreAll()
    for _, Target in pairs(self._Registry.Functions) do
        self:RestoreFunction(Target)
    end

    for Object, Metamethod in pairs(self._Registry.Metamethods) do
        self:RestoreMetamethod(Object, Metamethod)
    end

    self._Registry.Functions = {}
    self._Registry.Metamethods = {}
end

return HookManager
