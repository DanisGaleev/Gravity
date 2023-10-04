extends Node2D

onready var audio_1 = $AudioStreamPlayer
onready var audio_2 = $AudioStreamPlayer2
onready var bullet_sound = $BulletSound

var is_begin = false #исправить на _Global.is_begin
export var jump_speed : int

var isStarted = false
var player_and_beloved_jump = false

var save = Save_Handler.new()
signal colorChanged

func set_str():
	isStarted = true
func player_and_beloved_jump() -> void:
	player_and_beloved_jump = true

func _input(event):
	if event.is_action_pressed("exit"):
		change_scene()

func after_tween() -> void:
	$Hero.visible = false
	$AnimatedSprite.visible = true
	$AnimatedSprite.play("horn")
	yield($AnimatedSprite,"animation_finished")
	$SceneManagerEnd.play("cutscene_end")

func tween_animation() -> void:
	$Hero.global_position = _Global.playerPos_bef_Cutscene
	$Hero.rotation_degrees = _Global.playerRotation_bef_Cutscene
	$Path2D/PathFollow2D/Devil.visible = false
	var tween = create_tween()
	#tween.tween_property($Path2D/PathFollow2D/Devil, "visible", false, 0.0)
	tween.tween_property($Hero, "rotation_degrees", 0.0, 1.0)
	tween.tween_property($Hero, "global_position", Vector2(372, 120), 1.0)
	
	yield(tween, "finished")
	$SceneManagerEnd2.play("cutscene_end")
	#tween.tween_property($Hero, "visible", false, 0.0)
	#tween.tween_property($AnimatedSprite, "visible", true, 0.0)

#	yield(tween, "finished")
#	after_tween()
func horn_anim() -> void:
	$Hero.visible = false
	$Devil.visible = false
	$AnimatedSprite.visible = true
	$AnimatedSprite.play("horn")
func _ready():
	
	save.load_from_file("user://data.txt")
	
	audio_1.volume_db = _Global.map_number(save.get_value("cheech_value"), 0, 100, -80, 24)
	audio_2.volume_db = _Global.map_number(save.get_value("cheech_value"), 0, 100, -80, 24)
	bullet_sound.volume_db = _Global.map_number(save.get_value("sound_value"), 0, 100, -80, 24)	

	if is_begin:
		$SceneManagerBegin.play("cutscene")
		_Global.isStartScene = false
	else:
		tween_animation()
		yield(get_tree().create_timer(6.4), "timeout")
		horn_anim()
		#$SceneManagerEnd.play("cutscene_end")
	yield($SceneManagerBegin, "animation_finished")
	$Node/Scene_transition.transition_to("res://scenes/levels/plot_levels/Level7.tscn")
	#$Path2D/PathFollow2D/Devil.global_position = Vector2(420, 112)
func _process(delta):
#	change_color(delta)
	$Camera2D.zoom.x = 640 / get_viewport_rect().size.x
	$Camera2D.zoom.y = $Camera2D.zoom.x
	get_node("CanvasLayer").scale = Vector2(get_viewport_rect().size.x / 640, get_viewport_rect().size.y / 360)
	if isStarted:
		$Path2D/PathFollow2D.offset = $Path2D/PathFollow2D.offset + delta * jump_speed
	if player_and_beloved_jump:
		player_and_beloved_jump_func(delta)
	if has_node("Beloved_path/PathFollow2D/Beloved") and $Beloved_path/PathFollow2D.unit_offset == 1 and $Player_path/PathFollow2D.unit_offset == 1:
		player_and_beloved_jump = false
		$Player_path.queue_free()
		$Beloved_path.queue_free()
		yield($SceneManagerEnd2, "animation_finished")
		change_scene()
	if has_node("Path2D") and $Path2D/PathFollow2D.unit_offset == 1:
		isStarted = false
		$Path2D.queue_free()
		$Cell2.queue_free()
#		$Path2D/PathFollow2D/Devil.queue_free()
func change_scene() -> void:
	save.add_value("final_cutscene", true)
	save.save_to_file("user://data.txt")
	get_tree().change_scene("res://scenes/cutscenes/end_cutscene/EndCutScene.tscn")

func change_color(delta : float) -> void:
	if has_node("CanvasModulate") and $CanvasModulate.color.r < 1:
		$CanvasModulate.color.r += 0.5 * delta
		$CanvasModulate.color.g += 0.5 * delta
		$CanvasModulate.color.b += 0.5 * delta
	elif has_node("CanvasModulate") and $CanvasModulate.color.r >= 1:
		emit_signal("colorChanged")
		$CanvasModulate.queue_free()
func player_and_beloved_jump_func(delta) -> void:
	$Beloved_path/PathFollow2D.offset = $Beloved_path/PathFollow2D.offset + delta * 150
	$Player_path/PathFollow2D.offset = $Player_path/PathFollow2D.offset + delta * 130
