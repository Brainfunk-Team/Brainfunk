
function onCreatePost()
    local wavyBg = getModSetting('wavy')
    initLuaShader("wavy")
    if wavyBg then
        setSpriteShader("bg", "wavy")
    end
    minionX = getProperty("minion.x")
    startPos = minionX

    setProperty("gf.scale.x", -1)
end
 
function onUpdate()
    setShaderFloat("bg", "uTime", getSongPosition()/1000)
    setShaderFloat("bg", "uWaveAmplitude", 0.01)
    setShaderFloat("bg", "uSpeed", 2)
    setShaderFloat("bg", "uFrequency", 5)
    local minionY = 0 + math.sin(minionX * 0.01) * 30
    minionX = minionX + 8
    setProperty("minion.x", minionX)
    setProperty("minion.y", minionY)
    if minionX > 2500 then
        minionX = startPos
    end
end

function onEndSong()
    removeSpriteShader("bg")
end