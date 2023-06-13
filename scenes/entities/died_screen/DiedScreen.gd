extends CanvasLayer

func _ready():
	print("name: " + get_parent().get_parent().get_parent().name)
	if get_parent().get_parent().get_parent().name.begins_with("Level"):
		print("ggggg")
		var save = Save_Handler.new()
		save.load_from_file("user://data.txt")
		save.add_value("level", "1")
		save.save_to_file("user://data.txt")

func _input(event):
	if event.is_action_pressed("exit"):
		get_tree().change_scene("res://scenes/menu/menu/Menu.tscn")	

func _on_Exit_pressed():
	get_tree().change_scene("res://scenes/menu/menu/Menu.tscn")
