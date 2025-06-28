function goodNoteHit(id, direction, noteType, isSustainNote)
    if noteType == 'phone' then
        if not isSustainNote then
            characterPlayAnim('dad', 'a_bambi phone', true)
        end
    end
end
