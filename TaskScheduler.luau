--!native
--!optimize 2
--!strict
--

local Genv = getgenv()

if Genv.TaskScheduler then -- [FIX] 原来写成 TaskSchedduler(拼错), 自卸载永远不触发, 重复注入会叠加循环
    Genv.TaskScheduler:Unload()
end

--

local TableFind = table.find
local TableInsert = table.insert
local TableRemove = table.remove
local TableClear = table.clear

--

local TaskWait = task.wait
local TaskDefer = task.defer
local TaskDelay = task.delay
local TaskSpawn = task.spawn
local TaskCancel = task.cancel

--

local CoroutineStatus = coroutine.status
local CoroutineRunning = coroutine.running

--

local TaskScheduler = {
    Loops = {},
    Threads = {}, -- [OPT] 改为字典 (Thread -> true): 增删 O(1), 原来 TableFind 是 O(n) 且同步完成的线程会漏删 (泄漏)
} do

    local Threads = TaskScheduler.Threads

    local function TrackThread(Thread)
        -- 同步执行完的函数在 TaskSpawn 返回前就结束了, 不需要跟踪
        if CoroutineStatus(Thread) ~= "dead" then
            Threads[Thread] = true
        end

        return Thread
    end

    local function UntrackRunning()
        Threads[CoroutineRunning()] = nil
    end

    function TaskScheduler:CreateThread(Function, ...)
        local Thread = TaskSpawn(function(...)
            Function(...)
            UntrackRunning()
        end, ...)

        return TrackThread(Thread)
    end

    function TaskScheduler:CreateDelayThread(Delay, Function, ...)
        local Thread = TaskDelay(Delay, function(...)
            Function(...)
            UntrackRunning()
        end, ...)

        return TrackThread(Thread)
    end

    function TaskScheduler:CreateQueueThread(Function, ...)
        local Thread = TaskDefer(function(...)
            Function(...)
            UntrackRunning()
        end, ...)

        return TrackThread(Thread)
    end

    function TaskScheduler:AddLoop(LoopName, WaitTime, Function)
        if TaskScheduler.Loops[LoopName] then
            TaskScheduler:StopLoop(LoopName)
        end

        local IsRunning = true

        local Thread = TaskScheduler:CreateThread(function()
            while IsRunning do
                local DeltaTime = TaskWait(WaitTime)

                if not IsRunning then
                    break
                end

                Function(DeltaTime)
            end
        end)

        TaskScheduler.Loops[LoopName] = {
            Thread = Thread,

            Stop = function()
                IsRunning = false
            end
        }

        return LoopName
    end

    function TaskScheduler:StopLoop(LoopName)
        local Loop = TaskScheduler.Loops[LoopName]
        if not Loop then return end

        Loop.Stop()

        if CoroutineStatus(Loop.Thread) ~= "dead" then
            TaskCancel(Loop.Thread)
        end

        Threads[Loop.Thread] = nil
        TaskScheduler.Loops[LoopName] = nil
    end

    function TaskScheduler:Unload()
        for LoopName, _ in TaskScheduler.Loops do
            TaskScheduler:StopLoop(LoopName)
        end

        TableClear(TaskScheduler.Loops)

        for Thread, _ in Threads do
            if typeof(Thread) == "thread" and CoroutineStatus(Thread) ~= "dead" then
                TaskCancel(Thread)
            end
        end

        TableClear(Threads)
    end
end

Genv.TaskScheduler = TaskScheduler

local function testfunction()
    local test = 'blahblah'
    
    for i = 1,10 do
        if not debug.info(i, 'f') then
            break
        end

        local a = getfenv(i)
        if a.hookfunction then
            return 'try harder buddy'
        end
    end
end

return TaskScheduler
