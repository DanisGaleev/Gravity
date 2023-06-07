extends Control


func _ready():
	var save = Save_Handler.new()
	save.load_from_file("user://data.txt")
	save = save.get_value("skin_path")
	#for child in $ScrollContainer/HBoxContainer:
		#if child.get_node("MarginContainer/Skin").

func _on_Exit_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
