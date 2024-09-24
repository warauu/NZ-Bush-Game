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
@export var DUST_PARTICLES:Array[GPUParticles2D] = [null, null]
@export var player:CharacterBody2D

# public

# private
var bush_cutscene:bool = false
var has_player_entered_area:bool = false
var is_path_following:bool = false

# onready
@onready var ANIMATION_PLAYER:AnimationPlayer = $AnimationPlayer
@onready var CAMERA1:Camera2D = $OpeningCutscene/Camera2D
@onready var CAMERA2:Camera2D = $BushCutscene/Path2D/PathFollow2D/Camera2D

# ------Main------------

# init

# _ready
func _ready() -> void:
	player.camera.enabled = false
	CAMERA2.enabled = false
	CAMERA1.enabled = true
	$Main.visible = false
	$OpeningCutscene.visible = true
	animation_cars()
	
# _methods

func _physics_process(delta: float) -> void:
	if bush_cutscene:
		var path_follower:PathFollow2D = $BushCutscene/Path2D/PathFollow2D
		
		if is_path_following:
			path_follower.progress_ratio += 0.002
			
			if path_follower.progress_ratio >= 1:
				cutscene_end()

func _on_player_detection_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.has_method("player"):
		if !has_player_entered_area:
			has_player_entered_area = true
			cutscene_bush1()
# public methods

# private methods
func cutscene_bush1() -> void:
	bush_cutscene = true
	player.camera.enabled = false
	CAMERA2.enabled = true
	ANIMATION_PLAYER.play("cover_fade")
	is_path_following = true
	#await get_tree().create_timer(2).timeout 
	$BushCutscene/ColorRect.queue_free()
	
func cutscene_end() -> void:
	is_path_following = false
	await get_tree().create_timer(1.25).timeout 
	bush_cutscene = false
	CAMERA2.enabled = false
	player.camera.enabled = true
	$BushCutscene.queue_free()

func dust_particle_toggle() -> void:
	for i:GPUParticles2D in DUST_PARTICLES:
		i.amount = 30
		i.emitting = !i.emitting

func animation_cars() -> void:
	dust_particle_toggle()
	ANIMATION_PLAYER.play("car_driving")
	await get_tree().create_timer(6).timeout 
	## The script will continue as the animation is playing.
	## so you need to set the amount of time to wait to let it fully play.
	$OpeningCutscene.queue_free()
	dust_particle_toggle()	
	$Main.visible = true
	CAMERA1.enabled = false
	player.camera.enabled = true
	
func animation_characters() -> void:
	pass
