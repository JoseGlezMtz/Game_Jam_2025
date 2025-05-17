extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var plat_manager: Node = $"../Plat_manager"
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var Player_Direction
var Player_State


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		plat_manager.cambiar_estado()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	Player_Direction="Side"
	if direction:
		velocity.x = direction * SPEED
		Player_State="Walk"
		if direction>0:
			animated_sprite_2d.flip_h=false
		else:
			animated_sprite_2d.flip_h=true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		Player_State="Idle"
	
	move_and_slide()
	Play_Animation(Player_Direction,Player_State)
	

func Play_Animation(dir,stt):
	animated_sprite_2d.play(dir+stt)
