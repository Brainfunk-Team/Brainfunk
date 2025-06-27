local shaderName = "movingChromaticAbber"

function onCreate()
    initLuaShader(shaderName)
    setSpriteShader("shaderImage", shaderName)
end

function onUpdate(elapsed)
    local time = getSongPosition() / 1000
    setShaderFloat(shaderName, "iTime", time)
end
