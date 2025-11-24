extends Camera3D

@export var min_fov := 15.0
@export var max_fov := 70.0

func _input(_event):
	self.fov *= Input.get_axis("zoom_in", "zoom_out") * 0.1 + 1.0
	self.fov = clamp(self.fov, min_fov, max_fov)
