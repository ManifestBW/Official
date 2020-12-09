---Prototyran Deicide Cabbage

local s,id=GetID()
function s.initial_effect(c)
	c:EnableUnsummonable()
	c:EnableCounterPermit(0x8)
	c:EnableCounterPermit(0x1b)
	c:EnableCounterPermit(0x2e)
	c:EnableCounterPermit(0x2f)
	c:SetCounterLimit(0x2e,1)
	c:SetCounterLimit(0x2f,1)
	
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

	--Phagocyte Effect: Consume (e2)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_BATTLE_CONFIRM)
	e2:SetCondition(s.ConsumeCondition)
	e2:SetTarget(s.ConsumeTarget)
	e2:SetOperation(s.ConsumeOperation)
	c:RegisterEffect(e2)

	--Defender Rule #1: Avatar Interceptions (e3)
	--local e3=Effect.CreateEffect(c)
	--e3:SetDescription(aux.Stringid(id,1))
	--e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	--e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	--e3:SetCode(EVENT_BE_BATTLE_TARGET)
	--e3:SetRange(LOCATION_MZONE)
	--e3:SetCondition(s.AvatarInterceptCondition)
	--e3:SetCost(s.AvatarInterceptCost)
	--e3:SetTarget(s.AvatarInterceptTarget)
	--e3:SetOperation(s.AvatarInterceptOperation)
	--e3:SetValue(1)
	--c:RegisterEffect(e3)

	--Defender Rule #2: Direct Interceptions (e4)
	local e4=Effect.CreateEffect(c)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(s.DirectInterceptCondition)
	e4:SetTarget(s.DirectInterceptTarget)
	e4:SetOperation(s.DirectInterceptOperation)
	e4:SetValue(1)
	c:RegisterEffect(e4)

	--Defender Rule #3: Cannot Attack (e5)
	local e5=Effect.CreateEffect(c)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_ATTACK)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(1)
	c:RegisterEffect(e5)

	--Battle Rule #1: No Battle Damage (e6)
	local e6=Effect.CreateEffect(c)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_NO_BATTLE_DAMAGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetValue(1)
	c:RegisterEffect(e6)

	--Battle Rule #2: Avoid Battle Damage (e7)
	local e7=Effect.CreateEffect(c)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetValue(1)
	c:RegisterEffect(e7)

	--Battle Rule #3: Indestructable (e8)
	local e8=Effect.CreateEffect(c)
	e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e8:SetValue(1)
	c:RegisterEffect(e8)

	--Battle Rule #4: Loss of Life (e9)
	local e9=Effect.CreateEffect(c)
	e9:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e9:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e9:SetCategory(CATEGORY_DEFCHANGE)
	e9:SetCode(EVENT_BATTLED)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCondition(s.LifeLossCondition)
	e9:SetOperation(s.LifeLossOperation)
	c:RegisterEffect(e9)

	--Battle Rule #5: Self-destruct (e10)
	local e10=Effect.CreateEffect(c)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetCode(EFFECT_SELF_DESTROY)
	e10:SetRange(LOCATION_MZONE)
	e10:SetCondition(s.DeathCondition)
	e10:SetValue(1)
	c:RegisterEffect(e10)

	--Battle Rule #6: Evasion (e11)
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(id,2))
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e11:SetCode(EVENT_BE_BATTLE_TARGET)
	e11:SetOperation(s.EvasionOperation)
	c:RegisterEffect(e11)

	--Position Cannot Change (e12)
	local e12=Effect.CreateEffect(c)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e12:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e12)

	--Set Life (e13)
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetCode(EFFECT_UPDATE_DEFENSE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e13:SetRange(LOCATION_MZONE)
	e13:SetValue(s.DefenseValue)
	c:RegisterEffect(e13)	

	--Bind CD28--[o--CD80/86 (e14)
	local e14=Effect.CreateEffect(c)
	e14:SetType(EFFECT_TYPE_SINGLE)
	e14:SetCode(EFFECT_CHANGE_CODE)
	e14:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e14:SetRange(LOCATION_MZONE)
	e14:SetCondition(s.CD8086Condition)
	e14:SetValue(980)
	c:RegisterEffect(e14)
	
end

--Manifestation (e1)
function s.ManifestCondition(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsCanRemoveCounter(tp,1,0,0x1b,2,REASON_COST)
end
function s.ManifestOperation(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.RemoveCounter(tp,1,0,0x1b,2,REASON_COST)
end

function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function s.ManifestCostx(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,2,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x1b,2,REASON_COST)
end
function s.ManifestTargetx(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) 
	end
end
function s.ManifestOperationx(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_ATTACK)
end

--Phagocyte Effect: Consume (e2)
function s.ConsumeFilter(c)
	return c:GetEquipCount()>0
end
function s.ConsumeFilter2(c)
	return c:IsType(0x4)
end
function s.ConsumeCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()~=nil and e:GetHandler():GetEquipCount()<1
end
function s.ConsumeTarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and s.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.ConsumeFilter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.SetTargetCard(bc)
end
function s.ConsumeOperation(e,tp,eg,ep,ev,re,r,rp,g)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local eqg=tc:GetEquipGroup()
		if #eqg>0 and not eqg:IsExists(s.ConsumeFilter2,1,nil) then
			c:AddCounter(0x2f,1)
		end
		if #eqg>0 and eqg:IsExists(s.ConsumeFilter2,1,nil) then
			c:AddCounter(0x2e,1)
		end
		local code=Duel.CreateToken(tp,id-402)
		Duel.SpecialSummonStep(code,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		Duel.Equip(tp,code,c,false)
	end
end

--Defender Rule: Avatar Interceptions (e3)
--function s.AvatarInterceptCondition(e,tp,eg,ep,ev,re,r,rp)
	--local c=e:GetHandler()
	--local bt=eg:GetFirst()
	--return r~=REASON_REPLACE and c~=bt and bt:IsFaceup() and bt:GetControler()==c:GetControler()
--end
--function s.AvatarInterceptCost(e,tp,eg,ep,ev,re,r,rp,chk)
	--if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,2,REASON_COST) end
	--if Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
		--Duel.RemoveCounter(tp,1,0,0x1b,2,REASON_COST)
		--else 
		--Duel.NegateEffect(0)
	--end
--end
--function s.AvatarInterceptTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	--if chk==0 then return Duel.GetAttacker():GetAttackableTarget():IsContains(e:GetHandler()) end
--end
--function s.AvatarInterceptOperation(e,tp,eg,ep,ev,re,r,rp)
	--local c=e:GetHandler()
	--if c:IsRelateToEffect(e) and not Duel.GetAttacker():IsImmuneToEffect(e) then
		--Duel.ChangeAttackTarget(c)
	--end
--end

--Defender Rule: Direct Interceptions (e4)
function s.DirectInterceptCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():GetControler()~=tp and Duel.GetAttackTarget()==nil
end
function s.DirectInterceptTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttacker():GetAttackableTarget():IsContains(e:GetHandler()) end
end
function s.DirectInterceptOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and not Duel.GetAttacker():IsImmuneToEffect(e) then
		Duel.ChangeAttackTarget(c)
	end
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

--Battle Rule #5: Self-destruct (e10)
function s.DeathCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetDefense()==0
end


--Battle Rule #6: Evasion (e11)
function s.EvasionOperation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SelectYesNo(tp,aux.Stringid(id,2)) return end
	Duel.ChangeAttackTarget(nil)
end

---Set Life (e12)
function s.DefenseFilter(c)
	return c:GetDefense()>=0
end
function s.DefenseValue(e,c)
	local g=e:GetHandler():GetOverlayGroup():Filter(s.DefenseFilter,nil)
	return g:GetSum(Card.GetDefense)
end

--Bind CD28--[o--CD8086 (e13)
function s.NaiveFilter(c,code)
	return c:IsFaceup() and c:IsCode(928,601)
end
function s.CD8086Condition(e)
	return Duel.IsExistingMatchingCard(s.NaiveFilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end