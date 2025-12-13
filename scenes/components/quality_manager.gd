extends Node
class_name QualityManager

@export var TERRAIN : Terrain3D
@export var GRASS_PARTICLE : Terrain3DParticles
@export var POST_PROCESSING : ColorRect
@export var BILLBOARD_MATERIALS : Array[StandardMaterial3D]
#@export var SUN: DirectionalLight3D

var base_instance_spacing: float
var base_mesh_size: int
var base_material_fade_min: float
var base_material_fade_max: float
var base_lod_distance: float

func _ready() -> void:
	Global.quality_manager = get_node(get_path())
	base_instance_spacing = GRASS_PARTICLE.instance_spacing
	base_mesh_size = TERRAIN.mesh_size
	base_material_fade_min = BILLBOARD_MATERIALS[0].distance_fade_min_distance
	base_material_fade_max = BILLBOARD_MATERIALS[0].distance_fade_max_distance
	base_lod_distance = TERRAIN.assets.mesh_list[0].lod0_range

func set_quality_low() -> void:
	POST_PROCESSING.visible = false
	GRASS_PARTICLE.instance_spacing = base_instance_spacing * 2
	TERRAIN.mesh_size = int(base_mesh_size * 0.25)
	for material in BILLBOARD_MATERIALS:
		material.distance_fade_max_distance = 0
		material.distance_fade_min_distance = 0
	for mesh in TERRAIN.assets.mesh_list:
		mesh.lod0_range = 1.0
		await get_tree().create_timer(0.1).timeout 
	#SUN.directional_shadow_mode = DirectionalLight3D.SHADOW_ORTHOGONAL

func set_quality_high() -> void:
	POST_PROCESSING.visible = true
	GRASS_PARTICLE.instance_spacing = base_instance_spacing
	TERRAIN.mesh_size = base_mesh_size
	for material in BILLBOARD_MATERIALS:
		material.distance_fade_max_distance = base_material_fade_max
		material.distance_fade_min_distance = base_material_fade_min
	for mesh in TERRAIN.assets.mesh_list:
		mesh.lod0_range = base_lod_distance
		await get_tree().create_timer(0.1).timeout
	#SUN.directional_shadow_mode = DirectionalLight3D.SHADOW_PARALLEL_4_SPLITS
