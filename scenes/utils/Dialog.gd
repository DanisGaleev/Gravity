extends Node2D

class_name Dialog

export (Array, String) var dialog_en
export (Array, String) var dialog_ru

export var wait_time:int = 2

onready var timer = $Timer
onready var d1 = $Dialog1
onready var d2 = $Dialog2

var this_phrase := 0
var lang : String

func _ready():
	var save = Save_Handler.new()
	save.load_from_file("user://data.txt")
	lang = save.get_value("language")

func start():
	timer.wait_time = wait_time
	timer.start()
	timer.connect("timeout", self, "time_out")

func time_out():
	if this_phrase == dialog_en.size():
		queue_free()
		return
	if this_phrase % 2 == 0:
		if lang == "russian":
			d1.text = dialog_ru[this_phrase]
		elif lang == "englisn":
			d1.text = dialog_en[this_phrase]
		d2.text = ""
	else:
		if lang == "russian":
			d2.text = dialog_ru[this_phrase]
		elif lang == "englisn":
			d2.text = dialog_en[this_phrase]
		d1.text = ""
	this_phrase += 1	
