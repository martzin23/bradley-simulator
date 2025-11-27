extends Camera3D

@export var TARGET: Node3D

func _ready() -> void:
	self.top_level = true

func _process(_delta: float) -> void:
	self.position = lerp(self.position, to_global(TARGET.position), 0.9)
	#self.rotation = lerp(self.rotation, TARGET.rotation, 0.1)
	#tween.tween_property(self, "position", target.position, 10)
	#tween.tween_property(self, "rotation", target.rotation, 10)
