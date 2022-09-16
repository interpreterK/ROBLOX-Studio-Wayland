local S = setmetatable({}, {
    __index = function(k,s)
        if not rawget(k,s) then
            k[s] = game:GetService(s)
        end
        return rawget(k,s)
    end
})
local UIS = S.UserInputService
local Camera = workspace.CurrentCamera
if not Camera then
    repeat
        task.wait()
    until workspace.CurrentCamera ~= nil
    Camera = workspace.CurrentCamera
end

local Sens = 5
 
local function Rotate(Hit)
    local function m_2D_3DVector()
        local SPTR = Camera:ScreenPointToRay(Hit.x,Hit.y,0)
        return (SPTR.Origin+Camera.CFrame.LookVector+SPTR.Direction*(Camera.CFrame.p-Hit).Magnitude*2)
    end
    local M_pos = m_2D_3DVector()/Sens
    Camera.CFrame=CFrame.lookAt(Camera.CFrame.p,Vector3.new(M_pos.x,M_pos.y,M_pos.z))
end
UIS.InputChanged:Connect(function(input, _)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if UIS:IsKeyDown(Enum.KeyCode.Space) then
            Rotate(input.Position)
        end
    end
end)

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    Camera = workspace.CurrentCamera
end)