local mod	= DBM:NewMod("Onyxia", "DBM-Onyxia")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20200222200840")
mod:SetCreatureID(10184)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"UNIT_DIED",
	"UNIT_HEALTH"
)

local warnWhelpsSoon		= mod:NewAnnounce("WarnWhelpsSoon", 1)
local warnPhase2			= mod:NewPhaseAnnounce(2)
local warnPhase3			= mod:NewPhaseAnnounce(3)
local warnPhase2Soon		= mod:NewPrePhaseAnnounce(2)
local warnPhase3Soon		= mod:NewPrePhaseAnnounce(3)

--local preWarnDeepBreath     = mod:NewSoonAnnounce(17086, 2)--Experimental, if it is off please let me know.
local specWarnBreath		= mod:NewSpecialWarningRun(17086)
local specWarnBlastNova		= mod:NewSpecialWarningRun(68958, "Melee")

local timerNextFlameBreath	= mod:NewCDTimer(20, 68970)--Breath she does on ground in frontal cone.
local timerNextDeepBreath	= mod:NewCDTimer(35, 17086)--Range from 35-60seconds in between based on where she moves to.
local timerBreath			= mod:NewCastTimer(8, 17086)
local timerWhelps			= mod:NewTimer(105, "TimerWhelps", 10697)
local timerAchieve			= mod:NewAchievementTimer(300, 4405, "TimerSpeedKill")
local timerAchieveWhelps	= mod:NewAchievementTimer(10, 4406, "TimerWhelps")



mod.vb.warned_preP2 = false
mod.vb.warned_preP3 = false
mod.vb.phase = 0

function mod:OnCombatStart(delay)
	DBM:FireCustomEvent("DBM_EncounterStart", 10184, "Onyxia")
	self.vb.phase = 1
	self.vb.warned_preP2 = false
	self.vb.warned_preP3 = false
	timerAchieve:Start(-delay)
end

function mod:OnCombatEnd(wipe)
	DBM:FireCustomEvent("DBM_EncounterEnd", 10184, "Onyxia", wipe)
end

function mod:Whelps()
	if self:IsInCombat() then
		timerWhelps:Start(102)
		warnWhelpsSoon:Schedule(95)
		self:ScheduleMethod(105, "Whelps")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellP2 or msg:find(L.YellP2) then
		self.vb.phase = 2
		warnPhase2:Show()
--		preWarnDeepBreath:Schedule(72)	-- Pre-Warn Deep Breath
		timerNextDeepBreath:Start(77)
		timerAchieveWhelps:Start()
		timerNextFlameBreath:Cancel()
		self:ScheduleMethod(5, "Whelps")
	elseif msg == L.YellP3 or msg:find(L.YellP3) then
		self.vb.phase = 3
		warnPhase3:Show()
		self:UnscheduleMethod("Whelps")
		timerWhelps:Stop()
		timerNextDeepBreath:Stop()
		warnWhelpsSoon:Cancel()
--		preWarnDeepBreath:Cancel()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68958) then
		specWarnBlastNova:Show()
	elseif args:IsSpellID(17086, 18351, 18564, 18576) or args:IsSpellID(18584, 18596, 18609, 18617) then	-- 1 ID for each direction
		specWarnBreath:Show()
		timerBreath:Start()
		timerNextDeepBreath:Start()
--		preWarnDeepBreath:Schedule(35)              -- Pre-Warn Deep Breath
	elseif args:IsSpellID(18435, 68970) then        -- Flame Breath (Ground phases)
		timerNextFlameBreath:Start()
	end
end



function mod:UNIT_HEALTH(uId)
	if self.vb.phase == 1 and not self.vb.warned_preP2 and self:GetUnitCreatureId(uId) == 10184 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.67 then
		self.vb.warned_preP2 = true
		warnPhase2Soon:Show()
	elseif self.vb.phase == 2 and not self.vb.warned_preP3 and self:GetUnitCreatureId(uId) == 10184 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.41 then
		self.vb.warned_preP3 = true
		warnPhase3Soon:Show()
	end
end