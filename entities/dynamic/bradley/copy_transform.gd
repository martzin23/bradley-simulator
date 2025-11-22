extends Node3D

@export var Target: Node3D
@export var PositionX := false
@export var PositionY := false
@export var PositionZ := false
@export var RotationX := false
@export var RotationY := false
@export var RotationZ := false
@export var ScaleX := false
@export var ScaleY := false
@export var ScaleZ := false

func _process(_delta: float) -> void:
	if (PositionX):
		self.position.x = Target.position.x
	if (PositionY):
		self.position.y = Target.position.y
	if (PositionZ):
		self.position.z = Target.position.z
	if (RotationX):
		self.rotation.x = Target.rotation.x
	if (RotationY):
		self.rotation.y = Target.rotation.y
	if (RotationZ):
		self.rotation.z = Target.rotation.z
	if (ScaleX):
		self.scale.x = Target.scale.x
	if (ScaleY):
		self.scale.y = Target.scale.y
	if (ScaleZ):
		self.scale.z = Target.scale.z
