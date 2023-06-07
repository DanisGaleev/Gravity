extends Control

onready var bar = $CenterContainer/HBoxContainer/ProgressBar

func _ready():
	pass

func _process(delta):
	var save = Save_Handler.new()
	save.load_from_file("user://data.txt")
	var v = save.get_value("level")
	if v == null:
		bar.value = 0
	else:	
		bar.value = float(v) - 1

func _on_Start_pressed():
	var save = Save_Handler.new()
	save.load_from_file("user://data.txt")
	var v = save.get_value("level")
	if v == null:
		v = 1
	else:
		v = float(v)
	var level_path: String
	if v < 6:
		level_path = "res://scenes/Level" + str(v) + ".tscn"
	else:
		level_path = "res://scenes/Level5.tscn"
	get_tree().change_scene(level_path)
func _on_Authors_pressed():
	get_tree().change_scene("res://scenes/Authors.tscn")	

func _on_Generator_pressed():
	get_tree().change_scene("res://scenes/Generator.tscn")


func _on_Turorial_pressed():
	get_tree().change_scene("res://scenes/Tutorial.tscn")


func _on_Skins_pressed():
	get_tree().change_scene("res://scenes/Skins.tscn")
