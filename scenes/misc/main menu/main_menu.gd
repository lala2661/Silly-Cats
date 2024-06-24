extends Control

signal game_started

# get settings object
@onready var settings = $Settings

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_play_pressed():
	emit_signal("game_started")
	SceneManager.go_to_non_game_scene("res://scenes/misc/spooky/spooky.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_settings_pressed():
	settings.visible = true
