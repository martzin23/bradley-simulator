extends Node
class_name TurretControlComponent

@export var AXIS_HORIZONTAL: Node3D
@export var AXIS_VERTICAL: Node3D
@export var sensitivity := 0.5
@export var MIN_HEIGHT := -50.0;
@export var MAX_HEIGHT := 10.0;

func _process(delta: float) -> void:
	AXIS_HORIZONTAL.rotate_y(Input.get_axis("look_right", "look_left") * delta * sensitivity)
	AXIS_VERTICAL.rotate_x(Input.get_axis("look_up", "look_down") * delta * sensitivity)
	AXIS_VERTICAL.rotation_degrees.x = clamp(AXIS_VERTICAL.rotation_degrees.x, MIN_HEIGHT, MAX_HEIGHT)
