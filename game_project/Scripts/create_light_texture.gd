@tool
extends Node

# This script generates a smooth circular light texture

@export var texture_size: int = 256
@export var inner_radius_percent: float = 0.1
@export var generate: bool = false : set = _generate_texture

func _generate_texture(_value):
	if _value:
		var img = Image.create(texture_size, texture_size, false, Image.FORMAT_RGBA8)
		var center = Vector2(texture_size / 2, texture_size / 2)
		var max_radius = texture_size / 2
		var inner_radius = max_radius * inner_radius_percent
		
		# Fill the image with transparent pixels
		img.fill(Color(0, 0, 0, 0))
		
		# Generate a smooth circular gradient
		for y in range(texture_size):
			for x in range(texture_size):
				var pos = Vector2(x, y)
				var dist = pos.distance_to(center)
				
				if dist <= max_radius:
					# Use a smoother falloff function (cubic)
					var t = (dist - inner_radius) / (max_radius - inner_radius)
					t = clamp(t, 0.0, 1.0)
					var alpha = 1.0 - t * t * (3.0 - 2.0 * t)  # Smooth step function
					
					# Create a white pixel with calculated alpha
					var color = Color(1, 1, 1, alpha)
					img.set_pixel(x, y, color)
		
		# Create texture from image
		var texture = ImageTexture.create_from_image(img)
		
		# Save the texture
		var err = ResourceSaver.save(texture, "res://Assets/smooth_light.tres")
		if err == OK:
			print("Light texture saved successfully!")
		else:
			print("Error saving light texture: ", err)
