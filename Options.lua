local addonName, CMN = ...
if not QOLUtilsCommon then
	QOLUtilsCommon = {}
end
local common = QOLUtilsCommon

CMN.Panel = nil
CMN.LastChild = nil
CMN.LastChildCount = 0

SLASH_QOLUTILITIESCOMMON1 = '/qol'
SlashCmdList['QOLUTILITIESCOMMON'] = QOLUtilsCommon.OpenConfig

function CMN.LoadDefaults()
	if CMN_Config_Toon == nil then 
		CMN_Config_Toon = {}
	end
	if CMN_Config_Toon.Active == nil then
		CMN_Config_Toon.Active = false
	end
end

function common.OpenConfig(child)
	if CMN.Panel then
		InterfaceOptionsFrame_Show()
		InterfaceOptionsFrame_OpenToCategory(child == nil and CMN.Panel or child)
	end
end

function common.CreateConfigPanel()
	if not CMN.Panel then
		CMN.Panel = CreateFrame('Frame', 'QOL_Utils_Frame_' .. CMN.GetUniqueID(), UIParent)
		CMN.Panel.name = 'QoL Utilities'
		CMN.CheckBoxActive = common.CreateCheckBox(CMN.Panel, -CMN.Panel, common.ConfigSpacing.Indent, -common.ConfigSpacing.SectionGap, common.Labels.UseToon, CMN_Config_Toon.Active, common.ToggleToonSpecific)
		InterfaceOptions_AddCategory(CMN.Panel);
	end
end

function common.CreateChildConfigPanel(name, headerText)
	common.CreateConfigPanel()
	local child = CreateFrame('Frame', 'QOL_Utils_Frame_' .. CMN.GetUniqueID(), CMN.Panel)
	child.name = name
	child.parent = CMN.Panel.name
	InterfaceOptions_AddCategory(child)
	CMN.LastChild = CMN.CreateLinkHeader(CMN.Panel, CMN.LastChild, common.ConfigSpacing.Indent, -common.ConfigSpacing.HeaderGap, headerText, child)
	return child
end

function common.CreateHeader(parent, relativeParent, x, y, text)
	local fontFrame = CreateFrame('Frame', 'QOL_Utils_FontFrame_' .. CMN.GetUniqueID(), parent)
	fontFrame:SetPoint('TOPLEFT', relativeParent, 'TOPLEFT', x, y)
	fontFrame:SetSize(500, 10)
	local fontString = fontFrame:CreateFontString('QOLUtils_FontString_' .. CMN.GetUniqueID(), 'BACKGROUND', 'GameFontWhite')
	fontString:SetPoint('TOPLEFT')
	fontString:SetText(text)
	fontFrame.text = fontString
	return fontFrame
end

function CMN.CreateLinkHeader(parent, relativeParent, x, y, text, linkPanel)
	local header = common.CreateHeader(parent, relativeParent, x, y, text)
	header:SetScript('OnClick', function()
		common.OpenConfig(linkPanel)
	end)
end

function common.CreateCheckBox(parent, relativeParent, x, y, text, checked, callback)
	local checkBox = CreateFrame('CheckButton', 'QOLUtils_CheckBox_' .. CMN.GetUniqueID(), parent, 'ChatConfigCheckButtonTemplate')
	checkBox:SetPoint('TOPLEFT', relativeParent, 'TOPLEFT', x, y)
	getglobal(checkBox:GetName() .. 'Text'):SetText(text)
	checkBox:SetChecked(checked)
	checkBox:SetScript('OnClick', callback)
	return checkBox
end

function common.CreateLabel(parent, relativeParent, x, y, text)
	local fontFrame = CreateFrame('Frame', 'QOLUtils_FontFrame_' .. CMN.GetUniqueID(), parent)
	fontFrame:SetPoint('TOPLEFT', relativeParent, 'TOPLEFT', x, y)
	fontFrame:SetSize(500, 30)
	local fontString = fontFrame:CreateFontString('QOLUtils_FontString_' .. CMN.GetUniqueID(), 'BACKGROUND', 'GameFontWhite')
	fontString:SetPoint('TOPLEFT')
	fontString:SetText(text)
	fontFrame.text = fontString
	return fontFrame
end

function common.CreateEditBox(parent, relativeParent, x, y, text, callback)
	local editBox = CreateFrame('EditBox', 'QOLUtils_EditBox_' .. CMN.GetUniqueID(), parent, 'InputBoxTemplate')
	editBox:SetPoint('TOPLEFT', relativeParent, 'TOPLEFT', x, y)
	editBox:SetSize(200, 30)
	editBox:SetMultiLine(false)
	editBox:SetAutoFocus(false)
	editBox:SetText(text)
	editBox:SetCursorPosition(0)
	editBox:SetScript('OnEditFocusLost', callback)
	return editBox
end

local uniqueID = 0
function CMN.GetUniqueID()
	uniqueID = uniqueID + 1
	return uniqueID
end

function common.ToggleToonSpecific()
	CMN_Config_Toon.Active = not CMN_Config_Toon.Active
	common.UpdateCheckBox(CMN.CheckBoxActive, CMN_Config_Toon.Active)
end

function common.UpdateCheckBox(checkBox, checked)
	checkBox:SetChecked(checked)
end