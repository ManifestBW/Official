---Human Immunodeficiency Virus

local s,id=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsCode,id))

	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetCondition(s.atcon)
	e1:SetOperation(s.atop)
	c:RegisterEffect(e1)

	--Summon Limit #1
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e2:SetCondition(s.sumcon)
	c:RegisterEffect(e2) 

	--Summon Limit #2
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	c:RegisterEffect(e3) 
	
	--Summon Limit #3
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e4)

	--Change Code
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCode(EFFECT_CHANGE_CODE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e5:SetValue(id)
	c:RegisterEffect(e5)

	--Pathogen Rule: Set
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_MONSTER_SSET)
	e6:SetValue(TYPE_SPELL)
	c:RegisterEffect(e6)

	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetCode(EVENT_PHASE+PHASE_END)
	e7:SetRange(LOCATION_SZONE)
	e7:SetCountLimit(1)
	e7:SetCondition(s.atkcon)
	e7:SetOperation(s.atkop)
	c:RegisterEffect(e7)


end

--Summon Limit
function s.sumcon(e,c,minc)
	if not c then return true end
	return false
end

--Attach
function s.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_LOST_TARGET) and c:GetPreviousEquipTarget():IsLocation(LOCATION_OVERLAY)
end
function s.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetPreviousEquipTarget():GetReasonCard()
	Duel.Overlay(rc,Group.FromCards(c))
end
function s.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_LOST_TARGET) and c:GetPreviousEquipTarget():IsLocation(LOCATION_OVERLAY)
end
function s.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetPreviousEquipTarget():GetReasonCard()
	Duel.Overlay(rc,Group.FromCards(c))
end

function s.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.FilterFaceupFunction(Card.IsCanAddCounter,0x4,12),1-tp,LOCATION_FZONE,0,c)
	g:ForEach(Card.RemoveCounter,tp,0x4,1,REASON_EFFECT)
end
