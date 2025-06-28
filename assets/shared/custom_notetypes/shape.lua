holdingSpace = false
function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'shape' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/NOTE_assets_Shape')
			setPropertyFromGroup('unspawnNotes', i, 'antialiasing', false)
			--small fix
			if getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') then
				runHaxeCode([[
					var lol = ['purple', 'blue', 'green', 'red'];
					var daNote = game.unspawnNotes[]]..tostring(i)..[[];
					daNote.animation.play(lol[daNote.noteData % 4] + 'hold');
				]])
			else
				setPropertyFromGroup('unspawnNotes', i, 'offset.x', 2)
			end
		end
		setPropertyFromGroup('unspawnNotes', i, 'copyAlpha', false)
	end
end
function onCreatePost()
	makeLuaSprite('shapeWorldHint', 'ui/shapeNoteWarning', 0, 720)
	setProperty('shapeWorldHint.antialiasing', false)
	setObjectCamera('shapeWorldHint', 'hud')
	addLuaSprite('shapeWorldHint', true)
end
function onSongStart()
	doTweenY('penis', 'shapeWorldHint', 350, 0.20*2.4, 'cubeOut')
	ezTimer(nil, 0.2*2.4, function() 
		doTweenY('penis', 'shapeWorldHint', 450, 0.25*2.4, 'cubeInOut')
		ezTimer(nil, 2*2.4, function()
			doTweenY('asdf', 'shapeWorldHint', 350, 0.25*2.4, 'cubeInOut')
			ezTimer(nil, 0.25*2.4, function()
				doTweenY('gasf', 'shapeWorldHint', 720, 0.25*2.4, 'cubeInOut')
			end)
		end)
	end)
end
function onUpdate()
	if not inGameOver then
		holdingSpace = keyboardPressed('SPACE')
	end
end
function onUpdatePost()
	if not inGameOver then
		for i = 0, getProperty('notes.length')-1 do
			if getPropertyFromGroup('notes', i, 'mustPress') then
				if getPropertyFromGroup('notes', i, 'noteType') == 'shape' then
					local coolAlpha = holdingSpace and 1 or 0.5
					setPropertyFromGroup('notes', i, 'alpha', coolAlpha * getPropertyFromGroup('notes', i, 'multAlpha'))
					setPropertyFromGroup('notes', i, 'blockHit', not holdingSpace)
				else
					local coolAlpha = holdingSpace and 0.5 or 1
					setPropertyFromGroup('notes', i, 'alpha', coolAlpha * getPropertyFromGroup('notes', i, 'multAlpha'))
					setPropertyFromGroup('notes', i, 'blockHit', holdingSpace)
				end
			end
		end
	end
end
timers = {blankTags = 0}
function ezTimer(tag, timer, callback)
  if tag == nil then
    tag = 'blank_tags-'..tostring(timers.blankTags)
    timers.blankTags = timers.blankTags + 1
  end
  timers[tag] = callback
  runTimer(tag, timer)
end
function onTimerCompleted(tag)
  if timers[tag] ~= nil then
    timers[tag]()
    timers[tag] = nil
    if stringStartsWith(tag, 'blank_tags-') then
      timers.blankTags = tonumber(stringSplit(tag, '-')[2])
    end
  end
end