extends KinematicBody2D

export var speed  = 10

onready var navagent = $NavigationAgent2D
onready var removeTimer : Timer = $RemoveTimer

var velocity : Vector2

var died_screen_scene = preload("res://scenes/entities/died_screen/DiedScreen.tscn")

var died_screen: CanvasLayer

func _ready():
	_on_Timer_timeout()
	#navagent.set_target_location(get_parent().get_parent().get_parent().get_node("Player").global_position)
	
func _physics_process(delta):
	if navagent.is_navigation_finished():
		return
	var dir = global_position.direction_to(navagent.get_next_location())
	#var dir = (navagent.get_next_location() - global_position).normalized()
	velocity = dir * speed
	velocity = move_and_slide(velocity)


func _on_Timer_timeout():
	#print(get_parent().name)
	navagent.set_target_location(get_parent().get_parent().get_node("Player").global_position)


func _on_RemoveTimer_timeout():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		died_screen = died_screen_scene.instance()
		get_parent().get_parent().get_node("Node/Control").add_child(died_screen)
		for child in get_parent().get_parent().get_children():
			if child.name != "Node":
				child.queue_free()



func _on_Area2D_area_entered(area):
	if area.get_name() == "Player":
		died_screen = died_screen_scene.instance()
		get_parent().get_parent().get_node("Node/Control").add_child(died_screen)
		for child in get_parent().get_parent().get_children():
			if child.name != "Node":
				child.queue_free()
