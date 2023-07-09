extends Node2D

onready var camera = $Camera2D
export var jump_speed : int
var jump = false
var sub : Vector2
var save = Save_Handler.new()

signal colorChanged

func _ready():
	$CanvasModulate.color = Color(0,0,0)
	
	#TranslationServer.set_locale("en")
	save.load_from_file("user://data.txt")
	
	yield(self, "colorChanged")
	$AnimationPlayer.play("cutscene")
	
	yield($AnimationPlayer, "animation_finished")
	change_scene()
	
	$Path2D/PathFollow2D/move.global_position = Vector2(482, 285)
	print($Path2D/PathFollow2D/move.global_position)
	sub = $Hero.global_position - $Path2D/PathFollow2D/move.global_position
	
func _input(event):
	if event.is_action_pressed("exit"):
		save.add_value("start_cutscene", true)
		save.save_to_file("user://data.txt")
		get_tree().change_scene("res://scenes/menu/menu/Menu.tscn")
func _process(delta):
	change_color(delta)
	camera.zoom.x = 640 / get_viewport_rect().size.x
	camera.zoom.y = camera.zoom.x

	if jump:
		print($Path2D/PathFollow2D/move.global_position)
		$Path2D/PathFollow2D.offset = $Path2D/PathFollow2D.offset + delta * jump_speed
		$Hero.global_position = $Path2D/PathFollow2D/move.global_position
	
func start_jump():
	jump = true

func change_scene() -> void:
	save.add_value("start_cutscene", true)
	save.save_to_file("user://data.txt")
	get_tree().change_scene("res://scenes/menu/menu/Menu.tscn")

func change_color(delta : float) -> void:
	if has_node("CanvasModulate") and $CanvasModulate.color.r < 1:
		$CanvasModulate.color.r += 0.5 * delta
		$CanvasModulate.color.g += 0.5 * delta
		$CanvasModulate.color.b += 0.5 * delta
	elif has_node("CanvasModulate") and $CanvasModulate.color.r >= 1:
		emit_signal("colorChanged")
		$CanvasModulate.queue_free()

func _on_Beloved_visibility_trigger_area_entered(area):
	area.get_parent().visible = false
