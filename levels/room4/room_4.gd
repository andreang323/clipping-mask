extends Room

@export var free_bird_texture: Resource
@export var free_key_texture: Resource
@export var colors: Array[ColorDrag]
@export var key_color: ColorDrag

func _on_room_complete() -> void:
	for color in colors:
		color.visible = false
	$Sprite2D.texture = free_bird_texture
	$BirdFlying.visible = true
	$BirdFlying/AnimationPlayer.play("escape")

func _on_receiver_3_color_received(_color: Receiver.COLORTYPES) -> void:
	$Sprite2D.texture = free_key_texture
	$Key.visible = true
	$Key/AnimationPlayer.play("get_key")
	key_color.visible = false
	GlobalFlags.key_obtained.emit()
	GlobalFlags.room4_data.key_obtained = true
