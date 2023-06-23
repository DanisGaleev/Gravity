extends Control

onready var lang = $MarginContainer/Languages

func _ready():
	var l = TranslationServer.get_locale()
	for idx in lang.get_item_count():
		if lang.get_item_text(idx).to_lower().begins_with(l):
			lang.select(idx)

func _on_Languages_item_selected(index):
	TranslationServer.set_locale(lang.get_item_text(index).to_lower().substr(0, 2))
#	save.load_from_file("user://data.txt")
#	save.add_value("language", lang.get_item_text(index).to_lower())
#	save.save_to_file("user://data.txt")
