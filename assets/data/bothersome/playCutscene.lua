playVideo = false;
playDialogue = true;

function onStartCountdown()
	if isStoryMode then
		if playVideo then --Video cutscene plays first
			startVideo('mazeCutscene'); --Play video file from "videos/" folder
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

function onCreatePost()
	allowEnd = false;
	makeLuaText("dialogue", "", 550, 350.0, 250.0);
	setTextAlignment("dialogue", "center");
	setTextSize("dialogue", 50);
	addLuaText("dialogue");
end

function onStepHit()
	if curStep == 1722 or curStep == 1984 then
		doTweenAlpha('fadeIn', 'fade', .7, .1, 'linear')
	end
	if curStep > 1728 and curStep < 1764 then
		setTextString("dialogue", "I've gone 3D because of you too many times.");
	elseif curStep > 1764 and curStep < 1776 then
		setTextString("dialogue", "Why do you insist");
	elseif curStep > 1776 and curStep < 1797 then
		setTextString("dialogue", "on rap-battling so much?");
	elseif curStep > 1797 and curStep < 1808 then
		setTextString("dialogue", "I'm done.");
	elseif curStep > 1808 and curStep < 1824 then
		setTextString("dialogue", "Please...");
	elseif curStep > 1824 and curStep < 1840 then
		setTextString("dialogue", "Go...");
	elseif curStep > 1987 and curStep < 2000 then
		setTextString("dialogue", "Please...");
	elseif curStep > 2000 and curStep < 2014 then
		setTextString("dialogue", "Stop...");
	elseif curStep > 2014 and curStep < 2025 then
		setTextString("dialogue", "This...");
	elseif curStep > 2025 and curStep < 2036 then
		setTextString("dialogue", "Song...");
	elseif curStep > 2036 and curStep < 2074 then
		setTextString("dialogue", "I don't like being 3D...");
	elseif curStep > 2074 and curStep < 2092 then
		setTextString("dialogue", "You want to rap-battle?");
	elseif curStep > 2092 and curStep < 2110 then
		setTextString("dialogue", "Let's rap battle, then.");
	elseif curStep == 1840 or curStep == 2110 then
		doTweenAlpha('fadeIn', 'fade', 0, .1, 'linear')
		setTextString("dialogue", "")
	end
end 