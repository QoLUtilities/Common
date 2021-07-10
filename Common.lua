if not QOLUtilsCommon then
	QOLUtilsCommon = {}
end
local common = QOLUtilsCommon

function common.ParseInput(msg)
	return common.StrToTable(msg, common.Patterns.Words)
end

function common.Log(message, subID)
	local ID = '[QoLUtils]'
	if not common.IsNilOrWhitespace(subID) then
		ID = format('[QoLUtils - %s]', subID)
	end
	message = common.ValueOrDefault(message)
	print(format('%s  %s  %s', date('%H:%M'), ID, message))
end

function common.IsNilOrWhitespace(val)
	return val == nil or val:gsub(common.Patterns.WhiteSpaceStart, '') == ''
end

function common.ValueOrDefault(val, default)
	local result = nil
	if common.IsNilOrWhitespace(val) then
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

function common.TableIsNilOrEmpty(t)
	return t == nil or table.getn(t) < 1
end

function common.StrToTable(str, pattern)
	local args = {}
	for num in str:gmatch(pattern) do
		table.insert(args, num)
	end
	return args
end

function common.TableToStr(t, separator)
	local str = ''
	local sep = common.ValueOrDefault(separator, ' ')
	local count = table.getn(t)
	for i = 1, count do
		str = str .. tostring(t[i]) 
		if i < count then
			str = str .. sep
		end
	end
	str = str:gsub(common.Patterns.WhiteSpaceStart, ''):gsub(common.WhiteSpaceEnd, '')
	return str
end

function common.GetFrame(name)
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

function common.SettingEnabled(acctSetting, toonSetting, toonActive)
	return toonActive and toonSetting or not toonActive and acctSetting
end

function common.ToggleSetting(state, acctSetting, toonSetting, acctCheckBox, toonCheckBox, toonActive)
	local modifiedToonSetting = toonSetting
	local modifiedAcctSetting = acctSetting
	if toonActive then
		if state == nil then
			modifiedToonSetting = not toonSetting
		else
			modifiedToonSetting = state
		end
		common.UpdateCheckBox(toonCheckBox, modifiedToonSetting)
	else
		if state == nil then
			modifiedAcctSetting = not acctSetting
		else
			modifiedAcctSetting = state
		end
		common.UpdateCheckBox(acctCheckBox, modifiedAcctSetting)
	end
	return modifiedAcctSetting, modifiedToonSetting
end