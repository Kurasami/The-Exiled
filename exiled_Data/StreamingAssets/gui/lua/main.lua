-- API Documentation:
-- http://www.fairytale-distillery.com/docs/LuaGuiAPI/

modlist = require("lua/mods")
mods = {}

for k, mod in pairs(modlist) do
	if mod.active then
		mods[#mods + 1] = require("lua/mods/" .. mod.name .. "/main")
	end
end

function OnLoad()
	for k, mod in pairs(mods) do
		if mod.OnLoad then
			mod.OnLoad()
		end
	end
end

function OnUpdate()
	for k, mod in pairs(mods) do
		if mod.OnUpdate then
			mod.OnUpdate()
		end
	end
end

function OnDestroy()
	for k, mod in pairs(mods) do
		if mod.OnDestroy then
			mod.OnDestroy()
		end
	end
end

function OnPlayerLoad(player)
	for k, mod in pairs(mods) do
		if mod.OnPlayerLoad then
			mod.OnPlayerLoad(player)
		end
	end
end

function OnPlayerDestroy(player)
	for k, mod in pairs(mods) do
		if mod.OnPlayerDestroy then
			mod.OnPlayerDestroy(player)
		end
	end
end

function OnEnemyLoad(enemy)
	for k, mod in pairs(mods) do
		if mod.OnEnemyLoad then
			mod.OnEnemyLoad(enemy)
		end
	end
end

function OnEnemyDestroy(enemy)
	for k, mod in pairs(mods) do
		if mod.OnEnemyDestroy then
			mod.OnEnemyDestroy(enemy)
		end
	end
end

function OnMouseHit(key, x, y)
	for k, mod in pairs(mods) do
		if mod.OnMouseHit then
			mod.OnMouseHit(key, x, y)
		end
	end
end

function OnKeyHit(key, code, isShift, isAlt)
	for k, mod in pairs(mods) do
		if mod.OnKeyHit then
			mod.OnKeyHit(key, code, isShift, isAlt)
		end
	end
end