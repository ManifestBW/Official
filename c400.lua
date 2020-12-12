--Gamma Interference
local s,id=GetID()
function s.initial_effect(c)

	--MHC-I (e1)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_XMATERIAL+EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(s.MHCICondition)
	e1:SetOperation(s.MHCIOperation)
	e1:SetCountLimit(1)
	c:RegisterEffect(e1)

	--Inhibit Helper-2 T-Lymphocyte (e2)
	--local e2=Effect.CreateEffect(c)
	--e2:SetDescription(aux.Stringid(id,1))
	--e2:SetType(EFFECT_TYPE_XMATERIAL+EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	--e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	--e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	--e2:SetRange(LOCATION_MZONE)
	--e2:SetCondition(s.TH2BounceCondition)
	--e2:SetOperation(s.TH2BounceOperation)
	--e2:SetCountLimit(1)
	--c:RegisterEffect(e2)

	--Inhibit Helper-2 T-Lymphocyte (e3)
	--local e3=Effect.CreateEffect(c)
	--e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	--e3:SetCode(EVENT_BE_MATERIAL)
	--e3:SetCondition(s.efcon)
	--e3:SetOperation(s.efop)
	--c:RegisterEffect(e3)

end

function s.efcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_XYZ
end
function s.efop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(4)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE)
	rc:RegisterEffect(e1)
	if not rc:IsType(TYPE_EFFECT) then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CHANGE_TYPE)
		e2:SetValue(TYPE_MONSTER+TYPE_EFFECT+TYPE_XYZ)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		rc:RegisterEffect(e2)
	end
end

--Major Histocompatibility Complex-I (e1)
function s.filter(c)
	return c:GetEquipCount()>0
end
function s.efilter(c)
	return c:IsType(0x4)
end
function s.MHCICondition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and e:GetHandler():GetEquipGroup():IsExists(s.efilter,1,nil)
end
function s.MHCIOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local eqg=c:GetEquipGroup()
	if #eqg>0 then
	c:AddCounter(0x2e,1)
	end
end

--Inhibit Helper-2 T-Lymphocyte (e2)
function s.TH2BounceCondition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and e:GetHandler():IsCode(600402)
end
function s.TH2BounceOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.SendtoHand(c,nil,REASON_EFFECT)
end