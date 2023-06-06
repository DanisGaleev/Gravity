class_name Save_Handler
var path:String
func _init(path = "user://savefile.save"):
	self.path = path
var save = Save.new(self.path)
func load_level() -> String:
	return save.load_level()
