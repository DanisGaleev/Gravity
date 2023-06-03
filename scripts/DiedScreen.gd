extends CanvasLayer

func _input(event):
	if event.is_action_pressed("exit"):
		get_tree().change_scene("res://scenes/LevelMenu.tscn")	
	elif event.is_action_pressed("replay"):
		get_tree().reload_current_scene()

func _on_Replay_pressed():
	get_tree().reload_current_scene()

func _on_Exit_pressed():
	get_tree().change_scene("res://scenes/LevelMenu.tscn")
