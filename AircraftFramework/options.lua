function init()
    -- Initialize default option values
    if GetInt("thrust") == 0 then
        SetInt("thrust", 1000)
    end
    if GetInt("lift") == 0 then
        SetInt("lift", 500)
    end
    if GetInt("control") == 0 then
        SetInt("control", 100)
    end
end

function draw(dt)
    UiPush()
    UiTranslate(UiCenter(), UiMiddle() - 100)
    
    UiFont("bold.ttf", 24)
    UiText("Aircraft Framework Options")
    
    UiTranslate(0, 50)
    UiFont("regular.ttf", 16)
    
    UiText("Thrust Power: " .. GetInt("thrust"))
    local thrust = UiSlider("ui/thrust", "x", GetInt("thrust"), 500, 2000)
    SetInt("thrust", thrust)
    
    UiTranslate(0, 40)
    UiText("Lift Power: " .. GetInt("lift"))
    local lift = UiSlider("ui/lift", "x", GetInt("lift"), 200, 1000)
    SetInt("lift", lift)
    
    UiTranslate(0, 40)
    UiText("Control Sensitivity: " .. GetInt("control"))
    local control = UiSlider("ui/control", "x", GetInt("control"), 50, 200)
    SetInt("control", control)
    
    UiPop()
end