@icon("./turret_firing.png")
extends Node
class_name TurretFiringComponent

@export var impulse = 270
@export var spawn_offset = 1.3
@export var smoke_offset = 0.3

@export_group("References")
@export var tank_rigidbody: RigidBody3D
@export var muzzle: Node3D
@export var projectile: PackedScene
@export var smoke: PackedScene

@onready var cooldown_timer := $CooldownTimer
signal on_fired
signal on_cooldown_finished

func _input(event: InputEvent) -> void:
	if (event.is_action("fire")):
		trigger()
			
func trigger() -> void:
	if (cooldown_timer.is_stopped()):
		fire()
		cooldown_timer.start()
		
func fire() -> void:
		# stvaranje dima
		var smoke_instance: Node3D = smoke.instantiate()
		smoke_instance.position = muzzle.position + Vector3(0, smoke_offset, 0)
		muzzle.add_sibling(smoke_instance)
		
		# stvaranje projektila
		var instance: RigidBody3D = projectile.instantiate()
		get_tree().current_scene.add_child(instance)
		var spawn_pos = muzzle.global_transform.translated_local(Vector3(0, 0, spawn_offset))
		instance.global_transform = spawn_pos
		instance.linear_velocity = tank_rigidbody.linear_velocity
		instance.apply_impulse(muzzle.global_transform.basis.z * impulse)
		
		on_fired.emit()

func cooldown_finish() -> void:
	on_cooldown_finished.emit()
