local angleshit = 1.5;
local anglevar = 1.5;

function onBeatHit()
    if curBeat > 352 then
        -- Stop tweens manually
        cancelTween('turn')
        cancelTween('tuin')
        cancelTween('tt')
        cancelTween('ttrn')

        -- Reset camera properties to prevent lingering effects
        setProperty('camHUD.angle', 0)
        setProperty('camHUD.x', 0)
        setProperty('camGame.angle', 0)
        setProperty('camGame.x', 0)

        return -- Prevent further execution of onBeatHit logic
    end

    if curBeat > 31 then
        if curBeat % 2 == 0 then
            angleshit = anglevar;
        else
            angleshit = -anglevar;
        end
        setProperty('camHUD.angle', angleshit * 3)
        setProperty('camGame.angle', angleshit * 3)
        doTweenAngle('turn', 'camHUD', angleshit, stepCrochet * 0.002, 'circOut')
        doTweenX('tuin', 'camHUD', -angleshit * 8, crochet * 0.001, 'linear')
        doTweenAngle('tt', 'camGame', angleshit, stepCrochet * 0.002, 'circOut')
        doTweenX('ttrn', 'camGame', -angleshit * 8, crochet * 0.001, 'linear')
    end
end