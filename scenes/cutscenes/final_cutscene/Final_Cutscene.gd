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

func _process(delta):
	if isStarted:
		$Path2D/PathFollow2D.offset = $Path2D/PathFollow2D.offset + delta * jump_speed
	if $Path2D/PathFollow2D.unit_offset == 1 and has_node("Path2D/PathFollow2D/Devil"):
		$Path2D/PathFollow2D/Devil.queue_free()
