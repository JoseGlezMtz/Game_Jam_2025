extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 300.0
@export var max_health: int = 3
var health: int
signal player_died()

var Player_State : String
var Player_Direction : String


func _ready():
	health = max_health
	
func take_damage(amount: int):
	health -= amount
	if health <= 0:
		die()
		
		
func die():
	print("El jugador ha muerto")
	
	emit_signal("player_died") 
	queue_free()
	

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
		
	if direction.x==0 and direction.y==0:
		Player_State="Idle"
	else:
		Player_State="Walk"
	
	if direction.x:
		
		Player_Direction="Side"
		if direction.x>0:
			animated_sprite_2d.flip_h=false
		elif direction.x<0:
			animated_sprite_2d.flip_h=true
		
	if direction.y:
		if direction.y>0:
			Player_Direction="Front"
		elif direction.y<0:
			Player_Direction="Back"
	
	move_and_slide()
	Play_Animation(Player_Direction,Player_State)
	

func Play_Animation(dir,stt):
	animated_sprite_2d.play(dir+stt)
	
func _on_player_died() -> void:
	get_tree().reload_current_scene()
