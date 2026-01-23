@icon("./movement.png")
extends Node
class_name MovementComponent

signal move_started
signal move_stopped

var _is_moving := false

func _input(event: InputEvent) -> void:
	if (event.is_action("move_backward") or event.is_action("move_forward") or event.is_action("move_right") or event.is_action("move_left") or event.is_action("brake")):
		var axis := Input.get_vector("move_backward", "move_forward", "move_right", "move_left")
		var brakes := Input.is_action_pressed("brake")

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
