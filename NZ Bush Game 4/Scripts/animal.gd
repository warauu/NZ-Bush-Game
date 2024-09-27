# -----
# tool
# classname
class_name Animal
# extends
extends CharacterBody2D
# docstring
## This script controls the animal dialogue calls, movement and collision
# ----Variables-------
# signals
# enums
enum STATES { ## all movement states for the animal
	IDLE,
	NEW_DIR,
	MOVE,	
}
# constants
const SPEED:int = 30 ## speed that the aninal walks at

# exported
@export var file_root:String = "res://Dialogue/worker_dialogue_1.json" ## path for the dialogue that the specific animal needs
@export var roam:bool = true ## when this is false, the animal will not move around
@export var can_exterminate:bool = false ## true: then the aninal will destroy itself after you finish a conversation with it.
@export var sprite:String = "dog" ## what image file the game will display for each individual animal
# public
# private
var player:CharacterBody2D ## variable for the player to equal when in contack with hitbox
var direction:Vector2 = Vector2.RIGHT
var start_pos:Vector2

var is_roaming:bool = true
var is_chatting:bool = false
var player_in_chat_zone:bool = false

var current_state:STATES = STATES.IDLE

var array:Array[float] = [0.5, 1, 1.5] ## the variable times it takes for the animal to change directions.
var array2:Array[STATES] = [STATES.IDLE, STATES.NEW_DIR, STATES.MOVE] ## the movement states as defined in the enum.

# onready
@onready var TIMER:Timer = $Timer


# ------Main------------
# init
# _ready
func _ready() -> void:
	randomize()
	start_pos = self.position
	
	
# _methods
func _process(delta: float) -> void:
	if current_state == 0 || current_state == 1:
		$AnimatedSprite2D.play(sprite)
	if current_state == 2 && !is_chatting:
		pass
		#if direction == Vector2(-1,0):
			##$AnimatedSprite2D.play("wWalk")
		#if direction == Vector2(1,0):
			##$AnimatedSprite2D.play("eWalk")
		#if direction == Vector2(0,-1):
			##$AnimatedSprite2D.play("nWalk")
		#if direction == Vector2(0,1):
			##$AnimatedSprite2D.play("sWalk")

	if is_roaming:
		match current_state:
			STATES.IDLE:
				pass
			STATES.NEW_DIR:
				var array:Array[Vector2] = [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]
				array.shuffle()
				direction = array.front()
			STATES.MOVE:
				move(delta)
				
	if Input.is_action_just_pressed("chat") && player_in_chat_zone:
		$"../../../TopLayer/CanvasLayer/Dialogue".start(file_root, self)
		is_roaming = false
		is_chatting = true
		$AnimatedSprite2D.play(sprite)


func _on_chat_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player = body
		player_in_chat_zone = true


func _on_chat_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_chat_zone = false
		

func _on_timer_timeout() -> void:
	if !roam:
		return
	else:
		array.shuffle()
		array2.shuffle()
		TIMER.wait_time = array.front()
		current_state = array2.front()


func _on_dialogue_dialogue_finished() -> void:
	print(can_exterminate)
	is_chatting = false
	is_roaming = true

# public methods
# private methods
	
func move(delta) -> void:
	if !is_chatting:
		velocity = direction * SPEED
		move_and_slide()
	
func exterminate_self() -> void:
	$"../../../GlobalScript".exterminated_count += 1
	self.queue_free()
	$"../../../GlobalScript".increase_counter()
	print($"../../../GlobalScript".exterminated_count)
