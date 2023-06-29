extends Control

onready var bar = $MarginContainer/VBoxContainer/ProgressBar
onready var best_res = $MarginContainer/VBoxContainer/BestRes
onready var start = $MarginContainer/VBoxContainer/Start
onready var tutorial = $MarginContainer/VBoxContainer/Turorial
onready var authors = $MarginContainer/VBoxContainer/Authors
onready var generator = $MarginContainer/VBoxContainer/Generator
onready var skins = $MarginContainer/VBoxContainer/Skins
onready var settings = $MarginContainer/VBoxContainer/Settings

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
	var level = float(save.get_value("level"))
	
	var start_cutscene = save.get_value("start_cutscene")
	var final_cutscene =  save.get_value("final_cutscene")
	var end_cutscene =  save.get_value("end_cutscene")
	
	var level_path: String
	if level < 8:
		if level == 1 and not start_cutscene:
			level_path = "res://scenes/cutscenes/start_cutscene/StartCutScene.tscn"
		elif level == 7 and not final_cutscene:
			level_path = "res://scenes/cutscenes/final_cutscene/Final_Cutscene.tscn"
		else:
			level_path = "res://scenes/levels/plot_levels/Level" + str(level) + ".tscn"
	else:
			level_path = "res://scenes/levels/plot_levels/Level7.tscn"
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
