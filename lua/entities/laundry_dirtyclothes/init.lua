AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("autorun/laundry_config.lua") -- Include the config file. There are other ways to do this, but this one has proved to be the easiest.

function ENT:Initialize()
    self:SetModel("models/props_junk/garbage_bag001a.mdl") -- This is the model that the entity will use.
    self:SetMaterial(LaundryConfig.DirtyclothesUsedMaterial) -- The model for this entity is defined within the config.
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    
    local phys = self:GetPhysicsObject()
    if(phys:IsValid()) then
        phys:Wake()
    end
end