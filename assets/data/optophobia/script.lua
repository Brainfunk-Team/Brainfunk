function onUpdate(elapsed)
	changeDiscordPresence("CHEATER", nil, "eye")
	songPos = getSongPosition()
	local currentBeat = (songPos/5000)*(curBpm/18)
    local modchart = getModSetting('modchart')
    if modchart then
        noteTweenX(defaultPlayerStrumX3, 4, defaultPlayerStrumX3 - 390 + 1800*math.sin((currentBeat+10*1.5)*math.pi), 1.35)
        noteTweenX(defaultPlayerStrumX1, 5, defaultPlayerStrumX1 - 390 + 1800*math.sin((currentBeat+10*1.5)*math.pi), 1.35)
        noteTweenX(defaultPlayerStrumX0, 6, defaultPlayerStrumX0 - 210*math.sin((currentBeat+8*1.75)*math.pi), 0.00001)
        noteTweenX(defaultPlayerStrumX2, 7, defaultPlayerStrumX2 - 210*math.sin((currentBeat+8*1.75)*math.pi), 0.00001)

        noteTweenX(defaultOpponentStrumX3, 0, defaultOpponentStrumX3 + 390 - 1800*math.sin((currentBeat+10*1.5)*math.pi), 1.35)
        noteTweenX(defaultOpponentStrumX1, 1, defaultOpponentStrumX1 + 390 - 1800*math.sin((currentBeat+10*1.5)*math.pi), 1.35)
        noteTweenX(defaultOpponentStrumX0, 2, defaultOpponentStrumX0 + 210*math.sin((currentBeat+8*1.75)*math.pi), 0.00001)
        noteTweenX(defaultOpponentStrumX2, 3, defaultOpponentStrumX2 + 210*math.sin((currentBeat+8*1.75)*math.pi), 0.00001)
    end
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SEVEN') then
		playVideo = true;
		if playVideo then
			restartSong(true);
			startVideo('rickroll');
			playVideo = false;
			return Function_Stop;
		end
	end
end

function onCreatePost()
	unlockAchievement("alwayswatching")
    for i = 0, 3 do
        noteTweenAlpha("note" .. i, i, 0, 0.1)
    end
end


function showPopup(message) --function made with chatgpt if i'm being honest
    local osName = package.config:sub(1,1) == "\\" and "windows" or "unix"

    if osName == "windows" then
        -- Windows: Use msg command or PowerShell
        os.execute('msg * "' .. message .. '"')
    else
        -- macOS and Linux: Use AppleScript (macOS) or zenity/kdialog (Linux)
        local isMac = io.popen("uname"):read() == "Darwin"
        if isMac then
            os.execute('osascript -e \'display dialog "' .. message .. '"\'')
        else
            -- Linux: Use Zenity or kdialog
            if os.execute("command -v zenity") == 0 then
                os.execute('zenity --info --text="' .. message .. '"')
            elseif os.execute("command -v kdialog") == 0 then
                os.execute('kdialog --msgbox "' .. message .. '"')
            else
                print("No suitable dialog tool found on this system.")
            end
        end
    end
end

function onGameOver()
	showPopup("YOU THOUGHT YOU COULD BEAT A GOD.")	
end

function onEndSong()
    local modchart = getModSetting('modchart')
    if modchart then
        unlockAchievement("eye")
    end
end