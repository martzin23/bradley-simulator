extends Node3D
class_name EnvironmentManager

@export_group("Presets", "PRESET_")
@export var PRESET_DAY: Environment
@export var PRESET_NIGHT: Environment
@export var PRESET_FOG: Environment

@export_group("Nodes")
@export var ENVIRONMENT: WorldEnvironment
@export var LIGHT: DirectionalLight3D
@export var VOLUME: FogVolume

func _ready() -> void:
	Global.environment_manager = get_node(get_path())

func set_day():
	ENVIRONMENT.environment = PRESET_DAY
	LIGHT.visible = true
	VOLUME.visible = false
	
func set_night():
	ENVIRONMENT.environment = PRESET_NIGHT
	LIGHT.visible = false
	VOLUME.visible = false
	
func set_fog():
	ENVIRONMENT.environment = PRESET_FOG
	LIGHT.visible = false
	VOLUME.visible = true
