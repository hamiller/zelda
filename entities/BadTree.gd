extends KinematicBody2D

var run_speed = 25
var velocity = Vector2.ZERO
var player = null

func _physics_process(delta):
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position)
	
	velocity = velocity.normalized()
	animate(velocity.x, velocity.y)
	velocity = move_and_slide(velocity * run_speed)

func _on_DetectRadius_body_entered(body):
	player = body
	print("Player zu sehen")

func _on_DetectRadius_body_exited(body):
	player = null
	print("Player nicht mehr zu sehen")
	
func animate(x, y):
	$AnimatedSprite.playing = !(x==0 && y==0)
		
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


func _on_HitRadius_body_entered(body):
	if body.name == 'Player':
		body.hit(1)

func hit():
	print("bin getroffen")
	queue_free()
