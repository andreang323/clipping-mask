extends Room

func credits():
	print("blah")
	var tween = get_tree().create_tween()
	tween.tween_property(GlobalFlags.camera, "position", Vector2(GlobalFlags.camera.position.x, GlobalFlags.camera.position.y-960), 1)
	GlobalFlags.return_to_menu.emit()


func _on_room_complete() -> void:
	credits()
