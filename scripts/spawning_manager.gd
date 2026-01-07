extends Node

@export var num_of_enemies = 1
@export var enemy: PackedScene

func _ready() -> void:
	var spawns = self.get_children()
	for i in range(num_of_enemies):
		var rand = randi_range(0, len(spawns)-1)
		var instance: Node3D = enemy.instantiate()
		get_tree().current_scene.call_deferred("add_child", instance)
		instance.position = spawns[rand].position
		spawns.remove_at(rand)
		if len(spawns)==0:
			break
		
