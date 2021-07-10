local addonName, CMN = ...

CMN.EventFrame = CreateFrame('Frame')
CMN.Events = {}

function CMN.Events.ADDON_LOADED(...)
	local loadedAddon = ...
	if loadedAddon == addonName then
		CMN.LoadDefaults()
	end
end

----------------------------------
------  Event Registration  ------
----------------------------------

CMN.EventFrame:SetScript('OnEvent',	function(self, event, ...)
	CMN.Events[event](self, ...)
end)

for k, v in pairs(CMN.Events) do
	CMN.EventFrame:RegisterEvent(k)
end
