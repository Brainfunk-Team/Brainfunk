playVideo = true;
playDialogue = true;

function onStartCountdown()
	if isStoryMode then
		if playVideo then --Video cutscene plays first
			startVideo('mazeCutscene'); --Play video file from "videos/" folder
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
	if not allowEnd and isStoryMode and not isStoryMode then
		startDialogue('after', 'Breakfast');
		allowEnd = true;
		return Function_Stop;
	end
	return Function_Continue;
end



function onCreatePost()
	allowEnd = false;
	makeLuaText("dialogue", "", 550, 350.0, 250.0);
	setTextAlignment("dialogue", "center");
	setTextSize("dialogue", 50);
	addLuaText("dialogue");
end

function onStepHit()
	if curStep == 176 then
		doTweenAlpha('fadeIn', 'fade', .7, .1, 'linear')
	end
	if curStep > 194 and curStep < 224 then
		setTextString("dialogue", "*Gibberish*\nYou're a fucking liar.");
	elseif curStep > 224 and curStep < 240 then
		setTextString("dialogue", "STOP! BALDI\nHE'S DEAD");
	elseif curStep > 240 and curStep < 256 then
		setTextString("dialogue", "BALDI HE'S\nDEAD");
	elseif curStep == 257 then
		doTweenAlpha('fadeIn', 'fade', .4, .1, 'linear')
		setTextString("dialogue", "")
	end
end