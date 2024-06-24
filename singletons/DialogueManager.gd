extends Node

# import scenes so they can be instantiated
@onready var text_box_scene = preload("res://components/textbox.tscn")
@onready var exclamation_scene = preload("res://components/exclamation.tscn")

var dialogue_lines: Array = []
var current_line_index = 0

var text_box # instance of text box
var text_box_position: Vector2

var exclamation # instance of exclamation

var is_dialogue_active = false
var can_advance_line = false

var times_talked_to = { # dictionary with npc/interactable name and times it's been 'talked' to
}

func start_dialog(interactable: Node, is_item_dropped: bool):
	if is_dialogue_active:
		return
	
	var currently_holding = GameManager.currently_holding # enum
	var str_currently_holding = GameManager.Pickupable.keys()[currently_holding] # get string of enum
	if !is_item_dropped or GameManager.currently_holding == GameManager.Pickupable.NOTHING or !interactable.dialogue_dict.keys().has(str_currently_holding)	:
		if(times_talked_to.has(interactable.name)): # count how many times an npc/interactable has been talked to
			times_talked_to[interactable.name] += 1
		else:
			times_talked_to[interactable.name] = 0
		
		var dialogue_index = times_talked_to[interactable.name]
		if dialogue_index > interactable.dialogue_dict["NOTHING"].size() - 1: #get final set of dialogue if all dialogues have been run
			dialogue_index = interactable.dialogue_dict["NOTHING"].size() - 1
		dialogue_lines = interactable.dialogue_dict["NOTHING"][dialogue_index]
	else:
		#var currently_holding = GameManager.currently_holding # enum
		GameManager.currently_holding = GameManager.Pickupable.NOTHING # drop currently held item

		#var str_currently_holding = GameManager.Pickupable.keys()[currently_holding] # get string of enum
		dialogue_lines = interactable.dialogue_dict[str_currently_holding]
		
	# set y pos of text box based on height of texture
	var sprite_height = interactable.get_node("Sprite2D").texture.get_height()
	text_box_position = interactable.global_position
	text_box_position.x -= 100
	text_box_position.y -= sprite_height - (sprite_height/2) + 30 #to prevent text box on going on sprite
	
	_show_text_box()
	
	is_dialogue_active = true;
	GameManager.allowMovement = false; # freeze player movement 
	
func _show_text_box():
	text_box = text_box_scene.instantiate()
	can_advance_line = true
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	
	if(dialogue_lines[current_line_index] is String):
		text_box.display_text(dialogue_lines[current_line_index])
	elif dialogue_lines[current_line_index] is Dictionary: # if the next set of dialogue is a dictionary, it's a choice menu
		var choices:Dictionary = dialogue_lines[current_line_index]
		can_advance_line = false
		var choice = await text_box.display_options(choices.keys()[0], choices.keys()[1]) # returns key of choice selected
		dialogue_lines = dialogue_lines[current_line_index][choice] 
		current_line_index = -1 # set the current line so that it's at the beginning of this dialogue branch
		advance_text()
		
func _unhandled_input(event):
	if(
		event.is_action_pressed("interact") && # interact button pressed
		is_dialogue_active && # dialogue is still happening
		can_advance_line
	):
		advance_text()
		
func advance_text():
	text_box.queue_free() # delete text box instance
	current_line_index += 1
	if current_line_index >= dialogue_lines.size(): # close dialogue if all lines are done
		is_dialogue_active = false
		GameManager.allowMovement = true;
		current_line_index = 0
		return
	_show_text_box()

# shows exclamation over npc based on the height of the npc's sprite, called if the player is touching an npc
func show_exclamation(npc):
	exclamation = exclamation_scene.instantiate()
	get_tree().root.add_child(exclamation)
	exclamation.global_position =  npc.global_position
	var sprite_height = npc.get_node("Sprite2D").texture.get_height()
	exclamation.global_position.y -= sprite_height - (sprite_height/2) + 30

# deletes exclamation instance, called when the player stops touching an npc
func hide_exclamation():
	if(exclamation != null):
		exclamation.queue_free()


