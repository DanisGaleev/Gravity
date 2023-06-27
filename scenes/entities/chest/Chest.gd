extends Node2D

export var trigger_path : NodePath
export var animation_path : NodePath

var trigger : Area2D
var animation : AnimationPlayer

func _ready():
	trigger = get_node(trigger_path)
	trigger.connect("body_entered", self, "_on_Trigger_entered")
	
func _on_Trigger_entered(body):
	if body.name == "Player":
		animation = get_node(animation_path)
		animation.play("sword")
		#добавитить вызов анимации
		trigger.queue_free()
