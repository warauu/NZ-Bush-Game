# -----

# tool

# classname

# extends
extends Panel
# docstring

# ----Variables-------

# signals

# enums

# constants

# exported

# public

# private

# onready
@onready var item_sprite:Sprite2D = $CenterContainer/Panel/ItemSprite 
@onready var amount_text:Label = $CenterContainer/Panel/Label

# ------Main------------

# init

# _ready

# _methods

# public methods

# private methods
func update(slot:InvSlot) -> void:
	if !slot.item:
		item_sprite.visible = false
		amount_text.visible = false
	else:
		item_sprite.texture = slot.item.texture
		if slot.amount > 1:
			amount_text.text = str(slot.amount)
		item_sprite.visible = true
		amount_text.visible = true
	
