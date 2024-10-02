# -----
# tool
# classname
# extends
extends Node
# docstring
## This is an essential script and is not a ‘global variable’, it is an essential manager script.
# ----Variables-------
# signals
# enums
# constants
# exported
@export var player:CharacterBody2D

@export var thanks_for_playing:ColorRect
@export var exterminate_background:ColorRect
@export var collected_num:Label
@export var dialogue:NinePatchRect
@export var objective_label:Label
@export var location_label:Label

@export var popup_label:Label

@export var images:HBoxContainer
@export var labels:HBoxContainer
# public
# private
var exterminated_count:int
var talked_to_bob:bool = false

# onready
# ------Main------------
# init
# _ready
# _methods
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		objective_label.text = "Exterminate at least 4 pests!"
		location_label.text = "Location: Taniwha Trail Bush"
	
	
func _on_carpark_entrance_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		objective_label.text = "Exterminate at least 4 pests in bush area! (Not in carpark)"
		location_label.text = "Location: Taniwha Trail Carpark Area"
		if !talked_to_bob:
			popup_label.text = "Wait!\nTalk to Bob before entering the bush area!"
			popup_label.visible = true
		
		
		
func _on_button_pressed() -> void:
	popup_label.visible = false


# public methods
# private methods
func increase_counter() -> void:
	collected_num.text = "Pests found: " + str(exterminated_count)
	print(exterminated_count)
	if exterminated_count == 4:
		popup_label.text = "Well done!\nYou have found 4 pests.\n\nNext:\nlocate the marked trail to meet Bob."
		popup_label.visible = true
		await get_tree().create_timer(1).timeout
		objective_label.text = "Follow the trail in the bush to find and then talk to Bob!"
	elif exterminated_count == 9:
		print("Found all")
		collected_num.text = "Pests found: You've found them all!"



func function_global(code:int) -> void:
	if code == 1: ## when you talk to the caretaker at the end of the trail
		print("make thanks for playing visible")
		if exterminated_count == 9:
			print("9")
			dialogue.start("res://Dialogue/tourguide_3.json", null)
			await get_tree().create_timer(2).timeout
			player.visible = false
			thanks_for_playing.visible = true
		elif exterminated_count >= 0 && exterminated_count <= 3:
			print("0-3")
			dialogue.start("res://Dialogue/tourguide_4.json", null)
		elif exterminated_count >= 4:
			print("4-8")
			dialogue.start("res://Dialogue/tourguide_5.json", null)
			await get_tree().create_timer(2).timeout
			player.visible = false
			thanks_for_playing.visible = true
	if code == 2: ## When you talk to the caretaker in the carpark
		print("make collected num")
		exterminate_background.visible = true
		objective_label.text = "talk to birds around carpark area first, then enter the bush when you are ready"
		$"../Bush/Colliders/EnemyWall".set_collision_mask_value(1, false)
		$"../Bush/Colliders/EnemyWall".set_collision_layer_value(1, false)
		talked_to_bob = true
	if code == 3: ## when you talk to the person who is irresposibly with their dog.
		exterminated_count += 1
		increase_counter()
	if code == 4: ## cats
		go_through_node("cat")
	if code == 5: ## humans
		go_through_node("person")
	if code == 6: ## hedgehogs
		go_through_node("hedgehog")
	if code == 7: ## rodents
		go_through_node("rodent")

func go_through_node(pest_name:String) -> void:
	for i in images.get_children():
		if i is TextureRect:
			if i.name == pest_name:
				i.visible = true
				print("check")
	for i in labels.get_children():
		if i is Label && i.name == pest_name:
			i.visible = true
