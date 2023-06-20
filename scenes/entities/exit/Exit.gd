extends TextureButton

export (String) var exit_to_path

func _process(delta):
	set_language()

func set_language():
	var save = Save_Handler.new()
	save.load_from_file("user://data.txt")
	if save.get_value("language") == "english":
		texture_normal = load("res://sprites/gui/menu/EXIT L E.png")
		texture_hover = load("res://sprites/gui/menu/EXIT D E.png")
		texture_pressed = load("res://sprites/gui/menu/EXIT D E.png")
	elif save.get_value("language") == "russian": 
		texture_normal = load("res://sprites/gui/menu/EXIT L R.png")
		texture_hover = load("res://sprites/gui/menu/EXIT D R.png")
		texture_pressed = load("res://sprites/gui/menu/EXIT D R.png")
	
func _on_Exit_pressed():
	get_tree().change_scene(exit_to_path)
