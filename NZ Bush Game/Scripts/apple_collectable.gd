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

# public

# private

# onready


# ------Main------------

# init

# _ready
func _ready() -> void:
	fall_from_tree()
# _methods

# public methods

# private methods
func fall_from_tree() -> void:
	$AnimationPlayer.play("appleDrop")
	await get_tree().create_timer(1.5).timeout
	$AnimationPlayer.play("fade")
	await get_tree().create_timer(0.5).timeout
	queue_free() ## self
	print("+ 1 Apples")
