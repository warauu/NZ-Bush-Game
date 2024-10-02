#-----

#tool

#classname

#extends
extends CharacterBody2D
#docstring
## Outlines the paramenters and rules that the player will follow when the user presses different buttons.
#----Variables-------

#signals

#enums

#constants
var magnitude:int ## power of the velocuty vector quantity when thr player moves

#exported
#public

#private
var player_movement_state:String ## the player's moevemnt animation state

var enemy_attack_range:bool = false
var enemy_attack_cooldown:bool = true
const HEALTH:int = 100
var player_is_alive:bool = true

#var bow_equipped:bool = false ## will be true if the bow is equipped
#var bow_cooldown:bool = true ## will be true if the cooldown time is finished.
#var arrow:PackedScene = load("res://Scenes/arrow.tscn")
#var mouse_location_from_player:Vector2

#onready
@onready var ANIMATE_SPRITE:AnimatedSprite2D = $AnimatedSprite2D #Animated sprite node
@onready var camera:Camera2D = $Camera2D

#------Main------------

#init

#_ready

#_methods
func _process(delta: float) -> void:
	## fetching what direction buttons the player is pressing.
	var direction:Vector2 = Input.get_vector("left", "right", "up", "down")
	
	if direction == Vector2.ZERO:
		player_movement_state = "idle"
	elif direction != Vector2.ZERO:
		player_movement_state = "walking"
		
	velocity = direction * magnitude
	
	play_anim(direction) ## run play_anim function
	
	#if Input.is_action_just_pressed("e"):
			#bow_equipped = !bow_equipped ## simple toggle system
			#print("bow")
	
	var mouse_pos = get_global_mouse_position()
	$Marker2D.look_at(mouse_pos)
	
	#if Input.is_action_just_pressed("leftMouse") && bow_equipped && bow_cooldown:
		#bow_cooldown = false
		#var arrow_instance = arrow.instantiate()
		#arrow_instance.rotation = $Marker2D.rotation
		#arrow_instance.global_position = $Marker2D.global_position
		#add_child(arrow_instance) ## create an arrow instance and place it at the marker2D
		#
		#await get_tree().create_timer(0.4).timeout
		#bow_cooldown = true
		
		
func _physics_process(delta: float) -> void: #handles calculations for player moevemnt
	move_and_slide()


func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_attack_range = true
		
func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_attack_range = true

# public methods

#private methods
func play_anim(dir) -> void: ## Access AnimatedSprite2D node and play relevant animation
	magnitude = 150
	if player_movement_state == "idle":
		ANIMATE_SPRITE.play("idle")
	if player_movement_state == "walking":
		##directional movement
		if dir == Vector2(0,-1):
			ANIMATE_SPRITE.play("nWalk")
		if dir == Vector2(1,0):
			ANIMATE_SPRITE.play("eWalk")
		if dir == Vector2(0,1):
			ANIMATE_SPRITE.play("sWalk")
		if dir == Vector2(-1,0):
			ANIMATE_SPRITE.play("wWalk")
		
		##diagonal movement
		if dir.x > 0.5 && dir.y < -0.5:
			ANIMATE_SPRITE.play("neWalk")
		if dir.x > 0.5 && dir.y > 0.5:
			ANIMATE_SPRITE.play("seWalk")
		if dir.x < -0.5 && dir.y > 0.5:
			ANIMATE_SPRITE.play("swWalk")
		if dir.x < -0.5 && dir.y < -0.5:
			ANIMATE_SPRITE.play("nwWalk")


func player() -> void:
	pass
