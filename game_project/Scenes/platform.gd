extends AnimatableBody2D


@onready var plat_manager: Node = $"../Plat_manager"
@onready var group=get_groups()
@export var Type: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		
