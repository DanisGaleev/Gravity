extends Node2D


func _on_Trigger_body_entered(body):
	print(body.name)
	if body.name == "Player":
		self.queue_free()
