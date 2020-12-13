--Acquired Immunodeficiency Syndrome

local s,id=GetID()
function s.initial_effect(c)
	c:EnableCounterPermit(0x1b) --ATP Counters
	c:EnableCounterPermit(0x8) --Distress Counters
	c:EnableCounterPermit(0x7) --Delirium Counters
	c:SetCounterLimit(0x1b,6) --ATP Counters Limit
	aux.AddFieldSkillProcedure(c,2,false)

	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)

	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCountLimit(2)
	e2:SetCode(EVENT_PHASE+PHASE_DRAW)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCondition(s.con1)
	e2:SetOperation(s.op1)
	c:RegisterEffect(e2)

	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(s.thcon)
	e3:SetTargetRange(LOCATION_MZONE,0)
	c:RegisterEffect(e3)

	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_DISABLE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetTarget(s.Target)
	c:RegisterEffect(e4)

end

function s.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==1
end

function s.stfilter(c)
	return c:IsCode(100)
end

function s.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(s.stfilter,tp,LOCATION_HAND+LOCATION_DECK,0,c)
	Duel.MoveToField(g:GetFirst(),tp,0,LOCATION_SZONE,POS_FACEUP,true)
	local g2=Duel.GetMatchingGroup(aux.FilterFaceupFunction(Card.IsCanAddCounter,0x4,12),1-tp,LOCATION_FZONE,0,c)
	g2:ForEach(Card.AddCounter,0x4,12)
end

function s.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCounter(0,1,1,0x4)>=5
end

--function s.Target(e,tp,eg,ep,ev,re,r,rp,chk)
	--return c:IsCode(604,605,606)
--end