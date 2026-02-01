extends Area2D
class_name Receiver

enum COLORTYPES{BLACK, RED, GREEN, YELLOW, BLUE, PURPLE, ORANGE}
@export var answers : Array[int] = []

func _on_area_entered(area: Area2D) -> void:
	if area is ColorDrag:
		await area.drag_ended
		if area in get_overlapping_areas():
			var tween = get_tree().create_tween()
			tween.tween_property(area, "global_position", global_position, 0.2)
