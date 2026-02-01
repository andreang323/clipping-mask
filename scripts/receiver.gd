extends Area2D
class_name Receiver

enum COLORTYPES{BLACK, RED, GREEN, YELLOW, BLUE, PURPLE, ORANGE}
@export var answers : Array[int] = []
var correct = false
var answer : int = -1
signal color_received

func _on_area_entered(area: Area2D) -> void:
	if area is ColorDrag:
		await area.drag_ended
		if area in get_overlapping_areas():
			var tween = get_tree().create_tween()
			tween.tween_property(area, "global_position", global_position, 0.2)
			answer = area.id
		if answer in answers:
			correct = true
			color_received.emit()
		else:
			correct = false
