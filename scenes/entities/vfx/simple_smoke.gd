extends Node3D

@export var sprite: Sprite3D

func _ready() -> void:
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(sprite, "frame", sprite.hframes*sprite.vframes-1, 5).from_current()
