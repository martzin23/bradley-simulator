extends Camera3D
class_name FirstPersonCamera

@export var SENSITIVITY = 0.2
@export var captured := false:
	set(value):
		if (value):
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		captured = value
		
#var collided: bool = false
#var collider: Node3D
#@onready var RAY := $RayCast3D
#signal on_hover(target: Node3D)
#signal off_hover(target: Node3D)
#signal on_press(target: Node3D)
#signal on_release(target: Node3D)

func _input(event):
	if event is InputEventMouseMotion && captured:
		rotation_degrees.x -= event.relative.y * SENSITIVITY
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 90.0)
		rotation_degrees.y -= event.relative.x * SENSITIVITY
	elif (event.is_action_pressed("alt_look")):
		captured = !captured
	#elif (event.is_action("interact") and collided):
		#if (event.is_action_pressed("interact")):
			#on_press.emit(collider)
		#elif (event.is_action_released("interact")):
			#on_release.emit(collider)
		
#func _physics_process(delta: float) -> void:
	#if (RAY.is_colliding() != collided):
		#if (RAY.is_colliding()):
			#collider = RAY.get_collider()
			#on_hover.emit(collider)
		#else:
			#off_hover.emit(collider)
		#collided = RAY.is_colliding()
