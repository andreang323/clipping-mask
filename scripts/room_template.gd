extends Node2D
class_name Room

## Size of the room. Needed for autopopulation if used.
@export var room_size : Vector2 = Vector2(1080, 1080)
## Emitted when room complete.
signal room_complete()

var complete = false

## Called when a room is completed.
func room_finished():
	room_complete.emit()

func color_received():
	for receiver in get_tree().get_nodes_in_group("Receivers"):
		if !receiver.correct:
			return
	for color_drag in get_tree().get_nodes_in_group("Colors"):
		if color_drag is ColorDrag:
			color_drag.disable()
	complete = true
	print("room complete")
