extends Control

@export var drag_sound : AudioStreamPlayer
@export var drop_sound : AudioStreamPlayer
var drag = false
var just_pressed = true
var mouse_offset = Vector2(0,0)

func _process(_delta: float) -> void:
	if drag:
		position = get_global_mouse_position() + mouse_offset

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if just_pressed:
			just_pressed = false
			if drag_sound:
				drag_sound.play()
		drag = true
		mouse_offset = position - get_global_mouse_position()
	elif Input.is_action_just_released("input_drag"):
		if drag:
			drag = false
			if drop_sound:
				drop_sound.play()
		just_pressed = true
