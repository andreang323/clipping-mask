extends Room

var credits_roll: bool = false
@export var special_end: Resource

func credits():
	if GlobalFlags.room1_data.room_complete && GlobalFlags.room2_data.room_complete && GlobalFlags.room3_data.room_complete && GlobalFlags.room4_data.room_complete:
		$Background.texture = special_end
	var tween = get_tree().create_tween()
	tween.tween_property(GlobalFlags.camera, "position", Vector2(GlobalFlags.camera.position.x, GlobalFlags.camera.position.y-960), 1)
	await tween.finished
	if GlobalFlags.room4_data.bird_freed:
		$BirdFlying/AnimationPlayer.play("escape")
	credits_roll = true

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and credits_roll:
		GlobalFlags.reset_game.emit()

func _on_room_complete() -> void:
	credits()
