extends Node

enum Estado {A, B} 

var estado_actual = Estado.A
var plataformas_a : Array = []
var plataformas_b : Array = []

func _ready():
	plataformas_a = get_tree().get_nodes_in_group("grupo_a")
	plataformas_b = get_tree().get_nodes_in_group("grupo_b")
	
	actualizar_estado()

func cambiar_estado():
	estado_actual = Estado.A if estado_actual == Estado.B else Estado.B
	actualizar_estado()

func actualizar_estado():
	if estado_actual == Estado.A:
		activar_plataformas(plataformas_a)
		desactivar_plataformas(plataformas_b)
	else:
		activar_plataformas(plataformas_b)
		desactivar_plataformas(plataformas_a)

func activar_plataformas(plataformas):
	for p in plataformas:
		p.visible = true
		if p is CollisionObject2D:
			p.collision_layer = 1 # Ajusta según tu configuración

func desactivar_plataformas(plataformas):
	for p in plataformas:
		p.visible = false
		if p is CollisionObject2D:
			p.collision_layer = 0 # Ajusta según tu configuración
