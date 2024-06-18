extends QodotButton

var interact_text := "placeholder"

func update_properties() -> void:
	super()
	if 'interact_text' in properties:
		interact_text = properties.interact_text

func _init():
	add_to_group("interactable")

func interact() -> void:
	press()
