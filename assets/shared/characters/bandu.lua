function onCreatePost()
    banduX = getCharacterX("dad")
    baseX = banduX
end

local mod = 1

function onUpdate()
    banduX = banduX + (10*mod)
    setProperty("dad.x", banduX)
    if banduX > (baseX) then
        mod = -1
        setObjectOrder("dadGroup", getObjectOrder("dadGroup")+3)
    elseif banduX < (baseX-1200) then
        mod = 1
         setObjectOrder("dadGroup", getObjectOrder("dadGroup")-3)
    end

    if not mustHitSection then
        cameraSetTarget("dad")
    else
        cameraSetTarget("bf")
    end
end