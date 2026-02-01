extends Area2D
class_name DraggableKey


var held: bool = false
var offset: Vector2
@export var chest_lock: Area2D
var can_drag: bool = false

signal unlock_chest()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if held:
		global_position = get_global_mouse_position() + offset

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if !can_drag:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and Input.is_action_just_pressed("input_drag"):
		held = true
		offset = global_position - get_global_mouse_position()
	elif Input.is_action_just_released("input_drag"):
		held = false
		get_viewport().set_input_as_handled()

func _on_area_entered(area: Area2D) -> void:
	if area == chest_lock:
		unlock_chest.emit()
