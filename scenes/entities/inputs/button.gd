extends StaticBody3D

signal button_pressed()

@export var default_material: Material
@export var highlight_material: Material
@onready var mesh: MeshInstance3D = $Model/Base/Button
var press_tween: Tween

func enter():
	mesh.material_override = highlight_material
	
func exit():
	mesh.material_override = default_material
	
func press():
	button_pressed.emit()
	move_down()
	
func release():
	move_up()

func move_up():
	if (press_tween):
		press_tween.kill()
	press_tween = get_tree().create_tween()
	press_tween.tween_property(mesh, "position:y", 0.0, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	
func move_down():
	if (press_tween):
		press_tween.kill()
	press_tween = get_tree().create_tween()
	press_tween.tween_property(mesh, "position:y", -0.005, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
