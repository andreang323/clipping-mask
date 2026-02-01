extends CanvasLayer

@onready var master = AudioServer.get_bus_index("Master")
@onready var music = AudioServer.get_bus_index("Music")
@onready var sfx = AudioServer.get_bus_index("SFX")
@export var button : AudioStreamPlayer
## Hides quit button on main menu.
func _ready() -> void:
	$SettingsMenu/Buttons/QuitButton.hide()
	load_config()
	update()

## Initialize settings screen in preparation for game.
func game_ready():
	$SettingsMenu/Buttons/QuitButton.show()

## Quits the game.
func _on_quit_button_pressed() -> void:
	get_tree().quit()

## Hides the settings menu.
func _on_back_pressed() -> void:
	if button:
		button.play()
	get_tree().paused = false # resumes game if paused
	save_config()
	hide()

## Changes master volume.
func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master, linear_to_db(value))

## Changes music volume.
func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music, linear_to_db(value))

## Changes SFX volume.
func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx, linear_to_db(value))

## Toggles fullscreen.
func _on_check_button_toggled(toggled_on: bool) -> void:
	if button:
		button.play()
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

## Updates volume sliders and fullscreen toggle.
func update():
	# Updates slider volume based on current volume.
	$SettingsMenu/HBoxContainer/Options/MasterSlider.value = db_to_linear(AudioServer.get_bus_volume_db(master))
	$SettingsMenu/HBoxContainer/Options/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(music))
	$SettingsMenu/HBoxContainer/Options/SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx))
	
	# Sets correct state of fullscreen toggle without triggering the toggle function.
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		$SettingsMenu/HBoxContainer/Options/CheckButton.set_pressed_no_signal(true)
	else:
		$SettingsMenu/HBoxContainer/Options/CheckButton.set_pressed_no_signal(false)

## Save user settings.
func save_config():
	var config = ConfigFile.new()
	
	config.set_value("Volume", "master", $SettingsMenu/HBoxContainer/Options/MasterSlider.value)
	config.set_value("Volume", "music", $SettingsMenu/HBoxContainer/Options/MusicSlider.value)
	config.set_value("Volume", "sfx", $SettingsMenu/HBoxContainer/Options/SFXSlider.value)
	
	config.set_value("Box", "Fullscreen", $SettingsMenu/HBoxContainer/Options/CheckButton.button_pressed)
	
	config.save("user://settings.cfg")

## Load user settings.
func load_config():
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	
	if err != OK:
		AudioServer.set_bus_volume_db(master, linear_to_db(1))
		AudioServer.set_bus_volume_db(music, linear_to_db(0.71))
		AudioServer.set_bus_volume_db(sfx, linear_to_db(0.71))
		$SettingsMenu/HBoxContainer/Options/CheckButton.set_pressed_no_signal(false)
		
	else:
		AudioServer.set_bus_volume_db(master, linear_to_db(config.get_value("Volume","master",1)))
		AudioServer.set_bus_volume_db(music, linear_to_db(config.get_value("Volume","music",0.71)))
		AudioServer.set_bus_volume_db(sfx, linear_to_db(config.get_value("Volume","sfx",0.71)))
		
		$SettingsMenu/HBoxContainer/Options/CheckButton.set_pressed_no_signal(config.get_value("Box","Fullscreen", false))
	
	update()

## Allows us to access the settings menu during the game by hitting escape.
func _input(event: InputEvent) -> void:
	if $SettingsMenu/Buttons/QuitButton.visible and event.is_action_pressed("ui_cancel"):
		visible = !visible
		if !visible:
			save_config()
