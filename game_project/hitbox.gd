extends Sprite2D

var hp: int = 5

signal hp_changed
signal died

func take_damage( dmg ):
	set_hp(hp - dmg) 

func set_hp( new_hp ):
	hp = new_hp
	if hp <= 0:
		die()
		
func die():
	emit_signal("died")
	queue_free()
	
