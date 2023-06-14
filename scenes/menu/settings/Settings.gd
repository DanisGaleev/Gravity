extends Control

onready var lang = $MarginContainer/Languages

func _ready():
	var save = Save_Handler.new()
	save.load_from_file("user://data.txt")
	var l = save.get_value("language")
	for idx in lang.get_item_count():
		if lang.get_item_text(idx).to_lower() == l:
			lang.select(idx)

func _on_Languages_item_selected(index):
	print(lang.get_item_text(index).to_lower())
	var save = Save_Handler.new()
	save.load_from_file("user://data.txt")
	save.add_value("language", lang.get_item_text(index).to_lower())
	save.save_to_file("user://data.txt")
