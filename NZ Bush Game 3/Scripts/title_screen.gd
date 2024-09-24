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
var GAME:PackedScene
# onready


# ------Main------------

# init

# _ready
func _ready() -> void:
	GAME = load("res://Scenes/bush_2.tscn")
	$TitleVBox.visible = true
	for i in $Screens.get_children():
		i.visible = false
		
# _methods

func _on_play_pressed() -> void:
	#what's your name?
	#as you input your name, a small blurb shows up.
	get_tree().change_scene_to_packed(GAME)
	

func _on_info_pressed() -> void:
	$TitleVBox.visible = false
	$Screens/Info.visible = true

func _on_texture_button_pressed() -> void:
	$Screens/Info.visible = false
	$TitleVBox.visible = true
	
# public methods

# private methodsv
