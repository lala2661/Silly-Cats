extends Timer

@onready var timer:Timer = $"."
enum time_name {SUNRISE, NOON, AFTERNOON, SUNDOWN, EVENING, MIDNIGHT}

@onready var darkness = 0
@onready var num_time_of_day: int = 1 #noon


func _ready():
	pass

func _process(delta):
	pass

# called when the timer goes out, every 60 seconds
func _on_timeout():
	num_time_of_day += 1
	if(num_time_of_day == 6): #if it's past midnight, go back to sunrise
		num_time_of_day = 0
	match num_time_of_day:
		0: 
			darkness = 0.2
		1:
			darkness = 0
		2: 
			darkness = 0.1
		3: 
			darkness = 0.2
		4:
			darkness = 0.5
		5: 
			darkness = 0.6
		_:
			darkness = 1

