extends Node

var current_scene = null
var player_x_pos = 1000
var player_y_pos = 480

signal game_begin

# at start of the game get the initial scene
func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count()-1)
	
# "non-game scene" is a scene like main menu or the intro text scene where there isn't a player so the player
# x and y pos shouldn't be set
func go_to_non_game_scene(scene):
	call_deferred("deferred_go_to_scene", scene)

# go to scene and place player based on what edge of the scene they left from
func go_to_scene(scene, edge, x_pos, y_pos):
	if(edge != null):
		match edge.name :
			"LeftEdge":
				player_x_pos = 1700
			"RightEdge":
				player_x_pos = 100
			_:
				player_x_pos = x_pos
				player_y_pos = y_pos
	else:
		player_x_pos = x_pos
		player_y_pos = y_pos
			
	call_deferred("deferred_go_to_scene", scene)

# goes to scene, call_deferred waits until the engine is idle and all processes are done
# which is important when changing scenes
func deferred_go_to_scene(scene):
	if is_instance_valid(current_scene):
		var prev_scene = current_scene
		current_scene.queue_free()
		current_scene = null
		var s = ResourceLoader.load(scene)
		print(scene)
		current_scene = s.instantiate()
		get_tree().root.add_child(current_scene)
		if prev_scene.scene_file_path == "res://scenes/misc/spooky/spooky.tscn":
			emit_signal("game_begin") # start day night cycle and other start of game events
		

