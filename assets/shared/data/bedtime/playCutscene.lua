function onCreatePost()
	allowEnd = false;
	makeLuaText("dialogue", "", 550, 350.0, 250.0);
	setTextAlignment("dialogue", "center");
	setTextSize("dialogue", 50);
	addLuaText("dialogue");
end

function onStepHit()
	if curStep == 32 or curStep == 496 or curStep == 1072 then
		doTweenAlpha('fadeIn', 'fade', .7, .1, 'linear')
	end
	if curStep > 32 and curStep < 64 then
		setTextString("dialogue", "Tristan, are you\nin bed yet?");
	elseif curStep > 64 and curStep < 96 then
		setTextString("dialogue", "Get to bed now!");
	elseif curStep > 96 and curStep < 119 then
		setTextString("dialogue", "Now's not the time\nfor a rapbattle!");
	elseif curStep > 496 and curStep < 511 then
		setTextString("dialogue", "You're gonna get\ngrounded!");
	elseif curStep > 1072 and curStep < 1088 then
		setTextString("dialogue", "Stop this right\nnow!");
	elseif curStep == 119 or curStep == 511 or curStep == 1088 then
		doTweenAlpha('fadeIn', 'fade', 0, .1, 'linear')
		setTextString("dialogue", "")
	end
end