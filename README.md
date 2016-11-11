#PushSubdcriber Backend

This Sinatra App receives client requests and turns them into Urban Airship API calls.

# '/user-info'
Gibt komplette UA-Info über einen named user zurück
Params: ssoid

# '/add-tag'
Fügt ein Tag hinzu
Params: tag_name, ssoid, tag_group_name (tag_group_name muss im UA-Backend definiert worden sein)

# '/get-tags'
Gibt alle Tags zurück, die der named user gesetzt hat 
Params: ssoid

# '/has-tag'
Gibt true/false zurück, wenn das übergebene Tag bereits gesetzt ist.
Params: tag_name, ssoid, tag_group_name

# '/active-channels'
Gibt die aktiven Channels eines named users zurück - ein Array mit den device-types. Z.B. ['android', 'ios']
Params: ssoid