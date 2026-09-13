-- Fast Clicker Integration Example
-- Add this to any game script to enable fast clicking

local FastClicker = require(script.Parent:WaitForChild("FastClicker"))

-- Initialize with 100 clicks per second (adjust as needed)
local clicker = FastClicker.new(100)

-- Option 1: Start clicking immediately
-- clicker:start()

-- Option 2: Setup hotkey to toggle (press 'X' to start/stop)
clicker:setupHotkey(Enum.KeyCode.X)

-- Option 3: Programmatically control
-- clicker:start()
-- task.wait(5)
-- clicker:stop()
-- clicker:setCPS(200) -- Increase to 200 CPS

-- Monitor clicks
spawn(function()
    while true do
        task.wait(5)
        if clicker:getCPS() then
            print("[Info] Current CPS: " .. clicker:getCPS())
        end
    end
end)

-- Cleanup on script removal
script.Parent.AncestryChanged:Connect(function()
    if not script.Parent:IsDescendantOf(workspace) then
        clicker:stop()
    end
end)
