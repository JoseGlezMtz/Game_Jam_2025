extends CharacterBody2D

const obj_bullet = preload("res://Scenes/bullet.tscn")
var speed: float = 100.0
var direction: int = 1

func _physics_process(delta: float) -> void:
	velocity.x = speed * direction
	move_and_slide()
	
	if is_on_wall():
		direction *= -1

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		body.take_damage(1)
		
func shoot(angle: float, speed: float):
	var new_bullet = obj_bullet.instantiate()
	new_bullet.velocity = Vector2(speed, 0).rotated(deg_to_rad(angle))
	new_bullet.position =  position
	get_parent().add_child(new_bullet)
