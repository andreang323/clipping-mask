extends Room

@export var free_bird_texture: Resource
@export var free_key_texture: Resource
@export var free_bird_yes_key_texture: Resource
@export var colors: Array[ColorDrag]
@export var key_color: ColorDrag
@export var cat_cover_texture: Resource
@export var bird_receivers: Array[Receiver]

var bird_free: bool = false
var key_free: bool = false

func _ready() -> void:
	GlobalFlags.enter_room.connect(enter_room)
	for receiver in bird_receivers:
		receiver.color_received.connect(_on_bird_complete)

func enter_room(room_id_transition: int) -> void:
	if room_id == room_id_transition:
		if GlobalFlags.room4_data.cat_anim_played:
			return
		if GlobalFlags.room2_data.cat_awakened:
			for color in colors:
				color.visible = true
			$CatAnim/AnimationPlayer.play("cat_fall_reset")
			await get_tree().create_timer(.5).timeout
			$CatFallSFX.play()
			$CatAnim/Cover.visible = false
			$CatAnim/CatCloth.visible = true
			$CatAnim/AnimationPlayer.play("cat_fall")
			GlobalFlags.room4_data.cat_anim_played = true

func _on_bird_complete(_color) -> void:
	if !bird_free:
		for receiver in bird_receivers:
			if !receiver.correct:
				return
		
		for colordrag in get_tree().get_nodes_in_group("Colors"):
			if colordrag.name != "ColorKey":
				colordrag.hide()
				
		bird_free = true
		$BirdFlying.visible = true
		$BirdFlying/AnimationPlayer.play("escape")

		if key_free:
			$Sprite2D.texture = free_bird_texture
		else:
			$Sprite2D.texture = free_bird_yes_key_texture

func _on_receiver_key_color_received(_color: Receiver.COLORTYPES) -> void:
	if !key_free:
		key_free = true
		$Key.visible = true
		$Ding.play()
		$Key/AnimationPlayer.play("get_key")
		key_color.visible = false
		GlobalFlags.key_obtained.emit()
		GlobalFlags.room4_data.key_obtained = true

		if bird_free:
			$Sprite2D.texture = free_bird_texture
		else:
			$Sprite2D.texture = free_key_texture
		
