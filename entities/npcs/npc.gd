extends Node2D

@onready var mouse_in = false

signal show_exclamation

# preload exclamation "scene" so it can be instantiated
@onready var exclamation_scene = preload("res://components/exclamation.tscn")

# variables that can be changed in the inspector
@export var item: GameManager.Pickupable # item that is picked up when picking up the "npc" (this class is also used for interactables, like flowers)
@export var dialogue_json:JSON

var exclamation
var dialogue_dict  #where dialogue is stored in a dictionary

func _ready():
	dialogue_dict = load_json_file()
	
# when player enters hitbox, show exclamation over npc's head
func _on_area_2d_body_entered(body):
	if visible:
		DialogueManager.show_exclamation(self)

# when player leaves hitbox, hide exclamation over npc's head
func _on_area_2d_body_exited(body):
	DialogueManager.hide_exclamation()
	
# load dialogue json file and return dictionary
func load_json_file():
	if dialogue_json != null:
		if dialogue_json.data is Dictionary:
			return dialogue_json.data
		else:
			print("parsed result is not dictionary")
	else:
		print("json is null")

