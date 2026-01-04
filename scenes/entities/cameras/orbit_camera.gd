extends SpringArm3D
class_name OrbitCamera

@export var enabled := false:
	set(value):
		$Camera.current = value
		self.set_process_input(value)
		if (value and CAPTURE_MOUSE):
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		elif (value and !CAPTURE_MOUSE):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		enabled = value
@export var free_look = false
@export var SENSITIVITY = 0.2
@export var CAPTURE_MOUSE := false
@export var MIN_ZOOM := 5.0
@export var MAX_ZOOM := 25.0
@onready var CAMERA := $Camera
var zoom_tween: Tween
var target_length

func _ready():
	target_length = self.spring_length

func _input(event):
	if (event.is_action("zoom_in") or event.is_action("zoom_out")):
		target_length = clamp(target_length * (Input.get_axis("zoom_in", "zoom_out") * 0.1 + 1.0), MIN_ZOOM, MAX_ZOOM)
		if (zoom_tween):
			zoom_tween.kill()
		zoom_tween = get_tree().create_tween()
		zoom_tween.tween_property(self, "spring_length", target_length, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		
	if (event.is_action_pressed("alt_look")):
		if (self.free_look):
			CAMERA.rotation_degrees = Vector3()
		self.free_look = !self.free_look
		
	if event is InputEventMouseMotion:
		if (!self.free_look):
			self.rotation_degrees.x -= event.relative.y * SENSITIVITY
			self.rotation_degrees.x = clamp(self.rotation_degrees.x, -90.0, 90.0)
			self.rotation_degrees.y -= event.relative.x * SENSITIVITY
		else:
			CAMERA.global_rotation_degrees.x -= event.relative.y * SENSITIVITY
			CAMERA.global_rotation_degrees.x = clamp(CAMERA.global_rotation_degrees.x, -90.0, 90.0)
			CAMERA.global_rotation_degrees.y -= event.relative.x * SENSITIVITY
