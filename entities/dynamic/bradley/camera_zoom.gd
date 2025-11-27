extends Camera3D

@export var MIN_FOV := 15.0
@export var MAX_FOV := 70.0
@export var STEP := 0.1

func _input(_event):
	self.fov *= Input.get_axis("zoom_in", "zoom_out") * STEP + 1.0
	self.fov = clamp(self.fov, MIN_FOV, MAX_FOV)
