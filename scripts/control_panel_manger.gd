extends Node3D

@export var TURRET_CONTROL : TurretControlComponent
@export var CAMERA_MANAGER : CameraManagerComponent
@export var MOVEMENT_COMPONENT : MovementComponent
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
	match preset:
		0:
			Global.environment_manager.setDay()
		1:
			Global.environment_manager.setNight()
		2:
			Global.environment_manager.setFog()

func quality(mode: int):
	match mode:
		0:
			Global.quality_manager.setQualityLow()
		1:
			Global.quality_manager.setQualityHigh()

func night_vision(value: bool):
	POST_PROCESS_NV.visible = value
