# -----
# tool
# classname
# extends
extends VBoxContainer
# docstring
# ----Variables-------
# signals
# enums
# constants
# exported
# public
# private
var title_screen:PackedScene = load("res://Scenes/bush_2.tscn")
# onready
# ------Main------------
# init
# _ready
# _methods
func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(title_screen)


func _on_button_2_pressed() -> void:
	get_tree().quit()

# public methods
# private methods
