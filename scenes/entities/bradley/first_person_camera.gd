extends Camera3D
class_name FirstPersonCamera

@export var SENSITIVITY = 0.2
@export var enabled := true:
	set(value):
		self.current = value
		self.set_process_input(value)
		if (value and captured):
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		elif (value and !captured):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		enabled = value
@export var captured := false:
	set(value):
		if (value):
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		captured = value
		
@onready var RAY := $RayCast3D
var collided := false
var collider: PhysicsBody3D = null
var pressed := false

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
			pressed = true
		elif (event.is_action_released("interact") and collider.has_method("release")):
			collider.release()
			pressed = false
			
	if event is InputEventMouseMotion:
		if (captured):
			if (!RAY.is_colliding() && collided):
				if (collider.has_method("exit")):
					collider.exit()
				if (pressed && collider.has_method("release")):
					collider.release()
				collider = null
				collided = false
			elif (RAY.is_colliding() && !collided):
				collider = RAY.get_collider()
				if (collider.has_method("enter")):
					collider.enter()
				collided = true
			elif (RAY.is_colliding() and RAY.get_collider() != collider):
				if (collider.has_method("exit")):
					collider.exit()
				if (pressed && collider.has_method("release")):
					collider.release()
				collider = RAY.get_collider()
				if (collider.has_method("enter")):
					collider.enter()
		else:
			var ray_cast = cursor_ray_cast()
			if (ray_cast.is_empty() && collided):
				if (collider.has_method("exit")):
					collider.exit()
				if (pressed && collider.has_method("release")):
					collider.release()
				collider = null
				collided = false
			elif (!ray_cast.is_empty() && !collided):
				collider = ray_cast.collider
				if (collider.has_method("enter")):
					collider.enter()
				collided = true
			elif (!ray_cast.is_empty() and ray_cast.collider != collider):
				if (collider.has_method("exit")):
					collider.exit()
				if (pressed && collider.has_method("release")):
					collider.release()
				collider = ray_cast.collider
				if (collider.has_method("enter")):
					collider.enter()

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
	
	
