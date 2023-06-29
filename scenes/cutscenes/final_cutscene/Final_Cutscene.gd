extends Node2D

export var is_begin : bool
export var jump_speed : int

var isStarted = false

func set_str():
	isStarted = true

func _ready():
	if is_begin:
		$SceneManagerBegin.play("cutscene")
	else:
		$SceneManagerEnd.play("cutscene_end")
	yield($SceneManagerBegin, "animation_finished")
	get_tree().change_scene("res://scenes/levels/plot_levels/Level7.tscn")


func _process(delta):
	$Camera2D.zoom.x = 640 / get_viewport_rect().size.x
	$Camera2D.zoom.y = $Camera2D.zoom.x
	get_node("CanvasLayer").scale = Vector2(get_viewport_rect().size.x / 640, get_viewport_rect().size.y / 360)
	if isStarted:
		$Path2D/PathFollow2D.offset = $Path2D/PathFollow2D.offset + delta * jump_speed
	if has_node("Path2D") and $Path2D/PathFollow2D.unit_offset == 1:
		isStarted = false
		$Path2D.queue_free()
		yield($SceneManagerEnd, "animation_finished")
		get_tree().change_scene("res://scenes/cutscenes/end_cutscene/EndCutScene.tscn")
#		$Path2D/PathFollow2D/Devil.queue_free()
