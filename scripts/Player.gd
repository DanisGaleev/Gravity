extends KinematicBody2D
class_name Player

const GRAVITY = 1.0
const WALK_SPEED = 25
var velocity = Vector2()
var g = 0
var normal = Vector2.DOWN
var isStarted = false setget set_isStarted

func set_isStarted(new_is_started):
	isStarted = new_is_started

func _ready():
	#get_parent().get_node("spikes/spike_big/Area2D").connect("spike_connected", self, "camera_to_def")
	pass
func camera_to_def():
	rotation_degrees = 0
	print(rotation_degrees)

func _input(event):
	if event.is_action_pressed("left") or event.is_action_pressed("right") or event.is_action_pressed("rotate_left") or event.is_action_pressed("rotate_right"):
		isStarted = true
	if event.is_action_pressed("zoom_in"):
		var x = 0
		$Camera2D.zoom += Vector2(0.1, 0.1)
	if event.is_action_pressed("zoom_out"):
		var x = 0
		$Camera2D.zoom += Vector2(-0.1, -0.1)

func _physics_process(delta):
	if isStarted:
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
				
			rotate(PI / 2)
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
			#velocity.x = y
			#velocity.y = -x	
			rotate(-PI / 2)
			normal.x = yn
			normal.y = -xn

		velocity = move_and_slide(velocity, normal)		
	#print(String(Engine.get_frames_per_second()))
