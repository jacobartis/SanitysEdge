@tool
class_name TimerPoint
extends QodotEntity

signal trigger

var autostart: bool = false
var wait_time: float = 1
var one_shot: bool = false

func _ready():
	if get_children():
		return
	var new_timer: Timer = Timer.new()
	new_timer.wait_time = wait_time
	new_timer.one_shot = one_shot
	new_timer.autostart = autostart
	add_child(new_timer)
	new_timer.timeout.connect(emit_trigger)

func update_properties():
	super.update_properties()
	if "time" in properties:
		wait_time = properties.time
	if "one_shot" in properties:
		one_shot = properties.one_shot
	if "autostart" in properties:
		autostart = properties.autostart
	if get_children() and get_child(0) is Timer:
		get_child(0).wait_time = wait_time
		get_child(0).one_shot = one_shot
		get_child(0).autostart = autostart

func use() -> void:
	get_child(0).start()

func restart() -> void:
	get_child(0).restart()

func emit_trigger() -> void:
	print("trigger")
	trigger.emit()
