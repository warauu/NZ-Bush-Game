# -----

# tool

# classname

# extends
extends CharacterBody2D
# docstring

# ----Variables-------

# signals

# enums
enum STATES {
	IDLE,
	NEW_DIR,
	MOVE,	
}
# constants
const SPEED:int = 30

# exported
@export var file_root:String
@export var roam:bool = true
# public

# private
var player:CharacterBody2D
var direction:Vector2 = Vector2.RIGHT
var start_pos:Vector2


var is_roaming:bool = true
var is_chatting:bool = false

var player_in_chat_zone:bool = false

var current_state:STATES = STATES.IDLE

var array:Array[float] = [0.5, 1, 1.5]
var array2:Array[STATES] = [STATES.IDLE, STATES.NEW_DIR, STATES.MOVE]

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
		$AnimatedSprite2D.play("idle")
	if current_state == 2 && !is_chatting:
		if direction == Vector2(-1,0):
			$AnimatedSprite2D.play("wWalk")
		if direction == Vector2(1,0):
			$AnimatedSprite2D.play("eWalk")
		if direction == Vector2(0,-1):
			$AnimatedSprite2D.play("nWalk")
		if direction == Vector2(0,1):
			$AnimatedSprite2D.play("sWalk")
		
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
		print("chatting with npc")
		$"../../TopLayer/CanvasLayer/Dialogue".start(file_root)
		is_roaming = false
		is_chatting = true
		$AnimatedSprite2D.play("idle")

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
	is_chatting = false
	is_roaming = true
	if name == "Idiot":
		self.queue_free()
	if name == "Bro":
		$"../../../TopLayer/CanvasLayer/ThanksforPlaying!".visible = true
	if name == "TouristNpc":
		$"../../../TopLayer/CanvasLayer/Label".visible = true

# public methods

# private methods
	
func move(delta) -> void:
	if !is_chatting:
		velocity = direction * SPEED
		move_and_slide()
