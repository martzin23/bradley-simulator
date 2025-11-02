extends SpringArm3D

const sensitivity = 0.2

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	self.spring_length *= Input.get_axis("zoom_in", "zoom_out") * 0.1 + 1.0
	# self.sprint_length = clamp(self.spring_length, 1.0, 10.0)
	
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y * sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 90.0)
		
		rotation_degrees.y -= event.relative.x * sensitivity
		# rotation_degrees.y = clamp(rotation_degrees.y, 0.0, 360.0)
