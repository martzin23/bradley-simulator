extends SpringBoneSimulator3D

@export var VEHICLE: RigidBody3D

func _physics_process(_delta: float) -> void:
	var local_velocity := global_transform.basis.inverse() * VEHICLE.linear_velocity
	var strength: float = pow(max(local_velocity.length() * 0.1 - 0.5, 0.0), 0.5)
	self.external_force = -local_velocity.normalized() * strength
