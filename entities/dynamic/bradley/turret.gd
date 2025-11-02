extends Node3D

@onready var axis_horizontal: Node3D = $bradley/axis_horizontal
@onready var axis_vertical: Node3D = $bradley/axis_horizontal/axis_vertical
const sensitivity = 0.5

func _process(delta: float) -> void:
	axis_horizontal.rotate_y(Input.get_axis("look_right", "look_left") * delta * sensitivity)
	axis_vertical.rotate_x(Input.get_axis("look_up", "look_down") * delta * sensitivity)
	
