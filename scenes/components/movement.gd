extends Node
class_name MovementComponent

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("brake")):
		move(Vector2(0, 0), true)
	elif (event.is_action("move_forward") || event.is_action("move_backward") || event.is_action("move_right") || event.is_action("move_left")):
		move(Vector2(Input.get_axis("move_backward", "move_forward"), Input.get_axis("move_right", "move_left")), false)
		
func move(_axis: Vector2, _brakes: bool):
	pass
