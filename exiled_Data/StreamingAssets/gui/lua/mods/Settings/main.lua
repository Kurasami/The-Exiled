require("lua/libs/TSerial")

local mod = {}

-- Global Mod Variables
--mod.x = 320
--mod.y = 320
mod.hidden = true
mod.path = GetModPath() .. "mods.lua"

-- Load Function
mod.OnLoad = function()
	-----------------------
	-- ModManager Window --
	-----------------------
	-- Window
	mod.pnlWindow = newPanel(-128, -128, 256, 256)
	mod.pnlWindow:SetAlignment("center", "middle")
	mod.pnlWindow:AddComponent("Mask")
	mod.pnlWindow:AddComponent("Dragable")
	mod.pnlWindow:SetImage("menu_bg")
	mod.pnlWindow:AddComponent("Shadow")
	mod.pnlWindow:SetShadowAlpha(127)
	mod.pnlWindow:SetShadowPosition(4, 4)
	mod.pnlWindow:Hide()
	-- Text
	mod.txtTitle = newText(8, 16, 240, 24, mod.pnlWindow)
	mod.txtTitle:SetText("Settings")
	mod.txtTitle:SetTextAlign("center", "middle")
	mod.txtTitle:SetColor(255, 255, 127, 255)
	-- Close Button
	mod.btnClose = newButton(-40, 16, 24, 24, mod.pnlWindow)
	mod.btnClose:SetAlignment("right", "top")
	mod.btnClose:SetImage("border_white")
	mod.btnClose:SetColor(191, 0, 0, 255)
	mod.btnClose:OnButtonClick("ToggleSettings")
	mod.txtClose = newText(0, 0, 24, 24, mod.btnClose)
	mod.txtClose:SetText("x")
	mod.txtClose:SetFont("OpenSans-Semibold")
	mod.txtClose:SetTextAlign("center", "top")
	mod.txtClose:SetColor(255, 255, 255, 255)
	mod.txtClose:AddComponent("Outline")
	mod.txtClose:SetOutlineColor(0, 0, 0, 127)
end

-- Destroy Function
mod.OnDestroy = function()
	mod.pnlWindow:Clear()
	mod.txtTitle:Clear()
	mod.btnClose:Clear()
	mod.txtClose:Clear()
end

-- Global Functions
function ToggleSettings()
	mod.hidden = not mod.hidden

	if mod.hidden then
		mod.pnlWindow:Hide()
		SetSettingsMenu(false)
	else
		mod.pnlWindow:Show()
		SetSettingsMenu(true)
	end
end

return mod
