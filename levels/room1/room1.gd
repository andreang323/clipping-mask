extends Room

@export var moon_area: Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_light_checker_area_entered(area: Area2D) -> void:
	if area == moon_area:
		GlobalFlags.room1_data.lightbulb_filled = true
