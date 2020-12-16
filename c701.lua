--Bacterial Research Laboratory
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_STARTUP)
	e1:SetRange(0xff)
	e1:SetOperation(s.stop)
	c:RegisterEffect(e1)

	--Confirm
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_REMOVED)
	e2:SetCost(s.cost)
	e2:SetTarget(s.cftg)
	e2:SetOperation(s.cfop)
	c:RegisterEffect(e2)

	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_REMOVED)
	e3:SetCost(s.cost2)
	e3:SetTarget(s.cftg2)
	e3:SetOperation(s.cfop2)
	c:RegisterEffect(e3)

	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,2))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_REMOVED)
	e4:SetCost(s.cost3)
	e4:SetTarget(s.cftg3)
	e4:SetOperation(s.cfop3)
	c:RegisterEffect(e4)

	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(id,3))
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_IGNITION)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetRange(LOCATION_REMOVED)
	e5:SetCost(s.cost4)
	e5:SetTarget(s.cftg4)
	e5:SetOperation(s.cfop4)
	c:RegisterEffect(e5)

	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(id,4))
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_IGNITION)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetRange(LOCATION_REMOVED)
	e6:SetCost(s.cost5)
	e6:SetTarget(s.cftg5)
	e6:SetOperation(s.cfop5)
	c:RegisterEffect(e6)

	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(id,5))
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_IGNITION)
	e7:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e7:SetRange(LOCATION_REMOVED)
	e7:SetCost(s.cost6)
	e7:SetTarget(s.cftg6)
	e7:SetOperation(s.cfop6)
	c:RegisterEffect(e7)

	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(id,6))
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_IGNITION)
	e8:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e8:SetRange(LOCATION_REMOVED)
	e8:SetCost(s.cost7)
	e8:SetTarget(s.cftg7)
	e8:SetOperation(s.cfop7)
	c:RegisterEffect(e8)

	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(id,7))
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_IGNITION)
	e9:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e9:SetRange(LOCATION_REMOVED)
	e9:SetCost(s.cost8)
	e9:SetTarget(s.cftg8)
	e9:SetOperation(s.cfop8)
	c:RegisterEffect(e9)

	local e10=Effect.CreateEffect(c)
	e10:SetDescription(aux.Stringid(id,8))
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_IGNITION)
	e10:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e10:SetRange(LOCATION_REMOVED)
	e10:SetCost(s.cost9)
	e10:SetTarget(s.cftg9)
	e10:SetOperation(s.cfop9)
	c:RegisterEffect(e10)

	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(id,9))
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_IGNITION)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetRange(LOCATION_REMOVED)
	e11:SetCost(s.cost10)
	e11:SetTarget(s.cftg10)
	e11:SetOperation(s.cfop10)
	c:RegisterEffect(e11)
	
	--local e12=Effect.CreateEffect(c)
	--e12:SetDescription(aux.Stringid(id,10))
	--e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_IGNITION)
	--e12:SetProperty(EFFECT_FLAG_CARD_TARGET)
	--e12:SetRange(LOCATION_REMOVED)
	--e12:SetCost(s.cost11)
	--e12:SetTarget(s.cftg11)
	--e12:SetOperation(s.cfop11)
	--c:RegisterEffect(e12)
	
end

function s.stfilter(c)
	return c:IsType(TYPE_PENDULUM)
end

function s.stop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_REMOVED,0,1,nil,id) then
		Duel.DisableShuffleCheck()
		Duel.SendtoDeck(c,nil,-2,REASON_RULE)
	else
		local hct=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
		Duel.Remove(c,POS_FACEUP,REASON_RULE)
		Duel.Hint(HINT_CARD,0,id)
		local g=Duel.GetMatchingGroup(s.stfilter,tp,0xff,0,c)
		if #g>0 then
			Duel.Remove(g,POS_FACEDOWN,REASON_RULE)
			---Duel.SendtoExtraP(g,nil,-2,REASON_RULE)
		end
	end
end

--Gram Stain
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,1,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x1b,1,REASON_COST)
end
function s.cftg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsFacedown() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	Duel.SelectTarget(tp,Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,1,nil)
end
function s.cfop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFacedown() then
	local code=tc:GetOriginalCode()
	local op=Duel.SelectOption(1-tp,aux.Stringid(code,0))
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(code,0))
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(code,0))
	e:SetLabel(op)
	end
end

--Light Microscopy
function s.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,1,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x1b,1,REASON_COST)
end
function s.cftg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsFacedown() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	Duel.SelectTarget(tp,Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,1,nil)
end
function s.cfop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFacedown() then
	local code=tc:GetOriginalCode()
	local op=Duel.SelectOption(1-tp,aux.Stringid(code,1))
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(code,1))
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(code,1))
	e:SetLabel(op)
	end 
end

--Catalase Test
function s.cost3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,1,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x1b,1,REASON_COST)
end
function s.cftg3(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsFacedown() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	Duel.SelectTarget(tp,Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,1,nil)
end
function s.cfop3(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFacedown() then
	local code=tc:GetOriginalCode()
	local op=Duel.SelectOption(1-tp,aux.Stringid(code,2))
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(code,2))
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(code,2))
	e:SetLabel(op)
	end 
end

--Oxidase Test
function s.cost4(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,1,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x1b,1,REASON_COST)
end
function s.cftg4(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsFacedown() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	Duel.SelectTarget(tp,Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,1,nil)
end
function s.cfop4(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFacedown() then
	local code=tc:GetOriginalCode()
	local op=Duel.SelectOption(1-tp,aux.Stringid(code,3))
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(code,3))
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(code,3))
	e:SetLabel(op)
	end 
end

--Blood Agar
function s.cost5(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,1,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x1b,1,REASON_COST)
end
function s.cftg5(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsFacedown() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	Duel.SelectTarget(tp,Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,1,nil)
end
function s.cfop5(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFacedown() then
	local code=tc:GetOriginalCode()
	local op=Duel.SelectOption(1-tp,aux.Stringid(code,4))
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(code,4))
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(code,4)) 
	e:SetLabel(op)
	end 
end

--Coagulase Test
function s.cost6(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,1,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x1b,1,REASON_COST)
end
function s.cftg6(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsFacedown() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	Duel.SelectTarget(tp,Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,1,nil)
end
function s.cfop6(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFacedown() then
	local code=tc:GetOriginalCode()
	local op=Duel.SelectOption(1-tp,aux.Stringid(code,5))
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(code,5))
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(code,5))
	e:SetLabel(op)
	end 
end

--Lactose Fermentation Test
function s.cost7(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,1,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x1b,1,REASON_COST)
end
function s.cftg7(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsFacedown() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	Duel.SelectTarget(tp,Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,1,nil)
end
function s.cfop7(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFacedown() then
	local code=tc:GetOriginalCode()
	local op=Duel.SelectOption(1-tp,aux.Stringid(code,6))
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(code,6))
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(code,6))  
	e:SetLabel(op)
	end 
end

--Sulfur Reduction Test
function s.cost8(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,1,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x1b,1,REASON_COST)
end
function s.cftg8(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsFacedown() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	Duel.SelectTarget(tp,Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,1,nil)
end
function s.cfop8(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFacedown() then
	local code=tc:GetOriginalCode()
	local op=Duel.SelectOption(1-tp,aux.Stringid(code,7))
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(code,7))
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(code,7))
	e:SetLabel(op)
	end 
end

--Thioglycolate Broth

function s.cost9(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,1,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x1b,1,REASON_COST)
end
function s.cftg9(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsFacedown() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	Duel.SelectTarget(tp,Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,1,nil)
end
function s.cfop9(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFacedown() then
	local code=tc:GetOriginalCode()
	local op=Duel.SelectOption(1-tp,aux.Stringid(code,8))
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(code,8))
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(code,8)) 
	e:SetLabel(op)
	end 
end

--Urease Test

function s.cost10(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,1,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x1b,1,REASON_COST)
end
function s.cftg10(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsFacedown() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	Duel.SelectTarget(tp,Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,1,nil)
end
function s.cfop10(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFacedown() then
	local code=tc:GetOriginalCode()
	local op=Duel.SelectOption(1-tp,aux.Stringid(code,9))
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(code,9))
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(code,9))
	e:SetLabel(op)
	end 
end

--Capsule Stain

function s.cost11(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1b,1,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x1b,1,REASON_COST)
end
function s.cftg11(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsFacedown() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	Duel.SelectTarget(tp,Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,1,nil)
end
function s.cfop11(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFacedown() then
	local code=tc:GetOriginalCode()
	local op=Duel.SelectOption(1-tp,aux.Stringid(code,10))
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(code,10))
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(code,10)) 
	e:SetLabel(op)
	end 
end

--Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SELECT) 
--local op=Duel.SelectOption(1-tp,aux.Stringid(code,10)) 