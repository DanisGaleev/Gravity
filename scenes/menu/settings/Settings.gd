extends Control

onready var lang = $MarginContainer/Menu/TabContainer/Language/Languages
onready var sound = $MarginContainer/Menu/TabContainer/Sound/SoundContainer/SoundContainer/Sound
onready var music = $MarginContainer/Menu/TabContainer/Sound/SoundContainer/MusicContainer/Music
onready var cheech = $MarginContainer/Menu/TabContainer/Sound/SoundContainer/CheechContainer/Cheech

func _ready():
	var l = TranslationServer.get_locale()
	if l == "ru":
		lang.select(1)
	elif l == "en":
		lang.select(0)
	var save = Save_Handler.new()
	save.load_from_file("user://data.txt")
	
	sound.value = save.get_value("sound_value")
	music.value = save.get_value("music_value")
	cheech.value = save.get_value("cheech_value")
	
func _on_Languages_item_selected(index):
	print(lang.get_item_text(index))
	var save = Save_Handler.new()
	save.load_from_file("user://data.txt")
	match index:
		0:
			TranslationServer.set_locale("en")
		1:
			TranslationServer.set_locale("ru")
	save.add_value("language", TranslationServer.get_locale())
	save.save_to_file("user://data.txt")
	#TranslationServer.set_locale(lang.get_item_text(index).to_lower().substr(0, 2))
#	save.load_from_file("user://data.txt")
#	save.add_value("language", lang.get_item_text(index).to_lower())
#	save.save_to_file("user://data.txt")


func _on_Sound_value_changed(value):
	var save = Save_Handler.new()
	save.load_from_file("user://data.txt")
	save.add_value("sound_value", value)
	save.save_to_file("user://data.txt")

func _on_Music_value_changed(value):
	var save = Save_Handler.new()
	save.load_from_file("user://data.txt")
	save.add_value("music_value", value)
	save.save_to_file("user://data.txt")


func _on_Cheech_value_changed(value):
	var save = Save_Handler.new()
	save.load_from_file("user://data.txt")
	save.add_value("cheech_value", value)
	save.save_to_file("user://data.txt")
