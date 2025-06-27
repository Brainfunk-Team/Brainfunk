local daves = {'dave-happy-playable', 'insane-dave-playable'}

local characterFile = 'data/current-character.txt'
local char = getTextFromFile(characterFile)
--[[
function onCreatePost()
    if difficultyName:lower() == "normal" then
        for i, v in ipairs(daves) do
            if char == v and songName == "Prosthesis" and difficultyName ~= "dave" then
                loadSong("prosthesis", "dave")
                return
            end
        end
    end
end

]]