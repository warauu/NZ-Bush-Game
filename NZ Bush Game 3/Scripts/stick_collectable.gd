
# -----

# tool

# classname

# extends
extends StaticBody2D
# docstring

# ----Variables-------

# signals

# enums

# constants

# exported
@export var item: InvItem
# public

# private
var player = null
# onready


# ------Main------------

# init

# _ready

# _methods
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player = body
		player_collect()
		await get_tree().create_timer(0.5).timeout
		self.queue_free()
	
# public methods

# private methods
func player_collect() -> void: 
	player.collect(item)
