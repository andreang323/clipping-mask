extends ColorRect

var drag = false
var mouse_offset = Vector2(0,0)

func _process(_delta: float) -> void:
	if drag:
		position = get_global_mouse_position() + mouse_offset

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		drag = true
		mouse_offset = position - get_global_mouse_position()
	elif Input.is_action_just_released("input_drag"):
		if drag:
			drag = false
