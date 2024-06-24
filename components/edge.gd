extends Area2D

# edge of screen, if touched change scene

@export var scene: String
@export var scene_change_x_pos: int

func _on_body_entered(body):
	if body.name == "Player" and scene != "":
		SceneManager.go_to_scene(scene, self, scene_change_x_pos, 480)
