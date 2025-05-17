extends Label
@onready var alive_timer: Timer = $"../Alive_timer"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func time_left():
	var time_left =alive_timer.time_left
	var minute= floor(time_left / 60)
	var seconds= int(time_left) % 60
	return [minute, seconds]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = "%02d:%02d" % time_left() 
