extends Area3D

var portal_group_name: String = ""
var exit_angle: float = 360
var cooldown: float = .1
var current_cooldown: float = 0

@export var properties: Dictionary :
	get:
		return properties # TODOConverter40 Non existent get function 
	set(new_properties):
		if(properties != new_properties):
			properties = new_properties
			update_properties()

func update_properties() -> void:
	if "portal_group" in properties:
		portal_group_name = properties["portal_group"]
		add_to_group("portal_group_{name}".format({"name":portal_group_name}))
	if "cooldown" in properties:
		cooldown = properties["cooldown"]
	if "exit_angle" in properties:
		exit_angle = properties["exit_angle"]

func _init():
	connect("body_entered", body_entered)

func _process(delta):
	current_cooldown = clamp(current_cooldown-delta,0,INF)

func enter_cooldown():
	current_cooldown = cooldown

func body_entered(body):
	if !body.is_in_group("player") or current_cooldown:return
	var other_portals = get_tree().get_nodes_in_group("portal_group_{name}".format({"name":portal_group_name}))
	other_portals.erase(self)
	if !other_portals: return
	var other_portal = other_portals.pick_random()
	other_portal.enter_cooldown()
	body.global_position = other_portal.global_position
	body.rotation_degrees.y = other_portal.exit_angle
