if not QOLUtilsCommon then
	QOLUtilsCommon = {}
end

QOLUtilsCommon.ConfigSpacing = {}
local cs = QOLUtilsCommon.ConfigSpacing
cs.SectionGap = 40
cs.HeaderGap = 30
cs.ItemGap = 20
cs.Indent = 30

QOLUtilsCommon.Patterns = {}
local pn = QOLUtilsCommon.Patterns
pn.Words = '%w+'
pn.Numbers = '%d+'
pn.WhiteSpace = '%s+'
pn.WhiteSpaceStart = '^' .. QOLUtilsCommon.Patterns.WhiteSpace
pn.WhiteSpaceEnd = QOLUtilsCommon.Patterns.WhiteSpace .. '$'

QOLUtilsCommon.Labels = {}
local lb = QOLUtilsCommon.Labels
lb.Acct = 'ACCOUNT  WIDE  SETTINGS'
lb.Toon = 'CHARACTER  SPECIFIC  SETTINGS'
lb.UseToon = 'Use character specific settings.'

QOLUtilsCommon.Labels.AC = {}
local ac = QOLUtilsCommon.Labels.AC
ac.Header = 'Auto Confirm'
ac.Report = 'Report Auto Confirm status at player logon and on reload.'
ac.Refundable = 'Automatically confirm to equip Refundable items.'
ac.Tradeable = 'Automatically confirm to equip Tradeable items.'
ac.Bindable = 'Automatically confirm to equip "Bind on Equip" items.'

QOLUtilsCommon.Labels.QM = {}
local qm = QOLUtilsCommon.Labels.QM
qm.Header = 'Quiet Mode'
qm.Report = 'Report Quiet Mode status at player logon and on reload.'
qm.Party = 'Automatically decline Party Invites.'
qm.Duel = 'Automatically decline Duel Requests.'

QOLUtilsCommon.Labels.SMN = {}
local smn = QOLUtilsCommon.Labels.SMN
smn.Header = 'Summon Mounts & Pets'
smn.Report = 'Report Summon status at player logon and on reload.'
smn.OnlyFavoritePets = 'Only summon favorite pets when summoning a random pet.'
smn.OnlyFavoriteMounts = 'Only summon favorite mounts when summoning a mount.'

QOLUtilsCommon.Labels.VC = {}
local vc = QOLUtilsCommon.Labels.VC
vc.Header = 'Volume Cycler'
vc.Levels = 'Volume percentages to cycle through (each value separated by whitespace).'