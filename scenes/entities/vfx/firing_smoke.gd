extends Node3D

@export var sprite: Sprite3D

var alpha_duration := 2

func _ready() -> void:
	var tween = create_tween()
	tween.finished.connect(_on_tween_finished)
	tween.tween_property(sprite, "frame", sprite.hframes*sprite.vframes-1, 2)
	tween.parallel().tween_property(sprite, "modulate", Color(1, 1, 1, 0), alpha_duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _on_tween_finished():
	self.queue_free()
