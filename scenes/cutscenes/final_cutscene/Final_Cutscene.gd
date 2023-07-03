extends Node2D

var is_begin = false
export var jump_speed : int

var isStarted = false

var save = Save_Handler.new()

func set_str():
	isStarted = true
func _input(event):
	if event.is_action_pressed("exit"):
		change_scene()
func _ready():
	save.load_from_file("user://data.txt")
	if is_begin:
		$SceneManagerBegin.play("cutscene")
		_Global.isStartScene = false
	else:
		$SceneManagerEnd.play("cutscene_end")
	yield($SceneManagerBegin, "animation_finished")
	get_tree().change_scene("res://scenes/levels/plot_levels/Level7.tscn")
	#$Path2D/PathFollow2D/Devil.global_position = Vector2(420, 112)
func _process(delta):
	$Camera2D.zoom.x = 640 / get_viewport_rect().size.x
	$Camera2D.zoom.y = $Camera2D.zoom.x
	get_node("CanvasLayer").scale = Vector2(get_viewport_rect().size.x / 640, get_viewport_rect().size.y / 360)
	if isStarted:
		$Path2D/PathFollow2D.offset = $Path2D/PathFollow2D.offset + delta * jump_speed
	if has_node("Path2D") and $Path2D/PathFollow2D.unit_offset == 1:
		isStarted = false
		$Path2D.queue_free()
		$Cell2.queue_free()
		yield($SceneManagerEnd, "animation_finished")
		change_scene()
#		$Path2D/PathFollow2D/Devil.queue_free()
func change_scene() -> void:
	save.add_value("final_cutscene", true)
	save.save_to_file("user://data.txt")
	get_tree().change_scene("res://scenes/cutscenes/end_cutscene/EndCutScene.tscn")
