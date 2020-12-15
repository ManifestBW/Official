--Ampicillin

local s,id=GetID()
function s.initial_effect(c)

	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(s.AnticipateTarget)
	e1:SetOperation(s.AnticipateOperation)
	c:RegisterEffect(e1)

end

function s.filter(c)
	return c:IsFacedown()
end

function s.AnticipateTarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetControler()~=tp and chkc:IsLocation(LOCATION_ONFIELD) and s.AnticipateFilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.AnticipateFilter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.SelectTarget(tp,s.AnticipateFilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
	local ac=Duel.AnnounceCard(tp)
	Duel.SetTargetParam(ac)
	Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,nil,0,tp,ANNOUNCE_CARD)
end

function s.AnticipateOperation(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if not (e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e)) then return end
	if tc:IsCode(ac) and tc:IsCode(1) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end