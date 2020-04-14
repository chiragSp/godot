extends KinematicBody2D

const MAX_SPEED = 10
const ACCELERATION = 100
const FRICTION = 100
const GRAVITY = 10
const JUMP_FORCE = 280
const FLOOR = Vector2(0, -1)
var pursue_player = false
var velocity = Vector2(0,-1)
var direction = -1
func _ready() -> void:
	set_position(Vector2())
func _physics_process(delta):
	if pursue_player == true:
		$Timer.start()
		velocity.x = MAX_SPEED * direction
		velocity.y += GRAVITY  
		velocity = move_and_slide(velocity, FLOOR)
func pursue_player():
	pursue_player = false
	$Timer.start()
	set_position(Vector2())


func _on_Area2D_body_entered(body: Node) -> void:
	if body.get_name() == "PlayerBody":
		print("Pursuing player!")
		pursue_player = true



func _on_Area2D_body_exited(body: Node) -> void:
	if body.get_name() == "PlayerBody":
		print("player leave alone")
		pursue_player = false
