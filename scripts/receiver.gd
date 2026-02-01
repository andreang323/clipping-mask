extends Area2D
class_name Receiver

enum COLORTYPES{BLACK, RED, GREEN, YELLOW, BLUE, PURPLE, ORANGE, MAGENTA, MAROON, AZURE, FUSCHIA, VERT, PERIWINKLE, AQUAMARINE, CYAN, WHITE, PEACH, RAINBOW, SPACE, CRIMSON, GRADIENT, STRIPED, BEIGE}

@export var answers : Array[COLORTYPES] = []
var correct = false
var answer : int = -1
## Toggle this to determine snapping behavior.
@export var snap_enabled = true
signal color_received(color: COLORTYPES)
signal correct_color_received()

## Automatically connects color_received signal to parent
func _ready() -> void:
	color_received.connect(get_parent().color_received)

func _on_area_entered(area: Area2D) -> void:
	if area is ColorDrag:
		await area.drag_ended
		if area in get_overlapping_areas():
			if snap_enabled:
				var tween = get_tree().create_tween()
				tween.tween_property(area, "global_position", global_position, 0.2)
				$Snap.play()
				# Current answer = current overlapping
				answer = area.id
				# Check if correct answer
				if answer in answers:
					correct = true
					color_received.emit(area.id)
					correct_color_received.emit()
				else:
					correct = false
			# Snap disabled but we got the correct answer
			elif area.id in answers:
				correct = true
				color_received.emit(area.id)
			# Otherwise we just don't care. cool.

## Updates correct state upon exit of area
func _on_area_exited(_area: Area2D) -> void:
	var check = false
	for area in get_overlapping_areas():
		if area is ColorDrag and area.id in answers:
			check = true
	correct = check
