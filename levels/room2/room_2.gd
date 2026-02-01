extends Room

@export var needed_receivers: Array[Receiver]
@export var other_receivers: Array[Receiver]

func _ready() -> void:
    for receiver in needed_receivers:
        receiver.correct_color_received.connect(_on_correct_color_received)
    for receiver in other_receivers:
        receiver.correct_color_received.connect(_on_correct_color_received)

func _on_correct_color_received() -> void:
    for receiver in needed_receivers:
        if receiver.correct == false: return
    awaken_cat()
    for receiver in other_receivers:
        if receiver.correct == false: return
    GlobalFlags.room2_data.room_complete = true

func awaken_cat() -> void:
    GlobalFlags.room2_data.cat_awakened = true