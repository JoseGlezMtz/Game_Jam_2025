extends Node

@export var min_energy: float = 0.3
@export var max_energy: float = 0.7
@export var flicker_speed: float = 0.5
@export var noise_amplitude: float = 0.2

var noise = FastNoiseLite.new()
var time: float = 0.0
var lights: Array = []
var base_energies: Array = []

func _ready():
	# Find all PointLight2D nodes in the scene
	find_lights(get_tree().root)
	
	# Store the original energy values
	for light in lights:
		base_energies.append(light.energy)
	
	# Initialize the noise generator
	noise.seed = randi()
	noise.frequency = 0.5

func find_lights(node):
	# Recursively find all PointLight2D nodes
	if node is PointLight2D:
		lights.append(node)
	
	for child in node.get_children():
		find_lights(child)

func _process(delta):
	# Increment time
	time += delta * flicker_speed
	
	# Calculate new energy value using noise for natural flickering
	var noise_value = noise.get_noise_1d(time) * noise_amplitude
	
	# Apply the flickering effect to all lights
	for i in range(lights.size()):
		var light = lights[i]
		var base_energy = base_energies[i]
		light.energy = clamp(base_energy + noise_value, min_energy, max_energy)
