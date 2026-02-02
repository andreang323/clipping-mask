extends Room

var credits_roll: bool = false

func credits():
	print("blah")
	var tween = get_tree().create_tween()
	tween.tween_property(GlobalFlags.camera, "position", Vector2(GlobalFlags.camera.position.x, GlobalFlags.camera.position.y-960), 1)
	await tween.finished
	credits_roll = true

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and credits_roll:
		print("blah")
		GlobalFlags.reset_game.emit()

func _on_room_complete() -> void:
	credits()
