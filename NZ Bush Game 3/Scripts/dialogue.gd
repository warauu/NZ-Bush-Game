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

var d_active:bool = false
# onready


# ------Main------------

# init

# _ready
func _ready() -> void:
	$NinePatchRect.visible = false
	
	
# _methods
func _input(event: InputEvent) -> void:
	if !d_active:
		return	
	if event.is_action_pressed("ui_accept"):
		next_script()
# public methods

# private methods
func start(root) -> void:
	if d_active:
		return
	d_active = true
	$NinePatchRect.visible = true
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
		$NinePatchRect.visible = false
		emit_signal("dialogue_finished")
		return 
	
	$NinePatchRect/Name.text = dialogue[current_dialogue_id]["name"]
	$NinePatchRect/Text.text = dialogue[current_dialogue_id]["text"]
