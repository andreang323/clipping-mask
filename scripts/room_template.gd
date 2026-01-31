extends Node2D
class_name Room

## Size of the room. Needed for autopopulation if used.
@export var roomSize : Vector2 = Vector2(1080, 1080)
## Emitted when room complete.
signal roomComplete()

## Called when a room is completed.
func roomFinished():
	roomComplete.emit()
