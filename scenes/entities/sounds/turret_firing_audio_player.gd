extends AudioStreamPlayer3D

@export var SHOOT_SOUND: AudioStream
@export var FIRING_COMPONENT: Node

func _ready() -> void:
	assert(FIRING_COMPONENT)
	if not SHOOT_SOUND:
		push_warning("No SHOOT_SOUND assigned to TurretFiringAudioPlayer")
	FIRING_COMPONENT.connect("fired", _on_turret_fired)

func _on_turret_fired() -> void:
	pitch_scale = randf_range(0.95, 1.05)
	stream = SHOOT_SOUND
	play()
