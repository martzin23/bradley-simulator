extends Node3D

var impulse = 270
var spawn_offset = 1.3

@export var tank_rigidbody: RigidBody3D
@export var cooldown_timer: Timer
#var projectile := preload("res://scenes/entities/projectile/projectile.tscn")
@export var projectile: PackedScene
#var smoke := preload("res://scenes/entities/vfx/firing_smoke.tscn")
@export var smoke: PackedScene

signal fired

func _input(event: InputEvent) -> void:
	if (event.is_action("fire")):
		if (cooldown_timer.is_stopped()):
			# stvaranje dima
			var smoke_instance: Node3D = smoke.instantiate()
			smoke_instance.position = self.position
			self.add_sibling(smoke_instance)
			
			# stvaranje projektila
			var instance: RigidBody3D = projectile.instantiate()
			get_tree().current_scene.add_child(instance)
			var spawn_pos = self.global_transform.translated_local(Vector3(0, 0, spawn_offset))
			instance.global_transform = spawn_pos
			instance.linear_velocity = tank_rigidbody.linear_velocity
			instance.apply_impulse(global_transform.basis.z * impulse)
			
			fired.emit()
			cooldown_timer.start()
