extends Area2D
class_name ColorDrag

var drag = false
var mouse_offset = Vector2(0,0)
signal drag_ended

@export var particle_color : Color
@export var particle_type = 0
@export var auto_shape = true
var drag_started = true
enum COLORTYPES{BLACK, RED, GREEN, YELLOW, BLUE, PURPLE, ORANGE, MAGENTA, MAROON, AZURE, FUSCHIA, VERT, PERIWINKLE, AQUAMARINE, CYAN, WHITE, PEACH, RAINBOW}
# variable to check against receiver's desired ids
@export var id: COLORTYPES

@export var sprite: Sprite2D
var outline_sprite: Sprite2D

func _ready() -> void:
	if sprite:
		if auto_shape:
			$CollisionShape2D.shape = RectangleShape2D.new()
			$CollisionShape2D.shape.size = sprite.texture.get_size()
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
	# connect input event
	#input_event.connect(_on_input_event)
	# nonzero input loads water version of particles
	if particle_type:
		$Particles.texture = load("res://assets/ui/particle_effects_2.png")

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if drag_started:
			drag_started = false
			$Button2.play()
			drag = true
		mouse_offset = position - get_global_mouse_position()
		get_viewport().set_input_as_handled()
	elif Input.is_action_just_released("input_drag"):
		if drag:
			drag_started = true
			$Button.play()
			drag_ended.emit()
			drag = false
			get_viewport().set_input_as_handled()

func _process(_delta: float) -> void:
	if drag:
		position = get_global_mouse_position() + mouse_offset
	
	if outline_sprite:
		if Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_RIGHT):
			outline_sprite.visible = true
		else: outline_sprite.visible = false

func disable():
	if input_pickable:
		$Particles.modulate = particle_color
		$Particles.emitting = true
		set_deferred("input_pickable", false)
