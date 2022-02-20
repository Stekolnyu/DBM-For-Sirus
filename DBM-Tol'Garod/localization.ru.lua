if GetLocale() ~= "ruRU" then return end

local L

-- Норигорн
L = DBM:GetModLocalization("Norigorn")

L:SetGeneralLocalization{
	name = "Норигорн"
}

L:SetMiscLocalization{
}

-- Квест
L = DBM:GetModLocalization("Quest")

L:SetGeneralLocalization{
	name = "Контракты"
}

L:SetMiscLocalization{
}

-- Гогонаш
L = DBM:GetModLocalization("Gogonash")

L:SetGeneralLocalization{
	name = "Гогонаш"
}
-- Ктракс
L = DBM:GetModLocalization("Ctrax")

L:SetGeneralLocalization{
	name = "Ктракс"
}

L:SetMiscLocalization{
}
-- Пожиратель магии
L = DBM:GetModLocalization("MagicEater")

L:SetGeneralLocalization{
	name = "Пожиратель магии"
}

L:SetMiscLocalization{
}
