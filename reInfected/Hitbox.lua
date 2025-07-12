--// Settings / Feel freeto customize
local HEAD_HITBOX_SIZE = Vector3.new(4, 4, 4) -- Sizes
local DEBUG_TRANSPARENCY = 0.8 -- Transparency / 1 is invisible
local DEBUG_COLOR = Color3.fromRGB(255, 0, 0) -- Zombo hitbox colour
local P_COLOR = Color3.fromRGB(0, 225, 0) -- Player Colour

--// Ignore TS
local a=game:GetService"Players"
local b=a.LocalPlayer
local c=workspace.CurrentCamera
local d=b:GetMouse()


local function ExpandHead(e,f)
if e and e:IsA"BasePart"then
e.Size=HEAD_HITBOX_SIZE
e.Transparency=DEBUG_TRANSPARENCY
e.Color=DEBUG_COLOR
e.Material=Enum.Material.Neon
e.CanCollide=false
e.Massless=true
if f then
e.Color=P_COLOR
end

end
end


for e,f in ipairs(workspace:WaitForChild"AI_Zombies":GetChildren())do
ExpandHead(f:FindFirstChild"Head")
end

workspace.AI_Zombies.ChildAdded:Connect(function(e)
task.wait(0.1)
ExpandHead(e:FindFirstChild"Head")
end)


local function UpdatePlayerHitboxes()
for e,f in ipairs(a:GetPlayers())do
if f.Team and f.Team.Name=="Zombies"and f.Character then
local g=f.Character:FindFirstChild"Head"
ExpandHead(g,"player")
end
end
end

a.PlayerAdded:Connect(function(e)
e.CharacterAdded:Connect(function()
task.wait(0.1)
UpdatePlayerHitboxes()
end)
end)

game:GetService"RunService".Heartbeat:Connect(UpdatePlayerHitboxes)


local function GetClosestTargetHead()
local e
local f=math.huge

local function checkCandidate(g)
local h,i=c:WorldToScreenPoint(g.Position)
if i then
local j=(Vector2.new(d.X,d.Y)-Vector2.new(h.X,h.Y)).Magnitude
if j<f then
f=j
e=g
end
end
end


for g,h in ipairs(a:GetPlayers())do
if h~=b and h.Team and h.Team.Name=="Zombies"and h.Character then
local i=h.Character:FindFirstChild"Head"
if i then checkCandidate(i)end
end
end


for g,h in ipairs(workspace:WaitForChild"AI_Zombies":GetChildren())do
local i=h:FindFirstChild"Head"
if i then checkCandidate(i)end
end

return e
end



