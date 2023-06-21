class_name Save_Handler

var save = Save.new()

var data = {}

func _init():
	pass

func add_value(key, value):
	data[key] = value

func get_value(key):
	if key in data.keys():
		return data[key]
	else:
		return null

func save_to_file(file_path):
	var file = File.new()
	file.open(file_path, File.WRITE)
	file.store_line(to_json(data))
	file.close()

func load_from_file(file_path):
	var file = File.new()
	if file.file_exists(file_path):
		file.open(file_path, File.READ)
		data = parse_json(file.get_as_text())
		file.close()
	else:
		add_value("level", "1")
		save_to_file(file_path)
