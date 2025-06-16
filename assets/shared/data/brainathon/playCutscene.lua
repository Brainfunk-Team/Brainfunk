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
	if curStep == 64 or curStep == 2688 or curStep == 4944 or curStep == 5472 or curStep == 5968 then
		doTweenAlpha('fadeIn', 'fade', .7, .1, 'linear')
	end
	if curStep > 64 and curStep < 91 then
		setTextString("dialogue", "Well, it has come down to the final showdown.");
	elseif curStep > 91 and curStep < 112 then
		setTextString("dialogue", "I won't let you win, Boyfriend!");
	elseif curStep > 2688 and curStep < 2724 then
		setTextString("dialogue", "Well, if Bambi did it, do you wanna give it a go, Tristan?");
	elseif curStep > 4944 and curStep < 4969 then
		setTextString("dialogue", "You've survived longer than I thought you would.");
	elseif curStep > 4969 and curStep < 4992 then
		setTextString("dialogue", "Well, it isn't the end of the song yet!");
	elseif curStep > 4992 and curStep < 5008 then
		setTextString("dialogue", "You are going to lose!");
	elseif curStep > 5472 and curStep < 5488 then
		setTextString("dialogue", "Still going, Boyfriend?");
	elseif curStep > 5968 and curStep < 5984 then
		setTextString("dialogue", "Guess you won, Boyfriend...");
	end
	if curStep == 112 or curStep == 2724 or curStep == 5008 or curStep == 5488 or curStep == 5984 then
		doTweenAlpha('fadeIn', 'fade', .4, .1, 'linear')
		setTextString("dialogue", "")
	end
end
