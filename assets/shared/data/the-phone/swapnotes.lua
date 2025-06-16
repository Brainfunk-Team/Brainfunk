local actHealth = 1
local playerX = {}
local opponentX = {}

function onCreatePost()
    if middlescroll then
        createPopup("This song does not support Middle Scroll! Turn it off to play this song!!", "Warning")
        endSong()
    end
    actHealth = 1

    for i = 0, 3 do
        table.insert(opponentX, getPropertyFromGroup('strumLineNotes', i, 'x'))
        table.insert(playerX, getPropertyFromGroup('strumLineNotes', i + 4, 'x'))
    end

    for i = 0, 3 do
        noteTweenX('swapOpponent'..i, i, playerX[i + 1], 0.6, 'quartOut')
        noteTweenX('swapPlayer'..i, i + 4, opponentX[i + 1], 0.6, 'quartOut')
    end
    space = ""
    makeLuaText('leftSideText', 'You are playing here!', 300, 175, 400)
    setTextAlignment('leftSideText', 'center')
    setTextSize('leftSideText', 24)
    setTextFont('leftSideText', 'vcr.ttf')
    addLuaText('leftSideText')
    doTweenAlpha("makeInvisible", "leftSideText", 0, 0.0000001, "linear")
end

function onUpdate(elapsed)
    if actHealth > 1.99 then
        actHealth = 1.99
    end

    if actHealth <= 0 then
        actHealth = 0
        setHealth(actHealth)
    else
        setProperty('health', 2 - actHealth)
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    local rating = getPropertyFromGroup('notes', id, 'rating')

    if rating == 'sick' then
        actHealth = actHealth + 0.04
    elseif rating == 'good' then
        actHealth = actHealth + 0.03
    elseif rating == 'bad' then
        actHealth = actHealth + 0.02
    elseif rating == 'shit' then
        actHealth = actHealth + 0.01
    end
end



function onStepHit()
    if curStep == 1 then
        doTweenAlpha("fadeLeftText1", "leftSideText", 1, .1, "linear")
    end
    if curStep == 32 then
        doTweenAlpha("fadeLeftText2", "leftSideText", 0, .1, "linear")
    end
end

function onTweenCompleted(tag)
    if tag == "fadeLeftText2" then
        removeLuaText("leftSideText", true)
    end
end

function createPopup(message, title)
    local osName = package.config:sub(1,1) == '\\' and 'windows' or io.popen('uname'):read('*l'):lower()

    if osName == 'windows' then
        -- Windows popup using PowerShell
        os.execute('powershell -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show(\'' .. message .. '\', \'' .. title .. '\')"')
    
    elseif osName:find('darwin') then
        -- macOS popup using AppleScript
        os.execute('osascript -e \'display dialog "' .. message .. '" with title "' .. title .. '" buttons {"OK"} default button 1\'')
    
    elseif osName:find('linux') then
        -- Linux popup using zenity (must be installed)
        os.execute('zenity --info --title="' .. title .. '" --text="' .. message .. '"')
    else
        debugPrint(title .. message)
    end
end
