playVideo = false;
playDialogue = true;
achievement = true;
function onUpdate(elapsed)

if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SEVEN') then
	achievement = false;
	endSong(true);
	loadSong('optophobia');

end

end

function onCreatePost()
	setAchievementScore('dave', 25)
setProperty('debugKeysChart', null);

end
function onStartCountdown()
	if isStoryMode then
		if playVideo then --Video cutscene plays first
			startVideo('daveCutscene'); --Play video file from "videos/" folder
			playVideo = false;
			return Function_Stop; --Prevents the song from starting naturally
		elseif playDialogue then --Once the video ends it calls onStartCountdown again. Play dialogue this time
			startDialogue('dialogue', 'scaryAmbience'); --"breakfast" is the dialogue music file from "music/" folder
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
	if not allowEnd and isStoryMode and achievement then
		startDialogue('after', 'Breakfast');
		allowEnd = true;
		unlockAchievement('dave')
		return Function_Stop;
	end
	return Function_Continue;
end

