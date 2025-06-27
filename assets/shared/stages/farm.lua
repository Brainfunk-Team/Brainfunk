function onCreate()
    precacheImage('sky_sunset') 
end

function onCreatePost()
    if songName == "Agro-cultured" then
        loadGraphic("sprite8", "sky_sunset")
        setProperty("fade.alpha", 0.2)
    else
        if songName == "phonebreaker" then
            loadGraphic("sprite8", "sky_night")
            setProperty("fade.alpha", 0.4)
        else
            setProperty("fade.alpha", 0)
        end
    end
end