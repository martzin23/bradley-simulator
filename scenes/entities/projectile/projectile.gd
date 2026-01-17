extends RigidBody3D

@export var explosion: PackedScene
@export var strength := 50.0

var offset = 0.85

func projectile_collided(body: Node):
	for c in body.get_children():
		if (c is HealthComponent):
			c.damage(strength)
			break
			
	self.freeze = true
	
	# explosion vfx
	var instance: Node3D = explosion.instantiate()
	get_tree().current_scene.add_child(instance)
	instance.global_position = self.global_position + Vector3(0, offset, 0)
	self.queue_free()
