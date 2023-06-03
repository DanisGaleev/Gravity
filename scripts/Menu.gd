extends Control

func _on_Start_pressed():
	get_tree().change_scene("res://scenes/LevelMenu.tscn")

func _on_Authors_pressed():
	get_tree().change_scene("res://scenes/Authors.tscn")	

func _on_Generator_pressed():
	get_tree().change_scene("res://scenes/Generator.tscn")


func _on_Turorial_pressed():
	get_tree().change_scene("res://scenes/Tutorial.tscn")
