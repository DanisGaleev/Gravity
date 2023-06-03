extends Node2D

onready var player = $Player
onready var startPosition = $Start/startPos

func _ready():
	player.global_position = startPosition.global_position
