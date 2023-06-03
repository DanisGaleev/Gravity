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

func _process(delta):
	pass
	#print(str(text.modulate.a) + "  "  + str(wait_time))
	#wait_time += delta
	#if wait_time >= 3 and wait_time <= 5:
	#	text.modulate.a += 1 / (1 / delta * 3)
	#elif wait_time >= 5 and wait_time <= 8:
	#	text.modulate.a -= 1 / (1 / delta * 3)
	#if abs(wait_time - 5) <= 0.02 and text.modulate.a != 1:
	#	text.modulate.a = 1	
	#if wait_time >= 10:
	#	wait_time = 0
	#	text.modulate.a = 0
	#	text.text = enemy_phrases[randi() % enemy_phrases.size()]
	#if text.visible:	
	#	text.modulate.a
	#	nowTime += delta
	#if nowTime >= visibleTime and text.visible:
	#	text.visible = false
	#	nowTime = 0

func play_sound():
	print(text.text)
	if text.text == "You will never\nsafe your beloved":
		$AudioStreamPlayer.stream = load("res://you_will_never_safe.mp3")
	elif text.text == "You will never\nget out of my maze":
		$AudioStreamPlayer.stream = load("res://you_will_never_get_out.mp3")
	else:
		$AudioStreamPlayer.stream = load("res://your_beloved_will_stay.mp3")
	$AudioStreamPlayer.playing = true
func _on_Timer_timeout():
	#text.visible = true
	text.text = enemy_phrases[randi() % enemy_phrases.size()]
	print(text.text)
	#$AnimationPlayer.play("alpha")
