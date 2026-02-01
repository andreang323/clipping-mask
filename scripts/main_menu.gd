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

# Draw button logic

func _on_start_button_draw() -> void:
	if $TitleScreen/Container/Buttons/StartButton.get_draw_mode() == 2:
		$TitleScreen/Container/Buttons/StartButton/AnimatedSprite2D.play("default")
	elif $TitleScreen/Container/Buttons/StartButton.get_draw_mode() == 1:
		$TitleScreen/Container/Buttons/StartButton/AnimatedSprite2D.pause()
		var frame = $TitleScreen/Container/Buttons/StartButton/AnimatedSprite2D.frame
		$TitleScreen/Container/Buttons/StartButton/AnimatedSprite2D.play("pressed")
		$TitleScreen/Container/Buttons/StartButton/AnimatedSprite2D.pause()
		$TitleScreen/Container/Buttons/StartButton/AnimatedSprite2D.frame = frame
	else:
		var frame = $TitleScreen/Container/Buttons/StartButton/AnimatedSprite2D.frame
		$TitleScreen/Container/Buttons/StartButton/AnimatedSprite2D.play("default")
		$TitleScreen/Container/Buttons/StartButton/AnimatedSprite2D.pause()
		$TitleScreen/Container/Buttons/StartButton/AnimatedSprite2D.frame = frame


func _on_settings_button_draw() -> void:
	if $TitleScreen/Container/Buttons/SettingsButton.get_draw_mode() == 2:
		$TitleScreen/Container/Buttons/SettingsButton/AnimatedSprite2D.play("default")
	elif $TitleScreen/Container/Buttons/SettingsButton.get_draw_mode() == 1:
		$TitleScreen/Container/Buttons/SettingsButton/AnimatedSprite2D.pause()
		var frame = $TitleScreen/Container/Buttons/SettingsButton/AnimatedSprite2D.frame
		$TitleScreen/Container/Buttons/SettingsButton/AnimatedSprite2D.play("pressed")
		$TitleScreen/Container/Buttons/SettingsButton/AnimatedSprite2D.pause()
		$TitleScreen/Container/Buttons/SettingsButton/AnimatedSprite2D.frame = frame
	else:
		var frame = $TitleScreen/Container/Buttons/SettingsButton/AnimatedSprite2D.frame
		$TitleScreen/Container/Buttons/SettingsButton/AnimatedSprite2D.play("default")
		$TitleScreen/Container/Buttons/SettingsButton/AnimatedSprite2D.pause()
		$TitleScreen/Container/Buttons/SettingsButton/AnimatedSprite2D.frame = frame


func _on_quit_button_draw() -> void:
	if $TitleScreen/Container/Buttons/QuitButton.get_draw_mode() == 2:
		$TitleScreen/Container/Buttons/QuitButton/AnimatedSprite2D.play("default")
	elif $TitleScreen/Container/Buttons/QuitButton.get_draw_mode() == 1:
		$TitleScreen/Container/Buttons/QuitButton/AnimatedSprite2D.pause()
		var frame = $TitleScreen/Container/Buttons/QuitButton/AnimatedSprite2D.frame
		$TitleScreen/Container/Buttons/QuitButton/AnimatedSprite2D.play("pressed")
		$TitleScreen/Container/Buttons/QuitButton/AnimatedSprite2D.pause()
		$TitleScreen/Container/Buttons/QuitButton/AnimatedSprite2D.frame = frame
	else:
		var frame = $TitleScreen/Container/Buttons/QuitButton/AnimatedSprite2D.frame
		$TitleScreen/Container/Buttons/QuitButton/AnimatedSprite2D.play("default")
		$TitleScreen/Container/Buttons/QuitButton/AnimatedSprite2D.pause()
		$TitleScreen/Container/Buttons/QuitButton/AnimatedSprite2D.frame = frame
