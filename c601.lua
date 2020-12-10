---Innocent Droid

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

	--(e2)

	--Defender Rule #1: Avatar Interceptions (e3)
	--local e3=Effect.CreateEffect(c)
	--e3:SetDescription(aux.Stringid(id,1))
	--e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	--e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	--e3:SetCode(EVENT_BE_BATTLE_TARGET)
	--e3:SetRange(LOCATION_MZONE)
	--e3:SetCondition(s.cbcon)
	--e3:SetCost(s.cbcost)
	--e3:SetTarget(s.cbtg)
	--e3:SetOperation(s.cbop)
	--e3:SetValue(1)
	--c:RegisterEffect(e3)

	--Defender Rule #2: Direct Interceptions (e4)
	local e4=Effect.CreateEffect(c)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(s.intcon)
	e4:SetTarget(s.inttgt)
	e4:SetOperation(s.intop)
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
	e9:SetCondition(s.ldcon)
	e9:SetOperation(s.ldop)
	c:RegisterEffect(e9)

	--Battle Rule #5: Self-destruct (e10)
	local e10=Effect.CreateEffect(c)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetCode(EFFECT_SELF_DESTROY)
	e10:SetRange(LOCATION_MZONE)
	e10:SetCondition(s.descon)
	e10:SetValue(1)
	c:RegisterEffect(e10)

	--Battle Rule #6: Evasion (e11)
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(id,2))
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e11:SetCode(EVENT_PRE_DAMAGE_CALCULATION)
	e11:SetOperation(s.EvasionOperation)
	c:RegisterEffect(e11)

	--Position Cannot Change (e12)
	local e12=Effect.CreateEffect(c)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e12:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e12)

	--Over-Manifest "Cytotoxic T-Lymphocyte" (e13)
	local e13=Effect.CreateEffect(c)
	e13:SetDescription(aux.Stringid(id,4))
	e13:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e13:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e13:SetType(EFFECT_TYPE_QUICK_O)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCode(EVENT_FREE_CHAIN)
	e13:SetCountLimit(1)
	e13:SetCost(s.spcost2)
	e13:SetTarget(s.sptg2)
	e13:SetOperation(s.spop2)
	c:RegisterEffect(e13)

	--Over-Manifest "Helper-0 T-Lymphocyte" (e14)
	local e14=Effect.CreateEffect(c)
	e14:SetDescription(aux.Stringid(id,5))
	e14:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e14:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e14:SetType(EFFECT_TYPE_QUICK_O)
	e14:SetRange(LOCATION_MZONE)
	e14:SetCode(EVENT_FREE_CHAIN)
	e14:SetCountLimit(1)
	e14:SetCost(s.spcost3)
	e14:SetTarget(s.sptg3)
	e14:SetOperation(s.spop3)
	c:RegisterEffect(e14)

	--CD28--[o--CD80/86(B7) Binding (e15)
	local e15=Effect.CreateEffect(c)
	e15:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e15:SetType(EFFECT_TYPE_SINGLE)
	e15:SetCode(EFFECT_CHANGE_CODE)
	e15:SetRange(LOCATION_MZONE)
	e15:SetCondition(s.CD28Condition)
	e15:SetValue(928)
	c:RegisterEffect(e15)

end

--Manifest (e1)
function s.ManifestCondition(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsCanRemoveCounter(tp,1,0,0x1b,0,REASON_COST)
end
function s.ManifestOperation(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.RemoveCounter(tp,1,0,0x1b,0,REASON_COST)
end

function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) 
	end
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_ATTACK)
end

--(e2)

--Defender Rule: Avatar Interceptions (e3)
--function s.cbcon(e,tp,eg,ep,ev,re,r,rp)
	--local c=e:GetHandler()
	--local bt=eg:GetFirst()
	--return r~=REASON_REPLACE and c~=bt and bt:IsFaceup() and bt:GetControler()==c:GetControler()
--end
--function s.cbcost(e,tp,eg,ep,ev,re,r,rp,chk)
	--if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,4,REASON_COST) end
	--if Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
		--Duel.RemoveCounter(tp,1,0,0x1b,4,REASON_COST)
		--else 
		--Duel.NegateEffect(0)
	--end
--end
--function s.cbtg(e,tp,eg,ep,ev,re,r,rp,chk)
	--if chk==0 then return Duel.GetAttacker():GetAttackableTarget():IsContains(e:GetHandler()) end
--end
--function s.cbop(e,tp,eg,ep,ev,re,r,rp)
	--local c=e:GetHandler()
	--if c:IsRelateToEffect(e) and not Duel.GetAttacker():IsImmuneToEffect(e) then
		--Duel.ChangeAttackTarget(c)
	--end
--end

--Defender Rule: Direct Interceptions (e4)
function s.intcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():GetControler()~=tp and Duel.GetAttackTarget()==nil
end
function s.inttgt(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttacker():GetAttackableTarget():IsContains(e:GetHandler()) end
end
function s.intop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and not Duel.GetAttacker():IsImmuneToEffect(e) then
		Duel.ChangeAttackTarget(c)
	end
end

--Battle Rule #4: Loss of Life (e9)
function s.ldcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattleTarget()~=nil
end
function s.ldop(e,tp,eg,ep,ev,re,r,rp)
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
function s.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetDefense()==0
end

--Battle Rule #6: Evasion (e11)
function s.EvasionOperation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SelectYesNo(tp,aux.Stringid(id,2)) then return end
	Duel.ChangeAttackTarget(nil)
end

--Over-Manifest "Cytotoxic T-Lymphocyte" (e12)
function s.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,1,0x2e,1,REASON_COST) end
	Duel.RemoveCounter(tp,1,1,0x2e,1,REASON_COST)
end
function s.spfilter2(c,e,tp,mc,pg)
	return c:IsCode(608)
end

function s.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spfilter2,tp,LOCATION_DECK,0,1,nil,e,tp,c) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end

function s.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local pg=aux.GetMustBeMaterialGroup(tp,Group.FromCards(c),tp,nil,nil,REASON_XYZ)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.spfilter2,tp,LOCATION_DECK,0,1,1,nil,e,tp,c,pg)
	local sc=g:GetFirst()
	if sc then
		Duel.BreakEffect()
		sc:SetMaterial(Group.FromCards(c))
		Duel.Overlay(sc,Group.FromCards(c))
		Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		sc:CompleteProcedure()
	end
end

--Over-Manifest "Helper-0 T-Lymphocyte" (e13)
function s.spcost3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x2f,1,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x2f,1,REASON_COST)
end
function s.spfilter3(c,e,tp,mc,pg)
	return c:IsCode(604)
end
function s.sptg3(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spfilter3,tp,LOCATION_DECK,0,1,nil,e,tp,c) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function s.spop3(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local pg=aux.GetMustBeMaterialGroup(tp,Group.FromCards(c),tp,nil,nil,REASON_XYZ)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.spfilter3,tp,LOCATION_DECK,0,1,1,nil,e,tp,c,pg)
	local sc=g:GetFirst()
	if sc then
		Duel.BreakEffect()
		sc:SetMaterial(Group.FromCards(c))
		Duel.Overlay(sc,Group.FromCards(c))
		Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		sc:CompleteProcedure()
	end
end

--Bind CD28--[o--CD8086 (e14)
function s.PhagocyteFilter(c,code)
	return c:IsFaceup() and c:IsCode(602,603,980)
end
function s.CD28Condition(e)
	return Duel.IsExistingMatchingCard(s.PhagocyteFilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end