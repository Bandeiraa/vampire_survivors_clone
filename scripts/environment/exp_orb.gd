extends Area2D
class_name ExpOrb

var experience: int
var player_ref = null

export(int) var move_speed = 150
export(int) var distance_threshold = 16

func on_body_entered(body) -> void:
	if body.is_in_group("character"):
		player_ref = body
		
		
func _physics_process(delta: float) -> void:
	if player_ref == null:
		return
		
	var distance_to: float = global_position.distance_to(player_ref.global_position)
	var direction_to: Vector2 = global_position.direction_to(player_ref.global_position)
	
	translate(direction_to * delta * move_speed)
	if distance_to < distance_threshold:
		send_exp()
		
		
func send_exp() -> void:
	global_info.character.update_exp(experience)
	queue_free()
