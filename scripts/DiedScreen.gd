extends CanvasLayer

func _ready():
	if get_parent().name.begins_with("Level"):
		var save = Save_Handler.new()
		save.load_from_file("user://data.txt")
		save.add_value("level", "1")
		save.save_to_file("user://data.txt")

func _input(event):
	if event.is_action_pressed("exit"):
		get_tree().change_scene("res://scenes/Menu.tscn")	

func _on_Replay_pressed():
	get_tree().reload_current_scene()

func _on_Exit_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
