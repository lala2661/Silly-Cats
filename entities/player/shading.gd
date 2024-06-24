extends ColorRect

# black rectangle that covers the whole screen that changes opacity based on the time of day
func _ready():
	color = Color(0,0,0,DayNightTimer.darkness)
	DayNightTimer.timeout.connect(change_light)

func _process(delta):
	pass

func change_light():
	color = Color(0,0,0, DayNightTimer.darkness)
