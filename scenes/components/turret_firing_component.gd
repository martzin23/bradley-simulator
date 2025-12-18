extends Node3D

var impulse = 270
var spawn_offset = 1.3

@export var tank_rigidbody: RigidBody3D
@export var cooldown_timer: Timer
@export var smoke_timer: Timer
@export var smoke: Node3D
var projectile = preload("res://scenes/entities/bradley/projectile.tscn")

func _ready() -> void:
	smoke.visible = false

func _input(event: InputEvent) -> void:
	if (event.is_action("fire")):
		if (cooldown_timer.is_stopped()):
			smoke.visible = false
			smoke_timer.start()
			var instance: RigidBody3D = projectile.instantiate()
			get_tree().current_scene.add_child(instance)
			var spawn_pos = self.global_transform.translated_local(Vector3(0, 0, spawn_offset))
			instance.global_transform = spawn_pos
			instance.linear_velocity = tank_rigidbody.linear_velocity
			instance.apply_impulse(global_transform.basis.z * impulse)
			cooldown_timer.start()


func _on_smoke_timer_timeout() -> void:
	smoke.visible = false
