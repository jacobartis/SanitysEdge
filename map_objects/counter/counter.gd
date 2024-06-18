extends Node

signal trigger()

var number: int = 0

@export var properties: Dictionary :
	get:
		return properties # TODOConverter40 Non existent get function 
	set(new_properties):
		if(properties != new_properties):
			properties = new_properties
			update_properties()

func update_properties():
	if "number" in properties:
		number = properties.number

func use():
	number = clamp(number-1,0,INF)
	if !number:
		trigger.emit()
