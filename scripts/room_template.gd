extends Node2D
class_name Room


## Background image of room
@export var background: Sprite2D
@export var sound : AudioStreamPlayer
## Size of the room. Needed for autopopulation if used.
var room_size : Vector2 = Vector2(1980, 1080)
## Emitted when room complete.
signal room_complete()

var room_id: int

var complete = false

func _ready() -> void:
	if background:
		room_size = background.texture.get_size()

## Called when a room is completed.
func room_finished():
	room_complete.emit()

func color_received(_id):
	for receiver in get_tree().get_nodes_in_group("Receivers"):
		if is_ancestor_of(receiver) and !receiver.correct:
			return
	for color_drag in get_tree().get_nodes_in_group("Colors"):
		if is_ancestor_of(color_drag) and color_drag is ColorDrag:
			color_drag.disable()
	complete = true
	if sound:
		sound.play()
	room_finished()
	# print("room complete")
