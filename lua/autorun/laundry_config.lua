////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This simple laundry system was created by Dborasik. Please beware, this project was never finished and may //
// not be in a totally usable state. You are free to re-upload and edit this addon at your discretion.        //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

LaundryConfig = {}

// Main Settings //
LaundryConfig.Payment = 100 -- The amount of money a person recieves for placing clean laundry into a bin.

// Cooldowns/Timers //
LaundryConfig.DispenserCooldown = 10 -- After spawning dirty clothes through the dispenser, how long does someone need to wait to do it again?
LaundryConfig.WashingmachineTimer = 8 -- How long it takes for the washing machine to finish cleaning something.
LaundryConfig.DryerTimer = 8 -- How long it takes for the dryer to finishing drying something.

// Entity Appearance //
LaundryConfig.DirtyclothesUsedMaterial = "perftest/loader/crate02b" -- The material that the DIRTY CLOTHES use.
LaundryConfig.WetclothesUsedMaterial = "phoenix_storms/fender_wood" -- The material that the WET CLOTHES use.
LaundryConfig.CleanclothesUsedMaterial = "models/debug/debugwhite" -- The material that the CLEAN CLOTHES use.
