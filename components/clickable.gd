extends Area2D

# clickable way to change scene, for cave entrance for example

var mouse:bool = false;
@export var scene: String
@export var scene_change_x_pos: int

func _ready():
	pass

func _process(delta):
	if Input.is_mouse_button_pressed(1) && mouse:
		mouse = false
		SceneManager.go_to_scene(scene, self, scene_change_x_pos, 480)

func _on_mouse_entered():
	mouse = true

func _on_mouse_exited():
	mouse = false
	
