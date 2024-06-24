# a coloured overlay to show the time of day which wasn't implemented
extends CanvasModulate

var colour_sunrise: Color = Color(221,169,179)
var colour_noon: Color =  Color(232,235,234)
var colour_afternoon: Color = Color.hex(0xe7ebeb)
var colour_sundown: Color = Color.hex(0xe7ebeb)
var colour_evening: Color = Color.hex(0xe7ebeb)
var colour_midnight: Color  = Color.hex(0xe7ebeb)


var num_to_colour: Array = [
	colour_sunrise,
	colour_noon,
	colour_afternoon,
	colour_sundown,
	colour_evening,
	colour_midnight
]

func _ready():
	DayNightTimer.timeout.connect(change_light)
	color = num_to_colour[DayNightTimer.num_time_of_day]
	
	
func change_light():
	color = num_to_colour[DayNightTimer.num_time_of_day]
