extends Control

onready var bar = $CenterContainer/HBoxContainer/ProgressBar

func _ready():
	print(Save_Handler.new().load_level())

func _process(delta):
	bar.value = float(Save_Handler.new().load_level()) - 1

func _on_Start_pressed():
	var level_number = Save.new().load_level()
	var level_path: String
	if int(level_number) < 6:
		level_path = "res://scenes/Level" + level_number + ".tscn"
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
	pass # Replace with function body.
