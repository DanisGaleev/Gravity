extends Area2D

var win_screen_scene = preload("res://scenes/entities/win_screen/WinScreen.tscn")
var win_screen: CanvasLayer

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		var save = Save_Handler.new()
		save.load_from_file("user://data.txt")
		if get_parent().name.ends_with("7"):
			save.add_value("level", int(get_parent().name.substr(5)) + 1)
			save.save_to_file("user://data.txt")
			$Scene_transition.transition_to("res://scenes/cutscenes/final_cutscene/Final_Cutscene.tscn")
#			get_tree().change_scene("res://scenes/cutscenes/final_cutscene/Final_Cutscene.tscn")
		save.add_value("level", int(get_parent().name.substr(5)) + 1)
		save.save_to_file("user://data.txt")
		win_screen = win_screen_scene.instance()
		get_parent().get_node("Node/Control").add_child(win_screen)
		win_screen.visible = true
		for child in get_parent().get_children():
			if child.name != "Node":
				child.queue_free()
