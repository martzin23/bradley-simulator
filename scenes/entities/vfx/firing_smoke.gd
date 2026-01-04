extends Node3D

@export var sprite: Sprite3D

func _ready() -> void:
	var tween = create_tween()
	tween.finished.connect(_on_tween_finished)
	tween.tween_property(sprite, "frame", sprite.hframes*sprite.vframes-1, 2)
	tween.parallel().tween_property(sprite, "modulate", Color(1, 1, 1, 0), 2).set_ease(Tween.EASE_IN)

func _on_tween_finished():
	self.queue_free()
