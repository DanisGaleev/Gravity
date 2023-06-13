extends VBoxContainer

func _ready():
	pass


func _on_Select_pressed():
	var save = Save_Handler.new()
	save.load_from_file("user://data.txt")
	save.add_value("skin_path", $MarginContainer/Skin.texture.resource_path)
	save.save_to_file("user://data.txt")
