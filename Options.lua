if QOLUtilsCommon == nil then
	QOLUtilsCommon = {}
end

function QOLUtilsCommon.OpenConfig(panel)
	InterfaceOptionsFrame_Show()
	InterfaceOptionsFrame_OpenToCategory(panel == nil and QOLUtilsCommon.Panel or panel)
end

function QOLUtilsCommon.CreateConfig()
	local scrollchild = QOLUtilsCommon.CreateScrollFrame()
	QOLUtilsCommon.Acct = {}
	local acctHeader = QOLUtilsCommon.CreateHeader(scrollchild, scrollchild, indent, -sectionGap, QOLUtilsCommon.Labels.Acct)
	local acctACHeader = QOLUtilsCommon.CreateHeader(scrollchild, acctHeader, indent, -itemGap, QOLUtilsCommon.Labels.AC.Header)
	QOLUtilsCommon.CreateConfigItems(scrollchild, acctACHeader, QOL_Config_Acct, QOLUtilsCommon.Acct, indent, headerGap, itemGap)
	QOLUtilsCommon.Toon = {}
	local toonHeader = QOLUtilsCommon.CreateHeader(scrollchild, QOLUtilsCommon.Acct.VC.EditBoxLevels, -indent * 3, -sectionGap, QOLUtilsCommon.Labels.Toon)
	QOLUtilsCommon.Toon.Active = QOLUtilsCommon.CreateCheckBox(scrollchild, toonHeader, indent, -itemGap, QOLUtilsCommon.Labels.UseToon, QOL_Config_Toon.Active, QOLUtilsCommon.ToggleToonSpecific)
	local toonACHeader = QOLUtilsCommon.CreateHeader(scrollchild, QOLUtilsCommon.Toon.Active, 0, -headerGap, QOLUtilsCommon.Labels.AC.Header)
	QOLUtilsCommon.CreateConfigItems(scrollchild, toonACHeader, QOL_Config_Toon, QOLUtilsCommon.Toon, indent, headerGap, itemGap)
	InterfaceOptions_AddCategory(QOLUtilsCommon.Panel);
end

function QOLUtilsCommon.CreateScrollFrame()
	QOLUtilsCommon.Panel = CreateFrame('Frame', 'QoL Utilities', UIParent)
	QOLUtilsCommon.Panel.name = 'QoL Utilities'
	QOLUtilsCommon.Panel.ScrollFrame = CreateFrame('ScrollFrame', 'QOL_Utils_ScrollFrame_' .. QOLUtilsCommon.GetUniqueID(), QOLUtilsCommon.Panel, 'UIPanelScrollFrameTemplate')
	QOLUtilsCommon.Panel.ScrollFrame:SetPoint('TOPLEFT', QOLUtilsCommon.Panel, 'TOPLEFT')
	QOLUtilsCommon.Panel.ScrollFrame:SetPoint('BOTTOMRIGHT', QOLUtilsCommon.Panel, 'BOTTOMRIGHT')
	QOLUtilsCommon.Panel.ScrollFrame.ScrollBar:ClearAllPoints()
	QOLUtilsCommon.Panel.ScrollFrame.ScrollBar:SetPoint('TOPRIGHT', QOLUtilsCommon.Panel.ScrollFrame, 'TOPRIGHT', -5, -22)
	QOLUtilsCommon.Panel.ScrollFrame.ScrollBar:SetPoint('BOTTOMRIGHT', QOLUtilsCommon.Panel.ScrollFrame, 'BOTTOMRIGHT', -5, 22)
	local scrollchild = CreateFrame('Frame', 'QOL_Utils_ScrollChild_' .. QOLUtilsCommon.GetUniqueID(), QOLUtilsCommon.Panel.ScrollFrame)
	-----------------------------
	-- scrollchild.bg = scrollchild:CreateTexture(nil, 'BACKGROUND')
	-- scrollchild.bg:SetAllPoints(true)
	-- scrollchild.bg:SetColorTexture(0.4, 0, 0, 0.4)
	-----------------------------
	scrollchild:SetSize(400, 900)
	scrollchild:SetPoint('TOPLEFT', QOLUtilsCommon.Panel.ScrollFrame, 'TOPLEFT', -30, 30)
	QOLUtilsCommon.Panel.ScrollFrame:SetScrollChild(scrollchild)
	return scrollchild
end

function QOLUtilsCommon.CreateConfigItems(scrollchild, firstRelativeParent, config, storage, indent, headerGap, itemGap)
	storage.AC = {}
	storage.AC.CheckBoxReport = QOLUtilsCommon.CreateCheckBox(scrollchild, firstRelativeParent, indent, -itemGap, QOLUtilsCommon.Labels.AC.Report, config.AC.ReportAtLogon, QOLUtilsCommon.AC.ToggleLogonReportOnClick)
	storage.AC.CheckBoxRefundable = QOLUtilsCommon.CreateCheckBox(scrollchild, storage.AC.CheckBoxReport, 0, -itemGap, QOLUtilsCommon.Labels.AC.Refundable, config.AC.RefundableActive, QOLUtilsCommon.AC.ToggleRefundableOnClick)
	storage.AC.CheckBoxTradeable = QOLUtilsCommon.CreateCheckBox(scrollchild, storage.AC.CheckBoxRefundable, 0, -itemGap, QOLUtilsCommon.Labels.AC.Tradeable, config.AC.TradeableActive, QOLUtilsCommon.AC.ToggleTradeableOnClick)
	storage.AC.CheckBoxBindable = QOLUtilsCommon.CreateCheckBox(scrollchild, storage.AC.CheckBoxTradeable, 0, -itemGap, QOLUtilsCommon.Labels.AC.Bindable, config.AC.BindableActive, QOLUtilsCommon.AC.ToggleBindableOnClick)
	storage.QM = {}
	local qmHeader = QOLUtilsCommon.CreateHeader(scrollchild, storage.AC.CheckBoxBindable, -indent, -headerGap, QOLUtilsCommon.Labels.QM.Header)
	storage.QM.CheckBoxReport = QOLUtilsCommon.CreateCheckBox(scrollchild, qmHeader, indent, -itemGap, QOLUtilsCommon.Labels.QM.Report, config.QM.ReportAtLogon, QOLUtilsCommon.QM.ToggleLogonReportOnClick)
	storage.QM.CheckBoxParty = QOLUtilsCommon.CreateCheckBox(scrollchild, storage.QM.CheckBoxReport, 0, -itemGap, QOLUtilsCommon.Labels.QM.Party, config.QM.PartyActive, QOLUtilsCommon.QM.TogglePartyOnClick)
	storage.QM.CheckBoxDuel = QOLUtilsCommon.CreateCheckBox(scrollchild, storage.QM.CheckBoxParty, 0, -itemGap, QOLUtilsCommon.Labels.QM.Duel, config.QM.DuelActive, QOLUtilsCommon.QM.ToggleDuelOnClick)
	storage.SMN = {}
	local smnHeader = QOLUtilsCommon.CreateHeader(scrollchild, storage.QM.CheckBoxDuel, -indent, -headerGap, QOLUtilsCommon.Labels.SMN.Header)
	storage.SMN.CheckBoxReport = QOLUtilsCommon.CreateCheckBox(scrollchild, smnHeader, indent, -itemGap, QOLUtilsCommon.Labels.SMN.Report, config.SMN.ReportAtLogon, QOLUtilsCommon.SMN.ToggleLogonReportOnClick)
	storage.SMN.CheckBoxPets = QOLUtilsCommon.CreateCheckBox(scrollchild, storage.SMN.CheckBoxReport, 0, -itemGap, QOLUtilsCommon.Labels.SMN.OnlyFavoritePets, config.SMN.OnlyFavoritePets, QOLUtilsCommon.SMN.ToggleFavoritePetsOnClick)
	storage.SMN.CheckBoxMounts = QOLUtilsCommon.CreateCheckBox(scrollchild, storage.SMN.CheckBoxPets, 0, -itemGap, QOLUtilsCommon.Labels.SMN.OnlyFavoriteMounts, config.SMN.OnlyFavoriteMounts, QOLUtilsCommon.SMN.ToggleFavoriteMountsOnClick)
	storage.VC = {}
	local vcHeader = QOLUtilsCommon.CreateHeader(scrollchild, storage.SMN.CheckBoxMounts, -indent, -headerGap, QOLUtilsCommon.Labels.VC.Header)
	local toonVCLabel = QOLUtilsCommon.CreateLabel(scrollchild, vcHeader, indent, -itemGap, QOLUtilsCommon.Labels.VC.Levels)
	storage.VC.EditBoxLevels = QOLUtilsCommon.CreateEditBox(scrollchild, toonVCLabel, indent, -10, QOLUtilsCommon.TableToStr(config.VC.Levels), QOLUtilsCommon.ParseVolumeLevels)
end

function QOLUtilsCommon.CreateHeader(parent, relativeParent, x, y, text)
	local fontFrame = CreateFrame('Frame', 'QOL_Utils_FontFrame_' .. QOLUtilsCommon.GetUniqueID(), parent)
	fontFrame:SetPoint('TOPLEFT', relativeParent, 'TOPLEFT', x, y)
	fontFrame:SetSize(500, 10)
	local fontString = fontFrame:CreateFontString('QOLUtils_FontString_' .. QOLUtilsCommon.GetUniqueID(), 'BACKGROUND', 'GameFontWhite')
	fontString:SetPoint('TOPLEFT')
	fontString:SetText(text)
	fontFrame.text = fontString
	return fontFrame
end

function QOLUtilsCommon.CreateCheckBox(parent, relativeParent, x, y, text, checked, callback)
	local checkBox = CreateFrame('CheckButton', 'QOLUtils_CheckBox_' .. QOLUtilsCommon.GetUniqueID(), parent, 'ChatConfigCheckButtonTemplate')
	checkBox:SetPoint('TOPLEFT', relativeParent, 'TOPLEFT', x, y)
	getglobal(checkBox:GetName() .. 'Text'):SetText(text)
	checkBox:SetChecked(checked)
	checkBox:SetScript('OnClick', callback)
	return checkBox
end

function QOLUtilsCommon.CreateLabel(parent, relativeParent, x, y, text)
	local fontFrame = CreateFrame('Frame', 'QOLUtils_FontFrame_' .. QOLUtilsCommon.GetUniqueID(), parent)
	fontFrame:SetPoint('TOPLEFT', relativeParent, 'TOPLEFT', x, y)
	fontFrame:SetSize(500, 30)
	local fontString = fontFrame:CreateFontString('QOLUtils_FontString_' .. QOLUtilsCommon.GetUniqueID(), 'BACKGROUND', 'GameFontWhite')
	fontString:SetPoint('TOPLEFT')
	fontString:SetText(text)
	fontFrame.text = fontString
	return fontFrame
end

function QOLUtilsCommon.CreateEditBox(parent, relativeParent, x, y, text, callback)
	local editBox = CreateFrame('EditBox', 'QOLUtils_EditBox_' .. QOLUtilsCommon.GetUniqueID(), parent, 'InputBoxTemplate')
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
function QOLUtilsCommon.GetUniqueID()
	uniqueID = uniqueID + 1
	return uniqueID
end

function QOLUtilsCommon.ToggleToonSpecific()
	QOL_Config_Toon.Active = not QOL_Config_Toon.Active
	QOLUtilsCommon.UpdateCheckBox(QOLUtilsCommon.Toon.Active, QOL_Config_Toon.Active)
end

function QOLUtilsCommon.ParseVolumeLevels(self)
	local configLevels = self == QOLUtilsCommon.Acct.VC.EditBoxLevels and QOL_Config_Acct.VC.Levels or QOL_Config_Toon.VC.Levels
	local enteredPresets = QOLUtilsCommon.StrToTable(self:GetText(), QOLUtilsCommon.Patterns.Numbers)
	local validPresets = {}
	for i = 1, table.getn(enteredPresets) do
		if QOLUtilsCommon.VC.ValidLevel(enteredPresets[i]) then
			table.insert(validPresets, enteredPresets[i])
		end
	end
	configLevels = validPresets
	self:SetText(QOLUtilsCommon.TableToStr(configLevels))
end

function QOLUtilsCommon.UpdateCheckBox(checkBox, checked)
	checkBox:SetChecked(checked)
end