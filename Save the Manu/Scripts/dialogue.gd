# -----

# tool

# classname
# extends
extends Control
# docstring
## this is the script that manages the dialogue scene
# ----Variables-------

# signals
signal dialogue_finished ## other nodes in the scene will recieve the signal
# enums
# constants
# exported
@export_file("*.json") var d_file ## the chosen file format for dialogues
@export var global_script:Node ## the manager script
@export var player:CharacterBody2D
@export var objective:Panel
# public
# private
var dialogue:Array ## contents of dialogues stored here
var current_dialogue_id:int = 0 
var animal:Object ## the object that the player is currently talking to

var d_active:bool = false ## bool to make the dialogue box visible
# onready

# ------Main------------

# init

# _ready
func _ready() -> void:
	self.visible = false
	
	
# _methods
func _input(event: InputEvent) -> void:
	if !d_active:
		return	
	if event.is_action_pressed("space"):
		next_script()
# public methods

# private methods
func start(root, animal_node:Object) -> void: ##function that initialises the dialogue to display
	print(animal_node)
	player.stop_movement = true
	animal = animal_node
	if d_active:
		return
	d_active = true
	self.visible = true
	dialogue = load_dialogue(root)
	current_dialogue_id = -1
	next_script()


func load_dialogue(file_root) -> Array: ## checks the exported file.
	var file:FileAccess = FileAccess.open(file_root, FileAccess.READ)
	var content:Array = JSON.parse_string(file.get_as_text())
	return content
	
	
func next_script() -> void: ## moves to the next element in the dialogue array
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		d_active = false
		self.visible = false
		emit_signal("dialogue_finished")
		player.stop_movement = false
		if !objective.visible: 
			objective.visible = true
		if animal:	# Checks if null (This is null if it's not an animal)
			if animal is Animal:
				print("animal")
				if animal.can_exterminate:
					animal.exterminate_self()
				if animal.name == "kereru_carpark":
					global_script.function_global(4)
				if animal.name == "weka_carpark":
					global_script.function_global(5)
				if animal.name == "kiwi_carpark":
					global_script.function_global(6)
				if animal.name == "tui_carpark":
					global_script.function_global(7)
			elif animal is Npc:
				print("npc")
				if animal.name == "Bro":
					global_script.function_global(1)
					return
				if animal.name == "TourGuideNpc":
					global_script.function_global(2)
				if animal.name == "Bad":
					global_script.function_global(3)
					animal.queue_free()
			return
		
		return
		#if animal.can_exterminate.is_valid():
			#print(animal.can_exterminate)
			#exterminate_animal(animal)
		#else:
			#return 
	
	$Name.text = fetch_player_name("name")
	$Text.text = fetch_player_name("text")
	
func fetch_player_name(variable:String) -> String: ## gets the player's name from the save file
	var text:String
	for i:String in dialogue[current_dialogue_id][variable]:
		if i == "*":
			if FileAccess.file_exists("user://savefile.save"):
				var player_name:String
				player_name = FileAccess.open("user://savefile.save", FileAccess.READ).get_var()
				i = player_name
				print(player_name)
			else:
				print("no data found in file")
		elif i == "/":
			i = str(global_script.exterminated_count)
		text = text + i
	return text

#func exterminate_animal(animal:Object) -> void:
	#GLOBAL_SCRIPT.exterminated_count += 1
	#animal.queue_free() 
	#GLOBAL_SCRIPT.increase_counter()
	#print(GLOBAL_SCRIPT.exterminated_count)
