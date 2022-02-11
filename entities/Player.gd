extends KinematicBody2D

const MAX_SPEED = 200
signal habe_gehauen
signal player_vector
signal player_hit

var health = 5
	
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
	
	if vector != Vector2.ZERO:	
		$RayCast2D.cast_to = vector * 8
	
	animate(vector.x, vector.y)
	move_and_slide(vector * MAX_SPEED)
	
	
func _input(event):
	if event.is_action_pressed("hack_and_slay"):
		emit_signal("habe_gehauen")
		var target = $RayCast2D.get_collider()
		if target != null:
			if target.is_in_group("NPC"):
				set_process_input(false)
				target.talk()
				return
			if target.is_in_group("ENEMY"):
				return


func hit(amount):
	self.health -= amount
	print("ups, erwischt: ", self.health)
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

