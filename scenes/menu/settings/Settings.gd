extends Control

onready var lang = $MarginContainer/Languages

func _ready():
	var l = TranslationServer.get_locale()
	if l == "ru":
		lang.select(1)
	elif l == "en":
		lang.select(0)
func _on_Languages_item_selected(index):
	match index:
		0:
			TranslationServer.set_locale("en")
		1:
			TranslationServer.set_locale("ru")
	#TranslationServer.set_locale(lang.get_item_text(index).to_lower().substr(0, 2))
#	save.load_from_file("user://data.txt")
#	save.add_value("language", lang.get_item_text(index).to_lower())
#	save.save_to_file("user://data.txt")
