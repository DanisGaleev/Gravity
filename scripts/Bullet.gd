extends RigidBody2D

signal spike_connected
var died_screen_scene = preload("res://scenes/DiedScreen.tscn")
var died_screen: CanvasLayer

func _on_Area2D_body_entered(body):
	if body.get_name() != "Player" and body.get_name() != "EnemyTrigger":
		queue_free()
	elif body.get_name() == "Player":
		#body.queue_free()	
		#get_tree().reload_current_scene()
		died_screen = died_screen_scene.instance()
		#died_screen.rect_position = Vector2(312, 150)
		get_parent().get_parent().get_node("Node/Control").add_child(died_screen)
		for i in get_parent().get_parent().get_parent().get_children():
			if i.name != "Node":
				i.visible = false	
		emit_signal("spike_connected")


func _on_Area2D_area_entered(area):
	if area.get_name() != "Player" and area.get_name() != "EnemyTrigger":
		queue_free()
	elif area.get_name() == "Player":
		#body.queue_free()	
		#get_tree().reload_current_scene()
		died_screen = died_screen_scene.instance()
		#died_screen.rect_position = Vector2(312, 150)
		get_parent().get_parent().get_node("Node/Control").add_child(died_screen)
		for i in get_parent().get_parent().get_parent().get_children():
			if i.name != "Node":
				i.visible = false	
		emit_signal("spike_connected")
