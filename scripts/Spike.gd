extends Area2D

signal spike_connected
var died_screen_scene = preload("res://scenes/DiedScreen.tscn")
var died_screen: CanvasLayer


func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		died_screen = died_screen_scene.instance()
		#died_screen.rect_position = Vector2(312, 150)
		get_parent().get_parent().get_parent().get_node("Node/Control").add_child(died_screen)
		for i in get_parent().get_parent().get_parent().get_children():
			if i.name != "Node":
				i.visible = false	
		emit_signal("spike_connected")
		#get_tree().reload_current_scene()
