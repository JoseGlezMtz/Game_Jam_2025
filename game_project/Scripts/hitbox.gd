extends Area2D

var velocity: Vector2 = Vector2()
const duration: float = 20.0

func _ready() -> void:
	connect("body_entered", _on_body_entered)
	await get_tree().create_timer(duration).timeout
	queue_free()
	
func _physics_process(delta: float) -> void:
	position += velocity * delta
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		body.take_damage(1)
		queue_free()
