extends CharacterBody3D

enum targets{
	PLAYER,
	ENEMY,
	BOTH
}

var target: targets = targets.ENEMY

func _physics_process(delta):
	move_and_slide()
	if get_slide_collision_count():
		velocity = Vector3.ZERO
		queue_free()

func _on_area_3d_body_entered(body):
	if !body.is_in_group("player") and !body.is_in_group("enemy"): return
	if target == targets.PLAYER and !body.is_in_group("player"): return
	if target == targets.ENEMY and !body.is_in_group("enemy"): return
	body.take_damage(10)
	queue_free()
