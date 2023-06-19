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
		$SceneManagerEnd.play("cutscene")

func _process(delta):
	if isStarted:
		$Path2D/PathFollow2D.offset = $Path2D/PathFollow2D.offset + delta * jump_speed
