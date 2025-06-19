function onCreatePost()
    initLuaShader("wavy")
 
    setSpriteShader("sprite1", "wavy")
end
 
function onUpdate()
    setShaderFloat("sprite1", "uTime", getSongPosition()/1000)
    setShaderFloat("sprite1", "uWaveAmplitude", 0.01)
    setShaderFloat("sprite1", "uSpeed", 2)
    setShaderFloat("sprite1", "uFrequency", 5)
end

function onEndSong()
    removeSpriteShader("sprite1")
end