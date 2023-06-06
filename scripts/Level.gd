extends Node2D

var win_screen_scene = preload("res://scenes/WinScreen.tscn")
var win_screen: CanvasLayer
var died_screen_scene = preload("res://scenes/DiedScreen.tscn")
var died_screen: CanvasLayer
var enemy_scene = preload("res://scenes/Enemy.tscn")
var enemy: KinematicBody2D

onready var player = $Player
onready var startPosition = $Start/startPos
onready var enemyPos = $EnemyPos

func _ready():
	player.global_position = startPosition.global_position


func _on_Spikes_body_entered(body):
	if body.get_name() == "Player":
		died_screen = died_screen_scene.instance()
		#died_screen.rect_position = Vector2(312, 150)
		get_node("Node/Control").add_child(died_screen)
		for i in get_children():
			if i.name != "Node":
				#i.visible = false	
				i.queue_free()
		$Player.queue_free()


func _on_EnemyTrigger_body_entered(body):
	if body.name == "Player" and !has_node("Enemy"):
		enemy = enemy_scene.instance()
		add_child(enemy)
		enemy.global_position = enemyPos.global_position
