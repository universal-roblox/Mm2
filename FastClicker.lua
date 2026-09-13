-- FastClicker Module for Roblox Games
-- Provides optimized clicking functionality for all games

local FastClicker = {}
FastClicker.__index = FastClicker

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Configuration
local Config = {
    clicksPerSecond = 100,
    maxCPS = 1000,
    minCPS = 1,
    holdDuration = 0.01,
    mouseButton = Enum.UserInputType.MouseButton1,
}

-- Create new FastClicker instance
function FastClicker.new(clicksPerSecond)
    local self = setmetatable({}, FastClicker)
    
    self.cps = math.clamp(clicksPerSecond or Config.clicksPerSecond, Config.minCPS, Config.maxCPS)
    self.isClicking = false
    self.clickInterval = 1 / self.cps
    self.lastClickTime = 0
    self.targetButton = nil
    
    return self
end

-- Start clicking
function FastClicker:start(targetButton)
    if self.isClicking then return end
    
    self.targetButton = targetButton or Config.mouseButton
    self.isClicking = true
    self.lastClickTime = tick()
    
    self:_setupClickLoop()
    print("[FastClicker] Started - CPS: " .. self.cps)
end

-- Stop clicking
function FastClicker:stop()
    self.isClicking = false
    print("[FastClicker] Stopped")
end

-- Set clicks per second
function FastClicker:setCPS(newCPS)
    self.cps = math.clamp(newCPS, Config.minCPS, Config.maxCPS)
    self.clickInterval = 1 / self.cps
    print("[FastClicker] CPS updated to: " .. self.cps)
end

-- Get current CPS
function FastClicker:getCPS()
    return self.cps
end

-- Internal click loop
function FastClicker:_setupClickLoop()
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not self.isClicking then
            connection:Disconnect()
            return
        end
        
        local currentTime = tick()
        if currentTime - self.lastClickTime >= self.clickInterval then
            self:_click()
            self.lastClickTime = currentTime
        end
    end)
end

-- Perform a single click
function FastClicker:_click()
    if self.targetButton == Config.mouseButton then
        self:_mouseClick()
    else
        self:_keyPress(self.targetButton)
    end
end

-- Simulate mouse click
function FastClicker:_mouseClick()
    local mouse = game.Players.LocalPlayer:GetMouse()
    local clickPosition = mouse.Hit.Position
    
    UserInputService:SendMouseButtonEvent(mouse.X, mouse.Y, 0, true)
    task.wait(self.holdDuration)
    UserInputService:SendMouseButtonEvent(mouse.X, mouse.Y, 0, false)
end

-- Simulate key press
function FastClicker:_keyPress(keyCode)
    UserInputService:SendKeyEvent(true, keyCode, false)
    task.wait(self.holdDuration)
    UserInputService:SendKeyEvent(false, keyCode, false)
end

-- Toggle clicking with hotkey
function FastClicker:setupHotkey(keyCode)
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == keyCode then
            if self.isClicking then
                self:stop()
            else
                self:start()
            end
        end
    end)
end

return FastClicker
