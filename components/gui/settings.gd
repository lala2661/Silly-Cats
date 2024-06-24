extends Control

@onready var exit = $NinePatchRect/MarginContainer/Exit

func _ready():
	# if the scene is the main menu show the "exit" button to hide the settings menu since there's no 
	# top bar to do it
	if(SceneManager.current_scene.scene_file_path != "res://scenes/misc/main menu/main_menu2.tscn"):
		exit.visible = false

func _process(_delta):
	pass

func _on_volume_value_changed(value):
	AudioServer.set_bus_volume_db(1, linear_to_db(value))

func _on_exit_pressed():
	self.visible = false
