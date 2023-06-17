extends KinematicBody2D

export var canShot : bool

onready var timer = $Timer
onready var text = $Text
onready var pos = $Self_guided_bullets_position

var self_guided_bul = preload("res://scenes/entities/self_guided_bullet/Self_giuded_bullet.tscn")

var visibleTime = 4

var nowTime = 0

var enemy_phrases_en = [
	"You will never\nsafe your beloved!",
	"You will never\nget out of my maze!",
	"Your beloved will\nstay here forever!"]
var enemy_phrases_ru = [
	"Ты никогда\nне спасёшь свою возлюбленную!",
	"Ты никогда не выберишся\nиз моего лабиринта!",
	"Твоя возлюбленная\nостанется здесь навсегда!"]
var auduo_paths = {
	"You will never\nsafe your beloved!": "you_will_never_safe/you_will_never_safe_en",
	"You will never\nget out of my maze!" : "you_will_never_get_out/you_will_never_get_out_en",
	"Your beloved will\nstay here forever!" : "your_beloved_will_stay/your_beloved_will_stay_en",
	"Ты никогда\nне спасёшь свою возлюбленную!" : "you_will_never_safe/you_will_never_safe_ru",
	"Ты никогда не выберишся\nиз моего лабиринта!" : "you_will_never_get_out/you_will_never_get_out_ru",
	"Твоя возлюбленная\nостанется здесь навсегда!" : "your_beloved_will_stay/your_beloved_will_stay_ru"}
var wait_time = 0
var alpha_time = 3

var save = Save_Handler.new()

func _ready():
	randomize()
	save.load_from_file("user://data.txt")
	_on_Timer_timeout()
	if canShot:
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = 10
		timer.start()
		timer.connect("timeout", self, "bullet_timer")
		
func bullet_timer() -> void:
	print("bullet_timer")
	var bullet = self_guided_bul.instance()
	bullet.global_position = pos.global_position
	get_parent().add_child(bullet)
	
func play_sound():
	#save.get_value("language")
	#var t = text.text
	var def_path = "res://audio/devil_phrase/levels_phrase/"
	#var path: String
	$AudioStreamPlayer.stream = load(def_path + auduo_paths[text.text] + ".mp3")
#	if t == enemy_phrases_en[0]:
#		path = "you_will_never_safe/you_will_never_safe_en.mp3")
#	elif t == enemy_phrases_en[1]:
#		$AudioStreamPlayer.stream = load("you_will_never_get_out/you_will_never_get_out_en.mp3")
#	elif t == enemy_phrases_en[2]:
#		$AudioStreamPlayer.stream = load("your_beloved_will_stay/your_beloved_will_stay_en.mp3")
#	elif t == enemy_phrases_ru[0]:
#		$AudioStreamPlayer.stream = load("you_will_never_safe/you_will_never_safe_ru.mp3")
#	elif t == enemy_phrases_ru[1]:
#		$AudioStreamPlayer.stream = load("you_will_never_get_out/you_will_never_get_out_ru.mp3")
#	elif t == enemy_phrases_ru[2]:
#		$AudioStreamPlayer.stream = load("your_beloved_will_stay/your_beloved_will_stay_ru.mp3")
	$AudioStreamPlayer.playing = true
func _on_Timer_timeout():
	if 	save.get_value("language") == "english":
		text.text = enemy_phrases_en[randi() % enemy_phrases_en.size()]
	else:
		text.text = enemy_phrases_ru[randi() % enemy_phrases_ru.size()]
	#print(text.text)
