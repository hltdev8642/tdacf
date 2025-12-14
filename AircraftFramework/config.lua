-- Aircraft Configuration
-- This file defines the configuration for a specific aircraft.
-- To create a new aircraft:
-- 1. Copy this file and rename it (e.g., jet_config.lua)
-- 2. Update the xmlPath to point to your new XML file
-- 3. Update the components table with the correct body indices for your aircraft
-- 4. Modify main.lua to load your config file instead

local config = {
    -- Path to the aircraft XML file
    xmlPath = "prefab/aircraft_example.xml",
    
    -- Component body indices (1-based, matching the order in XML)
    components = {
        fuselage = 1,           -- Main body/cockpit
        leftAileron = 2,        -- Left wing control surface
        rightAileron = 3,       -- Right wing control surface
        elevator = 4,           -- Horizontal tail pitch control
        verticalStabilizer = 5, -- Fixed vertical tail fin
        rudder = 6,             -- Vertical tail yaw control
        leftGear = 7,           -- Left landing gear
        rightGear = 8,          -- Right landing gear
        noseGear = 9            -- Nose landing gear
    },
    
    -- Control surface deflection angles (degrees)
    maxDeflection = {
        aileron = 30,
        elevator = 30,
        rudder = 30
    }
}

return config