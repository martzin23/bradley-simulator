extends Node

@export var index := 0
@export var cameras: Array[Camera3D]

func _ready() -> void:
	cameras[index].current = true
	
func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("switch")):
		index = (index + 1) % len(cameras)
		cameras[index].current = true
