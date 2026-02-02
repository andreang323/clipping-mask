extends Room

var post_light = load("res://levels/room1/sprites/image1.png")
var opened_chest = load("res://levels/room1/sprites/image2.png")
var secret = load("res://levels/room1/sprites/lightbulb_secret_passage_reveal.png")
@export var key: DraggableKey


func _ready() -> void:
	GlobalFlags.key_obtained.connect(enable_key)
	key.unlock_chest.connect(unlock_chest)
	key.visible = false
	$Key/Sprite2D.z_index = 0

func enable_key() -> void:
	key.visible = true

func unlock_chest() -> void:
	$Background.texture = opened_chest
	key.queue_free()
	$GemChecker.process_mode = Node.PROCESS_MODE_INHERIT

func _on_light_checker_color_received(color: ColorDrag.COLORTYPES) -> void:
	if color == ColorDrag.COLORTYPES.YELLOW:
		GlobalFlags.room1_data.lightbulb_filled = true
		$Moon.disable()
		$LightChecker.monitoring = false
		$Background.texture = post_light
		$Key/Sprite2D.z_index = 2
		$Key.can_drag = true
		#await get_tree().create_timer(1).timeout
		#open_chest()

func open_chest():
	$Background.texture = opened_chest
	$GemChecker.process_mode = Node.PROCESS_MODE_PAUSABLE

func _on_gem_checker_color_received(color: Receiver.COLORTYPES) -> void:
	if color == ColorDrag.COLORTYPES.BLUE:
		$Background.texture = secret
		GlobalFlags.room1_data.secret_passage_enabled = true


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if !GlobalFlags.room1_data.secret_passage_enabled:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and Input.is_action_just_pressed("input_drag"):
		$Steps.play()
		GlobalFlags.go_to_final_level.emit()


func _on_room_complete() -> void:
	GlobalFlags.room1_data.room_complete = true
