extends Node3D

#enum PresetType {DAY, NIGHT, FOG}
#
#@export var current := PresetType.DAY:
	#set(value):
		#match value:
			#PresetType.DAY: 
				#setDay()
			#PresetType.NIGHT:
				#setNight()
			#PresetType.FOG:
				#setFog()
		#current = value

@export_group("Presets", "PRESET_")
@export var PRESET_DAY: Environment
@export var PRESET_NIGHT: Environment
@export var PRESET_FOG: Environment

@export_group("Nodes")
@export var ENVIRONMENT: WorldEnvironment
@export var LIGHT: DirectionalLight3D
@export var VOLUME: FogVolume

func setDay():
	ENVIRONMENT.environment = PRESET_DAY
	LIGHT.visible = true
	VOLUME.visible = false
	
func setNight():
	ENVIRONMENT.environment = PRESET_NIGHT
	LIGHT.visible = false
	VOLUME.visible = false
	
func setFog():
	ENVIRONMENT.environment = PRESET_FOG
	LIGHT.visible = false
	VOLUME.visible = true
