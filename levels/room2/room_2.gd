extends Room

@export var needed_receivers: Array[Receiver]
@export var other_receivers: Array[Receiver]
@onready var cat_animation_player: AnimationPlayer = get_node("Cat/AnimationPlayer")

func _ready() -> void:
	for receiver in needed_receivers:
		receiver.color_received.connect(_on_correct_color_received)
	for receiver in other_receivers:
		receiver.color_received.connect(_on_correct_color_received)
	cat_animation_player.play("sleep")

func _on_correct_color_received(_id) -> void:
	for receiver in needed_receivers:
		if receiver.correct == false: return
	awaken_cat()
	for receiver in other_receivers:
		if receiver.correct == false: return
	GlobalFlags.room2_data.room_complete = true

func awaken_cat() -> void:
	GlobalFlags.room2_data.cat_awakened = true
	$CatSFX.play()
	cat_animation_player.play("spooked")
