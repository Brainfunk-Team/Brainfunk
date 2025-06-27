playVideo = false;
playDialogue = true;

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

function onCreatePost()
	allowEnd = false;
	makeLuaText("dialogue", "", 550, 350.0, 250.0);
	setTextAlignment("dialogue", "center");
	setTextSize("dialogue", 50);
	addLuaText("dialogue");
end

function onStepHit()
	if curStep == 640 or curStep == 1408 then
		doTweenAlpha('fadeIn', 'fade', .7, .1, 'linear')
	end
	if curStep > 642 and curStep < 651 then
		setTextString("dialogue", "You know, Boyfriend,");
	elseif curStep > 642 and curStep < 672 then
		setTextString("dialogue", "I am starting to get tired of this battle.");
	elseif curStep > 672 and curStep < 704 then
		setTextString("dialogue", "You just don't understand how hard the world is getting");
	elseif curStep > 704 and curStep < 709 then
		setTextString("dialogue", "because of you.");
	elseif curStep > 709 and curStep < 730 then
		setTextString("dialogue", "It's like everyday I have to deal with you.");
	elseif curStep > 730 and curStep < 747 then
		setTextString("dialogue", "Especially against Bambi");
	elseif curStep > 747 and curStep < 768 then
		setTextString("dialogue", "We just want to move on with our lives.");
	elseif curStep > 768 and curStep < 787 then
		setTextString("dialogue", "There is so much out there for you too.");
	elseif curStep > 787 and curStep < 814 then
		setTextString("dialogue", "Is this what you do all the time?");
	elseif curStep > 814 and curStep < 839 then
		setTextString("dialogue", "Boyfriend?");
	elseif curStep > 839 and curStep < 869 then
		setTextString("dialogue", "Facing your opponents with rap skills?");
	elseif curStep > 869 and curStep < 896 then
		setTextString("dialogue", "Well, let me tell you something, Boyfriend.");
	elseif curStep > 1408 and curStep < 1433 then
		setTextString("dialogue", "It doesn't always work.");
	elseif curStep > 1433 and curStep < 1456 then
		setTextString("dialogue", "Most of the time");
	elseif curStep > 1456 and curStep < 1484 then
		setTextString("dialogue", "You are so incomprehensible.");
	elseif curStep > 1484 and curStep < 1498 then
		setTextString("dialogue", "You have a girlfriend too.");
	elseif curStep > 1498 and curStep < 1536 then
		setTextString("dialogue", "But another question");
	elseif curStep > 1536 and curStep < 1552 then
		setTextString("dialogue", "Why...");
	elseif curStep > 1552 and curStep < 1568 then
		setTextString("dialogue", "Us?");
	end
	if curStep == 896 or curStep == 1568 then
		doTweenAlpha('fadeIn', 'fade', 0, .1, 'linear')
		setTextString("dialogue", "")
	end
end




