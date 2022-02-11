extends KinematicBody2D

var run_speed = 80
var state_machine 

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	print("Ich existiere!")
	

func _physics_process(_delta):
	var current = state_machine.get_current_node()
	var vector = Vector2.ZERO
	
	if Input.is_action_just_pressed("hack_and_slay"):
		state_machine.travel("attack2")
		return
	if Input.is_action_pressed("up_pressed"):
		vector.y = -1
	if Input.is_action_pressed("down_pressed"):
		vector.y = 1
	if Input.is_action_pressed("left_pressed"):
		vector.x = -1
		$Sprite.scale.x = -1
	if Input.is_action_pressed("right_pressed"):
		vector.x = 1
		$Sprite.scale.x = 1
	if vector.length() == 0:
		state_machine.travel("idle")
	if vector.length() > 0:
		state_machine.travel("run")
	vector = vector.normalized()
	
	#animate(vector.x, vector.y)
	move_and_slide(vector * run_speed)
	#rotation = atan2(vector.y, vector.x)
	
	
func hurt():
	state_machine.travel("hurt")
func die():
	state_machine.travel("ded")
	set_physics_process(false)
	
	
	
func _input(event):
	if event.is_action_pressed("hack_and_slay"):
		print("killlll")
		

func hit(amount):
	self.health -= amount
	print(self.health)
	emit_signal("player_hit", self.health)

func animate(x, y):
	if x == 1:
		$AnimatedSprite.set_animation("move_right")
	if x == -1:
		$AnimatedSprite.set_animation("move_left")
	if y == 1:
		$AnimatedSprite.set_animation("move_down")
	if y == -1:
		$AnimatedSprite.set_animation("move_up")

