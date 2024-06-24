extends MarginContainer

# load objects of scene
@onready var label = $MarginContainer/RichTextLabel
@onready var timer = $LetterDisplayTimer
@onready var options_container = $MarginContainer/Options
@onready var option1button = $MarginContainer/Options/Option1
@onready var option2button = $MarginContainer/Options/Option2
@onready var option1label = $MarginContainer/Options/Option1/Option1Label
@onready var option2label = $MarginContainer/Options/Option2/Option2Label
@onready var font = label.get_theme_default_font()

const MAX_WIDTH = 256

var text = ""
var letter_index = 0

var choice
signal option_selected()
signal finished_displaying()

func _ready():
	scale = Vector2(0.7,0.7)
	DialogueManager.hide_exclamation() # hide exclamation over npc's head
	options_container.visible = false

# pop up animation for text box
func popup_anim():
	pivot_offset = Vector2(size.x/2, size.y)
	var tween = get_tree().create_tween()
	tween.tween_property(
		self, "scale", Vector2(1,1), 0.15
	).set_trans(Tween.TRANS_SINE)

func display_text(text_to_display: String):
	text =  text_to_display
	label.text =  text_to_display
	label.autowrap_mode = TextServer.AUTOWRAP_WORD
	popup_anim()

# displays choice menu
func display_options(option1text:String, option2text:String):
	option1label.text = option1text
	option2label.text = option2text
	options_container.visible = true
	popup_anim()
	await option_selected # wait until the user clicks one of the options
	return choice # return back to dialogue manager the choice that the player picked
	
func _on_option_1_pressed():
	choice = option1label.text
	option_selected.emit()

func _on_option_2_pressed():
	choice = option2label.text
	option_selected.emit()




