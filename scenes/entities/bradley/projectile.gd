extends RigidBody3D

@export var explosion: Node3D

func _ready() -> void:
	explosion.visible = false

func projectile_collided(_body: Node):
	var anim_player = explosion.get_node("AnimationPlayer")
	self.freeze = true
	self.get_node("Mesh").visible = false
	explosion.visible = true
	anim_player.play("Boom")
	anim_player.connect("animation_finished", anim_fin)

func anim_fin(anim_name: StringName):
	destroy_itself()

func destroy_itself():
	self.queue_free()
	
