--Prototyran Apollonian Beta

local s,id=GetID()
function s.initial_effect(c)
	c:EnableUnsummonable()
	c:EnableCounterPermit(0x8)
	c:EnableCounterPermit(0x1b)

	--Manifest (e1)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP_ATTACK,0)
	e1:SetCondition(s.ManifestCondition)
	e1:SetOperation(s.ManifestOperation)
	c:RegisterEffect(e1)

	--Anticipate from Hand (e2)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(s.AnticipateCondition)
	e2:SetTarget(s.AnticipateTarget)
	e2:SetOperation(s.AnticipateOperation)
	c:RegisterEffect(e2)

	--Defender Rule #1: Cannot Attack (e3)
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(1)
	c:RegisterEffect(e3)

	--Defender Rule #2: Avatar Interceptions (e4)
	--local e4=Effect.CreateEffect(c)
	--e4:SetDescription(aux.Stringid(id,1))
	--e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	--e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	--e4:SetCode(EVENT_BE_BATTLE_TARGET)
	--e4:SetRange(LOCATION_MZONE)
	--e4:SetCondition(s.AvatarInterceptionCondition)
	--e4:SetCost(s.AvatarInterceptionCost)
	--e4:SetTarget(s.AvatarInterceptionTarget)
	--e4:SetOperation(s.AvatarInterceptionOperation)
	--e4:SetValue(1)
	--c:RegisterEffect(e4)

	--Defender Rule #3: Direct Interceptions (e5)
	local e5=Effect.CreateEffect(c)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_ATTACK_ANNOUNCE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(s.DirectInterceptionCondition)
	e5:SetTarget(s.DirectInterceptionTarget)
	e5:SetOperation(s.DirectInterceptionOperation)
	e5:SetValue(1)
	c:RegisterEffect(e5)

	--Set Life (e6)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_UPDATE_DEFENSE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetValue(s.DefenseValue)
	c:RegisterEffect(e6)	

	--Battle Rule #1: No Battle Damage (e7)
	local e7=Effect.CreateEffect(c)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_NO_BATTLE_DAMAGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetValue(1)
	c:RegisterEffect(e7)

	--Battle Rule #2: Avoid Battle Damage (e8)
	local e8=Effect.CreateEffect(c)
	e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetValue(1)
	c:RegisterEffect(e8)

	--Battle Rule #3: Indestructable (e9)
	local e9=Effect.CreateEffect(c)
	e9:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e9:SetValue(1)
	c:RegisterEffect(e9)

	--Battle Rule #4: Loss of Life (e10)
	local e10=Effect.CreateEffect(c)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e10:SetCategory(CATEGORY_DEFCHANGE)
	e10:SetCode(EVENT_BATTLED)
	e10:SetRange(LOCATION_MZONE)
	e10:SetCondition(s.LifeLossCondition)
	e10:SetOperation(s.LifeLossOperation)
	c:RegisterEffect(e10)

	--Battle Rule #5: Self-Destruct (e11)
	local e11=Effect.CreateEffect(c)
	e11:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetCode(EFFECT_SELF_DESTROY)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCondition(s.SelfDestructCondition)
	e11:SetValue(1)
	c:RegisterEffect(e11)

	--Battle Rule #6: Evasion (e12)
	local e12=Effect.CreateEffect(c)
	e12:SetDescription(aux.Stringid(id,2))
	e12:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e12:SetCode(EVENT_BE_BATTLE_TARGET)
	e12:SetOperation(s.EvasionOperation)
	c:RegisterEffect(e12)

	--Position Cannot Change (e13)
	local e13=Effect.CreateEffect(c)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e13:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e13)

	--Bind CD40--[o--CD40L (e14)
	local e14=Effect.CreateEffect(c)
	e14:SetType(EFFECT_TYPE_SINGLE)
	e14:SetCode(EFFECT_CHANGE_CODE)
	e14:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e14:SetRange(LOCATION_MZONE)
	e14:SetCondition(s.CD40Condition)
	e14:SetValue(940)
	c:RegisterEffect(e14)

end

--Manifest (e1)
function s.ManifestCondition(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsCanRemoveCounter(tp,1,0,0x1b,4,REASON_COST)
end

function s.ManifestOperation(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.RemoveCounter(tp,1,0,0x1b,4,REASON_COST)
end

--Anticipate (e2)
function s.AnticipateFilter(c)
	return c:IsFacedown()
end

function s.DisableTarget(e,c)
	return c:IsCode(e:GetLabel())
end

function s.AnticipateCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>1 and Duel.IsCanRemoveCounter(tp,1,0,0x1b,4,REASON_EFFECT)
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
	if tc:IsCode(ac) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		Duel.ChangePosition(tc,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		e1:SetTarget(s.DisableTarget)
		e1:SetLabel(ac)
		Duel.RegisterEffect(e1,tp)
		else
		Duel.RemoveCounter(tp,1,0,0x1b,4,REASON_EFFECT)
		Duel.SendtoGrave(c,REASON_EFFECT)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_HAND,0,2,2,nil)
		if #g>1 then
			Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
		end
	end
end

--Defender Rule: Avatar Interceptions (e3)
--function s.AvatarInterceptionCondition(e,tp,eg,ep,ev,re,r,rp)
	--local c=e:GetHandler()
	--local bt=eg:GetFirst()
	--return r~=REASON_REPLACE and c~=bt and bt:IsFaceup() and bt:GetControler()==c:GetControler()
--end

--function s.AvatarInterceptionCost(e,tp,eg,ep,ev,re,r,rp,chk)
	--if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,4,REASON_COST) end
	--if Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
		--Duel.RemoveCounter(tp,1,0,0x1b,4,REASON_COST)
		--else 
		--Duel.NegateEffect(0)
	--end
--end

--function s.AvatarInterceptionTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	--if chk==0 then return Duel.GetAttacker():GetAttackableTarget():IsContains(e:GetHandler()) end
--end

--function s.AvatarInterceptionOperation(e,tp,eg,ep,ev,re,r,rp)
	--local c=e:GetHandler()
	--if c:IsRelateToEffect(e) and not Duel.GetAttacker():IsImmuneToEffect(e) then
		--Duel.ChangeAttackTarget(c)
	--end
--end

--Defender Rule: Direct Interceptions (e4)
function s.DirectInterceptionCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():GetControler()~=tp and Duel.GetAttackTarget()==nil
end
function s.DirectInterceptionTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttacker():GetAttackableTarget():IsContains(e:GetHandler()) end
end
function s.DirectInterceptionOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.SelectYesNo(tp,aux.Stringid(id,1)) then return end
	if c:IsRelateToEffect(e) and not Duel.GetAttacker():IsImmuneToEffect(e) then
		Duel.ChangeAttackTarget(c)
	end
end

---Set Life (e6)
function s.DefenseFilter(c)
	return c:GetDefense()>=0
end

function s.DefenseValue(e,c)
	local g=e:GetHandler():GetOverlayGroup():Filter(s.DefenseFilter,nil)
	return g:GetSum(Card.GetDefense)
end

--Battle Rule #4: Loss of Life (e9)
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

--Battle Rule #5: Self-Destruct (e10)
function s.SelfDestructCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetDefense()==0
end

--Battle Rule #7: Evasion (e11)
function s.EvasionOperation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SelectYesNo(tp,aux.Stringid(id,2)) then return end
	Duel.ChangeAttackTarget(nil)
end	

--Bind CD40--[o--CD40L (e14)
function s.HelperFilter(c,code)
	return c:IsFaceup() and c:IsCode(606,941)
end
function s.CD40Condition(e)
	return Duel.IsExistingMatchingCard(s.HelperFilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end


--Anticipate from Field (?)
function s.rmcon2(e,tp,eg,ep,ev,re,r,rp)
	if (Duel.IsExistingMatchingCard(s.envfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) or Duel.IsEnvironment(CARD_SANCTUARY_SKY)) then return e:GetHandler():GetFlagEffect(id)<2
		else return e:GetHandler():GetFlagEffect(id)<1 
	end
end

function s.envfilter(c)
	return c:IsFaceup() and c:IsCode(604)
end

function s.rmtg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and s.rmfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.rmfilter,tp,0,LOCATION_SZONE,1,nil) end
	local g=Duel.SelectTarget(tp,s.rmfilter,tp,0,LOCATION_SZONE,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
end

function s.rmfilter(c)
	return c:IsAttribute(0x16)
end

function s.rmop2(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if not (e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e)) then return end
	if tc:IsRelateToEffect(e) and tc:AddCounter(COUNTER_PREDATOR,1) and tc:GetLevel()>1 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetTarget(s.bantg2)
		e1:SetLabel(ac)
		tc:RegisterEffect(e1)
	end
end

function s.bantg2(e,c)
	return c:IsCode(e:GetLabel())
end

