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
		$AudioStreamPlayer.stream = load("res://audio/devil_phrase/levels_phrase/you_will_never_safe/you_will_never_safe_en.mp3")
	elif text.text == "You will never\nget out of my maze":
		$AudioStreamPlayer.stream = load("res://audio/devil_phrase/levels_phrase/you_will_never_get_out/you_will_never_get_out_en.mp3")
	else:
		$AudioStreamPlayer.stream = load("res://audio/devil_phrase/levels_phrase/your_beloved_will_stay/your_beloved_will_stay_en.mp3")
	$AudioStreamPlayer.playing = true
func _on_Timer_timeout():
	text.text = enemy_phrases[randi() % enemy_phrases.size()]
	print(text.text)
