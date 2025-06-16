function onSpawnNote(membersIndex, noteData, noteType, isSustainNote, strumTime)
    for i = 0, 3 do
        setPropertyFromGroup('strumLineNotes', i, 'texture', 'noteSkins/NOTE_assets_3D')
        setPropertyFromGroup('notes', i, 'texture', 'noteSkins/NOTE_assets_3D')
    end
end


function onCreatePost()
    for i = 0, 3 do
        setPropertyFromGroup('strumLineNotes', i, 'texture', 'noteSkins/NOTE_assets_3D')
    end
end