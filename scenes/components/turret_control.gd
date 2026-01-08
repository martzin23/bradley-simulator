@icon("./turret_control.png")
extends Node
class_name TurretControlComponent

@export var AXIS_HORIZONTAL: Node3D
@export var AXIS_VERTICAL: Node3D
@export var sensitivity := 0.5
@export var MIN_HEIGHT := -50.0
@export var MAX_HEIGHT := 10.0
var velocity := Vector2()

func _process(delta: float) -> void:
	AXIS_HORIZONTAL.rotate_y(velocity.y * delta * sensitivity)
	AXIS_VERTICAL.rotate_x(velocity.x * delta * sensitivity)
	AXIS_VERTICAL.rotation_degrees.x = clamp(AXIS_VERTICAL.rotation_degrees.x, MIN_HEIGHT, MAX_HEIGHT)

func _input(event: InputEvent) -> void:
	if (event.is_action("look_down") or event.is_action("look_up") or event.is_action("look_left") or event.is_action("look_right")):
		velocity.y = Input.get_axis("look_right", "look_left")
		velocity.x = Input.get_axis("look_up", "look_down")
	
func set_aim_velocity(v: Vector2) -> void:
	velocity = v
