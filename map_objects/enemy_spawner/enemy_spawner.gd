extends Node3D

signal trigger()

var enemy_type: int = 0

@export var properties: Dictionary :
	get:
		return properties # TODOConverter40 Non existent get function 
	set(new_properties):
		if(properties != new_properties):
			properties = new_properties
			update_properties()

func update_properties():
	if "enemy_type" in properties:
		enemy_type = properties.enemy_type

func use():
	var enemy = Loader.enemies[enemy_type].instantiate()
	enemy.died.connect(send_signal)
	get_tree().get_first_node_in_group("world").add_child(enemy)
	enemy.global_position = global_position

func send_signal():
	trigger.emit()
