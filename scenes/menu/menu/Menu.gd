extends Control

onready var bar = $MarginContainer/VBoxContainer/ProgressBar
onready var best_res = $MarginContainer/VBoxContainer/BestRes

func _ready():
	var save = Save_Handler.new()
	save.load_from_file("user://data.txt")
	var v = save.get_value("level")
	var best = save.get_value("best_result")
	if v == null:
		bar.value = 0
	else:	
		bar.value = float(v) - 1
	if best == null :
		save.add_value("best_result", 0)
		save.save_to_file("user://data.txt")
	best_res.text = "BEST RESULT\n0" if best == null else "BEST RESULT\n" + str(best)

func _process(delta):
	pass

func _on_Start_pressed():
	var save = Save_Handler.new()
	save.load_from_file("user://data.txt")
	var v = save.get_value("level")
	if v == null:
		v = 1
	else:
		v = float(v)
	var level_path: String
	if v < 7:
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
