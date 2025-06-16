function onBeatHit()
    if curBeat == 1200 then
        setProperty('dave.alpha', 1)
        setProperty('bambi.alpha', 0)
    end
    if curBeat == 1456 then
        setProperty('dave.alpha', 0)
        setProperty('bambi.alpha', 1)
    end
    if curBeat == 1520 then
        setProperty('dave.alpha', 1)
        setProperty('bambi.alpha', 0)
        playAnim("dave", "happy", true)
    end
    if curBeat == 2096 then
        removeLuaSprite("dave")
        setProperty('bambi.alpha', 1)
        playAnim("bambi", "corn", true)
    end
end

function onStepHit()
    if curStep == 4798 then
        doTweenAlpha("whiteFade", "whitefade", 1, .1)
    end
    if curStep == 4801 then
        doTweenAlpha("whiteFade", "whitefade", 0, .1)
    end
    if curStep == 5821 then
        doTweenAlpha("whiteFade", "whitefade", 1, .1)
    end
    if curStep == 5823 then
        doTweenAlpha("whiteFade", "whitefade", 0, .1)
    end
    if curStep == 6077 then
        doTweenAlpha("whiteFade", "whitefade", 1, .1)
    end
    if curStep == 6080 then
        doTweenAlpha("whiteFade", "whitefade", 0, .1)
    end
    if curStep == 8381 then
        doTweenAlpha("whiteFade", "whitefade", 1, .1)
    end
    if curStep == 8383 then
        doTweenAlpha("whiteFade", "whitefade", 0, .1)
    end
end