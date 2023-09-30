extends AudioStreamPlayer


func _ready():
	if get_tree().current_scene.name.begins_with('Level'):
		self.stream = load('res://audio/6537897036218368.wav')
		self.play()
