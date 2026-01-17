@icon("./health.png")
extends Node
class_name HealthComponent

@export var health := 100.0:
	set(value):
		if value <= 0:
			value = 0
			die()
		if value >= max_health:
			value = max_health
		change.emit(value)
		health = value

@export_group("Debug Health Text")
@export var DEBUG_HEALTH_TEXT: Label3D

@export_group("Death Smoke")
@export var ENABLE_SMOKE_VFX = false # enable this to use "Death smoke" vfx
@export var DEATH_SMOKE_POSITION: Node3D
@export var DEATH_SMOKE: PackedScene

signal died
signal change(health: float)
var dead := false
var max_health := 0.0;

func _ready() -> void:
	max_health = health
	if (DEBUG_HEALTH_TEXT != null):
		DEBUG_HEALTH_TEXT.text = str(health)

func damage(amount: float) -> void:
	health -= amount
	if (DEBUG_HEALTH_TEXT):
		DEBUG_HEALTH_TEXT.text = str(health)

func heal(amount: float) -> void:
	health += amount
	if (DEBUG_HEALTH_TEXT):
		DEBUG_HEALTH_TEXT.text = str(health)

func die():
	if !dead:
		dead = true
		died.emit()
		if ENABLE_SMOKE_VFX:
			spawn_smoke()

func spawn_smoke():
	var smoke_instance: Node3D = DEATH_SMOKE.instantiate()
	self.add_sibling(smoke_instance)
	if (DEATH_SMOKE_POSITION):
		smoke_instance.position = DEATH_SMOKE_POSITION.position
	else:
		smoke_instance.position = self.get_parent().position
