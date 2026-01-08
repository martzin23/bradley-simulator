@icon("./movement.png")
extends Node
class_name MovementComponent

signal move_started
signal move_stopped

var _is_moving := false

func _input(event: InputEvent) -> void:
	var axis := Vector2(
		Input.get_axis("move_backward", "move_forward"),
		Input.get_axis("move_right", "move_left")
	)

	var brakes := event.is_action_pressed("brake")

	var has_input := axis.length_squared() > 0.0001

	if has_input and not _is_moving:
		_is_moving = true
		move_started.emit()
	elif not has_input and _is_moving:
		_is_moving = false
		move_stopped.emit()

	move(axis, brakes)

func move(_axis: Vector2, _brakes: bool) -> void:
	pass
