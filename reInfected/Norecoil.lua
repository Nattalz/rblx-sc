-- Simple no Recoil
local oldRandom = math.random
math.random = function(...)
	return 0 
end
