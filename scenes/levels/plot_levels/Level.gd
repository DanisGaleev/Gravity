extends Node2D

signal continue_animation

export var speed : float

var isStart : bool
var win_screen_scene = preload("res://scenes/entities/win_screen/WinScreen.tscn")
var win_screen: CanvasLayer
var died_screen_scene = preload("res://scenes/entities/died_screen/DiedScreen.tscn")
var died_screen: CanvasLayer
var enemy_scene = preload("res://scenes/entities/enemy/Enemy.tscn")
var enemy: KinematicBody2D

onready var player = $Player
onready var startPosition = $Start/startPos
onready var enemyPos = $EnemyPos
onready var navmesh = $BulletsNavigation
onready var jump_hint = $JumpHint

func start():
	isStart = true

func _ready():
	player.global_position = startPosition.global_position
func _input(event):
	if event.is_action_pressed("jump"):
		emit_signal("continue_animation")
		jump_hint.visible = false
func continue_animation() -> void:
	$SwordPickUpAnimation.play("sword")
func remove_wall(tilemap_node_path : NodePath) -> void:
	var tilemap = get_node(tilemap_node_path)
	tilemap.set_cell(17, 15, -1)
	tilemap.set_cell(20, 16, -1)
	tilemap.set_cell(21, 16, -1)
	tilemap.set_cell(22, 16, -1)
	tilemap.set_cell(23, 16, -1)
	tilemap.set_cell(24, 16, -1)
	tilemap.set_cell(25, 14, -1)
	tilemap.set_cell(26, 14, -1)
	tilemap.set_cell(27, 14, -1)
	tilemap.set_cell(28, 14, -1)
	tilemap.update_bitmask_region(Vector2(17, 16), Vector2(28, 14))
	
func tween() -> void:
	$Player.set_isCutScene(true)
	$Player.set_velocity_v()
	var tween = create_tween()
	match int($Player.rotation_degrees):
		90:
			$Player.normal = $Player.normal.rotated(-90)
			$Player.g -= 1
		180:
			$Player.normal = $Player.normal.rotated(-180)
			$Player.g -= 2
		270:
			$Player.normal = $Player.normal.rotated(-270)
			$Player.g -= 3
		-90:
			$Player.normal = $Player.normal.rotated(90)
			$Player.g += 1
		-180:
			$Player.normal = $Player.normal.rotated(180)
			$Player.g += 2
		-270:
			$Player.normal = $Player.normal.rotated(270)
			$Player.g += 3
	if $Player.g == -1:
		$Player.g = 3
	tween.tween_property($Player, "rotation_degrees", 0.0, 1.0)
	tween.tween_property($Player, "global_position", Vector2(476, 216), 1.0)
	yield($PreCutScene, "animation_finished")
	yield(self, "continue_animation")
	continue_animation()
	 
func _process(delta):
	if isStart:
		if $JumpPath/JumpFollow2D.unit_offset < 0.99:
			print($JumpPath/JumpFollow2D.offset)
			$Player.set_isCutScene(true)
			$Player.set_velocity_v()
			$JumpPath/JumpFollow2D.offset = $JumpPath/JumpFollow2D.offset + delta * speed
			$Player.global_position = $JumpPath/JumpFollow2D/HeroMoveNode.global_position
		else:
			$JumpPath/JumpFollow2D.unit_offset = 1
			$Player.global_position = $JumpPath/JumpFollow2D/HeroMoveNode.global_position
			$JumpPath.queue_free()
			isStart = false
			$Player.set_isCutScene(false)


func _on_EnemyTrigger_body_entered(body):
	if body.name == "Player" and !has_node("Enemy") and has_node("EnemyPos"):
		enemy = enemy_scene.instance()
		enemy.sprite_visible = true
		add_child(enemy)
		enemy.global_position = enemyPos.global_position

func _on_SpikeMap_body_entered(body):
	if body.get_name() == "Player":
		died_screen = died_screen_scene.instance()
		print(get_node("GUI/GUI"))
		get_node("GUI/GUI").add_child(died_screen)
		for i in get_children():
			if i.name != "GUI":
				i.queue_free()
		$Player.queue_free()


func _on_StartCutsceneTrigger_body_entered(body):
	if body.name == "Player":
		_Global.playerPos_bef_Cutscene = $Player.global_position
		_Global.playerRotation_bef_Cutscene = round($Player.rotation_degrees)
		_Global.isStartScene = false
		var save = Save_Handler.new()
		save.load_from_file("user://data.txt")
		save.add_value("level", 8)
		save.save_to_file("user://data.txt")
		$StartCutsceneTrigger.queue_free()
		get_tree().change_scene("res://scenes/cutscenes/final_cutscene/Final_Cutscene.tscn")
