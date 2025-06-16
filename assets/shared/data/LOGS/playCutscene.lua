playVideo = false;
playDialogue = true;

local logs = 2 --Update this to how many logs are in the folder.
local curLog = 1 --Don't change this

function onStartCountdown()
	if playDialogue then
		startDialogue('LOG' .. curLog, 'creepy');
		curLog = curLog + 1
		if curLog > logs then
			playDialogue = false
		end
		return Function_Stop
	end

	if curLog > logs then
		endSong()
	end
end