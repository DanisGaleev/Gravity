extends Sprite

export var direction:Vector2
export var timerTime:int
export var speed:int

onready var tmr  = $Timer
onready var pos = $Position2D

var scene = preload("res://scenes/entities/bullet/Bullet.tscn")

func _ready():
	tmr.wait_time = timerTime

func _on_Timer_timeout():
	var ins = scene.instance()
	ins.position = pos.position
	ins.apply_central_impulse(direction * speed)
	add_child(ins)
