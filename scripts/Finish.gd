extends Area2D

var win_screen_scene = preload("res://scenes/WinScreen.tscn")
var win_screen: CanvasLayer

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		Save.new().save_level(str(int(get_parent().name.substr(5)) + 1))
		win_screen = win_screen_scene.instance()
		get_parent().get_node("Node/Control").add_child(win_screen)
		win_screen.visible = true
		print(get_parent().name)
		for child in get_parent().get_children():
			if child.name != "Node":
				print(child)
				child.queue_free()
				#child.visible = false
