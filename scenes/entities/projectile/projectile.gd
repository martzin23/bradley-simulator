extends RigidBody3D

#var explosion := preload("res://scenes/entities/vfx/explosion.tscn")
@export var explosion: PackedScene
@export var strength = 50

var offset = 0.85

func projectile_collided(body: Node):
	if body.is_in_group("damageable"):
		body.get_node("HealthManagerComponent").take_damage(strength)
	
	self.freeze = true
	
	# explosion vfx
	var instance: Node3D = explosion.instantiate()
	get_tree().current_scene.add_child(instance)
	instance.global_position = self.global_position + Vector3(0, offset, 0)
	self.destroy_itself()

func destroy_itself():
	self.queue_free()
