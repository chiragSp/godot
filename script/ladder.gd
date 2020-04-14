extends Area2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_laddder_body_entered(body):
	if body.name == "PlayerBody":
		get_parent().get_node("PlayerBody").on_ladder = true


func _on_laddder_body_exited(body):
	if body.name == "PlayerBody":
		get_parent().get_node("PlayerBody").on_ladder = false


func _on_laddder2_body_entered(body):
	if body.name == "PlayerBody":
		get_parent().get_node("PlayerBody").on_ladder = true


func _on_laddder2_body_exited(body):
	if body.name == "PlayerBody":
		get_parent().get_node("PlayerBody").on_ladder = false
