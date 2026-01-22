extends Node
class_name TankAimingAI

@export var enabled := true

@export_group("Components")
@export var turret_control: TurretControlComponent
@export var firing_component: TurretFiringComponent

@export_group("Target Settings")
@export var player_group := "player"
@export var target_offset: Vector3 = Vector3(0, 1.5, 0)

@export_group("Aiming Settings")
@export var aim_speed := 2.0
@export var aim_smoothing := 5.0

@export_group("Auto Fire Settings")
@export var enable_auto_fire := true
@export var fire_when_aimed_threshold := 5.0
@export var min_fire_distance := 5.0
@export var max_fire_distance := 100.0

@export_group("Line of Sight")
@export var enable_los_debug: bool = false
@export var los_origin: Node3D
@export var los_mask: int = 1    
@export var los_max_distance := 200.0

var _los_mesh_instance: MeshInstance3D
var _los_mesh := ImmediateMesh.new()
var target: Node3D = null

func _ready() -> void:
	_los_mesh_instance = MeshInstance3D.new()
	_los_mesh_instance.mesh = _los_mesh

	var mat := StandardMaterial3D.new()
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.albedo_color = Color.RED
	_los_mesh_instance.material_override = mat

	add_child(_los_mesh_instance)

func _draw_los_line(from: Vector3, to: Vector3, color: Color) -> void:
	if not enable_los_debug:
		return
	_los_mesh.clear_surfaces()

	var mat := _los_mesh_instance.material_override as StandardMaterial3D
	mat.albedo_color = color

	_los_mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	_los_mesh.surface_add_vertex(from)
	_los_mesh.surface_add_vertex(to)
	_los_mesh.surface_end()

func _process(delta: float) -> void:	
	if (!self.enabled):
		_stop_aiming()
		return
	
	_update_target()
	if not target:
		_stop_aiming()
		return
	
	var aim_data := _calculate_aim_direction()
	if not aim_data:
		return
	
	_apply_aiming(aim_data, delta)
	_handle_auto_fire(aim_data)

func _get_target_aim_position() -> Vector3:
	return target.global_position + target_offset

func _update_target() -> void:
	if is_instance_valid(target):
		return
	
	var players := get_tree().get_nodes_in_group(player_group)
	if players.size() > 0:
		target = players[0] as Node3D

func _stop_aiming() -> void:
	turret_control.set_aim_velocity(Vector2.ZERO)

func _calculate_aim_direction() -> Dictionary:
	var horizontal_axis := turret_control.AXIS_HORIZONTAL
	var vertical_axis := turret_control.AXIS_VERTICAL
	
	var target_pos := _get_target_aim_position()
	var turret_pos := vertical_axis.global_position
	var to_target := target_pos - turret_pos
	
	var horizontal_angle := _calculate_horizontal_angle(to_target, horizontal_axis)
	var pitch_diff := _calculate_pitch_difference(to_target, vertical_axis)
	var distance := to_target.length()
	
	return {
		"horizontal_angle": horizontal_angle,
		"pitch_diff": pitch_diff,
		"distance": distance,
		"horizontal_error_deg": 180 - abs(rad_to_deg(horizontal_angle)),
		"vertical_error_deg": 180 - abs(rad_to_deg(pitch_diff))
	}

func _calculate_horizontal_angle(to_target: Vector3, horizontal_axis: Node3D) -> float:
	var horizontal_dir := Vector2(to_target.x, to_target.z).normalized()
	var turret_forward := -horizontal_axis.global_transform.basis.z
	var turret_forward_2d := Vector2(turret_forward.x, turret_forward.z).normalized()
	
	return turret_forward_2d.angle_to(horizontal_dir)

func _calculate_pitch_difference(to_target: Vector3, vertical_axis: Node3D) -> float:
	var local_dir := vertical_axis.global_transform.basis.inverse() * to_target.normalized()
	var target_pitch := atan2(local_dir.y, -local_dir.z)
	var current_pitch := vertical_axis.rotation.x

	return _normalize_angle(target_pitch - current_pitch)

func _normalize_angle(angle: float) -> float:
	while angle > PI:
		angle -= TAU
	while angle < -PI:
		angle += TAU
	return angle


func _apply_aiming(aim_data: Dictionary, delta: float) -> void:
	# Note: velocity.x controls pitch (vertical), velocity.y controls yaw (horizontal)
	var aim_velocity := Vector2(
		-aim_data.pitch_diff * aim_speed,
		aim_data.horizontal_angle * aim_speed
	)
	
	var current_velocity := turret_control.velocity
	var smoothed_velocity := current_velocity.lerp(aim_velocity, aim_smoothing * delta)
	
	turret_control.set_aim_velocity(smoothed_velocity)

func _has_line_of_sight() -> bool:
	if not los_origin:
		return false

	var space := los_origin.get_world_3d().direct_space_state

	var from := los_origin.global_position
	var forward := los_origin.global_transform.basis.z
	var to := from + forward * los_max_distance

	var query := PhysicsRayQueryParameters3D.create(from, to)
	query.collision_mask = los_mask
	query.exclude = [self, turret_control, los_origin]

	var result := space.intersect_ray(query)

	if result.is_empty():
		_draw_los_line(from, to, Color.RED)
		return false

	var collider = result.collider
	var hit_player = collider.is_in_group(player_group)
	if not hit_player and collider.get_parent():
		hit_player = collider.get_parent().is_in_group(player_group)

	_draw_los_line(
		from,
		result.position,
		Color.GREEN if hit_player else Color.RED
	)

	return hit_player

func _handle_auto_fire(aim_data: Dictionary) -> void:
	if not enable_auto_fire or not firing_component:
		return
	
	if _should_fire(aim_data):
		firing_component.trigger()

func _should_fire(aim_data: Dictionary) -> bool:
	var total_error = aim_data.horizontal_error_deg + aim_data.vertical_error_deg
	
	var is_aimed = total_error < fire_when_aimed_threshold  # FIXED: was > should be 
	var in_range = aim_data.distance >= min_fire_distance and aim_data.distance <= max_fire_distance
	var in_sight = _has_line_of_sight()
	
	return is_aimed and in_range and in_sight

func set_enabled(value: bool) -> void:
	self.enabled = value
