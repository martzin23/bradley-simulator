extends SpringArm3D

@export var SENSITIVITY = 0.2
@export var CAPTURE_MOUSE := false
@export var MIN_ZOOM := 5.0
@export var MAX_ZOOM := 25.0

func _ready():
	if (CAPTURE_MOUSE):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	self.spring_length *= Input.get_axis("zoom_in", "zoom_out") * 0.1 + 1.0
	self.spring_length = clamp(self.spring_length, MIN_ZOOM, MAX_ZOOM)
	
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y * SENSITIVITY
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 90.0)
		
		rotation_degrees.y -= event.relative.x * SENSITIVITY
