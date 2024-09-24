# -----

# tool

# classname

# extends
extends Control
# docstring

# ----Variables-------

# signals

# enums

# constants

# exported

# public

# private
var is_open:bool = false ## is the UI open?

# onready
@onready var inv:Inv = load("res://Inventory/players_inventory.tres") ## preload a scene, with this root.
@onready var slots:Array[Node] = $NinePatchRect/GridContainer.get_children() ## how many slots in the node tree?
# ------Main------------

# init

# _ready
func _ready() -> void:
	inv.update.connect(update_slots) ## connect the signal
	visible = false ## in the beginning, set the UI as invisible
	is_open = false
	update_slots() ## update inventory in the beginning.
	
# _methods
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("i"):
		## Toggle the Inventory UI
		visible = !visible
		is_open = !is_open
			
			
# public methods

# private methods
func update_slots() -> void:
	for i:int in range(min(inv.slots.size(), slots.size())): ## for 1 in range that we expect
		slots[i].update(inv.slots[i]) ## takes the information from the child and updates to the parent variable.
