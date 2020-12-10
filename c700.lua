--Mitochondrion
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
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_PHASE+PHASE_DRAW)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCondition(s.con1)
	e2:SetOperation(s.op1)
	Duel.RegisterEffect(e2,tp)

	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_COUNTER)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCountLimit(1)
	e3:SetCode(EVENT_PHASE+PHASE_DRAW)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCondition(s.con2)
	e3:SetOperation(s.op2)
	Duel.RegisterEffect(e3,tp)

	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,2))
	e4:SetCategory(CATEGORY_COUNTER)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCountLimit(1)
	e4:SetCode(EVENT_PHASE+PHASE_DRAW)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCondition(s.con3)
	e4:SetOperation(s.op3)
	Duel.RegisterEffect(e4,tp)

	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(id,3))
	e5:SetCategory(CATEGORY_COUNTER)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCountLimit(1)
	e5:SetCode(EVENT_PHASE+PHASE_DRAW)
	e5:SetRange(LOCATION_FZONE)
	e5:SetCondition(s.con4)
	e5:SetOperation(s.op4)
	Duel.RegisterEffect(e5,tp)

	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(id,4))
	e6:SetCategory(CATEGORY_COUNTER)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetCountLimit(1)
	e6:SetCode(EVENT_PHASE+PHASE_DRAW)
	e6:SetRange(LOCATION_FZONE)
	e6:SetCondition(s.con5)
	e6:SetOperation(s.op5)
	Duel.RegisterEffect(e6,tp)

	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(id,5))
	e7:SetCategory(CATEGORY_COUNTER)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetCountLimit(1)
	e7:SetCode(EVENT_PHASE+PHASE_DRAW)
	e7:SetRange(LOCATION_FZONE)
	e7:SetCondition(s.con6)
	e7:SetOperation(s.op6)
	Duel.RegisterEffect(e7,tp)

	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(id,6))
	e8:SetCategory(CATEGORY_COUNTER)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e8:SetCountLimit(1)
	e8:SetCode(EVENT_PHASE+PHASE_DRAW)
	e8:SetRange(LOCATION_FZONE)
	e8:SetCondition(s.con7)
	e8:SetOperation(s.op7)
	Duel.RegisterEffect(e8,tp)
end

function s.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==1
end

function s.con2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==3
end

function s.con3(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==5
end

function s.con4(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==7
end

function s.con5(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==9
end

function s.con6(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==11
end

function s.con7(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()>11 and tp==Duel.GetTurnPlayer()
end

function s.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetHandler():GetCounter(0x1b)
	e:GetHandler():AddCounter(0x1b,1-ct)
end

function s.op2(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetHandler():GetCounter(0x1b)
	e:GetHandler():AddCounter(0x1b,2-ct)
end

function s.op3(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetHandler():GetCounter(0x1b)
	e:GetHandler():AddCounter(0x1b,3-ct)
end

function s.op4(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetHandler():GetCounter(0x1b)
	e:GetHandler():AddCounter(0x1b,4-ct)
end

function s.op5(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetHandler():GetCounter(0x1b)
	e:GetHandler():AddCounter(0x1b,5-ct)
end

function s.op6(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetHandler():GetCounter(0x1b)
	e:GetHandler():AddCounter(0x1b,6-ct)
end

function s.op7(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetHandler():GetCounter(0x1b)
	e:GetHandler():AddCounter(0x1b,6-ct,tp)
end