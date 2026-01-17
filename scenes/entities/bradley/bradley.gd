extends VehicleBody3D

@export_group("Private")
@export var DEATH_SCREEN : Control
@export var HEALTH_LABEL : Label3D

func open_death_screen():
	DEATH_SCREEN.visible = true

func update_health(health: float):
	HEALTH_LABEL.text = str(health)

func reset_scene():
	get_tree().reload_current_scene()
	
func quit_scene():
	get_tree().quit()
