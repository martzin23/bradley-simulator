@tool
extends StaticBody3D

signal switch_on()
signal switch_off()

enum Positioning {ABOVE, UNDER, LEFT, RIGHT}
@onready var MESH: MeshInstance3D = $Model/Base/Switch
@onready var LABEL_NODE: Label3D = $Label
@onready var AUDIO_PLAYER: AudioStreamPlayer3D = $AudioStreamPlayer3D
var flip_tween: Tween

@export var state = false:
	set(value):
		if (value):
			switch_on.emit()
			flip_down()
		else:
			switch_off.emit()
			flip_up()
		state = value
@export_group("Text")
@export var label := "":
	set(value):
		label = value
		update_text()
@export var label_position := Positioning.ABOVE:
	set(value):
		label_position = value
		update_text()
@export var label_spacing := 0.04:
	set(value):
		label_spacing = value
		update_text()
@export_group("Materials")
@export var default_material: Material
@export var highlight_material: Material
@export_group("Audio")
@export var switch_on_audio: AudioStream
@export var switch_off_audio: AudioStream


func _ready() -> void:
	update_text()
	if (state):
		flip_down()
	else:
		flip_up()

func enter():
	MESH.material_override = highlight_material
	
func exit():
	MESH.material_override = default_material
	
func press():
	state = !state
	
func release():
	pass

func flip_up():
	if !is_inside_tree():
		return 
	AUDIO_PLAYER.stream = switch_off_audio
	AUDIO_PLAYER.play()
	if (flip_tween):
		flip_tween.kill()
	flip_tween = get_tree().create_tween()
	flip_tween.tween_property(MESH, "rotation_degrees:x", 60, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	
func flip_down():
	if !is_inside_tree():
		return 
	AUDIO_PLAYER.stream = switch_on_audio
	AUDIO_PLAYER.play()
	if (flip_tween):
		flip_tween.kill()
	flip_tween = get_tree().create_tween()
	flip_tween.tween_property(MESH, "rotation_degrees:x", -60, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)

func update_text():
	if !is_inside_tree():
		return 
		
	if (len(label) > 0):
		LABEL_NODE.text = label
		LABEL_NODE.visible = true
	else:
		LABEL_NODE.visible = false
	
	match label_position:
		Positioning.ABOVE:
			LABEL_NODE.position = Vector3(0.0, 0.003, label_spacing)
			LABEL_NODE.rotation_degrees = Vector3(-90, -180, 0)
		Positioning.UNDER:
			LABEL_NODE.position = Vector3(0.0, 0.003, -label_spacing)
			LABEL_NODE.rotation_degrees = Vector3(-90, -180, 0)
		Positioning.LEFT:
			LABEL_NODE.position = Vector3(label_spacing, 0.003, 0.0)
			LABEL_NODE.rotation_degrees = Vector3(-90, -180, -90)
		Positioning.RIGHT:
			LABEL_NODE.position = Vector3(-label_spacing, 0.003, 0.0)
			LABEL_NODE.rotation_degrees = Vector3(-90, -180, -90)
