extends Node

# singleton which has data of the game that needs to be stored from scene to scene. Currently just stores
# what item the player is holding 

enum Pickupable {FLOWER, NOTHING, THEPINKCAT, STRANGE_FLOWER}
var currently_holding: Pickupable = Pickupable.NOTHING
var allowMovement:bool = true
signal show_currently_holding(item)

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func set_holding(item:Pickupable):
	currently_holding = item
	emit_signal("show_currently_holding", Pickupable.keys()[item])
