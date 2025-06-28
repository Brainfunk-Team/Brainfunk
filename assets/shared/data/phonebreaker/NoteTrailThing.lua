shitbf, shitdad, cshitbf, cshitdad = 0, 0, 0, 0
shitonbf, shitondad, shitlen, shitspd = true, true, 1, 0.03
shitvalbf, shitvaldad = 0.6, 0.6
sbf, sdad = false, false

-- OPTIONS
local Color = true -- Colored ghosts by healthbar
---

lastBFHit = -1
lastDadHit = -1
bfAnim = nil
dadAnim = nil

function goodNoteHit(_, _, _, s)
if not s then
if lastBFHit ~= -1 and (getSongPosition() - lastBFHit < 100) then
trail('bf', bfAnim)
lastBFHit = -1
bfAnim = nil
else
lastBFHit = getSongPosition()
bfAnim = getProperty('boyfriend.animation.frameName')
end
end
end
function opponentNoteHit(_, _, _, s)
if not s then
if lastDadHit ~= -1 and (getSongPosition() - lastDadHit < 100) then
trail('dad', dadAnim)
lastDadHit = -1
dadAnim = nil
else
lastDadHit = getSongPosition()
dadAnim = getProperty('dad.animation.frameName')
end
end
end

function onTimerCompleted(t) if t=='rsbf'then shitbf=0 elseif t=='rsdad'then shitdad=0 end end

function trail(w, anim)
    local c = w == 'bf' and cshitbf or cshitdad
    local d = w == 'bf' and 'boyfriend' or 'dad'
    local v = w == 'bf' and shitvalbf or shitvaldad
    local e = w == 'bf' and shitonbf or shitondad
    if not e then return end

    if c - shitlen + 1 >= 0 then
        for i = c - shitlen + 1, c - 1 do
            setProperty('shit'..w..i..'.alpha', getProperty('shit'..w..i..'.alpha') - (0.6 / (shitlen - 1)))
        end
        removeLuaSprite('shit'..w..(c - shitlen), true)
    end

    local tag = 'shit'..w..c
    makeAnimatedLuaSprite(tag, getProperty(d..'.imageFile'), getProperty(d..'.x'), getProperty(d..'.y'))
    setProperty(tag..'.offset.x', getProperty(d..'.offset.x'))
    setProperty(tag..'.offset.y', getProperty(d..'.offset.y'))
    setProperty(tag..'.flipX', getProperty(d..'.flipX'))
    setProperty(tag..'.scale.x', getProperty(d..'.scale.x'))
    setProperty(tag..'.scale.y', getProperty(d..'.scale.y'))
    setProperty(tag..'.alpha', v)

    if Color then
        local r = getProperty(d .. '.healthColorArray[0]')
        local g = getProperty(d .. '.healthColorArray[1]')
        local b = getProperty(d .. '.healthColorArray[2]')
        local color = (r * 0x10000) + (g * 0x100) + b
        setProperty(tag .. '.color', color)
    end

    setObjectOrder(tag, getObjectOrder('gfGroup') + 1)
    addAnimationByPrefix(tag, 's', string.sub(anim, 1, -4), 24, false)
    addLuaSprite(tag, false)
    doTweenAlpha('f' .. tag, tag, 0, 1, 'linear')
    if w == 'bf' then
        doTweenX('x' .. tag, tag, getProperty(tag .. '.x') + 100, 1, 'linear')
    else
        doTweenX('x' .. tag, tag, getProperty(tag .. '.x') - 100, 1, 'linear')
    end

end



function onTweenCompleted(tag)
    if string.sub(tag, 1, 5) == 'fshit' then
        local id = string.sub(tag, 6)
        if luaSpriteExists(id) then
            removeLuaSprite(id, true)
        end
    end
end
