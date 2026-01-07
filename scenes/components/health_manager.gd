extends Node

@export var health = 100

@export_group("Debug Health Text")
@export var enable_health_text = false # enable this to use debug health text overlay
@export var debug_health_text: Label3D

@export_group("Death Smoke")
@export var enable_smoke_vfx = false # enable this to use "Death smoke" vfx
@export var death_smoke_position: Node3D
@export var death_smoke: PackedScene

signal died
var dead = false

func _ready() -> void:
	if enable_health_text:
		debug_health_text.text = str(health)

func take_damage(amount: int):
	health-=amount
	if health<=0:
		health = 0
		if !dead:
			died.emit()
			if enable_smoke_vfx:
				var smoke_instance: Node3D = death_smoke.instantiate()
				self.add_sibling(smoke_instance)
				#get_tree().current_scene.add_child(smoke_instance)
				smoke_instance.position = death_smoke_position.position
			dead = true
	if enable_health_text:
		debug_health_text.text = str(health)
	#print(health)
