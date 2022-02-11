extends KinematicBody2D

const MAX_SPEED = 200

signal habe_gehauen
signal player_hit

var health = 5
var state_machine 
var _position_last_frame := Vector2()
var _cardinal_direction = 0

func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	
func _physics_process(_delta):
	var current = state_machine.get_current_node()
	var vector = Vector2.ZERO
	var hitting
	if Input.is_action_pressed("up_pressed"):
		vector.y += -1
	if Input.is_action_pressed("down_pressed"):
		vector.y += 1
	if Input.is_action_pressed("left_pressed"):
		vector.x += -1
	if Input.is_action_pressed("right_pressed"):
		vector.x += 1
	if vector.length() == 0 && hitting == false:
		state_machine.stop()
	vector = vector.normalized()
	
	if vector != Vector2.ZERO:
		$RayCast2D.cast_to = vector * 8
	
	animate(vector.x, vector.y)
	move_and_slide(vector * MAX_SPEED)

func _input(event):
	var hitting
	if event.is_action_pressed("hack_and_slay"):
		emit_signal("habe_gehauen")
		hitting = true
		hit_him()
		print("aaaaaaaaaaaaa")
		var target = $RayCast2D.get_collider()
		if target != null:
			if target.is_in_group("NPC"):
				set_process_input(false)
				target.talk()
				return
			if target.is_in_group("ENEMY"):
				return
	

func hit_him():
	var current = state_machine.get_current_node()
	# Get motion vector between previous and current position
	var motion = position - _position_last_frame
	# If the node actually moved, we'll recompute its direction.
	# If it didn't, we'll just the last known one.
	if motion.length() > 0.0001:
		# Now if you want a value between N.S.W.E,
		# you can use the angle of the motion.
		# I came up with this formula last time I needed it:
		_cardinal_direction = int(4.0 * (motion.rotated(PI / 4.0).angle() + PI) / TAU)
# Remember our current position for next frame
	_position_last_frame = position
	# And now you have it!
	# You can even use it with an array since it's like an index
	match _cardinal_direction:
		0:
			state_machine.travel("hit_left")
			print("West")
		1:
			state_machine.travel("hit_up")
			print("North")
		2:
			state_machine.travel("hit_right")
			print("East")
		3:
			state_machine.travel("hit_down")
			print("South")

	

func hit(dmg):
	print("Spieler wurde getroffen", dmg)
	health -= dmg
	emit_signal("player_hit", health)

func animate(x, y):
	var current = state_machine.get_current_node()
	if x == 1:
		state_machine.travel("walk_right")
	if x == -1:
		state_machine.travel("walk_left")
	if y == 1:
		state_machine.travel("walk_down")
	if y == -1:
		state_machine.travel("walk_up")

