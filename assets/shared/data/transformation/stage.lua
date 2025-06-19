function deleteSprite(obj)
    local curObj = "sprite" .. obj
    if luaSpriteExists(curObj) then
        removeLuaSprite(curObj, true)
    end
end

function setCharacterPos(type, x, y)
    setCharacterX(type, x)
    setCharacterY(type, y)
end

function onCreatePost()
    local wavyBg = getModSetting('wavy')
    initLuaShader("wavy")
    if wavyBg then
        setSpriteShader("bg", "wavy")
    end
end

function onStepHit()
    if curStep == 766 then
        doTweenAlpha("fade", "fade", 1, .1)
    end
    if curStep == 767 then
        deleteSprite(1)
        deleteSprite(2)
        deleteSprite(3)
        deleteSprite(4)
        deleteSprite(5)
        deleteSprite("1_copy1")
        makeLuaSprite("bg", "redsky/redsky", -2216, -1036)
        scaleObject("bg", 5, 5)
        setScrollFactor("bg", 0.8, 0.85)
        addLuaSprite("bg")
        setCharacterPos("dad", -375, -145)
        setCharacterPos("boyfriend", 770, 100)
        setSpriteShader("bg", "wavy")
    end
    if curStep == 768 then
        doTweenAlpha("fade", "fade", 0, .1)
    end
end

function onUpdate()
    if curStep > 767 then
        setShaderFloat("bg", "uTime", getSongPosition()/1000)
        setShaderFloat("bg", "uWaveAmplitude", 0.01)
        setShaderFloat("bg", "uSpeed", 2)
        setShaderFloat("bg", "uFrequency", 5)
    end
end