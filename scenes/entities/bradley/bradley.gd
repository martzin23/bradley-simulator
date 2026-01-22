extends VehicleBody3D

@export_group("Private")
@export var DEATH_SCREEN: Control
@export var HEALTH_LABEL: Label3D
@export var TURRET_CONTROL: TurretControlComponent
@export var TURRET_FIRING: TurretFiringComponent
@export var CAMERA_MANAGER: CameraManagerComponent

func _input(event: InputEvent) -> void:
	if (event.is_action("look_down") or event.is_action("look_up") or event.is_action("look_left") or event.is_action("look_right")):
		TURRET_CONTROL.set_aim_velocity(Input.get_vector("look_up", "look_down", "look_right", "look_left"))
	if (event.is_action("fire")):
		TURRET_FIRING.trigger()
	
func open_death_screen():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	CAMERA_MANAGER.EXTERIOR_CAMERA.enabled = false
	CAMERA_MANAGER.INTERIOR_CAMERA.enabled = false
	DEATH_SCREEN.visible = true

func update_health(health: float):
	HEALTH_LABEL.text = str(health)

func reset_scene():
	get_tree().reload_current_scene()
	
func quit_scene():
	get_tree().quit()
