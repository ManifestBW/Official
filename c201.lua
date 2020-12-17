---Pneumoknight Breathbuster
local s,id=GetID()
function s.initial_effect(c)
	c:EnableUnsummonable()
	c:EnableCounterPermit(0x8)
	c:EnableCounterPermit(0x2e)
	c:SetCounterLimit(0x2e,1)
	
	--Manifestation (e1)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	--e1:SetCost(s.ManifestCost)
	e1:SetTarget(s.ManifestTarget)
	e1:SetCondition(s.ManifestCondition)
	e1:SetOperation(s.ManifestOperation)
	c:RegisterEffect(e1)

	--Symptomize (e2)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(s.SymptomCost)
	e2:SetTarget(s.SymptomTarget)
	e2:SetCondition(s.SymptomCondition)
	e2:SetOperation(s.SymptomOperation)
	e2:SetCountLimit(1)
	c:RegisterEffect(e2)

	--Set Life (e3)
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(s.DefenseValue)
	c:RegisterEffect(e3)

	--Battle Rule #1: Avoid Battle Damage (e4)
	local e4=Effect.CreateEffect(c)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetValue(1)
	c:RegisterEffect(e4)

	--Battle Rule #2: Indestructable (e5)
	local e5=Effect.CreateEffect(c)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(1)
	c:RegisterEffect(e5)

	--Battle Rule #3: Loss of Life (e6)
	local e6=Effect.CreateEffect(c)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetCategory(CATEGORY_DEFCHANGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EVENT_BATTLED)
	e6:SetCondition(s.LifeLossCondition)
	e6:SetOperation(s.LifeLossOperation)
	c:RegisterEffect(e6)

	--Battle Rule #4: Self-destruct (e7)
	local e7=Effect.CreateEffect(c)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_SELF_DESTROY)
	e7:SetCondition(s.SelfDestructCondition)
	c:RegisterEffect(e7)

	--Battle Rule #5: Attack Limit (e8)
	local e8=Effect.CreateEffect(c)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e8:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e8:SetValue(aux.TargetBoolFunction(Card.IsFacedown))
	c:RegisterEffect(e8)

	--Battle Rule #6: Direct Attack (e9)
	local e9=Effect.CreateEffect(c)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e9:SetCode(EFFECT_DIRECT_ATTACK)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetRange(LOCATION_MZONE)
	e9:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	c:RegisterEffect(e9)

	--Battle Rule #7: Evasion (e10)
	local e10=Effect.CreateEffect(c)
	e10:SetDescription(aux.Stringid(id,2))
	e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e10:SetCode(EVENT_BE_BATTLE_TARGET)
	e10:SetOperation(s.EvasionOperation)
	c:RegisterEffect(e10)

	--Position Cannot Change (e11)
	local e11=Effect.CreateEffect(c)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e11:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e11)

	--Increase Power Proportional to Distress (e12)
	local e12=Effect.CreateEffect(c)
	e12:SetCode(EFFECT_UPDATE_ATTACK)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e12:SetValue(s.DistressPowerOperation)
	c:RegisterEffect(e12)

	--Existence Condition (e13)
	local e13=Effect.CreateEffect(c)
	e13:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e13:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e13:SetCode(EVENT_PHASE+PHASE_END)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCondition(s.ExistenceCondition)
	e13:SetOperation(s.ExistenceOperation)
	e13:SetCountLimit(1)
	c:RegisterEffect(e13)

	--Sealed Ability: Onslaught (e14)
	local e14=Effect.CreateEffect(c)
	e14:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e14:SetCode(EVENT_DAMAGE_STEP_END)
	e14:SetCost(s.OnslaughtCost)
	e14:SetCondition(s.OnslaughtCondition)
	e14:SetOperation(s.OnslaughtOperation)
	e14:SetValue(10)
	c:RegisterEffect(e14)

	--Unsealed Ability: Onslaught (e15)
	local e15=Effect.CreateEffect(c)
	e15:SetType(EFFECT_TYPE_XMATERIAL+EFFECT_TYPE_TRIGGER_O)
	e15:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e15:SetCode(EVENT_BATTLE_DAMAGE)
	e15:SetCost(s.OnslaughtCost)
	e15:SetOperation(s.OnslaughtOperation)
	e15:SetValue(10)
	c:RegisterEffect(e15)

	local e17=Effect.CreateEffect(c)
	e17:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e17:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e17:SetCondition(s.CrackleCondition)
	e17:SetOperation(s.CrackleOperation)
	e17:SetTarget(s.CrackleOperation)
	e17:SetRange(LOCATION_MZONE)
	e17:SetTargetRange(0,1)
	c:RegisterEffect(e17)

	--Fabricate Distress Counters (e18)
	local e18=Effect.CreateEffect(c)
	e18:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e18:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e18:SetCode(EVENT_SUMMON_SUCCESS)
	e18:SetRange(LOCATION_MZONE)
	e18:SetTarget(s.DistressTarget)
	e18:SetOperation(s.DistressOperation)
	c:RegisterEffect(e18)
	local e19=e18:Clone()
	e19:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e19)

end

--Manifestation (e1)
function s.ManifestFilter(c,tp)
	return c:IsCode(1,4,6,11,20,28,32,34,41,47,48,52) and c:GetType()&(TYPE_EQUIP)~=(TYPE_EQUIP)
	--S. aureus (1)
	--S. pneumoniae (4)
	--S. agalactiae (6)
	--L. monocytogenes (11)
	--N. asteroides (20)
	--P. aeruginosa (28)
	--K. pneumoniae (32)
	--M. catarrhalis (34)
	--H. influenzae (41)
	--A. baumannii (47)
	--B. fragilis (48)
	--L. pneumophilia (52)
end

--Manifestation
function s.AnchorLimit(e,c)
	return e:GetOwner()==c
end
function s.ManifestCondition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() 
end
function s.ManifestCost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,3,REASON_COST) end
	if Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
		Duel.RemoveCounter(tp,1,0,0x1b,3,REASON_COST)
		else 
		Duel.NegateEffect(0)
	end
end
function s.ManifestTarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and s.eqfilter(chkc,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(s.ManifestFilter,tp,LOCATION_SZONE,0,1,nil,tp)
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	local ct=math.min((Duel.GetLocationCount(tp,LOCATION_SZONE)),1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local sg=Duel.GetMatchingGroup(s.ManifestFilter,tp,LOCATION_SZONE,0,1,1,nil,tp)
	local g=sg:RandomSelect(tp,1)
	Duel.SetTargetCard(g)
end
function s.ManifestOperation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_ATTACK)~=0 then
		local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
		local g=Duel.GetTargetCards(e)
		--if ft<#g then return end
		Duel.BreakEffect()
		for tc in aux.Next(g) do
			Duel.Equip(tp,tc,c,false)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetValue(s.AnchorLimit)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(id,RESET_EVENT+RESETS_STANDARD,0,1)
		end
	end
end

--Symptomize (e2)
function s.SymptomFilter(c)
	return c:IsCode(400,401,402,403)
	--Ch Pain (400)
	--Fever I (401)
	--Cough I (402)
	--Dyspnea (403)
end
function s.SymptomCost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,3,REASON_COST) end
	if Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
		Duel.RemoveCounter(tp,1,0,0x1b,3,REASON_COST)
		else 
		Duel.NegateEffect(0)
	end
end
function s.SymptomTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.SymptomFilter,tp,LOCATION_EXTRA,0,1,nil) end
end
function s.SymptomCondition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and e:GetHandler():GetOverlayCount()<4
end

function s.SymptomOperation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_HAND,0,1,1,nil)
		if #g>0 then
			Duel.SendtoDeck(g,nil,1,REASON_EFFECT)
		end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,s.SymptomFilter,tp,LOCATION_EXTRA,0,1,1,nil)
	if #g>0 then
		Duel.Overlay(c,g)
	end
end

--Set Life (e3)
function s.DefenseFilter(c)
	return c:GetDefense()>=0
end
function s.DefenseValue(e,c)
	local g=e:GetHandler():GetOverlayGroup():Filter(s.DefenseFilter,nil)
	return g:GetSum(Card.GetDefense)
end

--Battle Rule #1: Avoid Battle Damage (e4)

--Battle Rule #2: Indestructable (e5)

--Battle Rule #3: Loss of Life (e6)
function s.LifeLossCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattleTarget()~=nil
end
function s.LifeLossOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if tc:IsFaceup() and tc:IsRelateToBattle() then
		local atk=c:GetAttack()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_DEFENSE)
		e1:SetValue(-atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end

--Battle Rule #4: Self-destruct (e7)
function s.SelfDestructCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetDefense()==0
end

--Battle Rule #5: Attack Limit (e8)

--Battle Rule #6: Direct Attack (e9)

--Battle Rule #7: Evasion (e10)
function s.EvasionOperation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SelectYesNo(tp,aux.Stringid(id,2)) then return end
	Duel.ChangeAttackTarget(nil)
end

--Position Cannot Change (e11)

--Increase Power Proportional to Distress (e12)
function s.DistressPowerOperation(e,c)
	return Duel.GetCounter(0,1,1,0x8)/4
end

--Existence Condition (e13)
function s.ExistenceCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetEquipCount()<1
end
function s.ExistenceOperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end

--Onslaught (e14,e15)
function s.OnslaughtCost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,3,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x1b,3,REASON_COST)
end
function s.OnslaughtCondition(e,tp,eg,ep,ev,re,r,rp,chk)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,400)
end
function s.OnslaughtOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToBattle() then
		Duel.ChainAttack()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE+PHASE_DAMAGE_CAL)
		c:RegisterEffect(e1)
	end
end

--Cough (e16)
function s.DistressTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,2,0,0x8)
end
function s.DistressOperation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.FilterFaceupFunction(Card.IsCanAddCounter,0x8,1),tp,LOCATION_MZONE,0,c)
	g:ForEach(Card.AddCounter,0x8,1)
end


--Crackle (e18) 
function s.CrackleCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattledGroupCount()>0
end

function s.CrackleTarget(e,c)
	return c:IsType(TYPE_FIELD)
end

function s.CrackleOperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	c:RemoveCounter(0x8,3)
	tc:AddCounter(0x8,3)
end