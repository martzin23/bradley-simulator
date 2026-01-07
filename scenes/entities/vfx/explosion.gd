extends Node3D

@export var anim_player: AnimationPlayer
@export var sprite: Sprite3D
@export var light: Light3D

func _ready() -> void:
	# sprite tween
	var sprite_tween = create_tween()
	sprite_tween.tween_property(sprite, "frame", sprite.hframes*sprite.vframes-1, 1)
	sprite_tween.parallel().tween_property(sprite, "modulate", Color(1, 1, 1, 0), 1
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT).set_delay(0.2)
	
	sprite_tween.finished.connect(_tweens_finished)
	
	# emission tween
	var emission_tween = create_tween()
	emission_tween.tween_property(light, "light_energy", 10, 0.4)
	emission_tween.tween_property(light, "light_energy", 0, 0.6)
	
	# light color
	var color_tween = create_tween()
	color_tween.tween_property(light, "light_color", Color(0.839, 0.663, 0.141, 1.0), 0.3)
	color_tween.tween_property(light, "light_color", Color(0, 0, 0), 0.5)

func _tweens_finished() -> void:
	self.queue_free()
