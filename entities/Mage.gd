extends KinematicBody2D

const run_speed = 150
signal habe_gehauen
signal player_vector
signal player_hit

var health = 3

const IDLE_STATE = 'idle'
const ATTACK_STATE = 'attack'

var player = null
var state = IDLE_STATE
var velocity
	
var current_delta = 0
	
func _enter_tree():
	$AnimatedSprite.set_animation("idle_down")
	
func _physics_process(_delta):
	if state == IDLE_STATE:
		process_idle(_delta)
	elif state == ATTACK_STATE:
		process_attack(_delta)
	
func process_idle(_delta):
	var target = $Vision.get_collider()
	
	if target != null && target.name == "Player":
		state = ATTACK_STATE
		player = target
		return
	
	current_delta += _delta
	
	if (current_delta > 2):
		current_delta = 0
		turn_into_random_direction()
	
func process_attack(_delta):
	velocity = position.direction_to(player.position)
	
	print(velocity)
	
	animate(velocity.x, velocity.y)
	velocity = move_and_slide(velocity * run_speed)
	
func animate(x, y):
	if(abs(x)>abs(y)):
		if x > 0:
			$AnimatedSprite.set_animation("move_right")
		if x < 0:
			$AnimatedSprite.set_animation("move_left")
	else:
		if y > 0:
			$AnimatedSprite.set_animation("move_down")
		if y < 0:
			$AnimatedSprite.set_animation("move_up")

func turn_into_random_direction():
	if $AnimatedSprite.animation == "idle_right":
		$AnimatedSprite.set_animation("idle_down")
		$Vision.cast_to = Vector2.DOWN * 20
	elif $AnimatedSprite.animation == "idle_down":
		$AnimatedSprite.set_animation("idle_left")
		$Vision.cast_to = Vector2.LEFT * 20
	elif $AnimatedSprite.animation == "idle_left":
		$AnimatedSprite.set_animation("idle_up")
		$Vision.cast_to = Vector2.UP * 20
	elif $AnimatedSprite.animation == "idle_up":
		$AnimatedSprite.set_animation("idle_right")
		$Vision.cast_to = Vector2.RIGHT * 20

func hit(amount):
	self.health -= amount
	print("Mage kriegt haue: ", self.health)

