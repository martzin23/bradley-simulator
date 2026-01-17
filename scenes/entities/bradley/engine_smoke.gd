extends Node3D

@export var sprite: Sprite3D
@export var movementComponent: MovementComponent

var start_time := 0.3
var stop_time := 3
var tween: Tween

func _ready() -> void:
	sprite.modulate.a = 0
	movementComponent.move_started.connect(_tank_started_moving)
	movementComponent.move_stopped.connect(_tank_stopped_moving)

func _tank_started_moving():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(sprite, "modulate", Color(1, 1, 1, .25), start_time
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	
func _tank_stopped_moving():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(sprite, "modulate", Color(1, 1, 1, 0), stop_time
	).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
