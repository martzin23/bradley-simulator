@tool
extends StaticBody3D

signal button_pressed()
signal button_released()

enum Positioning {ABOVE, UNDER, LEFT, RIGHT}
@onready var MESH: MeshInstance3D = $Model/Base/Button
@onready var LABEL_NODE: Label3D = $Label
@onready var ICON_NODE: Label3D = $Model/Base/Button/Icon
@onready var AUDIO_PLAYER: AudioStreamPlayer3D = $AudioStreamPlayer3D
var press_tween: Tween

@export_group("Text")
@export var icon := "":
	set(value): 
		icon = value
		update_text()
@export var label := "":
	set(value):
		label = value
		update_text()
@export var label_position := Positioning.ABOVE:
	set(value):
		label_position = value
		update_text()
@export var label_spacing := 0.03:
	set(value):
		label_spacing = value
		update_text()
@export_group("Materials")
@export var default_material: Material
@export var highlight_material: Material

func _ready() -> void:
	update_text()

func enter():
	MESH.material_override = highlight_material
	
func exit():
	MESH.material_override = default_material
	
func press():
	AUDIO_PLAYER.play()
	button_pressed.emit()
	move_down()
	
func release():
	button_released.emit()
	move_up()

func move_up():
	if (press_tween):
		press_tween.kill()
	press_tween = get_tree().create_tween()
	press_tween.tween_property(MESH, "position:y", 0.0, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	
func move_down():
	if (press_tween):
		press_tween.kill()
	press_tween = get_tree().create_tween()
	press_tween.tween_property(MESH, "position:y", -0.005, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)

func update_text():
	if !is_inside_tree():
		return 
		
	if (len(label) > 0):
		LABEL_NODE.text = label
		LABEL_NODE.visible = true
	else:
		LABEL_NODE.visible = false
		
	if (len(icon) > 0):
		ICON_NODE.text = icon
		ICON_NODE.visible = true
	else:
		ICON_NODE.visible = false
	
	match label_position:
		Positioning.ABOVE:
			LABEL_NODE.position = Vector3(0.0, 0.003, label_spacing)
		Positioning.UNDER:
			LABEL_NODE.position = Vector3(0.0, 0.003, -label_spacing)
		Positioning.LEFT:
			LABEL_NODE.position = Vector3(label_spacing, 0.003, 0.0)
		Positioning.RIGHT:
			LABEL_NODE.position = Vector3(-label_spacing, 0.003, 0.0)
