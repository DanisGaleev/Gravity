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
	#set_language(save)

func set_language(save : Save_Handler) -> void:
	if save.get_value("language") == "english":
		start.texture_normal = load("res://sprites/gui/menu/START L E.png")
		start.texture_hover = load("res://sprites/gui/menu/START D E.png")
		start.texture_pressed = load("res://sprites/gui/menu/START D E.png")
		tutorial.texture_normal = load("res://sprites/gui/menu/TUTOR L E.png")
		tutorial.texture_hover = load("res://sprites/gui/menu/TUTOR D E.png")
		tutorial.texture_pressed = load("res://sprites/gui/menu/TUTOR D E.png")
		authors.texture_normal = load("res://sprites/gui/menu/AUTHORS L E.png")
		authors.texture_hover = load("res://sprites/gui/menu/AUTHORS D E.png")
		authors.texture_pressed = load("res://sprites/gui/menu/AUTHORS D E.png")
		generator.texture_normal = load("res://sprites/gui/menu/GENER L E.png")
		generator.texture_hover = load("res://sprites/gui/menu/GENER D E.png")
		generator.texture_pressed = load("res://sprites/gui/menu/GENER D E.png")
		skins.texture_normal = load("res://sprites/gui/menu/SKINS L E.png")
		skins.texture_hover = load("res://sprites/gui/menu/SKINS D E.png")
		skins.texture_pressed = load("res://sprites/gui/menu/SKINS D E.png")
		settings.texture_normal = load("res://sprites/gui/menu/SETT L E.png")
		settings.texture_hover = load("res://sprites/gui/menu/SETT D E.png")
		settings.texture_pressed = load("res://sprites/gui/menu/SETT D E.png")
	elif save.get_value("language") == "russian":
		start.texture_normal = load("res://sprites/gui/menu/START L R.png")
		start.texture_hover = load("res://sprites/gui/menu/START D R.png")
		start.texture_pressed = load("res://sprites/gui/menu/START D R.png")
		tutorial.texture_normal = load("res://sprites/gui/menu/TUTOR L R.png")
		tutorial.texture_hover = load("res://sprites/gui/menu/TUTOR D R.png")
		tutorial.texture_pressed = load("res://sprites/gui/menu/TUTOR D R.png")
		authors.texture_normal = load("res://sprites/gui/menu/AUTHORS L R.png")
		authors.texture_hover = load("res://sprites/gui/menu/AUTHORS D R.png")
		authors.texture_pressed = load("res://sprites/gui/menu/AUTHORS D R.png")
		generator.texture_normal = load("res://sprites/gui/menu/GENER L R.png")
		generator.texture_hover = load("res://sprites/gui/menu/GENER D R.png")
		generator.texture_pressed = load("res://sprites/gui/menu/GENER D R.png")
		skins.texture_normal = load("res://sprites/gui/menu/SKINS L R.png")
		skins.texture_hover = load("res://sprites/gui/menu/SKINS D R.png")
		skins.texture_pressed = load("res://sprites/gui/menu/SKINS D R.png")
		settings.texture_normal = load("res://sprites/gui/menu/SETT L R.png")
		settings.texture_hover = load("res://sprites/gui/menu/SETT D R.png")
		settings.texture_pressed = load("res://sprites/gui/menu/SETT D R.png")

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
