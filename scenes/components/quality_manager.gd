extends Node
class_name QualityManager

@export var TERRAIN : Terrain3D
@export var GRASS_PARTICLE : Terrain3DParticles
@export var POST_PROCESSING : ColorRect

var base_instance_spacing
var base_mesh_size

func _ready() -> void:
	Global.quality_manager = get_node(get_path())
	base_instance_spacing = GRASS_PARTICLE.instance_spacing
	base_mesh_size = TERRAIN.mesh_size

func setQualityLow() -> void:
	POST_PROCESSING.visible = false
	GRASS_PARTICLE.instance_spacing = base_instance_spacing * 2
	TERRAIN.mesh_size = base_mesh_size * 0.5
	
func setQualityHigh() -> void:
	POST_PROCESSING.visible = true
	GRASS_PARTICLE.instance_spacing = base_instance_spacing
	TERRAIN.mesh_size = base_mesh_size
