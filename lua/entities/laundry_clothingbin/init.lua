AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("autorun/laundry_config.lua") -- Include the config file. There are other ways to do this, but this one has proved to be the easiest.

function ENT:Initialize()
    self:SetModel("models/props_wasteland/laundry_cart001.mdl"); -- This is the model that the entity will use.
    self:PhysicsInit(SOLID_VPHYSICS);
    self:SetMoveType(MOVETYPE_VPHYSICS);
    self:SetSolid(SOLID_VPHYSICS);

    local phys = self:GetPhysicsObject();
    if (phys:IsValid()) then
        phys:Wake();
    end;
end;

function ENT:StartTouch(ent)
    if (ent:GetClass() == "laundry_cleanclothes") then
        local EntOwner = ent:GetOwner();

        if (not EntOwner:IsValid()) then return end -- Added to avoid errors, especially in rare cases like where the player left the server.

        EntOwner:addMoney(LaundryConfig.Payment);
        DarkRP.notify(EntOwner, NOTIFY_GENERIC, 2, "You have recieved "..DarkRP.formatMoney(LaundryConfig.Payment).." for the laundry!");

        ent:Remove()
    end;
end;