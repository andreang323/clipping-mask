extends Control

var game_file = load("res://objects/main_scene.tscn")
@export var start_button : TextureButton
@export var settings_button : TextureButton
@export var quit_button : TextureButton

func _ready() -> void:
	$SettingsScreen.hide()

## Starts the game.
func _on_start_button_pressed() -> void:
	$Button3.play()
	$MinimalistVibes.stop()
	$SleepingIn.play()
	$SettingsScreen.game_ready()
	var game_start = game_file.instantiate()
	add_child(game_start)
	$TitleScreen.hide()

## Shows the settings menu.
func _on_settings_button_pressed() -> void:
	$Button3.play()
	$SettingsScreen.show()

## Quits the game.
func _on_quit_button_pressed() -> void:
	get_tree().quit()

# Draw button logic

func _on_start_button_draw() -> void:
	if start_button.get_draw_mode() == 2:
		start_button.get_node("AnimatedSprite2D").play("default")
	elif start_button.get_draw_mode() == 1:
		start_button.get_node("AnimatedSprite2D").pause()
		var frame = start_button.get_node("AnimatedSprite2D").frame
		start_button.get_node("AnimatedSprite2D").play("pressed")
		start_button.get_node("AnimatedSprite2D").pause()
		start_button.get_node("AnimatedSprite2D").frame = frame
	else:
		var frame = start_button.get_node("AnimatedSprite2D").frame
		start_button.get_node("AnimatedSprite2D").play("default")
		start_button.get_node("AnimatedSprite2D").pause()
		start_button.get_node("AnimatedSprite2D").frame = frame


func _on_settings_button_draw() -> void:
	if settings_button.get_draw_mode() == 2:
		settings_button.get_node("AnimatedSprite2D").play("default")
	elif settings_button.get_draw_mode() == 1:
		settings_button.get_node("AnimatedSprite2D").pause()
		var frame = settings_button.get_node("AnimatedSprite2D").frame
		settings_button.get_node("AnimatedSprite2D").play("pressed")
		settings_button.get_node("AnimatedSprite2D").pause()
		settings_button.get_node("AnimatedSprite2D").frame = frame
	else:
		var frame = settings_button.get_node("AnimatedSprite2D").frame
		settings_button.get_node("AnimatedSprite2D").play("default")
		settings_button.get_node("AnimatedSprite2D").pause()
		settings_button.get_node("AnimatedSprite2D").frame = frame


func _on_quit_button_draw() -> void:
	if quit_button.get_draw_mode() == 2:
		quit_button.get_node("AnimatedSprite2D").play("default")
	elif quit_button.get_draw_mode() == 1:
		quit_button.get_node("AnimatedSprite2D").pause()
		var frame = quit_button.get_node("AnimatedSprite2D").frame
		quit_button.get_node("AnimatedSprite2D").play("pressed")
		quit_button.get_node("AnimatedSprite2D").pause()
		quit_button.get_node("AnimatedSprite2D").frame = frame
	else:
		var frame = quit_button.get_node("AnimatedSprite2D").frame
		quit_button.get_node("AnimatedSprite2D").play("default")
		quit_button.get_node("AnimatedSprite2D").pause()
		quit_button.get_node("AnimatedSprite2D").frame = frame
