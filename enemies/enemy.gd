@tool
extends CharacterBody3D
signal died

@onready var nav_agent = $NavigationAgent3D
@export_range(0,2*PI) var angle_to_player: float = 0 :set=set_angle_to_player
@export var id:int = 0

var health: float = 10:
	set(new_health):
		health = clamp(new_health,0,INF)
		if health<=0:
			die()

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var player = get_tree().get_first_node_in_group("player")

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var anim_prefix = "front_"

func set_angle_to_player(angle):
	angle_to_player = angle
	if angle<PI/4 or angle>=(PI*7)/4:
		anim_prefix = "right_"
	elif angle<PI*3/4:
		anim_prefix = "front_"
	elif angle<PI*5/4:
		anim_prefix = "left_"
	else:
		anim_prefix = "back_"

func _process(delta):
	if Engine.is_editor_hint():return
	var vec2_pos = Vector2(global_position.x,global_position.z)
	var vec2_player = Vector2(player.global_position.x,player.global_position.z)-vec2_pos
	var vec2_view = Vector2(vec2_player.length(),0).rotated(rotation.y)
	angle_to_player = vec2_view.angle_to(vec2_player)+PI
	$Sprite.play(anim_prefix)

func _physics_process(delta):
	if Engine.is_editor_hint():return
	#nav_agent.target_position = player.global_position
	var next_pos = nav_agent.get_next_path_position()
	
	if next_pos == global_position or nav_agent.is_navigation_finished():
		velocity = Vector3.ZERO
	else:
		look_at(nav_agent.get_next_path_position())
		rotation *= Vector3.UP
		velocity = (Vector3.FORWARD.rotated(Vector3.UP,rotation.y)).normalized()*SPEED
	
	if !is_on_floor():
		velocity.y -= gravity
	move_and_slide()

func take_damage(val:float):
	health -= val
	print("ow ",val)

func die():
	emit_signal("died")
	queue_free()
