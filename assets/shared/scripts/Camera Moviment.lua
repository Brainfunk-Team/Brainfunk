                                                    --({Atomic})--
follow = true; 
angle = true; 
local camX = 0;
local camY = 0; 
local camPosX = 0; 
local camPosY = 0;
local angleVar = 0; 
local angleAmplificate = 0;

local time = 1; 
local ease = circIn;
local camOffset = 34; 
local angleStrong = 3; 

function onSongStart() camX = camPosX camY = camPosY end
function onMoveCamera() camPosX = getProperty('camFollow.x') camPosY = getProperty('camFollow.y') end

function opponentNoteHit(i, direction)
  if not mustHitSection and follow then
    if direction == 0 then camX = camPosX - camOffset camY = camPosY angleVar = angleAmplificate -angleStrong elseif direction == 1 then camX = camPosX camY = camPosY + camOffset angleVar = 0
    elseif direction == 2 then camX = camPosX camY = camPosY - camOffset angleVar = 0
    elseif direction == 3 then camX = camPosX + camOffset camY = camPosY angleVar = angleAmplificate +angleStrong
end end end

function goodNoteHit(i, direction)
  if mustHitSection and follow then
    if direction == 0 then camX = camPosX - camOffset camY = camPosY angleVar = -angleStrong elseif direction == 1 then camX = camPosX camY = camPosY + camOffset angleVar = 0
    elseif direction == 2 then camX = camPosX camY = camPosY - camOffset angleVar = 0
    elseif direction == 3 then camX = camPosX + camOffset camY = camPosY angleVar = angleStrong
end end end

function setOffs(offs,angle) --To Change This on a script use: callScript('scripts/Camera Moviment','setOffs', {'camOffset','angleStrong'})
 camOffset = offs;
 angleStrong = angle;
end

function onEvent(eventName, val1, val2)
if eventName == 'Camera Follow Pos' then
  if val1 ~= '' and val2 ~= '' then
	val1 = tonumber(val1)
	val2 = tonumber(val2)
	camPosX = val1
   camPosY = val2
else
	camPosX = getProperty('camFollow.x')
	camPosY = getProperty('camFollow.y')
  end
 end
end

function onUpdate()
if angle then
  doTweenAngle('camAngle','camGame',angleVar,time,ease)
 end
end
function onUpdatePost()
	if follow then
		setProperty('camFollow.x', camX)
		setProperty('camFollow.y', camY)
	end
  if mustHitSection then
       if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
            resetCam()
      end
   else
         if getProperty('dad.animation.curAnim.name') == 'idle' then
            resetCam()
    end
   end
end

function resetCam() camX = camPosX camY = camPosY angleVar = 0 end

