#PushSubdcriber Backend

This Sinatra App receives client requests and turns them into Urban Airship API calls.

#Alle named-user-Routen:

## '/user-info'
Gibt komplette UA-Info über einen named user zurück
Params: ssoid

## '/add-tag'
Fügt ein Tag hinzu
Params: tag_name, ssoid, tag_group_name (tag_group_name muss im UA-Backend definiert worden sein)
Params: channel_id, tag_name, tag_group_name

## '/get-tags'
Gibt alle Tags zurück, die der named user gesetzt hat 
Params: ssoid

## '/has-tag'
Gibt true/false zurück, wenn das übergebene Tag bereits gesetzt ist.
Params: tag_name, ssoid, tag_group_name

## '/active-channels'
Gibt die aktiven Channels eines named users zurück - ein Array mit den device-types. Z.B. ['android', 'ios']
Params: ssoid

##'/remove-tag'
Params: ssoid, tag_name, tag_group_name


#Alle Channel basierten Routen:

##'/channel'
Params: channel_id

##'/channel/has-tag'
Params: channel_id, tag_name, tag_group_name

##'/channel/add-tag'
Params: channel_id, tag_name, tag_group_name

##'/channel/remove-tag'
Params: channel_id, tag_name, tag_group_name

# Alle Push-Routen
## '/push'
Params: channel_id, message, device_type, title (optional)