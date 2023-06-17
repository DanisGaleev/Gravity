extends Label

export var wait_time : int = 0.1

func _ready():
	$Timer.wait_time = wait_time

var update :bool

func _process(delta):
	if update:
		text = str(1 / delta)
		update = false


func _on_Timer_timeout():
	update = true
