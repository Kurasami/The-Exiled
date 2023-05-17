require("lua/libs/TSerial")

local mod = {}

-- Global Mod Variables
mod.x = 320
mod.y = 320
mod.hidden = true
mod.path = GetModPath() .. "mods.lua"

-- Load Function
mod.OnLoad = function()
	---------------------
	-- ModManager Icon --
	---------------------
	mod.btnModManager = newButton(-80, -40, 32, 32)
	mod.btnModManager:AddComponent("FadeColor")
	mod.btnModManager:SetAlignment("right", "bottom")
	mod.btnModManager:SetImage("sm_icon_settings")
	mod.btnModManager:SetFadeColor1(255, 0, 255, 255)
	mod.btnModManager:SetFadeColor2(0, 255, 255, 255)
	mod.btnModManager:OnButtonClick("ToggleModManager")
	mod.btnModManager:Hide()

	-------------------
	-- ModClear Icon --
	-------------------
	mod.btnModClear = newButton(-40, -40, 32, 32)
	mod.btnModClear:AddComponent("FadeColor")
	mod.btnModClear:SetAlignment("right", "bottom")
	mod.btnModClear:SetImage("sm_icon_menu")
	mod.btnModClear:SetFadeColor1(0, 255, 0, 255)
	mod.btnModClear:SetFadeColor2(0, 0, 255, 255)
	mod.btnModClear:OnButtonClick("ReloadLua")
	mod.btnModClear:Hide()

	-----------------------
	-- ModManager Window --
	-----------------------
	-- Window
	mod.pnlWindow = newPanel(-128, -128, 256, 256)
	mod.pnlWindow:SetAlignment("center", "middle")
	mod.pnlWindow:AddComponent("Mask")
	mod.pnlWindow:AddComponent("Dragable")
	mod.pnlWindow:SetImage("window")
	mod.pnlWindow:SetColor(0, 0, 0, 255)
	mod.pnlWindow:Hide()
	-- Text
	mod.txtTitle = newText(8, 16, 240, 24, mod.pnlWindow)
	mod.txtTitle:SetText("ModManager 0.1")
	mod.txtTitle:SetTextAlign("center", "middle")
	mod.txtTitle:SetColor(255, 255, 127, 255)
	-- Close Button
	mod.btnClose = newButton(-40, 16, 24, 24, mod.pnlWindow)
	mod.btnClose:SetAlignment("right", "top")
	mod.btnClose:SetImage("gui_button")
	mod.btnClose:SetColor(191, 0, 0, 255)
	mod.btnClose:OnButtonClick("ToggleModManager")
	mod.txtClose = newText(0, 0, 24, 24, mod.btnClose)
	mod.txtClose:SetText("x")
	mod.txtClose:SetFont("OpenSans-Semibold")
	mod.txtClose:SetTextAlign("center", "top")
	mod.txtClose:SetColor(255, 255, 255, 255)
	mod.txtClose:AddComponent("Outline")
	mod.txtClose:SetOutlineColor(0, 0, 0, 127)
	-- Save Mod List
	mod.btnSave = newButton(16, -48, 64, 32, mod.pnlWindow)
	mod.btnSave:SetAlignment("left", "bottom")
	mod.btnSave:SetImage("gui_button")
	mod.btnSave:SetColor(245, 165, 74, 255)
	mod.btnSave:OnButtonClick("SaveModList")
	mod.txtSave = newText(0, 0, 64, 32, mod.btnSave)
	mod.txtSave:SetText("Save")
	mod.txtSave:SetFont("OpenSans-Semibold")
	mod.txtSave:SetColor(255, 255, 255, 255)
	mod.txtSave:AddComponent("Outline")
	mod.txtSave:SetOutlineColor(0, 0, 0, 127)
	-- Reload Lua
	mod.btnReload = newButton(96, -48, 144, 32, mod.pnlWindow)
	mod.btnReload:SetAlignment("left", "bottom")
	mod.btnReload:SetImage("gui_button")
	mod.btnReload:SetColor(245, 165, 74, 255)
	mod.btnReload:OnButtonClick("ReloadAllMods")
	mod.txtReload = newText(0, 0, 144, 32, mod.btnReload)
	mod.txtReload:SetText("Save & Reload")
	mod.txtReload:SetFont("OpenSans-Semibold")
	mod.txtReload:SetColor(255, 255, 255, 255)
	mod.txtReload:AddComponent("Outline")
	mod.txtReload:SetOutlineColor(0, 0, 0, 127)

	-- Mod List
	mod.modlist = require("lua/mods")
	mod.mods = {}
	mod.txtModname = {}
	mod.ckbActive = {}
	for k, v in pairs(mod.modlist) do
		if v.visible then
			mod.txtModname[k] = newText(16, k * 24 + 32, 240, 24, mod.pnlWindow)
			mod.txtModname[k]:SetText(v.name .. " v." .. v.version)
			mod.txtModname[k]:SetTextAlign("left", "middle")
			
			if v.editable then
				mod.ckbActive[k] = newCheckbox(216, k * 24 + 32, 20, 20, mod.pnlWindow)
				mod.ckbActive[k]:SetCheckboxValue(v.active)
				mod.ckbActive[k]:OnCheckboxValueChange("ToggleMod")
				mod.ckbActive[k]:SetImage("border_white")
				if v.active then
					mod.txtModname[k]:SetColor(0, 255, 0, 255)
				end
			else
				mod.txtModname[k]:SetColor(0, 127, 255, 255)
			end
		end
	end
end

-- Destroy Function
mod.OnDestroy = function()
	mod.btnModManager:Clear()
	mod.btnModClear:Clear()
	mod.pnlWindow:Clear()
	mod.txtTitle:Clear()
	mod.btnClose:Clear()
	mod.txtClose:Clear()
	mod.btnSave:Clear()
	mod.txtSave:Clear()
	mod.btnReload:Clear()
	mod.txtReload:Clear()
	for k, v in pairs(mod.txtModname) do
		v:Clear()
	end
end

mod.OnKeyHit = function(key, code, isShift, isAlt)
	if isAlt then
		if key == "M" then
			ToggleModManager()
		end

		if key == "L" then
			if isShift then
				ReloadLua()
			else
				mod.btnModManager:Toggle()
				mod.btnModClear:Toggle()
			end
		end
	end
end

-- Global Functions
function ToggleModManager()
	mod.hidden = not mod.hidden

	if mod.hidden then
		mod.pnlWindow:Hide()
		SetModMenu(false)
	else
		mod.pnlWindow:Show()
		SetModMenu(true)
	end
end

function ToggleMod()
	for k, v in pairs(mod.modlist) do
		if mod.ckbActive[k] then
			v.active = mod.ckbActive[k]:GetCheckboxValue()
		end
	end
end

function SaveModList()
	local f = io.open(mod.path, "w")
	f:write("local mods = " .. TSerial.pack_pretty(mod.modlist) .. "\n\nreturn mods")
	f:close()
end

function ReloadLua()
	ReloadLUA()
	Debug("LUA Reloaded!")
end

function ReloadAllMods()
	SaveModList()
	ReloadLUA()
	Debug("LUA Reloaded!")
end

return mod
