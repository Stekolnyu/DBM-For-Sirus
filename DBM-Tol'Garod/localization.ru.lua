if GetLocale() ~= "ruRU" then return end

local L

-- Norigorn
L = DBM:GetModLocalization("Norigorn")

L:SetGeneralLocalization{
	name = "Норигорн"
}

L:SetMiscLocalization{
}
-- Quest
L = DBM:GetModLocalization("Quest")

L:SetGeneralLocalization{
	name = "Контракты"
}

L:SetWarningLocalization{
	WarnRespawns				= "Респавн через 10 секунд"
}

L:SetMiscLocalization{
}