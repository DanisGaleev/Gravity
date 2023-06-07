extends KinematicBody2D

onready var timer = $Timer
onready var text = $Text

var visibleTime = 4

var nowTime = 0

var enemy_phrases = ["You will never\nsafe your beloved", "You will never\nget out of my maze", "You beloved will\nstay here forever"]

var wait_time = 0
var alpha_time = 3

func _ready():
	randomize()

func play_sound():
	print(text.text)
	if text.text == "You will never\nsafe your beloved":
		$AudioStreamPlayer.stream = load("res://audio/you_will_never_safe.mp3")
	elif text.text == "You will never\nget out of my maze":
		$AudioStreamPlayer.stream = load("res://audio/you_will_never_get_out.mp3")
	else:
		$AudioStreamPlayer.stream = load("res://audio/your_beloved_will_stay.mp3")
	$AudioStreamPlayer.playing = true
func _on_Timer_timeout():
	text.text = enemy_phrases[randi() % enemy_phrases.size()]
	print(text.text)
