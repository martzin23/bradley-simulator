extends Node

@export var START_INDEX := 0
@export var CAMERAS: Array[Camera3D]

func _ready() -> void:
	CAMERAS[START_INDEX].current = true
	
func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("switch")):
		START_INDEX = (START_INDEX + 1) % len(CAMERAS)
		CAMERAS[START_INDEX].current = true
