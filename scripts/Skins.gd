extends TextureButton

var path = "user://skin.save"
func _ready():
	for btn in $MarginContainer/ScrollContainer/HBoxContainer:
		print("ggg")
		btn.connect("pressed", self, "on_skin_pressed")


func on_skin_pressed():
	var save = SaveHandler.new(path)
	print(save)
