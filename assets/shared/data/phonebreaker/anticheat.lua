function onUpdate(elapsed)

    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SEVEN') then
        debugPrint("testing");   
    endSong(true);
    loadSong('cheating');
    
    end
    
    end