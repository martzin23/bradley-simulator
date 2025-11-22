extends VehicleBody3D

@export_group("General")
@export var ENGINE_POWER = 300
@export var STEERING_STRENGTH = 3
@export var BRAKE_POWER = 3

@export_group("Tracks")
@export var wheels_right: Array[VehicleWheel3D]
@export var wheels_left: Array[VehicleWheel3D]
@export var track_model: MeshInstance3D

func _physics_process(delta: float) -> void:
	var steering_factor = Input.get_axis("move_right", "move_left") * STEERING_STRENGTH
	
	track_model.get_active_material(1).uv1_offset.y -= (self.linear_velocity.dot(self.basis.z) + steering_factor) * delta * 0.5;
	track_model.get_active_material(2).uv1_offset.y -= (self.linear_velocity.dot(self.basis.z) - steering_factor) * delta * 0.5;
	
	for w in wheels_right:
		w.engine_force = (Input.get_axis("move_backward", "move_forward") + steering_factor) * ENGINE_POWER
		
	for w in wheels_left:
		w.engine_force = (Input.get_axis("move_backward", "move_forward") - steering_factor) * ENGINE_POWER
		
func _input(_event: InputEvent) -> void:
	if (Input.is_action_pressed("move_forward") || Input.is_action_pressed("move_backward")|| Input.is_action_pressed("move_right")|| Input.is_action_pressed("move_left")):
		self.brake = 0
	else:
		self.brake = BRAKE_POWER
