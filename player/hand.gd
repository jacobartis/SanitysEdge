extends Node3D

@export var body: CharacterBody3D
const PROJECTILE = preload("res://projectiles/projectile.tscn")

func attack():
	var proj = PROJECTILE.instantiate()
	get_tree().get_first_node_in_group("world").add_child(proj)
	proj.transform = global_transform
	proj.global_rotation = global_rotation
	proj.velocity = -proj.transform.basis.z*100
	get_tree().call_group("weapon_display","shoot")
