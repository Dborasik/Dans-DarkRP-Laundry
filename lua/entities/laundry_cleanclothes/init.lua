AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");
include("autorun/laundry_config.lua"); -- Include the config file. There are other ways to do this, but this one has proved to be the easiest.

function ENT:Initialize()
    self:SetModel("models/props_junk/garbage_newspaper001a.mdl"); -- This is the model that the entity will use.
    self:SetMaterial(LaundryConfig.CleanclothesUsedMaterial); -- The model for this entity is defined within the config.
    self:SetColor(Color(255, 120, 0)); -- Set the color to orange, just to make it really look like a uniform.
    self:PhysicsInit(SOLID_VPHYSICS);
    self:SetMoveType(MOVETYPE_VPHYSICS);
    self:SetSolid(SOLID_VPHYSICS);

    local phys = self:GetPhysicsObject();
    if (phys:IsValid()) then
        phys:Wake();
    end;
end;