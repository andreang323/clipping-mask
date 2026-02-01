extends Area2D
class_name ColorDrag

var mouse_in = false
var drag = false
var mouse_offset = Vector2(0,0)
signal drag_ended

@export var particle_color : Color

enum COLORTYPES{BLACK, RED, GREEN, YELLOW, BLUE, PURPLE, ORANGE}
# variable to check against receiver's desired ids
@export var id : COLORTYPES

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if mouse_in and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		drag = true
		mouse_offset = position - get_global_mouse_position()
	elif Input.is_action_just_released("input_drag"):
		if drag:
			drag_ended.emit()
			drag = false

func _process(_delta: float) -> void:
	if drag:
		position = get_global_mouse_position() + mouse_offset

func _on_mouse_entered() -> void:
	mouse_in = true

# func _on_mouse_exited() -> void:
# 	if drag:
# 		drag_ended.emit()
# 		drag = false
# 	mouse_in = false

func disable():
	$Particles.modulate = particle_color
	$Particles.emitting = true
	set_deferred("input_pickable", false)
