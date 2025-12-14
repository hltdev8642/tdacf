-- Aircraft Framework Mod for Teardown
-- This is a reusable framework for creating enterable aircraft vehicles with multiple controllable components.
-- To adapt for different aircraft:
-- 1. Modify config.lua to point to your XML and define component indices
-- 2. Update main.xml to define the vehicle structure with bodies and joints
-- 3. Adjust options in options.lua
-- 4. Create your vox models with appropriate collision shapes

local config = require("config")

local aircraftBodies = {}  -- Table to hold spawned bodies

function init()
    -- Spawn the aircraft at startup
    aircraftBodies = {}
    local spawned = Spawn(config.xmlPath, Transform(config.spawnPos, QuatEuler(0, 0, 0)))
    for i, body in ipairs(spawned) do
        if IsBody(body) then
            table.insert(aircraftBodies, body)
        end
    end
    if #aircraftBodies > 0 then
        SetTag(aircraftBodies[config.components.fuselage], "aircraft_main")
    end
end

function tick(dt)
    if #aircraftBodies > 0 and IsBodyValid(aircraftBodies[config.components.fuselage]) then
        -- Get options
        local thrustPower = GetInt("thrust")
        local liftPower = GetInt("lift")
        local controlSensitivity = GetInt("control")
        
        -- Get input
        local forward = InputDown("w") and 1 or (InputDown("s") and -1 or 0)
        local up = InputDown("space") and 1 or (InputDown("c") and -1 or 0)
        local yaw = (InputDown("a") and -1 or 0) + (InputDown("d") and 1 or 0)
        local roll = (InputDown("q") and -1 or 0) + (InputDown("e") and 1 or 0)
        local pitch = up - (InputDown("c") and 1 or 0)  -- Space for up, C for down
        
        -- Apply forces to main body
        local body = aircraftBodies[config.components.fuselage]
        local bodyTransform = GetBodyTransform(body)
        local forwardDir = bodyTransform.rot * Vec(0, 0, 1)
        local upDir = Vec(0, 1, 0)
        
        -- Thrust
        AddBodyForce(body, forwardDir * thrustPower * forward)
        -- Lift
        AddBodyForce(body, upDir * liftPower * (forward > 0 and 1 or 0))  -- Lift when moving forward
        
        -- Control surfaces
        -- Ailerons for roll
        if aircraftBodies[config.components.leftAileron] then
            local aileronRot = QuatEuler(0, 0, -roll * config.maxDeflection.aileron)  -- Deflect up to maxDeflection degrees
            SetBodyTransform(aircraftBodies[config.components.leftAileron], Transform(Vec(-2, 0, 0), aileronRot))
        end
        if aircraftBodies[config.components.rightAileron] then
            local aileronRot = QuatEuler(0, 0, roll * config.maxDeflection.aileron)
            SetBodyTransform(aircraftBodies[config.components.rightAileron], Transform(Vec(2, 0, 0), aileronRot))
        end
        
        -- Elevator for pitch
        if aircraftBodies[config.components.elevator] then
            local elevatorRot = QuatEuler(-pitch * config.maxDeflection.elevator, 0, 0)
            SetBodyTransform(aircraftBodies[config.components.elevator], Transform(Vec(0, 0, -2), elevatorRot))
        end
        
        -- Rudder for yaw
        if aircraftBodies[config.components.rudder] then
            local rudderRot = QuatEuler(0, yaw * config.maxDeflection.rudder, 0)
            SetBodyTransform(aircraftBodies[config.components.rudder], Transform(Vec(0, 1.5, -2), rudderRot))
        end
        
        -- Landing gear toggle (G key)
        if InputPressed("g") then
            -- Toggle gear (simplified, just hide/show or move)
            -- For now, just log
            DebugPrint("Landing gear toggle")
        end
    end
end

-- Optional: Add draw function if needed for UI
function draw(dt)
    -- Could add HUD or controls display here
end