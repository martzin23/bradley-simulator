extends StaticBody3D

signal switch_on()
signal switch_off()

@export var state = false:
	set(value):
		if (value):
			flip_up()
			switch_on.emit()
		else:
			flip_down()
			switch_off.emit()
		state = value
@export var default_material: Material
@export var highlight_material: Material
@onready var mesh: MeshInstance3D = $Model/Base/Switch
var flip_tween: Tween

func enter():
	mesh.material_override = highlight_material
	
func exit():
	mesh.material_override = default_material
	
func press():
	state = !state
	
func release():
	pass

func flip_up():
	if (flip_tween):
		flip_tween.kill()
	flip_tween = get_tree().create_tween()
	flip_tween.tween_property(mesh, "rotation_degrees:x", 60, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	
func flip_down():
	if (flip_tween):
		flip_tween.kill()
	flip_tween = get_tree().create_tween()
	flip_tween.tween_property(mesh, "rotation_degrees:x", -60, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
