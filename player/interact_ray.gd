extends RayCast3D

signal interaction_text(text:String)

var interaction_target :set=set_interaction_target

func set_interaction_target(new_target):
	if interaction_target == new_target: return
	if !new_target or !new_target.is_in_group("interactable"):
		interaction_text.emit("")
		interaction_target = null
	else:
		var button = ""
		if !InputMap.action_get_events("interact").is_empty():
			button = InputMap.action_get_events("interact")[0].as_text().trim_suffix(" (Physical)")
		interaction_text.emit("Press {button} to {interaction}".format({"button":button,"interaction":new_target.interact_text}))
		interaction_target = new_target


func _process(delta):
	interaction_target = get_collider()
	if Input.is_action_just_pressed("interact") and interaction_target:
		interaction_target.interact()
