local characters = {'bf', 'BFDel', 'dave-happy-playable', "insane-dave-playable", "dave", "splitathon-dave", 'bambi-playable', "angry-bambi-playable", "splitathon-bambi","bambi 20-playable", "tristan", "cheating-playable"} -- add own character files
local characterTxt = {'Boyfriend', 'Boyfriend (Delirium Form)', 'Dave', 'Dave (Insanity Form)', 'Dave (3D Form)', 'Dave (Splitathon Form)', 'Bambi', "Bambi (Screwed Form)", "Bambi (Splitathon Form)","Bambi (2.0 Form)", 'Tristan', "Expunged (Cheating Form)"} -- add own titles (must be in the same order)
local characterDesc = {
    'The one and only. He\'s everywhere!',
    'The one and only. He\'s everywhere!',
    'A man in a wheelchair that turns 3D sometimes.',
    'A man in a wheelchair that turns 3D sometimes.',
    'A man in a wheelchair that turns 3D sometimes.',
    'A man in a wheelchair that turns 3D sometimes.',
    'A loud farmer obsessed with corn and likes breaking phones.',
    'A loud farmer obsessed with corn and likes breaking phones. Now he\'s mad.',
    'A loud farmer obsessed with corn and likes breaking phones. He\'s in his pajama.',
    'A loud farmer obsessed with corn and likes breaking phones.',
    'Dave\'s adopted son.',
    'A mysterious entity bent on removing anybody that accidentally enters the 3D realm.'
} -- add own descriptions (leave them blank if you want to remove them)

local currentIndex = 1
local characterFile = 'mods/Brainfunk/data/current-character.txt'

function loadCharacterFromFile()
    if fileExists(characterFile) then
        local char = readFile(characterFile)
        for i, v in ipairs(characters) do
            if v == char then
                currentIndex = i
                return
            end
        end
    end
    currentIndex = 1
end

function saveCharacterToFile()
    success = saveFile(characterFile, characters[currentIndex], true)
end

function updateCharacter()
    local char = characters[currentIndex]
    setProperty('boyfriend.curCharacter', char)
    runHaxeCode('game.boyfriend.changeCharacter("' .. char .. '");')
    setCameraFollowPoint(600, 600)
    saveCharacterToFile()
    updateCharacterText()
end

function onSectionHit()
    setCameraFollowPoint(600, 600)
end

function hideUI()
    setProperty('healthBar.alpha', 0)
    setProperty('healthBarBG.alpha', 0)
    setProperty('healthBarBG2.alpha', 0)
    setProperty('scoreTxt.alpha', 0)
    setProperty('timeBar.alpha', 0)
    setProperty('timeBarBG.alpha', 0)
    setProperty('timeTxt.alpha', 0)
    setProperty('iconP1.alpha', 0)
    setProperty('iconP2.alpha', 0)
    setProperty('botplayTxt.alpha', 0)
    setProperty('misses.alpha', 0)
    setProperty('combo.alpha', 0)
    setProperty('rating.alpha', 0)
    setProperty('camHUD.visible', false)
end

function createCharacterText()
    makeLuaText('charTitle', characterTxt[currentIndex], 0, 100, 60)
    setTextSize('charTitle', 25)
    setTextAlignment('charTitle', 'left')
    addLuaText('charTitle')

    makeLuaText('charDesc', characterDesc[currentIndex], 1000, 100, 100)
    setTextSize('charDesc', 15)
    setTextAlignment('charDesc', 'left')
    addLuaText('charDesc')
end



function updateCharacterText()
    setTextString('charTitle', characterTxt[currentIndex])
    setTextString('charDesc', characterDesc[currentIndex])
end

function preload()
    precacheImage("characters/Angry_Bambi")
    precacheImage("characters/bambi20")
    precacheImage('characters/bambiRemake')
    precacheImage("characters/BFDel")
    precacheImage('characters/Cheating')
    precacheImage("characters/Dave_3D")
    precacheImage('characters/dave_insanity_lol')
    precacheImage('characters/dave_sheet')
    precacheImage('characters/Splitathon_Bambi')
    precacheImage('characters/Splitathon_Dave')
    precacheImage('characters/TRISTAN')
    precacheSound('scrollMenu')
end
--add own preload images


function onCreate()
    setProperty('skipCountdown', true)
    hideUI()
end

function createUI()
    makeLuaSprite('ui1', 'character-select/charSelectGuide', 0, 100)
    setScrollFactor('ui1', 0, 0)
    addLuaSprite("ui1", true)
    createArrowSprite('Left', 0, 350)
    createArrowSprite('Right', 1150, 350)
end

function createArrowSprite(dir, x, y)
    makeAnimatedLuaSprite("arrow" .. dir, 'character-select/arrow' .. dir, x, y)
    setScrollFactor('arrow' .. dir, 0, 0)
    scaleObject('arrow' .. dir, 0.5, 0.5, true)
    addLuaSprite('arrow' .. dir, true)
    addAnimationByPrefix('arrow' .. dir, 'idle', 'idle')
    addAnimationByPrefix('arrow' .. dir, 'press', 'press')
    playAnim('arrow' .. dir, 'idle')
end

function onCreatePost()
    createUI()
    createCharacterText()
    --loadCharacterFromFile()
    updateCharacter()
    if not getModSetting("precache") then
        preload()
    end
end

function onUpdate()
    setProperty('timeBar.visible', false);
    setProperty('timeBarBG.visible', false);
    setProperty('timeTxt.visible', false);
    for i = 0, 7 do
        setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
    end

    if keyboardJustPressed('RIGHT') then
        playAnim('arrowRight', 'press', true)
        playSound("scrollMenu")
        currentIndex = currentIndex + 1
        if currentIndex > #characters then currentIndex = 1 end
        updateCharacter()
        runTimer('animationArrowRight', .25)
    end
    if keyboardJustPressed('LEFT') then
        playAnim('arrowLeft', 'press', true)
        playSound("scrollMenu")
        currentIndex = currentIndex - 1
        if currentIndex < 1 then currentIndex = #characters end
        updateCharacter()
        runTimer('animationArrowLeft', .25)
    end

    if keyboardJustPressed('A') then
        runHaxeCode('game.boyfriend.playAnim("singLEFT", true);')
    elseif keyboardJustPressed('D') then
        runHaxeCode('game.boyfriend.playAnim("singRIGHT", true);')
    elseif keyboardJustPressed('W') then
        runHaxeCode('game.boyfriend.playAnim("singUP", true);')
    elseif keyboardJustPressed('S') then
        runHaxeCode('game.boyfriend.playAnim("singDOWN", true);')
    end

    if keyboardJustPressed("ENTER") then
        runHaxeCode('game.boyfriend.playAnim("singUP", true);')
        runHaxeCode('game.boyfriend.playAnim("singDOWN-alt", true);')
        playSound("confirmMenu")
        saveCharacterToFile()
        runTimer('end', 1)
    end
end

function onTimerCompleted(tag)
    if tag == 'end' then
        endSong()
    end

    if tag == 'animationArrowLeft' then
         playAnim('arrowLeft', 'idle', true)
    end

    if tag == 'animationArrowRight' then
         playAnim('arrowRight', 'idle', true)
    end
end

function onPause()
    return Function_Stop
end
