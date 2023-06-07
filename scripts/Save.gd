class_name Save

var data = {}

func add_value(key, value):
	data[key] = value

func get_value(key):
	return data[key]

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
