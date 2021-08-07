AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");
include("autorun/laundry_config.lua"); -- Include the config file. There are other ways to do this, but this one has proved to be the easiest.

function ENT:Initialize()
    self:SetModel("models/props_wasteland/laundry_basket001.mdl"); -- This is the model that the entity will use.
    self:SetAngles(Angle(180, 0, 0));
    self:PhysicsInit(SOLID_VPHYSICS);
    self:SetMoveType(MOVETYPE_VPHYSICS);
    self:SetSolid(SOLID_VPHYSICS);
    self:SetUseType(SIMPLE_USE);
    self.CanUse = true

    local phys = self:GetPhysicsObject();
    if(phys:IsValid()) then
        phys:Wake()
    end;
end;

function ENT:Use(activator)
    if(self.CanUse == true) then

        local OutputEnt = ents.Create("laundry_dirtyclothes"); -- Spawning the dirty clothing.
        OutputEnt:SetPos(self:GetPos() + Vector(0, 0, -15));
        OutputEnt:SetAngles(self:GetAngles());
        OutputEnt:SetOwner(EntOwner);
        OutputEnt:Spawn();

        self:EmitSound("buttons/lever1.wav");

        self.CanUse = false
        timer.Simple(LaundryConfig.DispenserCooldown, function() self.CanUse = true end); -- The cooldown is defined within the Config file.
    end;
end;