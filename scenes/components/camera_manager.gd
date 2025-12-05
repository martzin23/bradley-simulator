extends Node
class_name CameraManagerComponent

enum PerspectiveType {FIRST_PERSON, THIRD_PERSON}

@export var perspective := PerspectiveType.FIRST_PERSON:
	set(value):
		if (value == PerspectiveType.FIRST_PERSON):
			INTERIOR_CAMERA.enabled = true
			EXTERIOR_CAMERA.enabled = false
			EXTERIOR_CAMERA.set_process_input(false)
		else:
			EXTERIOR_CAMERA.enabled = true
			INTERIOR_CAMERA.enabled = false
			BARREL_CAMERA.set_process_input(false)
		perspective = value
@export var INTERIOR_CAMERA: FirstPersonCamera
@export var EXTERIOR_CAMERA: OrbitCamera
var current: PerspectiveType

@export_group("Barrel Camera")
@export var BARREL_CAMERA: Camera3D
@export var MIN_FOV := 10.0
@export var MAX_FOV := 75.0
@export var STEP := 0.1
@onready var target_fov := BARREL_CAMERA.fov
var zoom_tween: Tween

@export_group("Turret Control")
@export var TURRET_CONTROL : TurretControlComponent
var base_sensitivity: float

func _ready() -> void:
	base_sensitivity = TURRET_CONTROL.sensitivity
	
func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("switch")):
		if (perspective == PerspectiveType.FIRST_PERSON):
			perspective = PerspectiveType.THIRD_PERSON
		else:
			perspective = PerspectiveType.FIRST_PERSON
	
	if (perspective == PerspectiveType.FIRST_PERSON and (event.is_action("zoom_in") or event.is_action("zoom_out"))):
		zoom(Input.get_axis("zoom_in", "zoom_out"))

func zoom(value):
	target_fov *= value * STEP + 1.0
	target_fov = clamp(target_fov, MIN_FOV, MAX_FOV)
	TURRET_CONTROL.sensitivity = base_sensitivity * lerp(0.1, 1.0, (target_fov - MIN_FOV) / (MAX_FOV - MIN_FOV))
	
	if (zoom_tween):
		zoom_tween.kill()
	zoom_tween = get_tree().create_tween()
	zoom_tween.tween_property(BARREL_CAMERA, "fov", target_fov, 0.1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	
