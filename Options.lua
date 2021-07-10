local addonName, CMN = ...
if not QOLUtilsCommon then
	QOLUtilsCommon = {}
end
local common = QOLUtilsCommon

CMN.Panel = nil
CMN.ChildCount = 0

SLASH_QOLUTILITIESCOMMON1 = '/qolcmn'
SlashCmdList['QOLUTILITIESCOMMON'] = QOLUtilsCommon.OpenConfig

function common.OpenConfig(child)
	if CMN.Panel then
		InterfaceOptionsFrame_Show()
		InterfaceOptionsFrame_OpenToCategory(child or CMN.Panel)
	end
end

function common.CreateConfigPanel()
	if not CMN.Panel then
		CMN.Panel = CreateFrame('Frame', 'QOLUtils_Frame_' .. CMN.GetUniqueID(), UIParent)
		CMN.Panel.name = 'QoL Utilities'
		InterfaceOptions_AddCategory(CMN.Panel);
	end
end

function common.CreateChildConfigPanel(name, headerText)
	common.CreateConfigPanel()
	local child = CreateFrame('Frame', 'QOLUtils_Frame_' .. CMN.GetUniqueID(), CMN.Panel)
	child.name = name
	child.parent = CMN.Panel.name
	InterfaceOptions_AddCategory(child)
	CMN.ChildCount = CMN.ChildCount + 1
	local finalText = headerText or 'Go to ' .. name .. ' settings.'
	local linkLabel = CMN.CreateLinkLabel(CMN.Panel, CMN.Panel, common.ConfigSpacing.Indent, -common.ConfigSpacing.SectionGap * CMN.ChildCount, finalText, child)
	return child
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
	local fontFrame = CreateFrame('Frame', 'QOLUtils_Label_' .. CMN.GetUniqueID(), parent)
	fontFrame:SetPoint('TOPLEFT', relativeParent, 'TOPLEFT', x, y)
	fontFrame:SetSize(500, 30)
	local fontString = fontFrame:CreateFontString('QOLUtils_FontString_' .. CMN.GetUniqueID(), 'BACKGROUND', 'GameFontWhite')
	fontString:SetPoint('TOPLEFT')
	fontString:SetText(text)
	fontFrame.text = fontString
	return fontFrame
end

function CMN.CreateLinkLabel(parent, relativeParent, x, y, text, linkPanel)
	local label = common.CreateLabel(parent, relativeParent, x, y, text)
	local highlight = label:CreateTexture(nil, 'HIGHLIGHT')
	highlight:SetAllPoints(true)
	highlight:SetTexture(1, 1, 1, 0.1)
	label:SetScript('OnClick', function()
		common.OpenConfig(linkPanel)
	end)
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

CMN.UniqueID = 0
function CMN.GetUniqueID()
	CMN.UniqueID = CMN.UniqueID + 1
	return CMN.UniqueID
end

function common.UpdateCheckBox(checkBox, checked)
	checkBox:SetChecked(checked)
end