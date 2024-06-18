extends Area3D

var strength:float = 10
var direction:Vector3 = Vector3.UP

@export var properties: Dictionary :
	get:
		return properties
	set(new_properties):
		if(properties != new_properties):
			properties = new_properties
			update_properties()

func update_properties() -> void:
	if "strength" in properties:
		strength = properties.strength
	if "direction" in properties:
		direction = properties.direction.normalized()

func _ready():
	connect("body_entered",new_body_entered)

func new_body_entered(body):
	if body is CharacterBody3D:
		print(-body.velocity/2+strength*direction)
		body.velocity = -body.velocity/2+strength*direction
	if body is RigidBody3D:
		body.linear_velocity = -body.linear_velocity/2+(strength*direction)
