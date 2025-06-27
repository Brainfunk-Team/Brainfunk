function onUpdate(elapsed)
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SEVEN') then
        achievement = false;
        debugPrint("testing");   
        endSong(true);
        loadSong('lights-out');
    
    end
    
    end

function onCreatePost()
    setProperty('debugKeysChart', null);
end