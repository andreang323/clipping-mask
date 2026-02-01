extends Room

@export var background: Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	room_size = background.texture.get_size()


func _on_light_checker_color_received(color: ColorDrag.COLORTYPES) -> void:
	if color == ColorDrag.COLORTYPES.YELLOW:
		GlobalFlags.room1_data.lightbulb_filled = true
