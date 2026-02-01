extends Room

func credits():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position:y", -1440, 1)
