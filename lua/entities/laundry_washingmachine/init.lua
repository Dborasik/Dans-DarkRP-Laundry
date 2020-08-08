AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("autorun/laundry_config.lua") -- Include the config file. There are other ways to do this, but this one has proved to be the easiest.

-- Called when the entity should initialize.
function ENT:Initialize()
    if (SERVER) then
        self:SetModel("models/props_wasteland/laundry_dryer002.mdl");
        self:PhysicsInit(SOLID_VPHYSICS);
        self:SetMoveType(MOVETYPE_VPHYSICS);
        self:SetSolid(SOLID_VPHYSICS);

        self.laundry = ents.Create("prop_dynamic");
        self.laundry:DrawShadow(false);
        self.laundry:SetNoDraw(true);
        self.laundry:SetAngles(self:GetAngles());
        self.laundry:SetParent(self);
        self.laundry:SetModel("models/props_junk/garbage_bag001a.mdl");
        self.laundry:SetMaterial("perftest/loader/crate02b");
        self.laundry:SetPos(self:GetPos());
        self.laundry:Spawn();
        self:DeleteOnRemove(self.laundry);

        local phys = self:GetPhysicsObject();
        if (phys:IsValid()) then
            phys:Wake();
        end;
    end;
end;

function ENT:StartTouch(ent)
    if (ent:GetClass() == "laundry_dirtyclothes" and !self.laundry.shouldBeVisible) then
        local entOwner = ent:GetOwner();

        self:EmitSound("ambient/machines/thumper_amb.wav");
        ent:Remove()
        
        self.laundry:SetNoDraw(false);
        
        timer.Simple(LaundryConfig.WashingmachineTimer, function() -- This time is defined within the Config file, do NOT edit it here (pretty please :D)
            self:EmitSound("buttons/lever1.wav");
            self:StopSound("ambient/machines/thumper_amb.wav");
            
            self.laundry:SetNoDraw(true);
            
            local OutputEnt = ents.Create("laundry_wetclothes");
            OutputEnt:SetPos(self:GetPos() + Vector(0, 0, 0));
            OutputEnt:SetAngles(self:GetAngles());
            OutputEnt:SetOwner(entOwner);
            OutputEnt:Spawn();
        end);
    end;
end;

-- Called each frame.
function ENT:Think()
    if (!self.laundry:GetNoDraw()) then
        local modelAngle = (CurTime() * 90) % 360;

        self.laundry:SetAngles(Angle(modelAngle, 0, 0));
    end;
end;

-- Called when the entity is removed.
function ENT:OnRemove()
    self:StopSound("ambient/machines/thumper_amb.wav");
    self:StopSound("buttons/lever1.wav");
end;
