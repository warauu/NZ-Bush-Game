# -----
# tool
# classname
# extends
extends Node
# docstring
# ----Variables-------
# signals
# enums
# constants
# exported
# public
var exterminated_count:int
#var thanks_for_playing:
# private
# onready
# ------Main------------
# init
# _ready
# _methods
# public methods
# private methods
func increase_counter() -> void:
	$TopLayer/CanvasLayer/Label/Label.text = str(exterminated_count)
	if exterminated_count == 9:
		$TopLayer/CanvasLayer/Label/Label.text = "You found them all!"
