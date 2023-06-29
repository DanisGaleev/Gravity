extends KinematicBody2D
class_name Player

onready var camera = $Camera2D

const GRAVITY = 1.0
const WALK_SPEED = 25
var velocity = Vector2()
var g = 0
var normal = Vector2.DOWN
var isStarted = false setget set_isStarted
var isCutScene = false

func set_velocity_v() -> void:
	self.velocity = move_and_slide(self.velocity * 0, normal)
#	self.velocity = Vector2.ZERO
func get_rt():
	return 

func set_isStarted(new_is_started):
	isStarted = new_is_started
func set_isCutScene(new_is_started):
	isCutScene = new_is_started

func camera_to_def():
	rotation_degrees = 0
	print(rotation_degrees)

func _input(event):
	if event.is_action_pressed("left") or event.is_action_pressed("right") or event.is_action_pressed("rotate_left") or event.is_action_pressed("rotate_right"):
		isStarted = true
#	if event.is_action_pressed("zoom_in"):
#		var x = 0
#		$Camera2D.zoom += Vector2(0.1, 0.1)
#	if event.is_action_pressed("zoom_out"):
#		var x = 0
#		$Camera2D.zoom += Vector2(-0.1, -0.1)

func _process(delta):
	#print(get_viewport_rect().size)
	camera.zoom.x = 640 / get_viewport_rect().size.x
	camera.zoom.y = camera.zoom.x
	print(get_viewport_rect().size)
	get_parent().get_node("CanvasLayer").scale = Vector2(get_viewport_rect().size.x / 640, get_viewport_rect().size.y / 360)

func _physics_process(delta):
	if isStarted and !isCutScene:
		if g % 4 == 0:
			velocity.y += GRAVITY
		elif g % 4 == 1:
			velocity.x -= GRAVITY
		elif g % 4 == 2:
			velocity.y -= GRAVITY
		else:
			velocity.x += GRAVITY		
		if Input.is_action_pressed("left"):
			if g % 4 == 0:
				velocity.x = -WALK_SPEED
			elif g % 4 == 2:
				velocity.x = WALK_SPEED
			elif g % 4 == 1:
				velocity.y = -WALK_SPEED		
			else:
				velocity.y = WALK_SPEED
		elif Input.is_action_pressed("right"):
			if g % 4 == 0:
				velocity.x = WALK_SPEED
			elif g % 4 == 2:
				velocity.x = -WALK_SPEED
			elif g % 4 == 1:
				velocity.y = WALK_SPEED		
			else:
				velocity.y = -WALK_SPEED
		else:
			if g % 4 == 0 or g % 4 == 2:
				velocity.x = 0
			else:
				velocity.y = 0		
		if Input.is_action_just_pressed("rotate_left"):
			g += 1
			var x = velocity.x
			var y = velocity.y
			var xn = normal.x
			var yn = normal.y
			if g % 4 == 0 or g % 4 == 2:
				velocity.x = -y
				velocity.y = 0
			else:
				velocity.x = 0
				velocity.y = x
			rotation_degrees += 90
			#rotate(PI / 2)
			normal.x = -yn
			normal.y = xn
		if Input.is_action_just_pressed("rotate_right"):
			g -= 1
			if g == -1:
				g = 3
			var x = velocity.x
			var y = velocity.y
			var xn = normal.x
			var yn = normal.y
			if g % 4 == 0 or g % 4 == 2:
				velocity.x = y
				velocity.y = 0
			else:
				velocity.x = 0
				velocity.y = -x
			rotation_degrees -= 90
			#rotate(-PI / 2)
			normal.x = yn
			normal.y = -xn
		velocity = move_and_slide(velocity)
