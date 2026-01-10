extends MovementComponent
class_name SimpleMovementComponent

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
		
func move(axis: Vector2, brakes: bool) -> void:
	if axis.length() == 0.0:
		VEHICLE.brake = AUTO_BRAKE
	else:
		VEHICLE.brake = 0

	if brakes:
		VEHICLE.brake = BRAKE_POWER

	for w in WHEELS_RIGHT:
		w.engine_force = (axis.x + axis.y * STEERING_STRENGTH) * ENGINE_POWER

	for w in WHEELS_LEFT:
		w.engine_force = (axis.x - axis.y * STEERING_STRENGTH) * ENGINE_POWER

	
