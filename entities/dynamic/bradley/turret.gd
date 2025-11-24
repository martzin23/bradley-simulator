extends Node3D

@export var sensitivity := 0.5
@export var min_height := -50.0;
@export var max_height := 10.0;
@export var axis_horizontal: Node3D
@export var axis_vertical: Node3D

func _process(delta: float) -> void:
	axis_horizontal.rotate_z(Input.get_axis("look_right", "look_left") * delta * sensitivity)
	axis_vertical.rotate_x(Input.get_axis("look_up", "look_down") * delta * sensitivity)
	axis_vertical.rotation_degrees.x = clamp(axis_vertical.rotation_degrees.x, min_height, max_height)
