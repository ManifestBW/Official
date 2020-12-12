--Acquired Immunodeficiency Syndrome

local s,id=GetID()
function s.initial_effect(c)
	c:EnableCounterPermit(0x1b) --ATP Counters
	c:EnableCounterPermit(0x8) --Distress Counters
	c:EnableCounterPermit(0x7) --Delirium Counters
	c:SetCounterLimit(0x1b,6) --ATP Counters Limit
	aux.AddFieldSkillProcedure(c,2,false)

	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_STARTUP)
	e0:SetRange(0xff)
	e0:SetOperation(s.stop)
	c:RegisterEffect(e0)

	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)

end

function s.stfilter(c)
	return c:IsCode(100)
end

function s.stop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(s.stfilter,tp,0xff,0,c)
	Duel.MoveToField(g:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.Breakeffect()
	local g2=Duel.GetMatchingGroup(aux.FilterFaceupFunction(Card.IsCanAddCounter,0x8,1),1-tp,LOCATION_FZONE,0,c)
	g2:ForEach(Card.AddCounter,0x8,8)
end