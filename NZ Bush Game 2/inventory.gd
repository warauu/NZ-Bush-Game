# -----

# tool

# classname
class_name Inv
# extends
extends Resource
# docstring

# ----Variables-------

# signals
signal update 
# enums

# constants

# exported
@export var slots: Array[InvSlot] ## Array containing all of the InvSlot objects
# public

# private

# onready


# ------Main------------

# init

# _ready

# _methods

# public methods

# private methods
func insert(item:InvItem) -> void:
	## goes through each slot and checks which one can be modified.
	var item_slots = slots.filter(func(slot): return slot.item == item) 
	## calls a (temporary in this case) function that returns a value.
	if !item_slots.is_empty():
		## if the item slot already has one in it, the amount will just increase instead of adding a new one.
		item_slots[0].amount += 1
	else:
		var empty_slots = slots.filter(func(slot): return slot.item == null)
		if !empty_slots.is_empty():
			empty_slots[0].item = item
			empty_slots[0].amount = 1
	update.emit()
