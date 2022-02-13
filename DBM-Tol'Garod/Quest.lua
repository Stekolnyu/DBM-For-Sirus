local mod	= DBM:NewMod("Quest", "DBM-Tol'Garod")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20210501000000")
mod:SetCreatureID(82141, 82142, 82143, 82144, 82145, 82146)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_SUMMON",
	"UNIT_HEALTH",
    "UNIT_DESTROYED"
)

local WarnRespawn           = mod:NewAnnounce("warnRespawns")

local respArgomot           = mod:NewTimer(60, "Respawned")
local respKostegriz         = mod:NewTimer(60, "Respawned")
local respCynami            = mod:NewTimer(60, "Respawned")
local respTaifyn            = mod:NewTimer(60, "Respawned")
local respKrok              = mod:NewTimer(60, "Respawned")
local respShadras           = mod:NewTimer(60, "Respawned")

function mod:UNIT_DESTROYED(args)
local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 82145 then
                                respArgomot:Start()
                                WarnRespawn:Schedule(50)
    elseif cid == 82142 then
                                respKostegriz:Start()
                                WarnRespawn:Schedule(50)
    elseif cid == 82143 then
                                respCynami:Start()
                                WarnRespawn:Schedule(50)
    elseif cid == 82144 then
                                respTaifyn:Start()
                                WarnRespawn:Schedule(50)
    elseif cid == 82146 then
                                respKrok:Start()
                                WarnRespawn:Schedule(50)
    elseif cid == 82141 then
                                respShadras:Start()
                                WarnRespawn:Schedule(50)
    end
end
