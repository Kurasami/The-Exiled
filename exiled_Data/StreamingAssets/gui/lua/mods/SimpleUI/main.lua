local mod = {}

-- Global Mod Variables
mod.x = 256
mod.y = 256

-- Load Function
mod.OnLoad = function()
	mod.panel = newPanel(mod.x, mod.y, 256, 128)
	mod.panel:AddComponent("Mask")
	mod.panel:SetImage("menu_bg")
	mod.button = newButton(-40, 16, 24, 24, mod.panel)
	mod.button:SetAlignment("right", "top")
	mod.text = newText(0, 0, 24, 24, mod.button)
	mod.text:SetText("?")
	mod.text:SetColor(0, 255, 0, 255)
	mod.button2 = newButton(16, 48, 64, 64, mod.panel)
	mod.button2:OnButtonClick("ToggleSimpleUI2")
	--mod.button2:AddComponent("Dragable")
	mod.spr = newSprite(8, 8, 48, 48, mod.button2)
	mod.spr:SetImage("icon-effect-invul")
end

-- Destroy Function
mod.OnDestroy = function()
	mod.panel:Clear()
	mod.button:Clear()
	mod.text:Clear()
	mod.button2:Clear()
	mod.spr:Clear()
end

return mod