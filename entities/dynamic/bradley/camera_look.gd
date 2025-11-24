extends SpringArm3D

@export var sensitivity = 0.2
@export var capture_mouse := false
@export var min_zoom := 5.0
@export var max_zoom := 25.0

func _ready():
	if (capture_mouse):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	self.spring_length *= Input.get_axis("zoom_in", "zoom_out") * 0.1 + 1.0
	self.spring_length = clamp(self.spring_length, min_zoom, max_zoom)
	
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y * sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 90.0)
		
		rotation_degrees.y -= event.relative.x * sensitivity
