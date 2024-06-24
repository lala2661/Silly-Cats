# top bar with map, settings, paused, and instructions buttons
extends Control

@onready var map = $Map
@onready var settings = $Settings
@onready var paused = $Paused
@onready var help = $Instructions

enum States {PAUSE, MAP, HELP, SETTINGS, NOTHING}
@onready var showing: Object = null

func _ready():
	SceneManager.game_begin.connect(_on_help_pressed)


func _process(delta):
	pass

func what_the_scallop():
	print("what the scallop")

func _on_map_pressed():
	toggle_panel(map, States.MAP)

func _on_settings_pressed():
	toggle_panel(settings, States.SETTINGS)
	
func _on_help_pressed():
	toggle_panel(help, States.HELP)


func _on_pause_pressed():
	toggle_panel(paused, States.PAUSE)
	DayNightTimer.paused = true
	
func _on_unpause_button_pressed():
	toggle_panel(paused, States.PAUSE)
	DayNightTimer.paused = false
	
func _on_quit_button_pressed():
	get_tree().quit()
	
#toggles showing or hiding a panel
func toggle_panel(panel, state:States): 
	if(showing == null):
		GameManager.allowMovement = false # turn off player movement
		panel.visible = true
		showing = panel
	elif(showing == panel):
		if(!DialogueManager.is_dialogue_active):
			GameManager.allowMovement = true 
		panel.visible = false
		showing = null
	else:
		showing.visible = false
		panel.visible = true
		showing = panel







