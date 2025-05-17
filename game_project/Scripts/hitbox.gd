extends Node2D

var speed: float = 200
const duration: float = 20.0
@export var direction:Vector2 

func _ready() -> void:
	connect("body_entered", _on_bullet_body_entered)
	await get_tree().create_timer(duration).timeout
	queue_free()
	
func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	

func _on_bullet_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.take_damage(1)
		queue_free()
