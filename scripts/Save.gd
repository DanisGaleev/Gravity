class_name Save

var SAVE_PATH:String

func _init(path = "user://savefile.save"):
	SAVE_PATH = path

func save_level(level):
	var file = File.new()
	file.open(SAVE_PATH, File.WRITE)
	file.store_string(level)
	file.
	file.close()

func load_level() -> String: 
	var file = File.new()
	if not file .file_exists(SAVE_PATH):
		save_level("1")
	file.open(SAVE_PATH, File.READ)
	var path = file.get_as_text()
	file.close()
	return path
