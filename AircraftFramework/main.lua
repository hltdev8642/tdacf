-- Aircraft Framework Mod for Teardown
-- This is a reusable framework for creating aircraft vehicles with multiple parts.
-- To adapt for different aircraft:
-- 1. Modify main.xml to define the vehicle structure with bodies and joints
-- 2. Update vox paths in main.xml
-- 3. Adjust options in options.lua
-- 4. Create your vox models with appropriate collision shapes

local aircraftXml = "MOD/main.xml"  -- Path to the vehicle XML
local aircraftBodies = {}  -- Table to hold spawned bodies
local mainBodyIndex = 1  -- Index of the main body (fuselage)

function init()
    -- Register the aircraft tool
    RegisterTool("aircraft", "Aircraft", aircraftXml)
end

function tick(dt)
    local playerTool = GetString("game.player.tool")
    if playerTool == "aircraft" then
        -- Spawn aircraft if it doesn't exist
        if #aircraftBodies == 0 or not IsBodyValid(aircraftBodies[mainBodyIndex]) then
            aircraftBodies = {}
            local playerPos = GetPlayerTransform().pos
            local spawnPos = playerPos + Vec(0, 0, 5)  -- Spawn 5 units in front
            local spawned = Spawn(aircraftXml, Transform(spawnPos, QuatEuler(0, 0, 0)))
            for i, body in ipairs(spawned) do
                if IsBody(body) then
                    table.insert(aircraftBodies, body)
                end
            end
            if #aircraftBodies > 0 then
                SetTag(aircraftBodies[mainBodyIndex], "aircraft_main")
            end
        end
        
        if #aircraftBodies > 0 and IsBodyValid(aircraftBodies[mainBodyIndex]) then
            -- Get options
            local thrustPower = GetInt("thrust")
            local liftPower = GetInt("lift")
            local controlSensitivity = GetInt("control")
            
            -- Get input
            local forward = InputDown("w") and 1 or (InputDown("s") and -1 or 0)
            local up = InputDown("space") and 1 or (InputDown("c") and -1 or 0)
            local yaw = (InputDown("a") and -1 or 0) + (InputDown("d") and 1 or 0)
            
            -- Apply forces to main body
            local body = aircraftBodies[mainBodyIndex]
            local bodyTransform = GetBodyTransform(body)
            local forwardDir = bodyTransform.rot * Vec(0, 0, 1)
            local upDir = Vec(0, 1, 0)
            
            -- Thrust
            AddBodyForce(body, forwardDir * thrustPower * forward)
            -- Lift
            AddBodyForce(body, upDir * liftPower * up)
            -- Yaw control (torque)
            local torque = Vec(0, yaw * controlSensitivity, 0)
            SetBodyAngularVelocity(body, GetBodyAngularVelocity(body) + torque * dt)
        end
    end
end

-- Optional: Add draw function if needed for UI
function draw(dt)
    -- Could add HUD or controls display here
end