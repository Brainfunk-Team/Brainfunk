function onCreatePost()
    local wavyBg = getModSetting('wavy')
    initLuaShader("wavy")
    if wavyBg then
        setSpriteShader("bg", "wavy")
    end
end
 
function onUpdate()
    setShaderFloat("bg", "uTime", (getSongPosition()/1000))
    setShaderFloat("bg", "uWaveAmplitude", getSongPosition()/10000)
    setShaderFloat("bg", "uSpeed", getSongPosition()/10000)
    setShaderFloat("bg", "uFrequency", getSongPosition()/10000)
end

function onEndSong()
    removeSpriteShader("bg")
end


