extends RigidBody2D

signal spike_connected
var died_screen_scene = preload("res://scenes/entities/died_screen/DiedScreen.tscn")
var died_screen: CanvasLayer

func _ready():
	get_tree().get_nodes_in_group("sound")[0].play()

func _on_Area2D_body_entered(body):
	if body.get_name() != "Player" and body.get_name() != "EnemyTrigger":
		get_tree().get_nodes_in_group("sound")[0].play()
		queue_free()
	elif body.get_name() == "Player":
		get_tree().get_nodes_in_group("sound")[0].play()
		died_screen = died_screen_scene.instance()
		get_parent().get_parent().get_node("Node/Control").add_child(died_screen)
		for child in get_parent().get_parent().get_children():
			if child.name != "Node":
				child.queue_free()


func _on_Area2D_area_entered(area):
	if area.get_name() != "Player" and area.get_name() != "EnemyTrigger":
		get_tree().get_nodes_in_group("sound")[0].play()
		queue_free()
	elif area.get_name() == "Player":
		get_tree().get_nodes_in_group("sound")[0].play()
		died_screen = died_screen_scene.instance()
		get_parent().get_parent().get_node("Node/Control").add_child(died_screen)
		for child in get_parent().get_parent().get_children():
			if child.name != "Node":
				child.queue_free()
