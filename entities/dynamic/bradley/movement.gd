extends VehicleBody3D

@export_group("General")
@export var ENGINE_POWER = 300
@export var STEERING_STRENGTH = 3
@export var AUTO_BRAKE = 5
@export var BRAKE_POWER = 20

@export_group("Tracks")
@export var wheels_right: Array[VehicleWheel3D]
@export var wheels_left: Array[VehicleWheel3D]
@export var material_track_left: Material
@export var material_track_right: Material
@export var uv_speed := 0.5

func _process(delta: float) -> void:
	# var steering_factor = Input.get_axis("move_right", "move_left") * STEERING_STRENGTH
	# material_track_left.uv1_offset.y -= (self.linear_velocity.dot(self.basis.z) - steering_factor * 0.5) * delta * uv_speed;
	# material_track_right.uv1_offset.y -= (self.linear_velocity.dot(self.basis.z) + steering_factor * 0.5) * delta * uv_speed;
	material_track_left.uv1_offset.y -= wheels_left[4].get_rpm() * delta * uv_speed;
	material_track_right.uv1_offset.y -= wheels_right[4].get_rpm() * delta * uv_speed;
		
func _input(_event: InputEvent) -> void:
	if (Input.is_action_pressed("brake")):
		self.brake = BRAKE_POWER
	elif (Input.is_action_pressed("move_forward") || Input.is_action_pressed("move_backward") || Input.is_action_pressed("move_right") || Input.is_action_pressed("move_left")):
		self.brake = 0
	else:
		self.brake = AUTO_BRAKE
		
	var steering_factor = Input.get_axis("move_right", "move_left") * STEERING_STRENGTH
	var brake_released: int = int(!Input.is_action_pressed("brake"))
	for w in wheels_right:
		w.engine_force = (Input.get_axis("move_backward", "move_forward") + steering_factor) * ENGINE_POWER * brake_released
		
	for w in wheels_left:
		w.engine_force = (Input.get_axis("move_backward", "move_forward") - steering_factor) * ENGINE_POWER * brake_released
