extends Node

@export_group("General")
@export var VEHICLE: VehicleBody3D
@export var ENGINE_POWER = 200
@export var STEERING_STRENGTH = 3
@export var AUTO_BRAKE = 5
@export var BRAKE_POWER = 20

@export_group("Tracks")
@export var WHEELS_RIGHT: Array[VehicleWheel3D]
@export var WHEELS_LEFT: Array[VehicleWheel3D]
@export var MATERIAL_TRACK_RIGHT: Material
@export var MATERIAL_TRACK_LEFT: Material
@export var TRACK_SPEED := 0.08

func _process(delta: float) -> void:
	MATERIAL_TRACK_LEFT.uv1_offset.y -= WHEELS_LEFT[4].get_rpm() * delta * TRACK_SPEED;
	MATERIAL_TRACK_RIGHT.uv1_offset.y -= WHEELS_RIGHT[4].get_rpm() * delta * TRACK_SPEED;
		
func _input(_event: InputEvent) -> void:
	if (Input.is_action_pressed("brake")):
		VEHICLE.brake = BRAKE_POWER
	elif (Input.is_action_pressed("move_forward") || Input.is_action_pressed("move_backward") || Input.is_action_pressed("move_right") || Input.is_action_pressed("move_left")):
		VEHICLE.brake = 0
	else:
		VEHICLE.brake = AUTO_BRAKE
		
	var steering_factor = Input.get_axis("move_right", "move_left") * STEERING_STRENGTH
	var brake_released: int = int(!Input.is_action_pressed("brake"))
	for w in WHEELS_RIGHT:
		w.engine_force = (Input.get_axis("move_backward", "move_forward") + steering_factor) * ENGINE_POWER * brake_released
		
	for w in WHEELS_LEFT:
		w.engine_force = (Input.get_axis("move_backward", "move_forward") - steering_factor) * ENGINE_POWER * brake_released
