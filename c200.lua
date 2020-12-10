--Antigen (Sinister Omens)
local s,id=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddEquipProcedure(c)

	--Antigen Sampling (e1)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,3))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_NO_TURN_RESET)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EVENT_EQUIP)
	e1:SetCountLimit(1)
	e1:SetTarget(s.AntigenTarget1)
	e1:SetOperation(s.AntigenOperation1)
	c:RegisterEffect(e1)

	--Antigen Sampling (e2)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_NO_TURN_RESET)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(s.AntigenTarget)
	e2:SetOperation(s.AntigenOperation)
	c:RegisterEffect(e2)

	--Antigen Presentation to CD4 (e3,e4)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_EQUIP)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCondition(s.TransferCondition)
	e3:SetTarget(s.TransferTarget)
	e3:SetOperation(s.TransferOperation)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)

	--Antigen Presentation to CD8 (e9,e10)
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(id,2))
	e9:SetCategory(CATEGORY_EQUIP)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e9:SetCode(EVENT_SUMMON_SUCCESS)
	e9:SetRange(LOCATION_SZONE)
	e9:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e9:SetCondition(s.TransferCondition2)
	e9:SetTarget(s.TransferTarget2)
	e9:SetOperation(s.TransferOperation2)
	c:RegisterEffect(e9)
	local e10=e9:Clone()
	e10:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e10)

	--Self-Destruct (e5)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCode(EVENT_LEAVE_FIELD)
	e5:SetCondition(s.SelfDestructCondition)
	e5:SetOperation(s.SelfDestructOperation)
	c:RegisterEffect(e5)

	--Immunologic Memory (e6)
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_EQUIP)
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e11:SetCode(EVENT_BATTLE_START)
	e11:SetRange(LOCATION_SZONE)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetCondition(s.MemoryCondition2)
	e11:SetOperation(s.MemoryOperation2)
	c:RegisterEffect(e11)

	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_EQUIP)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_SUMMON_SUCCESS)
	e6:SetRange(LOCATION_SZONE)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetCondition(s.MemoryCondition)
	e6:SetOperation(s.MemoryOperation)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e7)

	--T-Helper Maturation (e8)
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_DESTROY_REPLACE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetRange(LOCATION_SZONE)
	e8:SetTarget(s.desreptg)
	e8:SetOperation(s.desrepop)
	c:RegisterEffect(e8)

end

--Antigen Sampling (e1)
function s.AntigenFilter1(c,e)
	return c:GetCounter(0x1108)>0
end

function s.AntigenTarget1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.GetMatchingGroup(s.AntigenFilter1,tp,0,LOCATION_SZONE,nil,e) end
	local g=Duel.GetMatchingGroup(s.AntigenFilter1,tp,0,LOCATION_SZONE,nil,e)
end

function s.AntigenOperation1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(s.AntigenFilter1,tp,0,LOCATION_SZONE,nil,e)
	if #g>1 then g=g:Select(tp,1,1,nil) end
	local c=e:GetHandler()
	local tc=g:GetFirst()
	if tc then
		c:SetCardTarget(tc)
		e:SetLabelObject(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetCondition(s.AntigenCondition)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
	end
end

--Antigen Sampling (e2)
function s.AntigenFilter(c,e)
	return c:IsType(TYPE_SPELL+TYPE_VIRUS) and c:IsType(TYPE_EQUIP) and c:GetEquipTarget()==Duel.GetAttacker()
end
function s.AntigenTarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.GetMatchingGroup(s.AntigenFilter,tp,0,LOCATION_SZONE,nil,e) end
	local g=Duel.GetMatchingGroup(s.AntigenFilter,tp,0,LOCATION_SZONE,nil,e)
end
function s.AntigenOperation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(s.AntigenFilter,tp,0,LOCATION_SZONE,nil,e)
	if #g>1 then g=g:Select(tp,1,1,nil) end
	local c=e:GetHandler()
	local tc=g:GetFirst()
	if tc then
		c:SetCardTarget(tc)
		e:SetLabelObject(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetCondition(s.AntigenCondition)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
	end
end
function s.AntigenCondition(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end

--Antigen Presentation (e3,e4)
function s.TCRFilter(c,tp)
	return c:IsCode(604)
end
function s.TransferCondition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.TCRFilter,1,nil,tp) 
	and e:GetHandler():GetType()&(TYPE_EQUIP)==(TYPE_EQUIP)
	and e:GetHandler():GetFirstCardTarget():GetType()&(TYPE_CONTINUOUS)~=(TYPE_CONTINUOUS)
	and e:GetHandler():GetEquipTarget():IsCode(602,603)

end
function s.TransferTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetMatchingGroup(s.TCRFilter,tp,LOCATION_ONFIELD,0,1,nil,e,tp) 
	end
end
function s.TransferOperation(e,tp,tc,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local g=Duel.GetMatchingGroup(s.TCRFilter,tp,LOCATION_ONFIELD,0,1,nil,e,tp)
	if #g>0 and c:IsType(TYPE_EQUIP) then
		local tc=g:GetFirst()
		Duel.Equip(tp,c,tc)
		Duel.Equip(1-tp,c,tc)
		Duel.Damage(1-tp,2,REASON_EFFECT)
	end
end

--Antigen Presentation (e9,e10)
function s.TCRFilter2(c,tp)
	return c:IsCode(608)
end
function s.TransferCondition2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.TCRFilter2,1,nil,tp) 
	and e:GetHandler():GetType()&(TYPE_EQUIP)==(TYPE_EQUIP) and e:GetHandler():GetEquipTarget():IsCode(602,603)
end

function s.TransferTarget2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetMatchingGroup(s.TCRFilter2,tp,LOCATION_ONFIELD,0,1,nil,e,tp) 
	end
end
function s.TransferOperation2(e,tp,tc,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local g=Duel.GetMatchingGroup(s.TCRFilter2,tp,LOCATION_ONFIELD,0,1,nil,e,tp)
	if #g>0 and c:IsType(TYPE_EQUIP) then
		local tc=g:GetFirst()
		Duel.Equip(tp,c,tc)
		Duel.Equip(1-tp,c,tc)
		Duel.Damage(1-tp,2,REASON_EFFECT)
	end
end

--Self-Destruct (e5)
function s.SelfDestructCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_LEAVE_CONFIRMED) then return false end
	local tc=c:GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function s.SelfDestructOperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end

--Immunologic Memory (e6,e7)
function s.MemoryFilter(c,tp)
	return c:IsFaceup() and c:IsCode(40,600) and c:IsControler(tp)
end
function s.MemoryFilter2(c,tp)
	return c:IsCode(41,600402)
end
function s.MemoryCondition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.MemoryFilter,1,nil,tp) and Duel.IsExistingMatchingCard(s.MemoryFilter2,tp,LOCATION_ONFIELD,0,1,nil) 
	and e:GetHandler():GetType()&(TYPE_SPELL+TYPE_CONTINUOUS)==(TYPE_SPELL+TYPE_CONTINUOUS)
end
function s.MemoryOperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc then
		Duel.ChangePosition(tc,POS_FACEUP)
		local c=e:GetHandler()
		if c:IsType(TYPE_SPELL + TYPE_CONTINUOUS) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
		e1:SetTarget(s.NegateTarget)
		e1:SetLabel(tc:GetCode())
		Duel.RegisterEffect(e1,tp)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
		e2:SetCode(EVENT_CHAIN_SOLVING)
		e2:SetCondition(s.NegateCondition)
		e2:SetOperation(s.NegateOperation)
		e2:SetLabel(tc:GetCode())
		Duel.RegisterEffect(e2,tp)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD)
		e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		e3:SetCode(EFFECT_FORBIDDEN)
		e3:SetTargetRange(0x7f,0x7f)
		e3:SetTarget(s.BanTarget)
		--e3:SetCondition(s.BanCon)
		e3:SetLabel(tc:GetCode())
		Duel.RegisterEffect(e3,tp)
		end
	end
end
function s.NegateTarget(e,c)
	return c:IsCode(e:GetLabel())
end
function s.NegateCondition(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler():IsCode(e:GetLabel())
end
function s.NegateOperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev) 
end
function s.BanTarget(e,c)
	return c:IsCode(e:GetLabel())
end

--Immunologic Memory - Helper ()
function s.MemoryFilter3(c,tp)
	return c:IsFaceup() and c:IsCode(40,600) and c:IsControler(tp)
end
function s.MemoryFilter4(c,tp)
	return c:IsCode(41,600402)
end
function s.MemoryCondition2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget()==Duel.GetAttacker()
end
	--return eg:IsExists(s.MemoryFilter3,1,nil,tp) and Duel.IsExistingMatchingCard(s.MemoryFilter4,tp,LOCATION_ONFIELD,0,1,nil) 
	--and e:GetHandler():GetType()&(TYPE_SPELL+TYPE_CONTINUOUS)==(TYPE_SPELL+TYPE_CONTINUOUS)
--end

function s.MemoryOperation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc then
		Duel.ChangePosition(tc,POS_FACEUP)
		local c=e:GetHandler()
		if c:IsType(TYPE_SPELL + TYPE_CONTINUOUS) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
		e1:SetTarget(s.NegateTarget2)
		e1:SetLabel(tc:GetCode())
		Duel.RegisterEffect(e1,tp)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
		e2:SetCode(EVENT_CHAIN_SOLVING)
		e2:SetCondition(s.NegateCondition2)
		e2:SetOperation(s.NegateOperation2)
		e2:SetLabel(tc:GetCode())
		Duel.RegisterEffect(e2,tp)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD)
		e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		e3:SetCode(EFFECT_FORBIDDEN)
		e3:SetTargetRange(0x7f,0x7f)
		e3:SetTarget(s.BanTarget2)
		--e3:SetCondition(s.BanCon)
		e3:SetLabel(tc:GetCode())
		Duel.RegisterEffect(e3,tp)
		end
	end
end
function s.NegateTarget2(e,c)
	return c:IsCode(e:GetLabel())
end
function s.NegateCondition2(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler():IsCode(e:GetLabel())
end
function s.NegateOperation2(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev) 
end
function s.BanTarget2(e,c)
	return c:IsCode(e:GetLabel())
end

--T-Helper Maturation (e8)
function s.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ec=c:GetPreviousEquipTarget()
	if chk==0 then return c:IsReason(REASON_LOST_TARGET) and ec and ec:IsReason(REASON_MATERIAL+REASON_XYZ) end
	return true
end
function s.desrepop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(s.HelperFilter,tp,LOCATION_ONFIELD,0,1,nil,e,tp)
	local tc=g:GetFirst()
	c:CancelToGrave()
	local e1=Effect.CreateEffect(c)
	e1:SetCode(EFFECT_CHANGE_TYPE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT + RESETS_STANDARD - RESET_TURN_SET)
	e1:SetValue(TYPE_SPELL + TYPE_CONTINUOUS)
	c:RegisterEffect(e1)
end
function s.HelperFilter(c,tp)
	return c:IsCode(41,600402)
end

--function s.BanCon(e,tp,eg,ep,ev,re,r,rp)
	--c:GetCode()~=(1101)
--end