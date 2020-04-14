extends KinematicBody2D

const MAX_SPEED = 100
const ACCELERATION = 100
const FRICTION = 100
const GRAVITY = 10
const JUMP_FORCE = 280
const FLOOR = Vector2(0,-1)
const FIREBALL = preload("res://main scrn/Fireball.tscn")

var velocity = Vector2.ZERO
var on_ground = true
var is_dead = false
var pursue_player = false
var is_attacking = false
var on_ladder = false



func _physics_process(delta):
	print(on_ladder)
	
	if is_dead == false:
		
		
		if Input.is_action_pressed("ui_right"):
			if is_attacking == false or is_on_floor() == false:
				velocity.x = MAX_SPEED
				if is_attacking == false:
					$Sprite.play("walk")
					$Sprite.flip_h = false
					if sign($Position2D.position.x) == -1:
						$Position2D.position.x *= -1
		elif Input.is_action_pressed("ui_left"):
			if is_attacking == false or is_on_floor() == false:
				velocity.x = -MAX_SPEED
				if is_attacking == false:
					$Sprite.play("walk")
					$Sprite.flip_h = true
					if sign($Position2D.position.x) == 1:
						$Position2D.position.x *= -1
		else:
			velocity.x = 0
			if on_ground == true && is_attacking == false:
				$Sprite.play("idle")
	
		if Input.is_action_pressed("ui_up"):
			if is_attacking == false:
				if on_ground == true:
					velocity.y = -JUMP_FORCE
					$Sprite.play("jump")
					on_ground = false

		velocity.y += GRAVITY
		
		
		
		if Input.is_action_just_pressed("ui_focus_next") && is_attacking == false:
			if is_on_floor():
				velocity.x = 0
			is_attacking = true
			$Sprite.play("attack animation")
			var fireball = FIREBALL.instance()
			if sign($Position2D.position.x) == 1:
				fireball.set_fireball_direction(1)
			else:
				fireball.set_fireball_direction(-1)
			get_parent().add_child(fireball)
			fireball.position = $Position2D.global_position
		
		
		
		if is_on_floor():
			if on_ground == false:
				is_attacking = false
			on_ground = true
		else:
			if is_attacking == false:
				 on_ground = false
				# if velocity.y < 0:
				#	$sprite.play()
				#else:
				#	$sprite.play()
				
				
		if on_ladder == true:
			GRAVITY == 0
			if Input.is_action_pressed("climb up"):
				velocity.y = -MAX_SPEED
				$Sprite.play("back")
			
			elif Input.is_action_pressed("climb down"):
				velocity.y = MAX_SPEED
				$Sprite.play("back")
			else:
				velocity.y = 0
				$Sprite.play("back")
		else:
			GRAVITY == 10
		velocity = move_and_slide(velocity, FLOOR)
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "enemy" in get_slide_collision(i).collider.name:
					dead()
			

func dead():
	is_dead = true
	velocity = Vector2(0,0)
	$Sprite.play("dead")
	$CollisionShape2D.disabled = true
	$Timer.start()
	
func _on_Timer_timeout() -> void:
	get_tree().reload_current_scene()
	

func _on_Area2D_area_entered(area: Area2D) -> void:
	get_parent().get_node("Area2D/grass").playing = true
	get_parent().get_node("Area2D/grass").frame = 0
	get_parent().get_node("Area2D2/grass").playing = true
	get_parent().get_node("Area2D2/grass").frame = 0
	get_parent().get_node("Area2D3/grass").playing = true
	get_parent().get_node("Area2D3/grass").frame = 0
	get_parent().get_node("Area2D4/grass").playing = true
	get_parent().get_node("Area2D4/grass").frame = 0
	get_parent().get_node("Area2D5/grass").playing = true
	get_parent().get_node("Area2D5/grass").frame = 0
	get_parent().get_node("Area2D6/grass").playing = true
	get_parent().get_node("Area2D6/grass").frame = 0
	get_parent().get_node("Area2D7/grass").playing = true
	get_parent().get_node("Area2D7/grass").frame = 0


func _on_Sprite_animation_finished() -> void:
	is_attacking = false



