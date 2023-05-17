local mod = {}

-- Global Mod Variables
mod.sprCount = 32
mod.time = 0
mod.speed = 0.1
mod.range = 16

-- Load Function
mod.OnLoad = function()
	mod.spr = {}
	mod.rnd = {}
	mod.pos = {}

	for i = 1, mod.sprCount do
		mod.rnd[i] = math.random(0, 100) * 0.01
		mod.pos[i] = {}
		mod.pos[i].x = math.random(0, GetScreenWidth())
		mod.pos[i].y = math.random(0, GetScreenHeight())
		mod.spr[i] = newSprite(mod.pos[i].x, mod.pos[i].y, 64, 64)
		mod.spr[i]:SetImage("icon-effect-soothing")
		mod.spr[i]:SetColor(math.random(0, 256), math.random(0, 256), math.random(0, 256), 127)
		--Shader can't be set at the moment
		--mod.spr[i]:SetShader("Particles/Additive")
	end
end

-- Update Function
mod.OnUpdate = function()
	mod.time = mod.time + mod.speed
	for i = 1, mod.sprCount do
		mod.spr[i]:SetPosition(mod.pos[i].x + math.sin(mod.time + mod.rnd[i]) * mod.range, mod.pos[i].y - math.cos(mod.time + mod.rnd[i]) * mod.range)
	end
end

-- Destroy Function
mod.OnDestroy = function()
	for i = 1, mod.sprCount do
		mod.spr[i]:Clear()
	end
end

return mod