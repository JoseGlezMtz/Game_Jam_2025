extends Node

@onready var personaje: Node2D = $"../Personaje"
@onready var win: Node2D = $"../Win"


func win_sequence():
	win.visible=true


func _on_alive_timer_timeout() -> void:
	Engine.time_scale=0.5
	win_sequence()
