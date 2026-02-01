extends Room

@export var free_bird_texture: Resource
@export var free_key_texture: Resource
@export var colors: Array[ColorDrag]
@export var key_color: ColorDrag
@export var cat_cover_texture: Resource

func _ready() -> void:
	GlobalFlags.enter_room.connect(enter_room)

func enter_room(room_id_transition: int) -> void:
	if room_id == room_id_transition:
		if GlobalFlags.room2_data.cat_awakened:
			await get_tree().create_timer(.5).timeout
			$CatFallSFX.play()
			$CatAnim/Cover.visible = false
			$CatAnim/CatCloth.visible = true
			$CatAnim/AnimationPlayer.play("cat_fall")
			for color in colors:
				color.visible = true

func _on_room_complete() -> void:
	for color in colors:
		color.visible = false
	$Sprite2D.texture = free_bird_texture
	$BirdFlying.visible = true
	$BirdFlying/AnimationPlayer.play("escape")

func _on_receiver_3_color_received(_color: Receiver.COLORTYPES) -> void:
	$Sprite2D.texture = free_key_texture
	$Key.visible = true
	$Ding.play()
	$Key/AnimationPlayer.play("get_key")
	key_color.visible = false
	GlobalFlags.key_obtained.emit()
	GlobalFlags.room4_data.key_obtained = true
