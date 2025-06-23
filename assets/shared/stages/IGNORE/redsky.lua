function onCreatePost()
    local wavyBg = getModSetting('wavy')
    initLuaShader("wavy")
    if wavyBg then
        setSpriteShader("bg", "wavy")
    end
end
 
function onUpdate()
    setShaderFloat("bg", "uTime", getSongPosition()/1000)
    setShaderFloat("bg", "uWaveAmplitude", 0.01)
    setShaderFloat("bg", "uSpeed", 2)
    setShaderFloat("bg", "uFrequency", 5)
end

function onEndSong()
    removeSpriteShader("bg")
end