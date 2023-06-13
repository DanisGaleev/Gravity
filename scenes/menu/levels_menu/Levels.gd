extends VBoxContainer

func _on_Level_1_pressed():
	get_tree().change_scene("res://scenes/levels/plot_levels/Level1.tscn")

func _on_Level_2_pressed():
	get_tree().change_scene("res://scenes/levels/plot_levels/Level2.tscn")


func _on_Exit_pressed():
	get_tree().change_scene("res://scenes/menu/menu/Menu.tscn")


func _on_Level_3_pressed():
	get_tree().change_scene("res://scenes/levels/plot_levels/Level3.tscn")


func _on_Level_4_pressed():
	get_tree().change_scene("res://scenes/levels/plot_levels/Level4.tscn")


func _on_Level_5_pressed():
	get_tree().change_scene("res://scenes/levels/plot_levels/Level5.tscn")
