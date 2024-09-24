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
var savePath:String = "user://savefile.save"

var GAME:PackedScene
var player_name:String
# onready


# ------Main------------

# init

# _ready
func _ready() -> void:
	GAME = load("res://Scenes/bush_2.tscn")
	$TitleVBox.visible = true
	handle_connecting_signals()
	for i in $Screens.get_children():
		i.visible = false
		
# _methods

func _on_play_pressed() -> void:
	#as you input your name, a small blurb shows up.
	$TitleVBox.visible = false
	$Screens/AskForName.visible = true
	$Screens/AskForName/MarginContainer/VBoxContainer/InputArea/HBoxContainer/LineEdit.grab_focus()
	await get_tree().create_timer(1.0).timeout 
	

func _on_info_pressed() -> void:
	$TitleVBox.visible = false
	$Screens/Info.visible = true

func _on_texture_button_pressed() -> void:
	$Screens/Info.visible = false
	$TitleVBox.visible = true
	
# public methods

# private methodsv
func on_text_submitted(text) -> void:
	if text:
		await get_tree().create_timer(0.05).timeout 
		if !$Screens/AskForName/MarginContainer/VBoxContainer/Text/Label.text == "...":
			$Screens/AskForName/MarginContainer/VBoxContainer/Text/Label.text = "Is this ok?"
		$Screens/AskForName/MarginContainer/VBoxContainer/HBoxContainer.visible = true
		$Screens/AskForName/MarginContainer/VBoxContainer/HBoxContainer/cancel.grab_focus()

func on_accept() -> void:
	var saveFile: FileAccess = FileAccess.open(savePath, FileAccess.WRITE)
	var name:String
	name = $Screens/AskForName/MarginContainer/VBoxContainer/InputArea/HBoxContainer/LineEdit.text
	player_name = name
	$Screens/AskForName/MarginContainer/VBoxContainer/Text/Label.text = "Welcome, " + name + " :-)"
	$Screens/AskForName/MarginContainer/VBoxContainer/HBoxContainer.visible = false
	saveFile.store_var(name)
	await get_tree().create_timer(1).timeout 
	#global_script.save_data(name)
	get_tree().change_scene_to_packed(GAME)

func on_cancel() -> void:
	$Screens/AskForName/MarginContainer/VBoxContainer/InputArea/HBoxContainer/LineEdit.grab_focus()
	$Screens/AskForName/MarginContainer/VBoxContainer/Text/Label.text = "Take your time!"
	$Screens/AskForName/MarginContainer/VBoxContainer/HBoxContainer.visible = false


func handle_connecting_signals() -> void:
	$Screens/AskForName/MarginContainer/VBoxContainer/InputArea/HBoxContainer/LineEdit.text_submitted.connect(on_text_submitted)
	$Screens/AskForName/MarginContainer/VBoxContainer/HBoxContainer/accept.button_down.connect(on_accept)
	$Screens/AskForName/MarginContainer/VBoxContainer/HBoxContainer/cancel.button_down.connect(on_cancel)
