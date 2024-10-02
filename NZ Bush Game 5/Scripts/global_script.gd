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
@export var thanks_for_playing:ColorRect
@export var exterminate_background:ColorRect
@export var collected_num:Label
@export var player:CharacterBody2D
@export var dialogue:NinePatchRect
@export var objective_text:Label
@export var images:HBoxContainer
@export var labels:HBoxContainer
# public
var exterminated_count:int
# private
# onready
# ------Main------------
# init
# _ready
# _methods
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		objective_text.text = "Exterminate at least 4 pests!"
	
# public methods
# private methods
func increase_counter() -> void:
	collected_num.text = str(exterminated_count)
	print(exterminated_count)
	if exterminated_count == 9:
		print("Found all")
		collected_num.text = "You found them all!"


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
		objective_text.text = "After you have talked to the birds, make your way to the bush!"
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
		if i is TextureRect && i.name == pest_name:
			i.visible = true
	for i in labels.get_children():
		if i is Label && i.name == pest_name:
			i.visible = true
