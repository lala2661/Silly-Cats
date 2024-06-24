# Text on screen that shows what object the player just picked up
extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 0)
	GameManager.show_currently_holding.connect(_show_currently_holding)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _show_currently_holding(item):
	var tween = get_tree().create_tween()
	text = "currently holding " + item.replace("_", " ") # replace underscores in name of item with space
	visible = true
	# fades in and out by changing opacity
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 1)
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 1)

	


