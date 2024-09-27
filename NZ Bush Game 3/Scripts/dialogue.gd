# -----

# tool

# classname

# extends
extends Control
# docstring

# ----Variables-------

# signals
signal dialogue_finished
# enums

# constants

# exported
@export_file("*.json") var d_file
# public

# private
var dialogue:Array
var current_dialogue_id:int = 0
var animal:Object

var d_active:bool = false
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
	if event.is_action_pressed("ui_accept"):
		next_script()
# public methods

# private methods
func start(root, animal_node:Object) -> void:
	print(animal_node)
	animal = animal_node
	if d_active:
		return
	d_active = true
	self.visible = true
	dialogue = load_dialogue(root)
	current_dialogue_id = -1
	next_script()

func load_dialogue(file_root) -> Array:
	var file:FileAccess = FileAccess.open(file_root, FileAccess.READ)
	var content:Array = JSON.parse_string(file.get_as_text())
	return content
	
func next_script() -> void:
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		d_active = false
		self.visible = false
		emit_signal("dialogue_finished")
		if animal.can_exterminate.is_valid():
			print(animal.can_exterminate)
			exterminate_animal(animal)
		else:
			return 
	
	$Name.text = fetch_player_name("name")
	$Text.text = fetch_player_name("text")
	
func fetch_player_name(variable:String) -> String:
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
		text = text + i
	return text

func exterminate_animal(animal:Object) -> void:
	GLOBAL_SCRIPT.exterminated_count += 1
	animal.queue_free() 
	GLOBAL_SCRIPT.increase_counter()
	print(GLOBAL_SCRIPT.exterminated_count)
