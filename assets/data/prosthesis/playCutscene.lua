playVideo = true;
playDialogue = true;

if playVideo == true then
	if getModSetting('video') == true then
		playVideo = false
	end
end

if playDialogue == true then
	if getModSetting('dialogue') == "Disable all \ncutscenes" then
		playDialogue = false
	end
end

function onStartCountdown()
	if isStoryMode or getModSetting('dialogue') == "Show cutscenes\neverywhere" then
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
	makeLuaText("dialogue", "", 550, 350.0, 250.0);
	setTextAlignment("dialogue", "center");
	setTextSize("dialogue", 50);
	addLuaText("dialogue");
end

function onStepHit()
	if curStep == 1264 then
		doTweenAlpha('fadeIn', 'fade', .7, .1, 'linear')
	end
	if curStep > 1268 and curStep < 1280 then
		setTextString("dialogue", "Oh, you really\nthought that was the")
	elseif curStep > 1280 and curStep < 1295 then
		setTextString("dialogue", "end of our rap battle, \nBoyfriend?");
	elseif curStep == 1295 then
		doTweenAlpha('fadeIn', 'fade', 0, .1, 'linear')
		setTextString("dialogue", "")
	end
end