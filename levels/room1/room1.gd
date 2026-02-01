extends Room

func _on_light_checker_color_received(color: ColorDrag.COLORTYPES) -> void:
	if color == ColorDrag.COLORTYPES.YELLOW:
		GlobalFlags.room1_data.lightbulb_filled = true
