extends CanvasLayer

onready var label = $MarginContainer/Label

func _ready():
	var level_name = get_parent().get_parent().get_parent().name
	label.text = "You succsefully passed " + level_name
	
func _input(event):
	if event.is_action_pressed("exit"):
		$Scene_transition.transition_to("res://scenes/menu/menu/Menu.tscn")
