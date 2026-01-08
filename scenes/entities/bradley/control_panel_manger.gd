extends Node3D

@export var TURRET_CONTROL : TurretControlComponent
@export var CAMERA_MANAGER : CameraManagerComponent
@export var MOVEMENT_COMPONENT : MovementComponent
@export var FIRING_COMPONENT : TurretFiringComponent
@export var POST_PROCESS_NV : ColorRect
@export var VEHICLE : PhysicsBody3D
@export var LIGHT : SpotLight3D

func zoom(value: float) -> void:
	CAMERA_MANAGER.zoom(value * 3)

func aim(vector: Vector2) -> void:
	TURRET_CONTROL.velocity = vector

func light(active: bool) -> void:
	LIGHT.visible = active
	
func move(vector: Vector2) -> void:
	MOVEMENT_COMPONENT.move(vector, false)

func flip():
	VEHICLE.global_position.y += 2
	VEHICLE.rotation_degrees.x = 0.0
	VEHICLE.rotation_degrees.z = 0.0

func environment(preset: int) -> void:
	if (not Global.environment_manager):
		return
	match preset:
		0:
			Global.environment_manager.set_day()
		1:
			Global.environment_manager.set_night()
		2:
			Global.environment_manager.set_fog()

func quality(mode: int):
	if (not Global.quality_manager):
		return
	match mode:
		0:
			Global.quality_manager.set_quality_low()
		1:
			Global.quality_manager.set_quality_high()

func night_vision(value: bool):
	POST_PROCESS_NV.visible = value

func fire():
	FIRING_COMPONENT.trigger()
