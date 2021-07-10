if QOLUtilsCommon == nil then
	QOLUtilsCommon = {}
end

function QOLUtilsCommon.ParseInput(msg)
	return QOLUtilsCommon.StrToTable(msg, QOLUtilsCommon.Patterns.Words)
end

function QOLUtilsCommon.Log(message, subID)
	local ID = '[QoLUtils]'
	if not QOLUtilsCommon.IsNilOrWhitespace(subID) then
		ID = format('[QoL Utils - %s]', subID)
	end
	message = QOLUtilsCommon.ValueOrDefault(message)
	print(format('%s  %s  %s', date('%H:%M'), ID, message))
end

function QOLUtilsCommon.IsNilOrWhitespace(val)
	return val == nil or val:gsub('^%s+', '') == ''
end

function QOLUtilsCommon.ValueOrDefault(val, default)
	local result = nil
	if QOLUtilsCommon.IsNilOrWhitespace(val) then
		if default == nil then
			result = 'NIL'
		else
			result = default
		end
	else
		result = val
	end
	return result
end

function QOLUtilsCommon.TableIsNilOrEmpty(t)
	return t == nil or table.getn(t) < 1
end

function QOLUtilsCommon.StrToTable(str, pattern)
	local args = {}
	for num in str:gmatch(pattern) do
		table.insert(args, num)
	end
	return args
end

function QOLUtilsCommon.TableToStr(t, separator)
	local str = ''
	local sep = QOLUtilsCommon.ValueOrDefault(separator, ' ')
	for i = 1, table.getn(t) do
		str = str .. tostring(t[i]) .. sep
	end
	str = str:gsub('^%s+', ''):gsub('%s+$', '')
	return str
end

function QOLUtilsCommon.GetFrame(name)
	local frame = _G[name]
	if frame == nil then 
		for i = 1, 10 do
			frame = _G[name .. i]
			if frame and frame.which and frame.IsShown and frame:IsShown() then
				return frame, i
			end
		end
	else
		return frame
	end
end

function QOLUtilsCommon.SettingIsTrue(acctSetting, toonSetting)
	return QOL_Config_Toon.Active and toonSetting or not QOL_Config_Toon.Active and acctSetting
end

function QOLUtilsCommon.ToggleSetting(state, acctSetting, toonSetting, acctCheckBox, toonCheckBox)
	local modifiedToonSetting = toonSetting
	local modifiedAcctSetting = acctSetting
	if QOL_Config_Toon.Active then
		if state == nil then
			modifiedToonSetting = not toonSetting
		else
			modifiedToonSetting = state
		end
		QOLUtilsCommon.OPT.UpdateCheckBox(toonCheckBox, modifiedToonSetting)
	else
		if state == nil then
			modifiedAcctSetting = not acctSetting
		else
			modifiedAcctSetting = state
		end
		QOLUtilsCommon.OPT.UpdateCheckBox(acctCheckBox, modifiedAcctSetting)
	end
	return modifiedAcctSetting, modifiedToonSetting
end