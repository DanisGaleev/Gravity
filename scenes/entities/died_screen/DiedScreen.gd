extends CanvasLayer

func _ready():
	if get_parent().get_parent().get_parent().name.begins_with("Level"):
		var save = Save_Handler.new()
		save.load_from_file("user://data.txt")
		save.add_value("level", 1)
		save.save_to_file("user://data.txt")

func _input(event):
	if event.is_action_pressed("exit"):
		get_tree().change_scene("res://scenes/menu/menu/Menu.tscn")	
