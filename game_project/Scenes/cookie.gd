extends Node


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		get_tree().change_scene_to_file("res://Scenes/BulletHell_Room.tscn")
