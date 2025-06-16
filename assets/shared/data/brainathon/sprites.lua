function onBeatHit()
    if curBeat == 436 then
        setProperty('dave.alpha', 1)
        setProperty('bambi.alpha', 0)
    end
    if curBeat == 672 then
        setProperty('dave.alpha', 0)
        setProperty('bambi.alpha', 1)
    end
    if curBeat == 684 then
        setProperty('dave2.alpha', 1)
        setProperty('tristan.alpha', 0)
    end
    if curBeat == 984 then
        setProperty('dave2.alpha', 0)
        setProperty('tristan.alpha', 1)
        setProperty('dave.alpha', 1)
        setProperty('bambi.alpha', 0)
        playAnim("dave", "happy", true)
    end
    if curBeat == 1220 then
        setProperty('dave.alpha', 0)
        setProperty('bambi.alpha', 1)
        playAnim("bambi", "corn", true)
    end
end

function onStepHit()
    if curStep == 1742 then
        doTweenAlpha("whiteFade", "whitefade", 1, .1)
    end
    if curStep == 1744 then
        doTweenAlpha("whiteFade", "whitefade", 0, .1)
    end
    if curStep == 2686 then
        doTweenAlpha("whiteFade", "whitefade", 1, .1)
    end
    if curStep == 2688 then
        doTweenAlpha("whiteFade", "whitefade", 0, .1)
    end
    if curStep == 2734 then
        doTweenAlpha("whiteFade", "whitefade", 1, .1)
    end
    if curStep == 2736 then
        doTweenAlpha("whiteFade", "whitefade", 0, .1)
    end
    if curStep == 3934 then
        doTweenAlpha("whiteFade", "whitefade", 1, .1)
    end
    if curStep == 3936 then
        doTweenAlpha("whiteFade", "whitefade", 0, .1)
    end
    if curStep == 4878 then
        doTweenAlpha("whiteFade", "whitefade", 1, .1)
    end
    if curStep == 4880 then
        doTweenAlpha("whiteFade", "whitefade", 0, .1)
    end
end