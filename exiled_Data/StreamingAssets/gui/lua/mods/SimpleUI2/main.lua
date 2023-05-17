local mod = {}

-- Global Mod Variables
mod.x = 320
mod.y = 320
mod.hidden = true

-- Load Function
mod.OnLoad = function()
	mod.panel = newPanel(mod.x, mod.y, 256, 128)
	mod.panel:AddComponent("Mask")
	mod.panel:AddComponent("Dragable")
	mod.panel:SetImage("menu_bg")
	mod.panel:Hide()
	mod.button = newButton(-40, 16, 24, 24, mod.panel)
	mod.button:SetAlignment("right", "top")
	mod.button:SetColor(255, 0, 0, 255)
	mod.button:OnButtonClick("ToggleSimpleUI2")
	mod.text = newText(0, 0, 24, 24, mod.button)
	mod.text:SetText("x")
	mod.text:SetColor(255, 0, 0, 255)
end

-- Destroy Function
mod.OnDestroy = function()
	mod.panel:Clear()
	mod.button:Clear()
	mod.text:Clear()
end

-- Global Function "ToggleSimpleUI2"
function ToggleSimpleUI2()
	mod.hidden = not mod.hidden

	if mod.hidden then
		mod.panel:Hide()
	else
		mod.panel:Show()
	end
end

return mod