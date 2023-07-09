extends ColorRect
func _ready() -> void:
	# Plays the animation backward to fade in
	$AnimationPlayer.play("scene_transition")

func transition_to(_next_scene : String) -> void:
	# Plays the Fade animation and wait until it finishes
	$AnimationPlayer.play_backwards("scene_transition")
	yield($AnimationPlayer, "animation_finished")
	# Changes the scene
	get_tree().change_scene(_next_scene)
