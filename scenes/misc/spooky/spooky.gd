extends Node2D

# Get objects in the "spooky" scene
@onready var animation_player = $AnimationPlayer
@onready var label = $ColorRect/Label

var anim_playing:bool = false
var count = 0 # line count

var lines = [
	"hello world (press enter or space)",
	"how do i write this without taking myself too seriously and being haughty",
	"when you wake up you'll learn that.....",
	"when you move around, you see more",
	"as a young boy once wrote trying to write a story about cats in the woods in his purple composition notebook.",
	"he was trying to describe the thought process of a newborn cat",
	"it was kind of stupid. he was 9 years old, give him a break",
	"he's here today trying to write the same thing, a cat being born",
	"cats in the woods",
	"who knows why"
]

func _ready():
	label.text = lines[count]
	animation_player.speed_scale = 1 / (lines[count].length() * 0.1) # adjust speed of typing each letter based on length of text
	animation_player.play("text")

func _process(_delta):
	pass

# when interact key is pressed, show next line of dialogue
func _unhandled_input(event):
	if(event.is_action_pressed("interact")):
		if !(count >= lines.size() - 1):
			if label.visible_ratio == 1: # if all text is shown
				animation_player.stop()
				count += 1
				label.text = lines[count]
				animation_player.speed_scale = 1 / (lines[count].length() * 0.1) # adjust speed of typing each letter based on length of text
				animation_player.play("text")
			else: # if not all text is shown, stop typing animation and show the entire text
				animation_player.stop()
				label.visible_ratio = 1
		else:
			DayNightTimer.start(60)
			SceneManager.go_to_scene("res://scenes/world/rockden.tscn", null, 1000, 480)


