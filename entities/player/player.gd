extends CharacterBody2D
@export var speed = 400
var current_dir = "right"
@onready var all_interactions = []
@onready var anim = $AnimatedSprite2D
@onready var exclamation = preload("res://components/exclamation.tscn")

func _init():
	print(SceneManager.player_x_pos)
	global_position.x = SceneManager.player_x_pos
	print(global_position.x)
	global_position.y = SceneManager.player_y_pos
	
func _ready():
	print(SceneManager.player_x_pos)
	global_position.x = SceneManager.player_x_pos
	print(global_position.x)
	global_position.y = SceneManager.player_y_pos

func movement():
	if !GameManager.allowMovement:
		anim.play("default")
		velocity.x = 0
	else:
		if Input.is_action_pressed("go_right"):
			anim.play("walk")
			anim.flip_h = true
			current_dir = "right"
			velocity.x = speed;
		elif Input.is_action_pressed("go_left"):
			anim.play("walk")
			anim.flip_h = false
			current_dir = "left"
			velocity.x = -speed
		else:
			anim.play("default")
			velocity.x = 0
	move_and_slide()

func _physics_process(delta):
	if Input.is_action_just_pressed("start_dialogue"):
		execute_interaction()
	if Input.is_action_just_pressed("pick_up_drop") and !DialogueManager.is_dialogue_active:
		execute_pickup()
	movement()
	
func _on_interaction_area_area_entered(area):
	var object = area.get_parent()
	if(object.is_in_group("interactable")):
		all_interactions.insert(0, area)
		exclamation.instantiate()

func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)

func execute_interaction():
	if all_interactions:
		var cur_interaction = all_interactions[0]
		var interactable = cur_interaction.get_parent()
		DialogueManager.start_dialog(interactable, false)

func execute_pickup():
	if all_interactions:
		var cur_interaction = all_interactions[0]
		var interactable = cur_interaction.get_parent()
		if interactable.is_in_group("pickupable"):
			interactable.queue_free()
			GameManager.set_holding(interactable.item)
			DialogueManager.hide_exclamation()
		elif (interactable.is_in_group("interactable") && GameManager.currently_holding != GameManager.Pickupable.NOTHING):
			DialogueManager.start_dialog(interactable, true)
	else:
		GameManager.set_holding(GameManager.Pickupable.NOTHING)
		print(GameManager.currently_holding)

