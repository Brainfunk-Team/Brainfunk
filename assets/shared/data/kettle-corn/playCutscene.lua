playVideo = false;
playDialogue = true;

function onStartCountdown()
	if isStoryMode then
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
	if curStep > 178 and curStep < 192 then
		setTextString("dialogue", "MOLDY\nYOU TROLL!");
	elseif curStep == 192 then
		doTweenAlpha('fadeIn', 'fade', 0, .1, 'linear')
		setTextString("dialogue", "")
	end
end




