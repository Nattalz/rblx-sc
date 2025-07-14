
local a=Vector3.new(4,4,4)
local b=0.8
local c=Color3.fromRGB(255,0,0)


local d=game:GetService"Players"
local e=d.LocalPlayer
local f=workspace.CurrentCamera
local g=e:GetMouse()
local h=game:GetService"RunService"

local i=600
local j=0.2
local k=0
local l

local m={}


local function ExpandHead(n)
if n and n:IsA"BasePart"then
n.Size=a
n.Transparency=b
n.Color=c
n.Material=Enum.Material.Neon
n.CanCollide=false
n.Massless=true
end
end


local function highlightZombie(n)
if not n or n:FindFirstChild"ZombieHighlight"then return end

local o=Instance.new"Highlight"
o.Name="ZombieHighlight"
o.FillTransparency=1
o.OutlineTransparency=0
o.OutlineColor=Color3.fromRGB(0,255,0)
o.Adornee=n
o.Parent=n


local p=n:FindFirstChildOfClass"Humanoid"
if p then
p.Died:Connect(function()
if o then o:Destroy()end
end)
end
end


local function setupPlayer(n)
local function handleChar(o)
task.wait(0.1)
if n.Team and n.Team.Name=="Zombies"then
local p=o:FindFirstChild"Head"
if p then ExpandHead(p)end
highlightZombie(o)
end
end


n.CharacterAdded:Connect(handleChar)


n:GetPropertyChangedSignal"Team":Connect(function()
local o=n.Character
if o then
if n.Team and n.Team.Name=="Zombies"then
highlightZombie(o)
else
local p=o:FindFirstChild"ZombieHighlight"
if p then p:Destroy()end
end
end
end)


if n.Character then handleChar(n.Character)end
end


for n,o in ipairs(workspace:WaitForChild"AI_Zombies":GetChildren())do
ExpandHead(o:FindFirstChild"Head")
end

workspace.AI_Zombies.ChildAdded:Connect(function(n)
task.wait(0.1)
ExpandHead(n:FindFirstChild"Head")
end)


h.Heartbeat:Connect(function()
local n={}

for o,p in ipairs(d:GetPlayers())do
if p~=e and p.Team and p.Team.Name=="Zombies"and p.Character then
local q=p.Character:FindFirstChild"Head"

if q then
ExpandHead(q)
n[p.Character]=true
end
end
end

for o,p in pairs(m)do
if not n[o]or not o.Parent then
if p and p.Parent then
p:Destroy()
end
m[o]=nil
end
end
end)


for n,o in ipairs(d:GetPlayers())do
setupPlayer(o)
end


d.PlayerAdded:Connect(setupPlayer)



local function GetClosestTargetHead()
if tick()-k<j then
return l
end
k=tick()

local n=Vector2.new(g.X,g.Y)
local o={
player={head=nil,dist=math.huge},
deathwalker={head=nil,dist=math.huge},
Patientzero={head=nil,dist=math.huge},
Necromancer={head=nil,dist=math.huge},
Influencer={head=nil,dist=math.huge},
Siren={head=nil,dist=math.huge},
other={head=nil,dist=math.huge}
}

local function isValid(p)
if not p then return false end
local q=p:FindFirstAncestorOfClass"Model"
local r=q and q:FindFirstChildOfClass"Humanoid"
if not r or r.Health<=0 then return false end
local s=p.Position-f.CFrame.Position
if s.Magnitude>i then return false end
local t=s.Unit:Dot(f.CFrame.LookVector)
return t>0.5 and s.Magnitude>3
end

local function checkCandidate(p,q)
if isValid(p)then
local r,s=f:WorldToScreenPoint(p.Position)
if s then
local t=(n-Vector2.new(r.X,r.Y)).Magnitude
if t<o[q].dist then
o[q].head=p
o[q].dist=t
end
end
end
end


for p,q in ipairs(d:GetPlayers())do
if q~=e
and q.Team and q.Team.Name=="Zombies"
and q.Character
and not q.Name:lower():match"^nat_gameng%d+"then

local r=q.Character:FindFirstChild"Head"
local s=q.Character:FindFirstChildOfClass"Humanoid"
if r and s and s.Health>0 then
checkCandidate(r,"player")
end
end
end


local p=workspace:FindFirstChild"AI_Zombies"
if p then
for q,r in ipairs(p:GetChildren())do
local s=r:FindFirstChild"Head"
if s then
local t=r.Name:lower()
if t:find"deathwalker"then
checkCandidate(s,"deathwalker")
elseif t:find"patientzero"then
checkCandidate(s,"Patientzero")
elseif t:find"necromancer"then
checkCandidate(s,"Necromancer")
elseif t:find"influencer"then
checkCandidate(s,"Influencer")
elseif t:find"siren"then
checkCandidate(s,"Siren")
else
checkCandidate(s,"other")
end
end
end
end


l=o.player.head
or o.deathwalker.head
or o.Patientzero.head
or o.Necromancer.head
or o.Influencer.head
or o.Siren.head
or o.other.head

return l
end


local n
n=hookmetamethod(game,"__namecall",function(o,...)
local p={...}
local q=getnamecallmethod()

if q=="FireServer"and tostring(o)=="ByteNetReliable"then
if typeof(p[2])=="table"then
local r=GetClosestTargetHead()
if r then
local s=r:FindFirstAncestorOfClass"Model"
if s then
p[2]={s,r,s,r,s,r}
end
end
end
return o.FireServer(o,unpack(p))
end

return n(o,...)
end)
print"✅ Silent Aim + Hitbox Expander + Highlights Loaded"



print"✅ Maded  by Naetl"
