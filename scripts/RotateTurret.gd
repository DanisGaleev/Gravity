extends KinematicBody2D


export var timerTime:int
export var ang_speed:int
export var speed:int

var direction = Vector2()

onready var tmr  = $Timer
onready var pos = $Position2D

var scene = preload("res://scenes/Bullet.tscn")

func _ready():
	tmr.wait_time = timerTime
	
func _process(delta):
	rotation += (ang_speed * delta)	
	rotation = deg2rad(int(rad2deg(rotation)) % 360)

func _on_Timer_timeout():
	var dir_angl = rad2deg(rotation)
	direction = Vector2(0,1).rotated(dir_angl)
	print(dir_angl, direction.x, direction.y)
	var ins = scene.instance()
	ins.global_position = pos.global_position
	ins.apply_central_impulse(direction * speed)
	print(get_parent().name)
	get_parent().add_child(ins)
