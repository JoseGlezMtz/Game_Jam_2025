extends CharacterBody2D


const SPEED = 300.0
#const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)
	
	# Normalize vectors for correction of movement
	if direction.length() > 0:
		direction = direction.normalized()
		velocity = direction * SPEED
	else:
		velocity = Vector2(
			move_toward(velocity.x, 0, SPEED),
			move_toward(velocity.y, 0, SPEED)
		)
	move_and_slide()
