---Ampicillin

local s,id=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_ADD_TYPE)
	e1:SetLocation(LOCATION_HAND+LOCATION_FIELD)
	e1:SetValue(TYPE_PENDULUM)
	c:RegisterEffect(e1)
end