extends Node2D

var save = Save_Handler.new()
onready var camera = $Camera2D

func _ready():
	save.load_from_file("user://data.txt")
	$AnimationPlayer.play("cutscene")
	yield($AnimationPlayer, "animation_finished")
	change_scene()
func _process(delta):
	camera.zoom.x = 640 / get_viewport_rect().size.x
	camera.zoom.y = camera.zoom.x

func change_scene() -> void:
	save.add_value("end_cutscene", true)
	save.save_to_file("user://data.txt")
	get_tree().change_scene("res://scenes/menu/menu/Menu.tscn")
