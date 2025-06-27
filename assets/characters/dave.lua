function onUpdate()
	if getSongPosition() > 0 then
		songPos = getSongPosition()
		local currentBeat = (songPos/5000)*(curBpm/60)*2
		setCharacterY('dad', getCharacterY('dad') + (math.sin(currentBeat) * 2))
	end
end
