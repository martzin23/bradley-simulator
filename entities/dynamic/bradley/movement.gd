extends VehicleBody3D

@export var MAX_STEERING = 0.25
@export var POWER = 10000

func _physics_process(delta: float) -> void:
	steering = move_toward(steering, Input.get_axis("move_right", "move_left") * MAX_STEERING, delta * 10)
	engine_force = Input.get_axis("move_backward", "move_forward") * POWER
