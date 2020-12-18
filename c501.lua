--Injected Medley - Pneumonia
local s,id=GetID()
function s.initial_effect(c)

	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_CANNOT_SSET)
	e0:SetRange(LOCATION_HAND)
	c:RegisterEffect(e0)

	--Manifestation (e1)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	--e1:SetCost(s.ManifestCost)
	--e1:SetTarget(s.ManifestTarget)
	--e1:SetCondition(s.ManifestCondition)
	--e1:SetOperation(s.ManifestOperation)
	c:RegisterEffect(e1)
	
	--local e1=Effect.CreateEffect(c)
	--e1:SetDescription(aux.Stringid(id,0))
	--e1:SetType(EFFECT_TYPE_ACTIVATE)
	--e1:SetCode(EVENT_FREE_CHAIN)
	--e1:SetCost(s.RecruitCost)
	--e1:SetTarget(s.PathogenTarget)
	--e1:SetOperation(s.PathogenOperation)
	--c:RegisterEffect(e1)

	--local e2=Effect.CreateEffect(c)
	--e2:SetDescription(aux.Stringid(id,1))
	--e2:SetType(EFFECT_TYPE_ACTIVATE)
	--e2:SetCode(EVENT_FREE_CHAIN)
	--e2:SetCost(s.RecruitCost)
	--e2:SetTarget(s.AvatarTarget)
	--e2:SetOperation(s.AvatarOperation)
	--c:RegisterEffect(e2)

	--local e3=Effect.CreateEffect(c)
	--e3:SetDescription(aux.Stringid(id,2))
	--e3:SetType(EFFECT_TYPE_ACTIVATE)
	--e3:SetCode(EVENT_FREE_CHAIN)
	--e3:SetCost(s.LinkCost)
	--e3:SetTarget(s.LinkTarget)
	--e3:SetOperation(s.LinkOperation)
	--c:RegisterEffect(e3)
end

--Search Effect(s)
function s.RecruitCost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,1,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x1b,1,REASON_COST)
end
function s.LinkCost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,2,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x1b,2,REASON_COST)
end
function s.PathogenFilter(c)
	return c:IsCode(101,1011) and c:IsLocation(LOCATION_DECK)
end
function s.AvatarFilter(c)
	return c:IsCode(201,202,203) and c:IsLocation(LOCATION_DECK)
end
function s.PathogenTarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(s.PathogenFilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.AvatarTarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(s.AvatarFilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.PathogenOperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.PathogenFilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
function s.AvatarOperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.AvatarFilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end

--Link Effect

function s.LinkCost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,2,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x1b,2,REASON_COST)
end
function s.LinkFilter1(c,tp)
	return c:IsCode(400,401,402,403)
end
function s.LinkFilter2(c)
	return c:IsFaceup(201,202,203)
end
function s.LinkTarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingMatchingCard(s.LinkFilter1,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil) 
	and Duel.IsExistingMatchingCard(s.LinkFilter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(id,5))
	local g=Duel.SelectTarget(tp,s.LinkFilter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	e:SetLabelObject(g:GetFirst())
end
function s.LinkOperation(e,tp,eg,ep,ev,re,r,rp)
	local c1=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(id,6))
	local c2=Duel.SelectMatchingCard(tp,s.LinkFilter1,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,1,nil)
	if c1:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not c1:IsImmuneToEffect(e) and not tc:IsImmuneToEffect(e) then
		Duel.Overlay(c1,c2)
	end
end

--Manifestation (e1)
function s.ManifestCondition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end

function s.AvatarFilter(c,tp)
	return c:IsLocation(LOCATION_DECK) and c:IsCode(201)
end

function s.PathogenFilter(c,tp)
	return c:IsFacedown() and c:IsCode(1,4)
end

function s.ManifestTarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and s.eqfilter(chkc,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(s.AvatarFilter,tp,LOCATION_DECK,0,1,nil,tp)
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	local ct=math.min((Duel.GetLocationCount(tp,LOCATION_SZONE)),1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local sg=Duel.GetMatchingGroup(s.AvatarFilter,tp,LOCATION_DECK,0,1,1,nil,tp)
	--local g=sg:RandomSelect(tp,1)
	Duel.SetTargetCard(g)
end

function s.ManifestOperation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or tc:IsImmuneToEffect(e) then return end
	if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.GetMatchingCard(s.PathogenFilter,tp,LOCATION_SZONE,0,1,nil,tp)
	--local g=tg:RandomSelect(tp,1)
	local sc=g:GetFirst()
	if sc then
		Duel.Equip(tp,sc,tc,false)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetValue(s.AnchorLimit)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(id,RESET_EVENT+RESETS_STANDARD,0,1)
		sc:CompleteProcedure()
	end
end