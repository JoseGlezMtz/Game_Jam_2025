extends Node

@onready var personaje: Node2D = $"../Personaje"
@onready var win: Node2D = $"../Win"


func win_sequence():
	get_tree().change_scene_to_file("res://win.tscn")


func _on_alive_timer_timeout() -> void:
	
	win_sequence()
