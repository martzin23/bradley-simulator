extends Camera3D

@export var SENSITIVITY = 0.2
@export var CAPTURE_MOUSE := false

func _ready():
	if (CAPTURE_MOUSE):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y * SENSITIVITY
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 90.0)
		rotation_degrees.y -= event.relative.x * SENSITIVITY
