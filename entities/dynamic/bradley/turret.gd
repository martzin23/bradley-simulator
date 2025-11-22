extends Node3D

@onready var axis_horizontal: Node3D = $Bradley/Body/Turret
@onready var axis_vertical: Node3D = $Bradley/Body/Turret/Barrel
const sensitivity = 0.5

func _process(delta: float) -> void:
	axis_horizontal.rotate_z(Input.get_axis("look_right", "look_left") * delta * sensitivity)
	axis_vertical.rotate_x(Input.get_axis("look_up", "look_down") * delta * sensitivity)
	
