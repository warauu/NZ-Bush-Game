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
# public
var exterminated_count:int
# private
# onready
# ------Main------------
# init
# _ready
# _methods
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
			player.visible = false
			thanks_for_playing.visible = true
		elif exterminated_count >= 0 && exterminated_count <= 4:
			print("0-4")
			dialogue.start("res://Dialogue/tourguide_4.json", null)
		elif exterminated_count >= 5:
			print("5-8")
			dialogue.start("res://Dialogue/tourguide_5.json", null)
			player.visible = false
			thanks_for_playing.visible = true
	if code == 2: ## When you talk to the caretaker in the carpark
		print("make collected num")
		exterminate_background.visible = true
	if code == 3: ## when you talk to the person who is irresposibly with their dog.
		exterminated_count += 1
		increase_counter()
	
