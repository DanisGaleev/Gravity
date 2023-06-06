extends Node2D

class_name Dialog

export (Array, String) var dialog
onready var timer = $Timer
onready var d1 = $Dialog1
onready var d2 = $Dialog2

var this_phrase := 0
#func _ready():
#	timer.start()
#	timer.connect("timeout", self, "time_out")
func start():
	timer.wait_time = 2
	timer.start()
	timer.connect("timeout", self, "time_out")

func time_out():
	if this_phrase == dialog.size():
		queue_free()
		return
	if this_phrase % 2 == 0:
		d1.text = dialog[this_phrase]
		d2.text = ""
	else:
		d2.text = dialog[this_phrase]
		d1.text = ""
	this_phrase += 1	
