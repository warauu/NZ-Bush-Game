# -----

# tool

# classname

# extends
extends Area2D
# docstring

# ----Variables-------

# signals

# enums

# constants

# exported

# public

# private
const MAGNITUDE:int = 300
# onready


# ------Main------------

# init

# _ready
func _ready() -> void:
	set_as_top_level(true)
	
	
# _methods
func _process(delta: float) -> void:
	position += (Vector2.RIGHT*MAGNITUDE).rotated(rotation) * delta 
	## it will travel in the orientation the player is facing at the rate of deltatime
	
	
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()


# public methods

# private methods
func deal_damage() -> void:
	pass
