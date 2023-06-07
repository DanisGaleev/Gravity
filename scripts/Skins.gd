extends TextureButton

var path = "user://skin.save"
func _ready():
	


func on_skin_pressed():
	var save = SaveHandler.new(path)
	print(save)
