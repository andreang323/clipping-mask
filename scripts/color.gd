extends Area2D
class_name ColorDrag

var drag = false
var mouse_offset = Vector2(0,0)
signal drag_ended

@export var particle_color : Color

enum COLORTYPES{BLACK, RED, GREEN, YELLOW, BLUE, PURPLE, ORANGE}
# variable to check against receiver's desired ids
@export var id: COLORTYPES

@export var sprite: Sprite2D
var outline_sprite: Sprite2D

func _ready() -> void:
	# create new sprite with same texture as sprite
	var new_sprite = Sprite2D.new()
	new_sprite.texture = sprite.texture
	# set material of new sprite
	var mat = ShaderMaterial.new()
	mat.shader = load("res://shaders/outline.gdshader")
	new_sprite.material = mat
	# set visibility of new sprite 
	new_sprite.visible = false
	new_sprite.z_index = 2
	sprite.add_child(new_sprite)
	outline_sprite = new_sprite

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		drag = true
		mouse_offset = position - get_global_mouse_position()
	elif Input.is_action_just_released("input_drag"):
		if drag:
			drag_ended.emit()
			drag = false

func _process(_delta: float) -> void:
	if drag:
		position = get_global_mouse_position() + mouse_offset
	
	if Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_RIGHT):
		outline_sprite.visible = true
	else: outline_sprite.visible = false

func disable():
	$Particles.modulate = particle_color
	$Particles.emitting = true
	set_deferred("input_pickable", false)
