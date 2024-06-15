extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var player = get_tree().get_first_node_in_group("player")

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	look_at(player.global_position)
	move_and_slide()
