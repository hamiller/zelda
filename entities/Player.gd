extends KinematicBody2D

const MAX_SPEED = 200
signal habe_gehauen
signal player_vector

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Ich existiere!")
	

func _physics_process(_delta):
	var vector = Vector2.ZERO
	if Input.is_action_pressed("up_pressed"):
		vector.y = -1
	if Input.is_action_pressed("down_pressed"):
		vector.y = 1
	if Input.is_action_pressed("left_pressed"):
		vector.x = -1
	if Input.is_action_pressed("right_pressed"):
		vector.x = 1
	
	vector = vector.normalized()
	
	animate(vector.x, vector.y)
	move_and_slide(vector * MAX_SPEED)
	
	
func _input(event):
	if event.is_action_pressed("hack_and_slay"):
		print("killlll!!!!")
		emit_signal("habe_gehauen")


func animate(x, y):
	if x == 1:
		$AnimatedSprite.set_animation("move_right")
	if x == -1:
		$AnimatedSprite.set_animation("move_left")
	if y == 1:
		$AnimatedSprite.set_animation("move_down")
	if y == -1:
		$AnimatedSprite.set_animation("move_up")

