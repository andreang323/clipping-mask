extends Control

var game_file = load("res://objects/main_scene.tscn")

func _ready() -> void:
	$SettingsScreen.hide()

## Starts the game.
func _on_start_button_pressed() -> void:
	$SettingsScreen.game_ready()
	var game_start = game_file.instantiate()
	add_child(game_start)
	$TitleScreen.hide()

## Shows the settings menu.
func _on_settings_button_pressed() -> void:
	$SettingsScreen.show()

## Quits the game.
func _on_quit_button_pressed() -> void:
	get_tree().quit()
