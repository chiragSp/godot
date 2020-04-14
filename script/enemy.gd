extends KinematicBody2D

const MAX_SPEED = 100
const ACCELERATION = 100
const FRICTION = 100
const GRAVITY = 10
const JUMP_FORCE = 280
const FLOOR = Vector2(0,-1)

var velocity = Vector2.ZERO
var direction = 1
var is_dead = false




func dead():
	is_dead = true
	velocity = Vector2(0,0)
	$AnimationPlayer.play("die")
	$CollisionShape2D.disabled = true
	$Timer.start()

func _physics_process(delta):
	if is_dead == false: 
		velocity.x = MAX_SPEED * direction
		if direction == 1:
			$AnimationPlayer.play("walk")
			$Sprite.flip_h = false
		else:
			$AnimationPlayer.play("walk")
			$Sprite.flip_h = true
		velocity.y += GRAVITY  
		velocity = move_and_slide(velocity, FLOOR)
	
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1
	
	
	if $RayCast2D.is_colliding() == false:
		 direction = direction * -1
		 $RayCast2D.position.x *= -1


func _on_Timer_timeout() -> void:
	queue_free()
