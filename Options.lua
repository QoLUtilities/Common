if QOLUtilsCommon == nil then
	QOLUtilsCommon = {}
end
local common = QOLUtilsCommon

SLASH_QOLUTILITIESCOMMON1 = '/qol'
SlashCmdList['QOLUTILITIESCOMMON'] = QOLUtilsCommon.OpenConfig

function common.OpenConfig(child)
	if common.Panel then
		InterfaceOptionsFrame_Show()
		InterfaceOptionsFrame_OpenToCategory(child == nil and common.Panel or child)
	end
end

function common.CreateConfig()
	common.CreateConfigPanel()
	InterfaceOptions_AddCategory(common.Panel);
end

function common.CreateConfigPanel()
	if common.Panel == nil then
		common.Panel = CreateFrame('Frame', 'QoL Utilities Common', UIParent)
		common.Panel.name = 'QoL Utilities'
	end
end

function common.CreateChildConfigPanel()

end

function common.CreateConfigItems(scrollchild, firstRelativeParent, config, storage, indent, headerGap, itemGap)
	storage.AC = {}
	storage.AC.CheckBoxReport = common.CreateCheckBox(scrollchild, firstRelativeParent, indent, -itemGap, common.Labels.AC.Report, config.AC.ReportAtLogon, common.AC.ToggleLogonReportOnClick)
	storage.AC.CheckBoxRefundable = common.CreateCheckBox(scrollchild, storage.AC.CheckBoxReport, 0, -itemGap, common.Labels.AC.Refundable, config.AC.RefundableActive, common.AC.ToggleRefundableOnClick)
	storage.AC.CheckBoxTradeable = common.CreateCheckBox(scrollchild, storage.AC.CheckBoxRefundable, 0, -itemGap, common.Labels.AC.Tradeable, config.AC.TradeableActive, common.AC.ToggleTradeableOnClick)
	storage.AC.CheckBoxBindable = common.CreateCheckBox(scrollchild, storage.AC.CheckBoxTradeable, 0, -itemGap, common.Labels.AC.Bindable, config.AC.BindableActive, common.AC.ToggleBindableOnClick)
	storage.QM = {}
	local qmHeader = common.CreateHeader(scrollchild, storage.AC.CheckBoxBindable, -indent, -headerGap, common.Labels.QM.Header)
	storage.QM.CheckBoxReport = common.CreateCheckBox(scrollchild, qmHeader, indent, -itemGap, common.Labels.QM.Report, config.QM.ReportAtLogon, common.QM.ToggleLogonReportOnClick)
	storage.QM.CheckBoxParty = common.CreateCheckBox(scrollchild, storage.QM.CheckBoxReport, 0, -itemGap, common.Labels.QM.Party, config.QM.PartyActive, common.QM.TogglePartyOnClick)
	storage.QM.CheckBoxDuel = common.CreateCheckBox(scrollchild, storage.QM.CheckBoxParty, 0, -itemGap, common.Labels.QM.Duel, config.QM.DuelActive, common.QM.ToggleDuelOnClick)
	storage.SMN = {}
	local smnHeader = common.CreateHeader(scrollchild, storage.QM.CheckBoxDuel, -indent, -headerGap, common.Labels.SMN.Header)
	storage.SMN.CheckBoxReport = common.CreateCheckBox(scrollchild, smnHeader, indent, -itemGap, common.Labels.SMN.Report, config.SMN.ReportAtLogon, common.SMN.ToggleLogonReportOnClick)
	storage.SMN.CheckBoxPets = common.CreateCheckBox(scrollchild, storage.SMN.CheckBoxReport, 0, -itemGap, common.Labels.SMN.OnlyFavoritePets, config.SMN.OnlyFavoritePets, common.SMN.ToggleFavoritePetsOnClick)
	storage.SMN.CheckBoxMounts = common.CreateCheckBox(scrollchild, storage.SMN.CheckBoxPets, 0, -itemGap, common.Labels.SMN.OnlyFavoriteMounts, config.SMN.OnlyFavoriteMounts, common.SMN.ToggleFavoriteMountsOnClick)
	storage.VC = {}
	local vcHeader = common.CreateHeader(scrollchild, storage.SMN.CheckBoxMounts, -indent, -headerGap, common.Labels.VC.Header)
	local toonVCLabel = common.CreateLabel(scrollchild, vcHeader, indent, -itemGap, common.Labels.VC.Levels)
	storage.VC.EditBoxLevels = common.CreateEditBox(scrollchild, toonVCLabel, indent, -10, common.TableToStr(config.VC.Levels), common.ParseVolumeLevels)
end

function common.CreateHeader(parent, relativeParent, x, y, text)
	local fontFrame = CreateFrame('Frame', 'QOL_Utils_FontFrame_' .. common.GetUniqueID(), parent)
	fontFrame:SetPoint('TOPLEFT', relativeParent, 'TOPLEFT', x, y)
	fontFrame:SetSize(500, 10)
	local fontString = fontFrame:CreateFontString('QOLUtils_FontString_' .. common.GetUniqueID(), 'BACKGROUND', 'GameFontWhite')
	fontString:SetPoint('TOPLEFT')
	fontString:SetText(text)
	fontFrame.text = fontString
	return fontFrame
end

function common.CreateCheckBox(parent, relativeParent, x, y, text, checked, callback)
	local checkBox = CreateFrame('CheckButton', 'QOLUtils_CheckBox_' .. common.GetUniqueID(), parent, 'ChatConfigCheckButtonTemplate')
	checkBox:SetPoint('TOPLEFT', relativeParent, 'TOPLEFT', x, y)
	getglobal(checkBox:GetName() .. 'Text'):SetText(text)
	checkBox:SetChecked(checked)
	checkBox:SetScript('OnClick', callback)
	return checkBox
end

function common.CreateLabel(parent, relativeParent, x, y, text)
	local fontFrame = CreateFrame('Frame', 'QOLUtils_FontFrame_' .. common.GetUniqueID(), parent)
	fontFrame:SetPoint('TOPLEFT', relativeParent, 'TOPLEFT', x, y)
	fontFrame:SetSize(500, 30)
	local fontString = fontFrame:CreateFontString('QOLUtils_FontString_' .. common.GetUniqueID(), 'BACKGROUND', 'GameFontWhite')
	fontString:SetPoint('TOPLEFT')
	fontString:SetText(text)
	fontFrame.text = fontString
	return fontFrame
end

function common.CreateEditBox(parent, relativeParent, x, y, text, callback)
	local editBox = CreateFrame('EditBox', 'QOLUtils_EditBox_' .. common.GetUniqueID(), parent, 'InputBoxTemplate')
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
function common.GetUniqueID()
	uniqueID = uniqueID + 1
	return uniqueID
end

function common.ToggleToonSpecific()
	QOL_Config_Toon.Active = not QOL_Config_Toon.Active
	common.UpdateCheckBox(common.Toon.Active, QOL_Config_Toon.Active)
end

function common.ParseVolumeLevels(self)
	local configLevels = self == common.Acct.VC.EditBoxLevels and QOL_Config_Acct.VC.Levels or QOL_Config_Toon.VC.Levels
	local enteredPresets = common.StrToTable(self:GetText(), common.Patterns.Numbers)
	local validPresets = {}
	for i = 1, table.getn(enteredPresets) do
		if common.VC.ValidLevel(enteredPresets[i]) then
			table.insert(validPresets, enteredPresets[i])
		end
	end
	configLevels = validPresets
	self:SetText(common.TableToStr(configLevels))
end

function common.UpdateCheckBox(checkBox, checked)
	checkBox:SetChecked(checked)
end