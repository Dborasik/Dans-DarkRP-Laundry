AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("autorun/laundry_config.lua") -- Include the config file. There are other ways to do this, but this one has proved to be the easiest.

function ENT:Initialize()
    self:SetModel("models/props_wasteland/laundry_washer003.mdl"); -- This is the model that the entity will use.
    self:PhysicsInit(SOLID_VPHYSICS);
    self:SetMoveType(MOVETYPE_VPHYSICS);
    self:SetSolid(SOLID_VPHYSICS);
    self.IsInUse = false

    local phys = self:GetPhysicsObject();
    if (phys:IsValid()) then
        phys:Wake();
    end;
end;

function ENT:StartTouch(ent)
    if (ent:GetClass() == "laundry_wetclothes" and self.IsInUse == false) then
        local EntOwner = ent:GetOwner()

        self:EmitSound("ambient/machines/thumper_amb.wav");
        ent:Remove()

        self.IsInUse = true

        -- Creating a function within the timer because creating a separate one was too much trouble..
        timer.Simple(LaundryConfig.DryerTimer, function()
            self:EmitSound("buttons/button9.wav");
            self:StopSound("ambient/machines/thumper_amb.wav");

            local OutputEnt = ents.Create("laundry_cleanclothes"); -- Spawning the clean clothing.
            OutputEnt:SetPos(self:GetPos() + Vector(0, 0, 30));
            OutputEnt:SetAngles(self:GetAngles());
            OutputEnt:SetOwner(EntOwner);
            OutputEnt:Spawn();

            self.IsInUse = false
        end);
    end;
end;

function ENT:OnRemove()
    self:StopSound("ambient/machines/thumper_amb.wav");
end;