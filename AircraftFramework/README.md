# Aircraft Framework for Teardown

A reusable, extendable framework for creating enterable aircraft vehicles in Teardown with realistic flight controls and multiple controllable components.

## Features

- **Enterable Cockpit**: Full vehicle entry with cockpit camera
- **Realistic Flight Controls**: Thrust, lift, and control surface animation
- **Multiple Components**: Ailerons, elevators, rudder, vertical stabilizer, landing gear
- **Configurable Parameters**: Adjustable thrust, lift, and control sensitivity
- **Extendable Design**: Easy to create new aircraft variants
- **Modular Structure**: Separate configuration, templates, and logic

## Installation

1. Copy the `AircraftFramework` folder to `Documents/Teardown/mods/`
2. Create the required vox models (see below)
3. Enable the mod in Teardown's Mod Manager
4. Start a new game or load a level
5. The aircraft will spawn automatically at the configured location

## Controls (When Entered)

| Control | Action |
|---------|--------|
| W/S | Forward/Reverse Thrust |
| A/D | Rudder (Yaw Left/Right) |
| Q/E | Ailerons (Roll Left/Right) |
| Space/C | Elevators (Pitch Up/Down) |
| G | Toggle Landing Gear |

## File Structure

```
AircraftFramework/
├── info.txt           # Mod metadata
├── main.lua           # Core framework logic
├── config.lua         # Aircraft configuration
├── main.xml           # Vehicle structure template
├── options.lua        # Flight parameter settings
├── spawn.txt          # Spawn position configuration
└── README.md          # This documentation
```

## Required Vox Models

Place these models in `AircraftFramework/MOD/vox/`:

- **fuselage.vox**: Main body and cockpit
- **aileron.vox**: Wing control surfaces
- **elevator.vox**: Horizontal tail pitch control
- **vertical_stabilizer.vox**: Fixed vertical tail fin
- **rudder.vox**: Vertical tail yaw control
- **gear.vox**: Landing gear wheels

## Configuration

### Flight Parameters (options.lua)

Adjust these in the mod options menu:
- **Thrust Power**: Forward propulsion strength (500-2000)
- **Lift Power**: Upward lift force (200-1000)
- **Control Sensitivity**: Control surface responsiveness (50-200)

### Aircraft Configuration (config.lua)

```lua
local config = {
    xmlPath = "MOD/main.xml",           -- Vehicle XML file path
    spawnPos = Vec(0, 10, 0),          -- Spawn position
    components = {                      -- Body indices in XML
        fuselage = 1,
        leftAileron = 2,
        rightAileron = 3,
        elevator = 4,
        verticalStabilizer = 5,
        rudder = 6,
        leftGear = 7,
        rightGear = 8,
        noseGear = 9
    },
    maxDeflection = {                   -- Control surface limits (degrees)
        aileron = 30,
        elevator = 30,
        rudder = 30
    }
}
```

## Creating New Aircraft

### Step 1: Create New Configuration

1. Copy `config.lua` to `jet_config.lua`
2. Update the paths and settings for your new aircraft:

```lua
local config = {
    xmlPath = "MOD/jet.xml",
    spawnPos = Vec(0, 15, 0),
    components = {
        -- Update indices based on your XML
        fuselage = 1,
        -- ... etc
    },
    maxDeflection = {
        aileron = 25,
        elevator = 35,
        rudder = 40
    }
}
return config
```

### Step 2: Create Vehicle XML

1. Copy `main.xml` to `jet.xml`
2. Modify the vehicle structure:
   - Update vox file paths
   - Adjust body positions and sizes
   - Modify joint connections
   - Update cockpit location

Example XML structure:
```xml
<vehicle name="Jet">
    <body>
        <voxbox pos="0 0 0" size="1 1 1" file="MOD/vox/jet_fuselage.vox"/>
    </body>
    <!-- Add more bodies for components -->
    <joint type="hinge" pos="..." axis="..." body1="1" body2="2" />
    <location name="player" tags="player" pos="0.45 0.77 2.1" rot="0.0 0.0 0.0"/>
</vehicle>
```

### Step 3: Create Vox Models

Design your aircraft parts in MagicaVoxel:
- Use appropriate scales and collision shapes
- Ensure cockpit area is clear for the player
- Export as .vox files to the MOD/vox/ directory

### Step 4: Update Main Script

Modify `main.lua` to load your configuration:
```lua
local config = require("jet_config")  -- Change this line
```

### Step 5: Test and Tune

1. Load the mod in Teardown
2. Test flight characteristics
3. Adjust config values for desired performance
4. Fine-tune control surface positions in XML

## Advanced Customization

### Adding New Components

1. Add new body in XML with vox model
2. Connect with appropriate joint
3. Add component index to config.lua
4. Add control logic in main.lua tick() function

### Custom Controls

Extend the input handling in `tick()`:
```lua
if InputPressed("your_key") then
    -- Custom action
end
```

### Physics Tuning

Adjust forces and torques in the flight logic:
```lua
AddBodyForce(body, direction * power * input)
```

## Troubleshooting

### Aircraft Won't Spawn
- Check that all vox files exist in MOD/vox/
- Verify XML file paths are correct
- Ensure config.lua points to valid XML

### No Flight Controls
- Make sure you're inside the cockpit (press E near aircraft)
- Check that component indices match XML body order
- Verify control surface bodies exist

### Poor Flight Performance
- Increase thrust/lift in options
- Adjust control surface deflection angles
- Check body masses and joint strengths in XML

## API Reference

### Teardown Functions Used
- `Spawn(xmlPath, transform)` - Create vehicle from XML
- `AddBodyForce(body, force)` - Apply physics forces
- `SetBodyTransform(body, transform)` - Move control surfaces
- `GetInt(key)` - Read option values
- `InputDown(key)` - Check input state

### Configuration Options
- `config.xmlPath`: Path to vehicle XML file
- `config.spawnPos`: Initial spawn position
- `config.components`: Body index mappings
- `config.maxDeflection`: Control surface limits

## License

This framework is provided as-is for Teardown modding. Feel free to modify and distribute your aircraft creations.

## Credits

Created with GitHub Copilot for the Teardown modding community.