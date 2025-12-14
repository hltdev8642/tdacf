# Aircraft Framework for Teardown

A comprehensive, reusable framework for creating enterable aircraft vehicles in Teardown with realistic flight physics, multiple controllable components, and extensible architecture.

## Features

- **Enterable Cockpit**: Full vehicle entry with cockpit camera and custom controls
- **Advanced Flight Physics**: Realistic thrust, lift, drag, and control surface deflection
- **Multiple Aircraft Components**: Ailerons, elevators, rudder, vertical stabilizer, retractable landing gear
- **Configurable Parameters**: Adjustable flight characteristics via mod options
- **Spawnable Item**: Available in Teardown's spawn menu for easy access
- **Extendable Design**: Modular architecture for creating unlimited aircraft variants
- **Template-Based**: Use `aircraft_example.xml` as a starting point for custom designs

## Installation

1. Copy the `AircraftFramework` folder to `Documents/Teardown/mods/`
2. Create the required vox models in `prefab/vox/` (see below)
3. Enable the mod in Teardown's Mod Manager
4. In-game, press T to open the spawn menu
5. Navigate to "AIRCRAFT/Aircraft Framework" and spawn it
6. Approach the spawned aircraft and press E to enter the cockpit

## Flight Controls

| Key | Action | Component |
|-----|--------|-----------|
| W/S | Forward/Reverse Thrust | Engine |
| A/D | Yaw Left/Right | Rudder |
| Q/E | Roll Left/Right | Ailerons |
| Space/C | Pitch Up/Down | Elevator |
| G | Toggle Landing Gear | Gear |

## Framework Architecture

### Core Files
- **main.lua**: Flight physics logic and component control
- **config.lua**: Aircraft-specific configuration and component mapping
- **options.lua**: User-adjustable flight parameters
- **spawn.txt**: Registers the aircraft in Teardown's spawn menu

### Template Files
- **prefab/aircraft_example.xml**: Vehicle structure template with all components
- **prefab/vox/**: Directory for aircraft 3D models

### Configuration System
The framework uses a Lua-based configuration system for maximum flexibility:

```lua
local config = {
    xmlPath = "prefab/aircraft_example.xml",  -- Vehicle definition
    components = {                           -- Body index mapping
        fuselage = 1,
        leftAileron = 2,
        -- ... etc
    },
    maxDeflection = {                        -- Control limits
        aileron = 30,   -- degrees
        elevator = 30,
        rudder = 30
    }
}
```

## Required Vox Models

Place these models in `AircraftFramework/prefab/vox/`:

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
    xmlPath = "prefab/aircraft_example.xml",           -- Vehicle XML file path
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
    xmlPath = "prefab/jet.xml",
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

1. Copy `aircraft_example.xml` to `jet.xml`
2. Modify the vehicle structure:
   - Update vox file paths
   - Adjust body positions and sizes
   - Modify joint connections
   - Update cockpit location

Example XML structure:
```xml
<vehicle name="Jet">
    <body>
        <voxbox pos="0 0 0" size="1 1 1" file="prefab/vox/jet_fuselage.vox"/>
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
- Export as .vox files to the prefab/vox/ directory

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
- Check that the mod is enabled in Mod Manager
- Open spawn menu (T key) and look for "AIRCRAFT/Aircraft Framework"
- Ensure spawn.txt is correctly formatted
- Verify XML file exists at prefab/aircraft_example.xml

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
- `config.components`: Body index mappings
- `config.maxDeflection`: Control surface limits

## License

This framework is provided as-is for Teardown modding. Feel free to modify and distribute your aircraft creations.

## Credits

Created with GitHub Copilot for the Teardown modding community.