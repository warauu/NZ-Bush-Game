# -----

# tool

# classname

# extends
extends CharacterBody2D
# docstring

# ----Variables-------

# signals

# enums

# constants
var MAGNITUDE = 50
# exported
@export var item_resource: InvItem
# public

# private
var health:int = 100
var dead:bool = false
var player_in_area:bool = false
var player:CharacterBody2D
# onready
@onready var enemy = $SlimeCollectable

# ------Main------------

# init

# _ready
func _ready() -> void:
	dead = false
	
# _methods
func _physics_process(delta: float) -> void:
	if !dead:
		$DetectionArea/CollisionShape2D.disabled = false
		if player_in_area:
			position += (player.position - self.position) / MAGNITUDE
			$AnimatedSprite2D.play("move")
		else:
			$AnimatedSprite2D.play("idle")
	else:
		$DetectionArea/CollisionShape2D.disabled = true
		
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		player = body

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
		
func _on_hit_box_area_entered(area: Area2D) -> void:
	var damage:int
	if area.has_method("deal_damage"):
		damage = 50
		take_damage(damage)


func _on_slime_collect_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player = body

# public methods

# private methods
func take_damage(damage) -> void:
	health = health - damage
	if health <= 0 && !dead:
		death()
		
func death() -> void:
	dead = true
	$AnimatedSprite2D.play("death")
	await get_tree().create_timer(1).timeout
	drop_slime()
	
	$AnimatedSprite2D.visible = false
	$HitBox/CollisionShape2D.disabled = true
	$DetectionArea/CollisionShape2D.disabled = true
	
	
func drop_slime() -> void:
	enemy.visible = true
	$SlimeCollectArea/CollisionShape2D.disabled = false
	enemy_collect()
	
func enemy_collect() -> void:
	await get_tree().create_timer(1.5).timeout
	enemy.visible = false
	player.collect(item_resource)
	queue_free()
