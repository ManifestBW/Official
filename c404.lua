local s,id=GetID()
function s.initial_effect(c)
	--sXyz.AddProcedure(c,nil,1,2)
	c:EnableReviveLimit()
	--Fling Shuriken (e1)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(s.ShurikenCondition)
	e1:SetTarget(s.ShurikenTarget)
	e1:SetOperation(s.ShurikenActivate)
	e1:SetCountLimit(1)
	c:RegisterEffect(e1)
end

--Fling Shuriken (e1)
function s.ShurikenCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>1
end
function s.ShurikenFilter(c)
	return c:IsFaceup() and c:IsCode(28,604)
end
function s.ShurikenTarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return s.ShurikenFilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.ShurikenFilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SelectTarget(tp,s.ShurikenFilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function s.ShurikenActivate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() and c:IsRelateToEffect(e) then
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_HAND,0,2,2,nil)
		if #g>1 then
			Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
			Duel.Overlay(tc,c)
		end
	end
end