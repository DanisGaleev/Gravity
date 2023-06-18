extends Control

onready var bar = $MarginContainer/VBoxContainer/ProgressBar
onready var best_res = $MarginContainer/VBoxContainer/BestRes

func _ready():
	var save = Save_Handler.new()
	save.load_from_file("user://data.txt")
	var v = save.get_value("level")
	var best = save.get_value("best_result")
	bar.value = float(v) - 1
	best_res.text = "BEST RESULT\n" + str(best)

func _on_Start_pressed():
	var save = Save_Handler.new()
	save.load_from_file("user://data.txt")
	var v = float(save.get_value("level"))
	var level_path: String
	if v < 8:
		level_path = "res://scenes/levels/plot_levels/Level" + str(v) + ".tscn"
	else:
		level_path = "res://scenes/levels/plot_levels/Level6.tscn"
	get_tree().change_scene(level_path)
func _on_Authors_pressed():
	get_tree().change_scene("res://scenes/menu/authors/Authors.tscn")	

func _on_Generator_pressed():
	get_tree().change_scene("res://scenes/levels/generator/Generator.tscn")


func _on_Turorial_pressed():
	get_tree().change_scene("res://scenes/menu/tutorial/Tutorial.tscn")


func _on_Skins_pressed():
	get_tree().change_scene("res://scenes/menu/skins/Skins.tscn")


func _on_Settings_pressed():
	get_tree().change_scene("res://scenes/menu/settings/Settings.tscn")
