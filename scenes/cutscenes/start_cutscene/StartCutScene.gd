extends Node2D

onready var camera = $Camera2D
export var jump_speed : int
var jump = false
var sub : Vector2

func _ready():
	$AnimationPlayer.play("cutscene")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://scenes/menu/menu/Menu.tscn")
	
	$Path2D/PathFollow2D/move.global_position = Vector2(482, 285)
	print($Path2D/PathFollow2D/move.global_position)
	sub = $Hero.global_position - $Path2D/PathFollow2D/move.global_position
	
func _input(event):
	if event.is_action_pressed("exit"):
		get_tree().change_scene("res://scenes/menu/menu/Menu.tscn")
func _process(delta):
	camera.zoom.x = 640 / get_viewport_rect().size.x
	camera.zoom.y = camera.zoom.x

	if jump:
		print($Path2D/PathFollow2D/move.global_position)
		$Path2D/PathFollow2D.offset = $Path2D/PathFollow2D.offset + delta * jump_speed
		$Hero.global_position = $Path2D/PathFollow2D/move.global_position
	
func start_jump():
	jump = true

func _on_Beloved_visibility_trigger_area_entered(area):
	area.get_parent().visible = false
