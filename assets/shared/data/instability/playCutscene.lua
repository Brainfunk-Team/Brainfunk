playVideo = false;
playDialogue = true;

function onStartCountdown()
	if isStoryMode or isStoryMode then
		if playVideo then --Video cutscene plays first
			startVideo('daveCutscene'); --Play video file from "videos/" folder
			playVideo = false;
			return Function_Stop; --Prevents the song from starting naturally
		elseif playDialogue then --Once the video ends it calls onStartCountdown again. Play dialogue this time
			startDialogue('dialogue', 'breakfast'); --"breakfast" is the dialogue music file from "music/" folder
			playDialogue = false;
			return Function_Stop; --Prevents the song from starting naturally
		end
	end
	return Function_Continue; --Played video and dialogue, now the song can start normally
end

function onEndSong()
	for i = 0,7 do
		setPropertyFromGroup('strumLineNotes',i,'x',-330)
    	end
	if not allowEnd and isStoryMode then
		startDialogue('after', 'breakfast');
		allowEnd = true;
		return Function_Stop;
	end
	return Function_Continue;
end

