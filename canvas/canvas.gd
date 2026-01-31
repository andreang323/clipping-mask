extends Sprite2D
class_name Canvas


@export var image_size: Vector2i
@export var brush_size: Vector2i
@export var brush_texture: Texture2D
@export var paint_with_brush: bool = false
@export var color: Color

var prev_mouse_position: Vector2i
var img: Image
var brush_img: Image

func _ready() -> void:
	# initialize canvas
	texture = ImageTexture.new();
	img = Image.create_empty(image_size.x, image_size.y, false, Image.FORMAT_RGBA8)
	img.fill(Color.WHITE)
	texture.set_image(img)

	prev_mouse_position = get_mouse_position()

	if brush_img:
		brush_img = brush_texture.get_image()
		brush_img.resize(brush_size.x, brush_size.y)

func _process(_delta: float) -> void:
	var mouse_position: Vector2i = get_mouse_position()

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):

		var mouse_movement: float = (mouse_position - prev_mouse_position).abs().length()
		var prev_mouse_float := Vector2(prev_mouse_position)

		if mouse_movement > 0:
			var num = ceili(mouse_movement)
			for i in num:
				prev_mouse_float = prev_mouse_float.move_toward(mouse_position, 1)
				paint_rect(prev_mouse_float)
		else:
			paint_rect(mouse_position)

		texture.update(img)
	
	prev_mouse_position = mouse_position

func update_brush() -> void:
	if brush_img:
		brush_img = brush_texture.get_image()
		brush_img.resize(brush_size.x, brush_size.y)

		for x in brush_img.get_size().x:
			for y in brush_img.get_size().y:
				var cc := brush_img.get_pixel(x, y)
				brush_img.set_pixel(x, y, color * cc)

func get_mouse_position() -> Vector2i:
	return get_local_mouse_position() + Vector2(img.get_width()/2, img.get_height()/2)

func paint_rect(rect_position: Vector2i):
	img.fill_rect(Rect2i(rect_position, brush_size), color)

func paint_brush(rect_position: Vector2i):
	img.blend_rect(brush_img, brush_img.get_used_rect(), rect_position - brush_size/2)
