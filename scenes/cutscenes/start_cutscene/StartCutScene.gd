extends Node2D

export var jump_speed : int
var jump = false
var sub : Vector2

func _ready():
	$AnimationPlayer.play("cutscene")
	$Path2D/PathFollow2D/move.global_position = Vector2(414, 328)
	print($Path2D/PathFollow2D/move.global_position)
	sub = $Hero.global_position - $Path2D/PathFollow2D/move.global_position
func _process(delta):
	if jump:
		print($Path2D/PathFollow2D/move.global_position)
		$Path2D/PathFollow2D.offset = $Path2D/PathFollow2D.offset + delta * jump_speed
		$Hero.global_position = $Path2D/PathFollow2D/move.global_position
	
func start_jump():
	jump = true
