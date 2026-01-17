@icon("./enemy_spawner.png")
extends Node
class_name EnemySpawner

@export var ENEMY_COUNT = 1
@export var ENEMY: PackedScene

func _ready() -> void:
	var spawns = self.get_children()
	for i in range(ENEMY_COUNT):
		var rand = randi_range(0, len(spawns)-1)
		var instance: Node3D = ENEMY.instantiate()
		get_tree().current_scene.call_deferred("add_child", instance)
		instance.position = spawns[rand].position
		spawns.remove_at(rand)
		if len(spawns)==0:
			break
		
