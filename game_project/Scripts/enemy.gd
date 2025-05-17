extends Node2D

const obj_bullet = preload("res://Scenes/bullet.tscn")
@onready var timer: Timer = $Timer
var attack_types = ["burst", "star", "fan", "spiral", "exploding"]
var current_attack = "star"
var attack_finished= true
var general_delay=1

func _ready() -> void:
	timer.start()
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	
func _on_timer_timeout() -> void:
	move_randomly()
	if attack_finished:
		attack_finished=false
		current_attack = attack_types[randi() % attack_types.size()]
		print(current_attack)
		
		match current_attack:
			"burst":
				shoot_burst(200, 50, 0.1)
			"star":
				shoot_star(200, 8, 10)
			"fan":
				shoot_fan(200, 10, 30)
			"spiral":
				shoot_spiral(200, 18, 20)
			"exploding":
				shoot_exploding(150, 5, 1.5, 8)
		await get_tree().create_timer(general_delay).timeout
		
		timer.start()

func move_randomly():
	var area_size = Vector2(850, 515)
	var new_position = Vector2(
		randf_range(30, area_size.x),
		randf_range(30, area_size.y)
	)
	position = new_position

func shoot(direction: float, speed: float):
	var new_bullet= obj_bullet.instantiate()
	new_bullet.position=self.position
	get_parent().add_child(new_bullet)

func shoot_burst(speed: float, count: int, delay: float):
	for i in range(count):
		await get_tree().create_timer(delay).timeout
		var new_bullet = obj_bullet.instantiate()
		new_bullet.position = self.position
		var angle = randf_range(0.0, 360.0)
		new_bullet.direction = Vector2.RIGHT.rotated(deg_to_rad(angle))
		new_bullet.speed = speed
		get_parent().add_child(new_bullet)
	attack_finished=true
		
func shoot_star(speed: float, num_shots: int, shot_times: int):
	for j in range(shot_times):
		await get_tree().create_timer(0.2).timeout
		for i in range(num_shots):
			var angle = i * (360 / num_shots)
			var new_bullet = obj_bullet.instantiate()
			new_bullet.position = self.position
			new_bullet.direction = Vector2.RIGHT.rotated(deg_to_rad(angle)) # Balas en círculo
			new_bullet.speed = speed
			get_parent().add_child(new_bullet)
	attack_finished=true

func shoot_spiral(speed: float, num_shots: int, rotation_speed: float):
	for i in range(num_shots):
		var angle = i * rotation_speed
		var new_bullet = obj_bullet.instantiate()
		new_bullet.position = self.position
		new_bullet.direction = Vector2.RIGHT.rotated(deg_to_rad(angle))  # Rotamos en espiral
		new_bullet.speed = speed
		get_parent().add_child(new_bullet)
	attack_finished=true

func shoot_fan(speed: float, num_shots: int, spread_angle: float):
	var base_direction = Vector2.RIGHT.rotated(deg_to_rad(randf_range(0.0, 360.0)))
	
	for i in range(num_shots):
		var base_angle = -spread_angle / 2 + (i / float(num_shots - 1)) * spread_angle
		var random_offset = randf_range(-5.0, 5.0)
		var final_angle = base_angle + random_offset
		
		var direction = base_direction.rotated(deg_to_rad(final_angle))
		var new_bullet = obj_bullet.instantiate()
		new_bullet.position = self.position
		new_bullet.direction = direction
		new_bullet.speed = speed
		get_parent().add_child(new_bullet)
	attack_finished=true
	
func shoot_exploding(speed: float, count: int, explode_after: float, fragments: int):
	for i in range(count):
		var main_bullet = obj_bullet.instantiate()
		main_bullet.position = self.position
		var angle = randf_range(0.0, 360.0)
		main_bullet.direction = Vector2.RIGHT.rotated(deg_to_rad(angle))
		main_bullet.speed = speed
		get_parent().add_child(main_bullet)
		
		explote_later(main_bullet, explode_after, fragments)
	attack_finished = true

func explote_later(bullet: Node, delay: float, fragments: int) -> void:
	await get_tree().create_timer(delay).timeout
	if bullet and bullet.is_inside_tree():
		for i in range(fragments):
			var angle = i * (360.0 / fragments)
			var fragment = obj_bullet.instantiate()
			fragment.position = bullet.position
			fragment.direction = Vector2.RIGHT.rotated(deg_to_rad(angle))
			fragment.speed = 150
			get_parent().add_child(fragment)
		bullet.queue_free()
		
#func _ready() -> void:
	#timer.start()

	
