extends CanvasLayer

func _ready():
	Save.new().save_level("1")

func _input(event):
	if event.is_action_pressed("exit"):
		get_tree().change_scene("res://scenes/Menu.tscn")	

func _on_Replay_pressed():
	get_tree().reload_current_scene()

func _on_Exit_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
