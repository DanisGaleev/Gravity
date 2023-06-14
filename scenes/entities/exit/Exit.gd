extends TextureButton

export (String) var exit_to_path

func _on_Exit_pressed():
	get_tree().change_scene(exit_to_path)
