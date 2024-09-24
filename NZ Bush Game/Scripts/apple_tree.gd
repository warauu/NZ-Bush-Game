# -----

# tool

# classname

# extends
extends Node2D
# docstring

# ----Variables-------

# signals

# enums

# constants

# exported
@export var item:InvItem
# public

# private
var player = null

var apples:bool = true  ## false = no apples, true = apples
var player_in_area:bool = false
# onready
@onready var apple_scene:PackedScene = load("res://Scenes/apple_collectable.tscn")

# ------Main------------

# init

# _ready
func _ready() -> void:
	pass
		
# _methods
func _process(delta: float) -> void:
	if apples == false:
		$AnimatedSprite2D.play("noApples")
	else:
		$AnimatedSprite2D.play("apples")
		if player_in_area:
			if Input.is_action_pressed("e"):
				apples = false
				drop_apple()

func _on_pickable_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"): ## literally checks if the body has a function called 'player'
		player_in_area = true
		player = body


func _on_pickable_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
		
		
func _on_growth_timer_timeout() -> void:
	if apples == false: ## not neccessary, but harmless precaution
		apples = true

# public methods

# private methods
func drop_apple() -> void:
	var apple_instance = apple_scene.instantiate()
	apple_instance.global_position = $Marker2D.global_position 
	get_parent().add_child(apple_instance)
	player.collect(item)
	await get_tree().create_timer(0.5).timeout
	## until the following is completed, the rest of the script in this function will not happen.
	$GrowthTimer.start()
