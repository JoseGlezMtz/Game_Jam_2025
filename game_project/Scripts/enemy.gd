extends Node2D

const obj_bullet = preload("res://Scenes/bullet.tscn")

func shoot(directiion: float, speed: float):
	var new_bullet= obj_bullet.instantiate()
	new_bullet.position=self.position
	get_parent().add_child(new_bullet)
	
func _physics_process(delta: float) -> void:
	shoot(1.0, 10.0)
