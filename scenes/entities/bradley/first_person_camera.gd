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
		
@onready var RAY := $RayCast3D
var collided: bool = false
var collider: PhysicsBody3D = null

func _input(event):
	if event is InputEventMouseMotion && captured:
		rotation_degrees.x -= event.relative.y * SENSITIVITY
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 90.0)
		rotation_degrees.y -= event.relative.x * SENSITIVITY
	elif (event.is_action_pressed("alt_look")):
		captured = !captured
	elif (event.is_action("interact") and collided):
		if (event.is_action_pressed("interact") and collider.has_method("press")):
			collider.press()
		elif (event.is_action_released("interact") and collider.has_method("release")):
			collider.release()
		
func _physics_process(_delta: float) -> void:
	if (captured):
		if (RAY.is_colliding() != collided):
			if (RAY.is_colliding()):
				collider = RAY.get_collider()
				if (collider.has_method("enter")):
					collider.enter()
			else:
				if (collider.has_method("exit")):
					collider.exit()
				collider = null
			collided = RAY.is_colliding()
			
	else:
		var ray_cast = cursor_ray_cast()
		if (!ray_cast.is_empty() != collided):
			if (ray_cast.is_empty()):
				if (collider.has_method("exit")):
					collider.exit()
				collider = null
			else:
				collider = ray_cast.collider
				if (collider.has_method("enter")):
					collider.enter()
			collided = !ray_cast.is_empty()

# https://www.youtube.com/watch?v=5Uc9yzj4YLY
func cursor_ray_cast() -> Dictionary:
	var mouse = get_viewport().get_mouse_position()
	var space = get_world_3d().direct_space_state
	var start = get_viewport().get_camera_3d().project_ray_origin(mouse)
	var end = get_viewport().get_camera_3d().project_position(mouse, abs(RAY.target_position.y))
	
	var params = PhysicsRayQueryParameters3D.new()
	params.from = start
	params.to = end
	var result = space.intersect_ray(params)
	return result
	
	
