extends Room

var post_light = load("res://levels/room1/sprites/image1.png")
var opened_chest = load("res://levels/room1/sprites/image2.png")
var secret = load("res://levels/room1/sprites/lightbulb_secret_passage_reveal.png")


func _on_light_checker_color_received(color: ColorDrag.COLORTYPES) -> void:
	if color == ColorDrag.COLORTYPES.YELLOW:
		GlobalFlags.room1_data.lightbulb_filled = true
		$Moon.disable()
		$LightChecker.monitoring = false
		$Background.texture = post_light
		#await get_tree().create_timer(1).timeout
		#open_chest()

func open_chest():
	$Background.texture = opened_chest
	$GemChecker.process_mode = Node.PROCESS_MODE_PAUSABLE

func _on_gem_checker_color_received(color: Receiver.COLORTYPES) -> void:
	if color == ColorDrag.COLORTYPES.BLUE:
		$Background.texture = secret
