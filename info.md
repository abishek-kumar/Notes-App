Notes App 

DataModel

    Users
        id, name, password ,user_id
        
    Notes
        id, title, content

    Trash
        notes_id (FK Notes.id), deleted_time

    Labels
        id,name
        
    Notes_Label
        label_id (FK Label.id), note_id  (FK Note.id)



APIs

    Users
        /signup
        /login
        /logout
        
    Notes
        /note/create
        /note/list(?search_term, labels)
        /note/id/save
        /note/id/delete
        /note/id/trash
        /note/id/addLabel
        /note/id/removeLabel
        /note/id/bulkdelete
        /note/id/bulktrash
        /note/id/bulkAddLabel

    Label
        /label/create
        /label/delete
        /label/delete_notes
        /label/list
        
    Trash
        /trash/empty
        /trash/restoreAll
        /trash/id/restore
